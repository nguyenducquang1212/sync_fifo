module sync_fifo 
#(
	parameter FIFO_DEPTH = 256,
	parameter DATA_WIDTH =  32,
	parameter WIDTH      = 8
) (
	input                         i_clk            , // Source domain clock
	input                         i_rst_n          , // Source domain asynchronous reset (active low)
	input                         i_valid_s        , // Request write data into FIFO
	input                         i_ready_m        , // Request read data from FIFO
	input        [WIDTH-1:0]      i_almostempty_lvl, // "The number of empty memory locations in the FIFO at which the o_almostempty flag is active"					
	input        [WIDTH-1:0]      i_almostfull_lvl , // "The number of empty memory locations in the FIFO at which the o_almostfull flag is active"					
	input        [DATA_WIDTH-1:0] i_datain         , // Push data in FIFO
	output logic                  o_almostfull     , // FIFO almostfull flag (determined by i_almostfull_lvl)
	output logic                  o_full           , // FIFO full flag
	output logic                  o_ready_s        , // "Status write data into FIFO (if FIFO not full then o_ready_s = 1)"					
	output logic                  o_valid_m        , // "Status read data from FIFO (if FIFO not empty then o_valid_m = 1)"					
	output logic                  o_almostempty    , // FIFO almostempty flag (determined by i_almostempty_lvl)
	output logic                  o_empty          , // FIFO empty flag
	output logic [DATA_WIDTH-1:0] o_dataout          // Pop data from FIFO
);

logic [DATA_WIDTH-1:0] fifo [FIFO_DEPTH-1:0];
logic [WIDTH-1:0] ptr;

assign o_dataout = fifo[0];
assign o_almostfull = (ptr == (i_almostfull_lvl-1));
assign o_full       = (ptr == (FIFO_DEPTH-1));
assign o_valid_m    = !o_full;
assign o_empty      = (!|ptr);
assign o_ready_s    = !o_empty;
assign o_almostempty= (ptr == (i_almostempty_lvl-1));

always_ff @(posedge i_clk or negedge i_rst_n) begin
	if(~i_rst_n) begin
		ptr <= {WIDTH{1'b0}};
	end else begin
		case ({i_ready_m, i_valid_s})
			2'b01: begin
				if (o_full) begin
					ptr <= ptr;
				end
				else begin 
					ptr <= ptr + 1;
				end
			end
			2'b10: begin 
				if (o_empty) begin
					ptr <= ptr;
				end
				else begin 
					ptr <= ptr - 1;
				end
			end
			default: begin 
				ptr <= ptr;
			end
		endcase
	end
end

always_ff @(posedge i_clk or negedge i_rst_n) begin
	if(~i_rst_n) begin
		for (int i = 0; i < FIFO_DEPTH; i++) begin
			fifo[i] <= {DATA_WIDTH{1'b0}};
		end
	end else begin
		case ({i_ready_m, i_valid_s})
			2'b01: begin 
				if (o_valid_m) begin
					fifo[ptr] <= i_datain;					
				end
			end
			2'b10: begin 
				if (o_ready_s) begin
					for (int i = 0; i < FIFO_DEPTH-1; i++) begin
						fifo[i] <= fifo[i+1];
					end
				end
			end
			2'b11: begin 
				for (int i = 0; i < FIFO_DEPTH-1; i++) begin
					if (i == ptr) begin
						fifo[i] <= i_datain;
					end
					else begin 
						fifo[i] <= fifo[i+1];
					end
				end
			end
			//default : /* default */;
		endcase
	end
end

endmodule