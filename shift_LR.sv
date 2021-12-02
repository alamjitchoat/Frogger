module shift_LR(clk, reset, L, R, rowPattern, bitNumber, winResult, loseResult, rowNumber);
  
  input logic         clk, reset, L, R, winResult, loseResult;
  input integer       rowNumber;
  output logic [15:0] rowPattern;
  output integer      bitNumber;
  
   
	always_ff @(posedge clk)
		if (reset | winResult | loseResult) begin
			rowPattern <= 16'b0000000100000000;
			bitNumber <= 8;
		end else if (L & ~R & rowPattern != 16'b1000000000000000)  begin
			rowPattern <= rowPattern << 1;
			bitNumber = bitNumber + 1;
		end else if (R & ~L & rowPattern != 16'b0000000000000001) begin
			rowPattern <= rowPattern >> 1;
			bitNumber = bitNumber - 1;
		end else begin
			rowPattern <= rowPattern;
			bitNumber <= bitNumber;
		end
		
endmodule

module shift_LR_testbench();
   logic         clk, reset, L, R, winResult, loseResult;
   integer       rowNumber;
   logic    [15:0] rowPattern;
   integer      bitNumber;
	
	shift_LR dut(clk, reset, L, R, rowPattern, bitNumber, winResult, loseResult, rowNumber);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
    	clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	@(posedge clk);	reset <= 1;
	@(posedge clk);	reset <= 0; rowPattern <= 16'b0000000100000000;
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	L <= 1;		R <= 0;
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	L <= 1;		R <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	L <= 1;		R <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	L <= 1;		R <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	L <= 1;		R <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	L <= 1;		R <= 0;
	@(posedge clk);
	@(posedge clk);	
	@(posedge clk);	L <= 1;		R <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	L <= 1;		R <= 0;
	@(posedge clk);
	@(posedge clk);	
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	L <= 0;		R <= 1;
	@(posedge clk);	
	@(posedge clk);	
	@(posedge clk);	L <= 0;		R <= 1;
	@(posedge clk);		
	@(posedge clk);
	@(posedge clk);	L <= 0;		R <= 1;
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	L <= 0;		R <= 1;
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	L <= 0;		R <= 1;
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	reset <= 1;		
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);

	$stop;
	end
endmodule


