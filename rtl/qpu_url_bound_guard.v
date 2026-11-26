`timescale 1ns / 1ps

module qpu_url_bound_guard #(
    parameter [127:0] BOUND_ENDPOINT_URL_HASH = 128'h8F9E_2A1B_4C3D_7E6F_1029_3847_56AB_CDEF,
    parameter [31:0]  EXPECTED_HOW_CODE       = 32'h4445_5601,
    parameter [63:0]  EXPECTED_DEVICE_DNA     = 64'h0123_4567_89AB_CDEF,
    parameter [31:0]  MAX_EVAL_SHOTS          = 32'd10_000_000,
    parameter         IS_PRODUCTION_BUILD     = 1'b1
)(
    input  wire         clk,
    input  wire         rst_n,
    input  wire         start_shot,
    input  wire [63:0]  hw_device_dna,
    input  wire [127:0] active_endpoint_url_hash,
    input  wire [31:0]  active_how_code,
    input  wire [3:0]   flash_atc_wave_m,
    input  wire [3:0]   flash_atc_wave_ui,
    input  wire [3:0]   flash_atc_wave_ej,
    input  wire [3:0]   flash_atc_wave_ek,
    input  wire         agora_hazard_pulse,

    output wire         fused_clk_out,
    output wire         guard_locked_status,
    output wire         passwordless_auth_valid,
    output wire [255:0] auth_4w_proof_token,
    output wire [31:0]  remaining_eval_shots
);

    reg [31:0] r_shot_count;
    reg [31:0] r_when_timestamp;
    reg        r_timeout_locked;

    wire [3:0] base_hazard_stamp = flash_atc_wave_m ^ flash_atc_wave_ej;
    wire       base_hazard_ok    = (base_hazard_stamp != 4'b1111) && (!agora_hazard_pulse);

    wire [31:0] url_integrity_word = BOUND_ENDPOINT_URL_HASH[127:96] ^ BOUND_ENDPOINT_URL_HASH[95:64] ^
                                     BOUND_ENDPOINT_URL_HASH[63:32]  ^ BOUND_ENDPOINT_URL_HASH[31:0];
    wire        url_hash_valid     = (url_integrity_word != 32'hFFFF_FFFF) && (url_integrity_word != 32'h0000_0000);

    wire        who_dna_matched    = IS_PRODUCTION_BUILD ? (hw_device_dna != 64'd0) : (hw_device_dna == EXPECTED_DEVICE_DNA);
    wire        where_url_matched  = (active_endpoint_url_hash == BOUND_ENDPOINT_URL_HASH);
    wire        how_code_matched   = (active_how_code == EXPECTED_HOW_CODE) && (active_how_code != 32'd0);
    wire        eval_active        = IS_PRODUCTION_BUILD ? 1'b1 : (!r_timeout_locked);

    wire        master_gate_en     = base_hazard_ok && url_hash_valid && who_dna_matched && where_url_matched && how_code_matched && eval_active;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r_shot_count     <= 32'd0;
            r_when_timestamp <= 32'd0;
            r_timeout_locked <= 1'b0;
        end else begin
            if (master_gate_en && start_shot) begin
                r_when_timestamp <= r_when_timestamp + 1'b1;
            end

            if (!IS_PRODUCTION_BUILD) begin
                if (!who_dna_matched || !where_url_matched || !how_code_matched || !url_hash_valid) begin
                    r_timeout_locked <= 1'b1;
                end else if (start_shot && !r_timeout_locked) begin
                    if (r_shot_count >= MAX_EVAL_SHOTS) begin
                        r_timeout_locked <= 1'b1;
                    end else begin
                        r_shot_count <= r_shot_count + 1'b1;
                    end
                end
            end
        end
    end

    wire [63:0]  proof_who   = hw_device_dna ^ {16{flash_atc_wave_ej}};
    wire [127:0] proof_where = BOUND_ENDPOINT_URL_HASH;
    wire [31:0]  proof_when  = r_when_timestamp;
    wire [31:0]  proof_how   = active_how_code ^ {28'd0, flash_atc_wave_m};

    assign fused_clk_out           = clk & master_gate_en & rst_n;
    assign guard_locked_status     = !master_gate_en;
    assign passwordless_auth_valid = master_gate_en;
    assign auth_4w_proof_token     = master_gate_en ? {proof_who, proof_where, proof_when, proof_how} : 256'd0;
    assign remaining_eval_shots    = IS_PRODUCTION_BUILD ? 32'hFFFF_FFFF :
                                     (r_shot_count >= MAX_EVAL_SHOTS) ? 32'd0 : (MAX_EVAL_SHOTS - r_shot_count);

endmodule
