/*
Filename : main.v
-------------------------------------------------------
Pulse Width Modulation TestBench
-------------------------------------------------------
Main module for this example code. Here we initiate the state machines and various 
modules.
-------------------------------------------------------
Author : Akhil Kapadia
-------------------------------------------------------
*/

module main (
    input clk,
    input [4:0] sw,
    output [1:0] pwm
);
     reg [15:0] duty;


     //pwm 1: Period of 2000000 ns or 50 Hz and a width of 1 ms.
     pwm #(21,  2000000)    //50 Hz pulse
     wave1(
          .clk(clk),
          .duty(1000000),   // 1 ms pulse width
          .pulse(pulse1)
     );

     //pwm 2: Create a period of 1 ms and various duty cycles
     pwm #(16,  100000)
     wave2(
          .clk(clk),
          .duty(duty),
          .pulse(pulse2)
     );
     
     //Send out the pulses
     assign pwm = (sw[0]) ? {pulse1, pulse2}: 2'b0;
     
     //change the speed
     always @(posedge clk ) begin
          case (sw[4:1])
               4'b0001: duty = 25000;     //25%
               4'b0010: duty = 50000; //50%
               4'b0100: duty = 75000; //75%
               4'b1000: duty = 95000; //95%
               default: duty = 0;
          endcase
     end
          
endmodule