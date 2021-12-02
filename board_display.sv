module board_display(clk, reset, car1, car3, car5, car6, displayPattern, displayRow, RedPixels, GrnPixels);
	input logic clk, reset;
	input logic [15:0] car1, car3, car5, car6, displayPattern;
	input integer displayRow;
	output logic [15:0] [15:0] RedPixels;
	output logic [15:0] [15:0] GrnPixels;
	
	 always_comb begin
		if (reset) begin
			RedPixels = '0;
			GrnPixels = '0;
		end
		else if (displayRow == 0) begin
			GrnPixels[00] = 16'b0000000000000000;
			GrnPixels[01] = 16'b0000000000000000;
			GrnPixels[02] = 16'b0000000000000000;
			GrnPixels[03] = 16'b0000000000000000;
			GrnPixels[04] = 16'b0000000000000000;
			GrnPixels[05] = 16'b0000000000000000;
			GrnPixels[06] = 16'b0000000000000000;
			GrnPixels[07] = 16'b0000000100000000;
			RedPixels[01] = car1;
		   RedPixels[03] = car3;
		   RedPixels[05] = car5;
		   RedPixels[06] = car6;
		end
		else if (displayRow == 1) begin
			GrnPixels[displayRow] = displayPattern;
			GrnPixels[00] = 16'b0000000000000000;
			GrnPixels[02] = 16'b0000000000000000;
			GrnPixels[03] = 16'b0000000000000000;
			GrnPixels[04] = 16'b0000000000000000;
			GrnPixels[05] = 16'b0000000000000000;
			GrnPixels[06] = 16'b0000000000000000;
			GrnPixels[07] = 16'b0000000000000000;
			RedPixels[01] = car1;
		   RedPixels[03] = car3;
		   RedPixels[05] = car5;
		   RedPixels[06] = car6;
		end
		else if (displayRow == 2) begin
			GrnPixels[displayRow] = displayPattern;
			GrnPixels[00] = 16'b0000000000000000;
			GrnPixels[01] = 16'b0000000000000000;
			GrnPixels[03] = 16'b0000000000000000;
			GrnPixels[04] = 16'b0000000000000000;
			GrnPixels[05] = 16'b0000000000000000;
			GrnPixels[06] = 16'b0000000000000000;
			GrnPixels[07] = 16'b0000000000000000;
			RedPixels[01] = car1;
		   RedPixels[03] = car3;
		   RedPixels[05] = car5;
		   RedPixels[06] = car6;
		end
		else if (displayRow == 3) begin
			GrnPixels[displayRow] = displayPattern;
			GrnPixels[00] = 16'b0000000000000000;
			GrnPixels[01] = 16'b0000000000000000;
			GrnPixels[02] = 16'b0000000000000000;
			GrnPixels[04] = 16'b0000000000000000;
			GrnPixels[05] = 16'b0000000000000000;
			GrnPixels[06] = 16'b0000000000000000;
			GrnPixels[07] = 16'b0000000000000000;
		   RedPixels[01] = car1;
		   RedPixels[03] = car3;
		   RedPixels[05] = car5;
		   RedPixels[06] = car6;
		end
		else if (displayRow == 4) begin
			GrnPixels[displayRow] = displayPattern;
			GrnPixels[00] = 16'b0000000000000000;
			GrnPixels[01] = 16'b0000000000000000;
			GrnPixels[02] = 16'b0000000000000000;
			GrnPixels[03] = 16'b0000000000000000;
			GrnPixels[05] = 16'b0000000000000000;
			GrnPixels[06] = 16'b0000000000000000;
			GrnPixels[07] = 16'b0000000000000000;
		   RedPixels[01] = car1;
		   RedPixels[03] = car3;
		   RedPixels[05] = car5;
		   RedPixels[06] = car6;
		end
		else if (displayRow == 5) begin
			GrnPixels[displayRow] = displayPattern;
			GrnPixels[00] = 16'b0000000000000000;
			GrnPixels[01] = 16'b0000000000000000;
			GrnPixels[02] = 16'b0000000000000000;
			GrnPixels[03] = 16'b0000000000000000;
			GrnPixels[04] = 16'b0000000000000000;
			GrnPixels[06] = 16'b0000000000000000;
			GrnPixels[07] = 16'b0000000000000000;
		   RedPixels[01] = car1;
		   RedPixels[03] = car3;
		   RedPixels[05] = car5;
		   RedPixels[06] = car6;
		end		
		else if (displayRow == 6) begin
			GrnPixels[displayRow] = displayPattern;
			GrnPixels[00] = 16'b0000000000000000;
			GrnPixels[01] = 16'b0000000000000000;
			GrnPixels[02] = 16'b0000000000000000;
			GrnPixels[03] = 16'b0000000000000000;
			GrnPixels[04] = 16'b0000000000000000;
			GrnPixels[05] = 16'b0000000000000000;
			GrnPixels[07] = 16'b0000000000000000;
		   RedPixels[01] = car1;
		   RedPixels[03] = car3;
		   RedPixels[05] = car5;
		   RedPixels[06] = car6;
		end
		else if (displayRow == 7) begin
			GrnPixels[displayRow] = displayPattern;
			GrnPixels[00] = 16'b0000000000000000;
			GrnPixels[01] = 16'b0000000000000000;
			GrnPixels[02] = 16'b0000000000000000;
			GrnPixels[03] = 16'b0000000000000000;
			GrnPixels[04] = 16'b0000000000000000;
			GrnPixels[05] = 16'b0000000000000000;
			GrnPixels[06] = 16'b0000000000000000;
		   RedPixels[01] = car1;
		   RedPixels[03] = car3;
		   RedPixels[05] = car5;
		   RedPixels[06] = car6;
		end		
		else begin
		  GrnPixels[displayRow] = displayPattern;
		end
	end
endmodule

module board_display_testbench();
	logic clk, reset;
	logic [15:0] car1, car3, car5, car6, displayPattern;
	integer displayRow;
	logic [15:0] [15:0] RedPixels;
	logic [15:0] [15:0] GrnPixels;
	
	board_display dut(clk, reset, car1, car3, car5, car6, displayPattern, displayRow, RedPixels, GrnPixels);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
    	clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
	@(posedge clk);	reset <= 1;
	@(posedge clk);	reset <= 0; displayPattern <= 16'b0000000100000000;
	@(posedge clk);	car1 <= 16'b0000000100000000; car3 <= 16'b0000000100000000; car5 <= 16'b0000000100000000; car6 <= 16'b0000000100000000;
	@(posedge clk);
	@(posedge clk);	displayRow <= 1;	
	@(posedge clk);	
	@(posedge clk);
	@(posedge clk);	displayRow <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	displayRow <= 1;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	displayRow <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	displayRow <= 1;
	@(posedge clk);	displayRow <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	displayRow <= 1;
	@(posedge clk);	displayRow <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	displayRow <= 1;
	@(posedge clk);	displayRow <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	displayRow <= 1;
	@(posedge clk);	displayRow <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	displayRow <= 1;
	@(posedge clk);	displayRow <= 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);	displayRow <= 1;
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