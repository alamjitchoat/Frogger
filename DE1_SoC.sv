// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays
    assign HEX0 = '1;
    assign HEX1 = '1;
    assign HEX2 = '1;
    assign HEX3 = '1;
    assign HEX4 = '1;
    assign HEX5 = '1;
	 
	 
	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal	 
	 /* If you notice flickering, set SYSTEM_CLOCK faster.
	    However, this may reduce the brightness of the LED board. */
	
	 
	 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST;						// reset - toggle this on startup
	 logic [15:0] car1, car3, car5, car6;
	 logic [15:0] LSFRoutput;
	 logic [15:0] rowPattern; 
	 integer      rowNumber, bitNumber;
	 logic L, R, U, D;
	 logic winResult, loseResult;	 
	 
	 assign RST = SW[9];
	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	 
	 /* LED board test submodule - paints the board with a static pattern.
	    Replace with your own code driving RedPixels and GrnPixels.
		 
	 	 SW9      : Reset
		 =================================================================== */
	 // Code to enable KEY0-KEY3 as buttons and generate a LSFR output
	 buttonInput leftKey (.Clock(SYSTEM_CLOCK), .Reset(RST), .Out(L), .Key(~KEY[0]));
	 buttonInput rightKey (.Clock(SYSTEM_CLOCK), .Reset(RST), .Out(R), .Key(~KEY[1]));
	 buttonInput upKey (.Clock(SYSTEM_CLOCK), .Reset(RST), .Out(U), .Key(~KEY[2]));
	 buttonInput downKey (.Clock(SYSTEM_CLOCK), .Reset(RST), .Out(D), .Key(~KEY[3]));
	 LSFR l (LSFRoutput[15:0], SYSTEM_CLOCK, reset);
	 
	 // code to create 4 car patterns from the LSFR output
	 shift_operator shift1 (.clk(SYSTEM_CLOCK), .reset(RST), .rowToShift(LSFRoutput[15:0]), .shiftedRow(car1), .shiftPattern(LSFRoutput[15:0]));
	 shift_operator shift3 (.clk(SYSTEM_CLOCK), .reset(RST), .rowToShift(LSFRoutput[15:0]), .shiftedRow(car3), .shiftPattern(LSFRoutput[15:0]));
	 shift_operator shift5 (.clk(SYSTEM_CLOCK), .reset(RST), .rowToShift(LSFRoutput[15:0]), .shiftedRow(car5), .shiftPattern(LSFRoutput[15:0]));
	 shift_operator shift6 (.clk(SYSTEM_CLOCK), .reset(RST), .rowToShift(LSFRoutput[15:0]), .shiftedRow(car6), .shiftPattern(LSFRoutput[15:0]));
	 
	 
	 // code to shift a green pixel left,right, up or down and reset correctly
	 shift_LR LR (.clk(SYSTEM_CLOCK), .reset(RST), .L(L), .R(R), .rowPattern(rowPattern), .bitNumber(bitNumber), .winResult(winResult), .loseResult(loseResult), .rowNumber(rowNumber));
	 shift_UD UD (.clk(SYSTEM_CLOCK), .reset(RST), .U(U), .D(D), .rowNumber(rowNumber), .winResult(winResult), .loseResult(loseResult));
	 
	 
	 // code displaying overall board red and green pixels
	 board_display display (.clk(SYSTEM_CLOCK), .reset(RST), .car1(car1), .car3(car3), .car5(car5), .car6(car6), 
	 .displayPattern(rowPattern), .displayRow(rowNumber), .RedPixels, .GrnPixels);
	 	 
	 
	 // code to determine if user won or lost 
	game_result resultOfGame (.clk(SYSTEM_CLOCK), .reset(RST), .rowNumber(rowNumber), .bitNumber(bitNumber), .RedPixels, .GrnPixels, 
	 .winResult(winResult), .loseResult(loseResult));
	 
endmodule


module DE1_SoC_testbench();
    logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 logic [9:0]  LEDR;
    logic [3:0]  KEY;
    logic [9:0]  SW;
    logic [35:0] GPIO_1;
    logic CLOCK_50;
	 logic [15:0][15:0]RedPixels; 
    logic [15:0][15:0]GrnPixels; 
	 logic RST;						
	 logic [15:0] car1, car3, car5, car6;
	 logic [15:0] LSFRoutput;
	 logic [15:0] rowPattern; 
	 integer      rowNumber, bitNumber;
	 logic L, R, U, D;
	 logic winResult, loseResult;	


	DE1_SoC dut (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial begin
    	CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		@(posedge CLOCK_50); RST <= 1;
		@(posedge CLOCK_50); RST <= 0; 
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);
		@(posedge CLOCK_50); L <= 0; R <= 1; U <= 0; D <= 0;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);            
		@(posedge CLOCK_50); L <= 0; R <= 1; U <= 0; D <= 0;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);            
		@(posedge CLOCK_50); L <= 0; R <= 1; U <= 0; D <= 0;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50); 
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50); L <= 1; R <= 0; U <= 0; D <= 0;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);		
		@(posedge CLOCK_50); L <= 1; R <= 0; U <= 0; D <= 0;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);            
		@(posedge CLOCK_50); L <= 1; R <= 0; U <= 0; D <= 0;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);             
		@(posedge CLOCK_50); L <= 0; R <= 0; U <= 1; D <= 0;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);          
		@(posedge CLOCK_50); L <= 0; R <= 0; U <= 1; D <= 0;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);            
		@(posedge CLOCK_50); L <= 0; R <= 0; U <= 1; D <= 0;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);             
		@(posedge CLOCK_50); L <= 0; R <= 0; U <= 0; D <= 1;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);            
		@(posedge CLOCK_50); L <= 0; R <= 0; U <= 0; D <= 1;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);            
		@(posedge CLOCK_50); L <= 0; R <= 0; U <= 0; D <= 1;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);          
		@(posedge CLOCK_50); L <= 0; R <= 0; U <= 0; D <= 0;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50);            
		@(posedge CLOCK_50); RST <= 1;
		@(posedge CLOCK_50);           
		@(posedge CLOCK_50); 
		$stop; // End the simulation
	end
endmodule