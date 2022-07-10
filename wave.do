onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sync_fifo_tb/FIFO_DEPTH
add wave -noupdate /sync_fifo_tb/DATA_WIDTH
add wave -noupdate /sync_fifo_tb/WIDTH
add wave -noupdate /sync_fifo_tb/DUT/i_clk
add wave -noupdate /sync_fifo_tb/DUT/i_rst_n
add wave -noupdate /sync_fifo_tb/DUT/i_valid_s
add wave -noupdate /sync_fifo_tb/DUT/i_ready_m
add wave -noupdate /sync_fifo_tb/DUT/i_almostempty_lvl
add wave -noupdate /sync_fifo_tb/DUT/i_almostfull_lvl
add wave -noupdate /sync_fifo_tb/DUT/ptr
add wave -noupdate -expand /sync_fifo_tb/DUT/fifo
add wave -noupdate /sync_fifo_tb/DUT/i_datain
add wave -noupdate /sync_fifo_tb/DUT/o_almostfull
add wave -noupdate /sync_fifo_tb/DUT/o_full
add wave -noupdate /sync_fifo_tb/DUT/o_ready_s
add wave -noupdate /sync_fifo_tb/DUT/o_valid_m
add wave -noupdate /sync_fifo_tb/DUT/o_almostempty
add wave -noupdate /sync_fifo_tb/DUT/o_empty
add wave -noupdate /sync_fifo_tb/DUT/o_dataout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {271 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {692 ns}
