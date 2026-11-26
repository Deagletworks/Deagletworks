`timescale 1ns / 1ps

module qpu_axi_token_bridge #(
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer C_S_AXI_ADDR_WIDTH = 6
)(
    input  wire                                S_AXI_ACLK,
    input  wire                                S_AXI_ARESETN,

    input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]     S_AXI_AWADDR,
    input  wire [2 : 0]                        S_AXI_AWPROT,
    input  wire                                S_AXI_AWVALID,
    output wire                                S_AXI_AWREADY,

    input  wire [C_S_AXI_DATA_WIDTH-1 : 0]     S_AXI_WDATA,
    input  wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
    input  wire                                S_AXI_WVALID,
    output wire                                S_AXI_WREADY,

    output wire [1 : 0]                        S_AXI_BRESP,
    output wire                                S_AXI_BVALID,
    input  wire                                S_AXI_BREADY,

    input  wire [C_S_AXI_ADDR_WIDTH-1 : 0]     S_AXI_ARADDR,
    input  wire [2 : 0]                        S_AXI_ARPROT,
    input  wire                                S_AXI_ARVALID,
    output wire                                S_AXI_ARREADY,

    output wire [C_S_AXI_DATA_WIDTH-1 : 0]     S_AXI_RDATA,
    output wire [1 : 0]                        S_AXI_RRESP,
    output wire                                S_AXI_RVALID,
    input  wire                                S_AXI_RREADY,

    output wire                                qpu_start_shot,
    output wire                                qpu_ca_detok_ack,
    output wire [3:0]                          qpu_flash_wave_m,
    output wire [3:0]                          qpu_flash_wave_ui,
    output wire [3:0]                          qpu_flash_wave_ej,
    output wire [3:0]                          qpu_flash_wave_ek,
    output wire [127:0]                        qpu_active_url_hash,
    output wire [31:0]                         qpu_active_how_code,

    input  wire [7:0]                          qpu_amplituhedron_vol,
    input  wire [15:0]                         qpu_twist_string_amp,
    input  wire                                qpu_shot_complete,
    input  wire                                qpu_ca_detok_valid,
    input  wire                                qpu_guard_locked,
    input  wire                                qpu_auth_valid,
    input  wire [255:0]                        qpu_auth_4w_token,
    input  wire [31:0]                         qpu_remaining_shots
);

    reg [C_S_AXI_ADDR_WIDTH-1 : 0] axi_awaddr;
    reg                            axi_awready;
    reg                            axi_wready;
    reg [1 : 0]                    axi_bresp;
    reg                            axi_bvalid;
    reg [C_S_AXI_ADDR_WIDTH-1 : 0] axi_araddr;
    reg                            axi_arready;
    reg [C_S_AXI_DATA_WIDTH-1 : 0] axi_rdata;
    reg [1 : 0]                    axi_rresp;
    reg                            axi_rvalid;
    reg                            aw_en;

    reg        r_start_shot;
    reg        r_ca_detok_ack;
    reg [15:0] r_wave_inputs;
    reg [31:0] r_url_hash_0;
    reg [31:0] r_url_hash_1;
    reg [31:0] r_url_hash_2;
    reg [31:0] r_url_hash_3;
    reg [31:0] r_how_code;

    wire slv_reg_wren;
    wire slv_reg_rden;

    assign S_AXI_AWREADY = axi_awready;
    assign S_AXI_WREADY  = axi_wready;
    assign S_AXI_BRESP   = axi_bresp;
    assign S_AXI_BVALID  = axi_bvalid;
    assign S_AXI_ARREADY = axi_arready;
    assign S_AXI_RDATA   = axi_rdata;
    assign S_AXI_RRESP   = axi_rresp;
    assign S_AXI_RVALID  = axi_rvalid;

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_awready <= 1'b0;
            aw_en       <= 1'b1;
        end else begin
            if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en) begin
                axi_awready <= 1'b1;
                aw_en       <= 1'b0;
            end else if (S_AXI_BREADY && axi_bvalid) begin
                aw_en       <= 1'b1;
                axi_awready <= 1'b0;
            end else begin
                axi_awready <= 1'b0;
            end
        end
    end

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_awaddr <= {C_S_AXI_ADDR_WIDTH{1'b0}};
        end else if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en) begin
            axi_awaddr <= S_AXI_AWADDR;
        end
    end

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_wready <= 1'b0;
        end else if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en) begin
            axi_wready <= 1'b1;
        end else begin
            axi_wready <= 1'b0;
        end
    end

    assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            r_start_shot   <= 1'b0;
            r_ca_detok_ack <= 1'b0;
            r_wave_inputs  <= 16'd0;
            r_url_hash_0   <= 32'd0;
            r_url_hash_1   <= 32'd0;
            r_url_hash_2   <= 32'd0;
            r_url_hash_3   <= 32'd0;
            r_how_code     <= 32'd0;
        end else begin
            r_start_shot <= 1'b0;
            if (slv_reg_wren) begin
                case (axi_awaddr[5:2])
                    4'h0: begin
                        if (S_AXI_WSTRB[0]) begin
                            r_start_shot   <= S_AXI_WDATA[0];
                            r_ca_detok_ack <= S_AXI_WDATA[1];
                        end
                    end
                    4'h1: begin
                        if (S_AXI_WSTRB[0]) r_wave_inputs[7:0]  <= S_AXI_WDATA[7:0];
                        if (S_AXI_WSTRB[1]) r_wave_inputs[15:8] <= S_AXI_WDATA[15:8];
                    end
                    4'h4: r_url_hash_0 <= S_AXI_WDATA;
                    4'h5: r_url_hash_1 <= S_AXI_WDATA;
                    4'h6: r_url_hash_2 <= S_AXI_WDATA;
                    4'h7: r_url_hash_3 <= S_AXI_WDATA;
                    4'h8: r_how_code   <= S_AXI_WDATA;
                    default: ;
                endcase
            end
        end
    end

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_bvalid <= 1'b0;
            axi_bresp  <= 2'b00;
        end else begin
            if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID) begin
                axi_bvalid <= 1'b1;
                axi_bresp  <= 2'b00;
            end else if (S_AXI_BREADY && axi_bvalid) begin
                axi_bvalid <= 1'b0;
            end
        end
    end

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_arready <= 1'b0;
            axi_araddr  <= {C_S_AXI_ADDR_WIDTH{1'b0}};
        end else begin
            if (~axi_arready && S_AXI_ARVALID) begin
                axi_arready <= 1'b1;
                axi_araddr  <= S_AXI_ARADDR;
            end else begin
                axi_arready <= 1'b0;
            end
        end
    end

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_rvalid <= 1'b0;
            axi_rresp  <= 2'b00;
        end else begin
            if (axi_arready && S_AXI_ARVALID && ~axi_rvalid) begin
                axi_rvalid <= 1'b1;
                axi_rresp  <= 2'b00;
            end else if (axi_rvalid && S_AXI_RREADY) begin
                axi_rvalid <= 1'b0;
            end
        end
    end

    assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;

    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            axi_rdata <= 32'd0;
        end else if (slv_reg_rden) begin
            case (axi_araddr[5:2])
                4'h0: axi_rdata <= {21'd0, qpu_auth_valid, qpu_guard_locked, qpu_shot_complete, 6'd0, r_ca_detok_ack, r_start_shot};
                4'h1: axi_rdata <= {16'd0, r_wave_inputs};
                4'h2: axi_rdata <= {7'd0, qpu_ca_detok_valid, qpu_twist_string_amp, qpu_amplituhedron_vol};
                4'h3: axi_rdata <= qpu_remaining_shots;
                4'h4: axi_rdata <= r_url_hash_0;
                4'h5: axi_rdata <= r_url_hash_1;
                4'h6: axi_rdata <= r_url_hash_2;
                4'h7: axi_rdata <= r_url_hash_3;
                4'h8: axi_rdata <= r_how_code;
                4'h9: axi_rdata <= qpu_auth_4w_token[31:0];
                4'hA: axi_rdata <= qpu_auth_4w_token[63:32];
                4'hB: axi_rdata <= qpu_auth_4w_token[95:64];
                4'hC: axi_rdata <= qpu_auth_4w_token[127:96];
                4'hD: axi_rdata <= qpu_auth_4w_token[159:128];
                4'hE: axi_rdata <= qpu_auth_4w_token[191:160];
                4'hF: axi_rdata <= qpu_auth_4w_token[223:192];
                default: axi_rdata <= 32'd0;
            endcase
        end
    end

    assign qpu_start_shot      = r_start_shot;
    assign qpu_ca_detok_ack    = r_ca_detok_ack;
    assign qpu_flash_wave_m    = r_wave_inputs[3:0];
    assign qpu_flash_wave_ui   = r_wave_inputs[7:4];
    assign qpu_flash_wave_ej   = r_wave_inputs[11:8];
    assign qpu_flash_wave_ek   = r_wave_inputs[15:12];
    assign qpu_active_url_hash = {r_url_hash_3, r_url_hash_2, r_url_hash_1, r_url_hash_0};
    assign qpu_active_how_code = r_how_code;

endmodule
