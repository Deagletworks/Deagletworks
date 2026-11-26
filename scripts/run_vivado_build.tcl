# =====================================================================
# Vivado Non-Project Mode Build Script with Timestamp Output
# =====================================================================

# 現在の日時を "YYYYMMDD_HHMMSS" 形式で取得
set timestamp [clock format [clock seconds] -format "%Y%m%d_%H%M%S"]
set output_dir "C:/qpu_design_center/releases/CI_Build_$timestamp"

# タイムスタンプ付きの出力フォルダを作成
file mkdir $output_dir
puts "INFO: Output directory set to: $output_dir"

puts "INFO: Setting Target Part..."
set_part xc7a35tcpg236-1

puts "INFO: Reading RTL Source Files..."
read_verilog "./rtl/qpu_url_bound_guard.v"
read_verilog "./rtl/qpu_system_amplituhedron_integrated_top.v"
read_verilog "./rtl/qpu_axi_token_bridge.v"

# 1. 論理合成 (Synthesis)
puts "INFO: Starting Logic Synthesis..."
synth_design -top qpu_system_amplituhedron_integrated_top -part xc7a35tcpg236-1 \
    -generic BOUND_ENDPOINT_URL_HASH=128'h14492FE0FABA765E3BE2325B3D040B58 \
    -generic EXPECTED_HOW_CODE=32'h44455601 \
    -generic EXPECTED_DEVICE_DNA=64'h0123456789ABCDEF \
    -generic IS_PRODUCTION_BUILD=1'b0

write_checkpoint -force "$output_dir/post_synth.dcp"
report_utilization -file "$output_dir/synth_utilization.txt"

# 2. 配置 (Placement)
puts "INFO: Starting Placement..."
place_design
write_checkpoint -force "$output_dir/post_place.dcp"

# 3. 配線 (Routing)
puts "INFO: Starting Routing..."
route_design
write_checkpoint -force "$output_dir/post_route_locked.dcp"

# 4. 各種レポート出力
puts "INFO: Generating Final Reports..."
report_utilization -file "$output_dir/route_utilization.txt"
report_timing_summary -file "$output_dir/route_timing_summary.txt"
report_power -file "$output_dir/route_power.txt"

puts "INFO: Build Completed Successfully in $output_dir !"
exit
