module game_result(clk, reset, rowNumber, bitNumber, RedPixels, GrnPixels, winResult, loseResult);
  
  input logic         clk, reset;
  input integer       bitNumber, rowNumber;
  input logic         [15:0] [15:0] RedPixels;
  input logic         [15:0] [15:0] GrnPixels;
  output logic        winResult, loseResult; 
  
   
	always_ff @(posedge clk)
		if (reset) begin
			winResult = 0;
			loseResult = 0;
		end else if ((GrnPixels[rowNumber][bitNumber] == 1) & (RedPixels[rowNumber][bitNumber] == 1)) begin
			loseResult = 1;
			winResult = 0;
		end else if (rowNumber == 0) begin
			winResult = 1;
			loseResult = 0;
		end else begin
			winResult = 0;
			loseResult = 0;
		end	
endmodule

module game_result_testbench();
  logic         clk, reset;
  integer       bitNumber, rowNumber;
  logic         [15:0] [15:0] RedPixels;
  logic         [15:0] [15:0] GrnPixels;
  logic         winResult, loseResult; 
	
	game_result dut(clk, reset, rowNumber, bitNumber, RedPixels, GrnPixels, winResult, loseResult);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
    	clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	@(posedge clk);	reset <= 1;
	@(posedge clk);	reset <= 0; 
	@(posedge clk);	
	@(posedge clk);   rowNumber <= 0; winResult <= 1;
	@(posedge clk);	
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	rowNumber <= 6; bitNumber <= 6; loseResult <= 1;
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
