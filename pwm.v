/*
Filename: pwm.v
-------------------------------------------------------
Pulse Width Modulation Module
-------------------------------------------------------
Creates a pwm signal with a given period and duty cycle. Counting is incremented every
10 ns which is the clock speed of the BASYS 3 board. By specifying the parameters we can 
precisely create different clocks and pwms of varying width/duty. SIZE is the bit size of
the period, and the PERIOD parameter is used to fine tune the period/frequency of the signal.
The input "duty" is the duration of the pulse width and duty/period can be used to calculate the
duty cycle.
-------------------------------------------------------
Author : Akhil Kapadia
Based off code made by Rice Rodriguez
https://github.com/ricerodriguez/ttu-lab1-code-examples/blob/master/part1-clocks-and-counters/example3_pwm.v
-------------------------------------------------------
*/
//Instantiate the module and declare inputs, output, and/or parameters.
module pwm #(parameter SIZE = 12, PERIOD = 4095)
(input clk,
input [SIZE-1:0] duty,	
output reg pulse);

//Create local register to count to the duty cycle
reg [SIZE-1:0] count;

//Initalize all registers. This is only useful for testbench purposes.
initial
	begin
		count <=0;
		pulse <= 0;
	end

//As the pwm is based on the BASYS clk, we use procedural assignment.
always @ (posedge clk)
	begin
//Increase Count each time the BASYS clock pulses.
		count <= (count < PERIOD) ? count + 1 : 0;
//Send out a signal according to what duty is.
		pulse <= (count < duty) ? 1 : 0;
	end
endmodule