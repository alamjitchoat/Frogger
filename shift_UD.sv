module shift_UD(clk, reset, U, D, rowNumber, winResult, loseResult);
  
  input logic         clk, reset, U, D, winResult, loseResult;
  output integer      rowNumber;
  
   
	always_ff @(posedge clk)
		if (reset | loseResult | winResult) begin
			rowNumber = 7;
		end else if (U & ~D & rowNumber != 0)  begin
			rowNumber = rowNumber - 1;
		end else if (~U & D & rowNumber != 7) begin
			rowNumber = rowNumber + 1;
		end else begin
			rowNumber <= rowNumber;
		end
		
endmodule

module shift_UD_testbench();
   logic         clk, reset, U, D, winResult, loseResult;
   integer      rowNumber;
	
	shift_UD dut(clk, reset, U, D, rowNumber, winResult, loseResult);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
    	clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	@(posedge clk);	reset <= 1;
	@(posedge clk);	reset <= 0; rowNumber <= 0;
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	D <= 1;		U <= 0;
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	D <= 1;		U <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	D <= 1;		U <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	D <= 1;		U <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	D <= 1;		U <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	D <= 1;		U <= 0;
	@(posedge clk);
	@(posedge clk);	
	@(posedge clk);	D <= 1;		U <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	D <= 0;		U <= 1;
	@(posedge clk);
	@(posedge clk);	
	@(posedge clk);	D <= 0;		U <= 1;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	D <= 0;		U <= 1;
	@(posedge clk);	
	@(posedge clk);	
	@(posedge clk);	D <= 0;		U <= 1;
	@(posedge clk);		
	@(posedge clk);
	@(posedge clk);	D <= 0;		U <= 1;
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	D <= 0;		U <= 1;
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	reset <= 1;		
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);

	$stop;
	end
endmodule





