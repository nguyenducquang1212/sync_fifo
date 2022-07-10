module sync_fifo_tb ();

logic                  i_clk            ;
logic                  i_rst_n          ;
logic                  i_valid_s        ;
logic                  i_ready_m        ;
logic [WIDTH-1:0]      i_almostempty_lvl;
logic [WIDTH-1:0]      i_almostfull_lvl ;
logic [DATA_WIDTH-1:0] i_datain         ;
wire                   o_almostfull     ;
wire                   o_full           ;
wire                   o_ready_s        ;
wire                   o_valid_m        ;
wire                   o_almostempty    ;
wire                   o_empty          ;
wire  [DATA_WIDTH-1:0] o_dataout        ;


sync_fifo #(
	.FIFO_DEPTH (8)
	.DATA_WIDTH (32)
	.WIDTH      (8)
) DUT (
	.i_clk            (i_clk            ),
	.i_rst_n          (i_rst_n          ),
	.i_valid_s        (i_valid_s        ),
	.i_ready_m        (i_ready_m        ),
	.i_almostempty_lvl(i_almostempty_lvl),
	.i_almostfull_lvl (i_almostfull_lvl ),
	.i_datain         (i_datain         ),
	.o_almostfull     (o_almostfull     ),
	.o_full           (o_full           ),
	.o_ready_s        (o_ready_s        ),
	.o_valid_m        (o_valid_m        ),
	.o_almostempty    (o_almostempty    ),
	.o_empty          (o_empty          ),
	.o_dataout        (o_dataout        )
);

always #10 i_clk = ~i_clk;

initial begin 
	i_clk             = 0;
	i_rst_n           = 0;
	i_valid_s         = 0;
	i_ready_m         = 0;
	i_almostempty_lvl = 2;
	i_almostfull_lvl  = 5;
	i_datain          = 0;
	repeat(5) begin 
		@(negedge i_clk);
		i_datain = $random();
		i_valid_s = 1;
	end
end

endmodule