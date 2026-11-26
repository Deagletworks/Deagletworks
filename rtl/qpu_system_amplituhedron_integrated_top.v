// =================================================================================
// DEAGLETWORKS PUBLIC DOMAIN MASTER QPU CORES (STRICT SYNTAX REVISED)
// Module: qpu_system_amplituhedron_integrated_top
// Description: Amplituhedron Positive Simplex & TwistString Scattering Amplitude
//              Integrated with 16-Sedenion Planes, In-Situ XOR Logic, Anti-Hazard Core,
//              & Crystal-Ark Detokenizer Interface.
// =================================================================================

`timescale 1ns / 1ps

module qpu_system_amplituhedron_integrated_top (
    input wire clk,                    // システムマスタークロック (500MHz / 1GHz)
    input wire rst_n,                  // アクティブ・ローリセット
    input wire start_shot,             // 演算開始トリガー
    input wire agora_hazard_pulse,     // 【防衛核】AGORA戦争・犯罪コマンド / 不正ハザード検知パルス
    
    // 【⑤ Divine】マルチフェロイック膜からの4次元パラレル入力
    input wire [3:0] flash_atc_wave_m,  // 原始情報 (m)
    input wire [3:0] flash_atc_wave_ui, // 空間座標 (μi)
    input wire [3:0] flash_atc_wave_ej, // 揺らぎ量 (εj)
    input wire [3:0] flash_atc_wave_ek, // 歳入予算 (Ek)

    // 出力インターフェース (データフロー制御 & 散乱振幅・体積確定バス)
    output wire vcsel_x_scan_en,           // X軸走査有効化 (上部VCSEL1制御)
    output wire [9:0] matrix_x_addr,       // 1024本 X軸アドレス
    output wire [9:0] matrix_y_addr,       // 1024本 Y軸アドレス
    output wire [7:0] amplituhedron_vol,   // 【アンプリチューヘデロン】正Simplex幾何学的体積
    output wire [15:0] twist_string_amp,   // 【ツインストリング】散乱振幅確定値
    output wire [3:0] active_sedenion_out, // 活性化された16元数位相ステータス
    output wire qpu_shot_complete,         // 物理1サイクル演算完了フラグ

    // 【🆕 Crystal-Ark Detokenizer Interface】（計算結果資源活用インタフェース）
    input wire ca_detok_ack,               // デトークン受領確認信号 (Ack)
    output wire ca_detok_req,              // デトークン要求信号 (Req)
    output wire [7:0] ca_simplex_vol_tok,  // デトークン化されたSimplex幾何体積
    output wire [15:0] ca_twist_amp_tok,   // デトークン化されたツインストリング散乱振幅
    output wire ca_detok_valid             // デトークンデータ有効フラグ
);

    // ── 【不可分防衛核：動的クロック・ゲーティング】 ──
    wire [3:0] anti_hazard_stamp = flash_atc_wave_m ^ flash_atc_wave_ej;
    wire clock_enable_latch = (anti_hazard_stamp != 4'b1111) && (!agora_hazard_pulse);
    wire fused_clk = clk & clock_enable_latch & rst_n;

    // ── 16元数物理レジスタ面 (Sedenion Phase Planes) ──
    reg [3:0] sedenion_reg [0:3];

    // 状態遷移パラメータ
    localparam ST_IDLE = 2'b00;
    localparam ST_SCAN = 2'b01;
    localparam ST_DONE = 2'b10;

    reg [1:0] current_state, next_state;
    reg [9:0] scan_cnt;

    // 融合クロックによる自律同期ステートマシン
    always @(posedge fused_clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= ST_IDLE;
            scan_cnt      <= 10'd0;
        end else begin
            current_state <= next_state;
            if (current_state == ST_SCAN) begin
                scan_cnt <= scan_cnt + 1'b1;
            end else begin
                scan_cnt <= 10'd0;
            end
        end
    end

    // 次状態ロジック
    always @(*) begin
        case (current_state)
            ST_IDLE: next_state = start_shot ? ST_SCAN : ST_IDLE;
            ST_SCAN: next_state = (scan_cnt == 10'd1023) ? ST_DONE : ST_SCAN;
            ST_DONE: next_state = ST_IDLE;
            default: next_state = ST_IDLE;
        endcase
    end

    // ── データパス用レジスタ ──
    reg r_vcsel_en;
    reg [9:0] r_mat_x;
    reg [9:0] r_mat_y;
    reg r_complete;

    reg [7:0] r_simplex_vol;
    reg [15:0] r_twist_amp;

    // 【🆕 Detokenizer 用データパスレジスタ】
    reg [7:0] r_simplex_vol_tok;  // データ幅を修正
    reg [15:0] r_twist_amp_tok;   // データ幅を修正
    reg r_detok_req;
    reg r_detok_valid;

    // ── 組合せ回路によるアンプリチューヘデロン演算器 ──
    wire [7:0] calc_simplex_vol;
    wire [15:0] calc_twist_amp;

    assign calc_simplex_vol = (sedenion_reg[0] * sedenion_reg[1]) + 
                              (sedenion_reg[2] * sedenion_reg[3]) + 
                              ({4'd0, scan_cnt[3:0]});

    assign calc_twist_amp   = ({8'h00, sedenion_reg[0], sedenion_reg[1]} ^ 
                              {scan_cnt[7:0], sedenion_reg[2], sedenion_reg[3]}) + 
                              16'h1026;

    // ── 同期式データパス（Case文を極限まで簡素化、デトークナイザー統合） ──
    always @(posedge fused_clk or negedge rst_n) begin
        if (!rst_n) begin
            r_vcsel_en      <= 1'b0;
            r_mat_x         <= 10'd0;
            r_mat_y         <= 10'd0;
            r_complete      <= 1'b0;
            r_simplex_vol   <= 8'd0;
            r_twist_amp     <= 16'd0;
            sedenion_reg[0] <= 4'd0;
            sedenion_reg[1] <= 4'd0;
            sedenion_reg[2] <= 4'd0;
            sedenion_reg[3] <= 4'd0;

            r_simplex_vol_tok <= 8'd0;
            r_twist_amp_tok   <= 16'd0;
            r_detok_req       <= 1'b0;
            r_detok_valid     <= 1'b0;
        end else begin
            // デフォルト値
            r_complete      <= 1'b0;
            r_vcsel_en      <= 1'b0;
            r_detok_req     <= 1'b0;
            r_detok_valid   <= 1'b0;

            if (current_state == ST_IDLE) begin
                if (start_shot) begin
                    sedenion_reg[0] <= flash_atc_wave_m;
                    sedenion_reg[1] <= flash_atc_wave_ui;
                    sedenion_reg[2] <= flash_atc_wave_ej;
                    sedenion_reg[3] <= flash_atc_wave_ek;
                end
            end
            else if (current_state == ST_SCAN) begin
                r_vcsel_en    <= 1'b1;
                r_mat_x       <= scan_cnt;
                r_mat_y       <= scan_cnt ^ {6'd0, sedenion_reg[0]}; 
                r_simplex_vol <= calc_simplex_vol;
                r_twist_amp   <= calc_twist_amp;
            end
            else if (current_state == ST_DONE) begin
                r_complete <= 1'b1;

                // ST_DONEに入った瞬間にデトークン要求をアサートし、データをラッチ
                r_detok_req       <= 1'b1;
                r_detok_valid     <= 1'b1;
                r_simplex_vol_tok <= amplituhedron_vol;
                r_twist_amp_tok   <= twist_string_amp;
            end
        end
    end

    // 出力アサイン
    assign vcsel_x_scan_en      = r_vcsel_en;
    assign matrix_x_addr        = r_mat_x;
    assign matrix_y_addr        = r_mat_y;
    assign amplituhedron_vol    = r_simplex_vol;
    assign twist_string_amp     = r_twist_amp;
    assign active_sedenion_out  = sedenion_reg[0] ^ sedenion_reg[1] ^ sedenion_reg[2] ^ sedenion_reg[3];
    assign qpu_shot_complete    = r_complete;

    assign ca_detok_req         = r_detok_req;
    assign ca_simplex_vol_tok   = r_simplex_vol_tok;
    assign ca_twist_amp_tok     = r_twist_amp_tok;
    assign ca_detok_valid       = r_detok_valid;

endmodule
