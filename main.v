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
    input [1:0] sw,
    output pwm1,
    output pwm2
);


     //pwm 1: Period of the full 16 bits and a duty cycle of 40%
     //65535 * 0.40 = 26214
     pwm #(17,  65535)
     wave1(
          .clk(clk),
          .duty(26214),
          .pulse(pulse1)
     );

     //pwm 2: Create a period of 1 ms and a duty cycle of 10%
     pwm #(17,  100000)
     wave2(
          .clk(clk),
          .duty(10000),
          .pulse(pulse2)
     );
     
     //Send out the pulses
     assign pwm1 = (sw[0]) ? pulse1:0;
     assign pwm2 = (sw[1]) ? pulse2:0;
     
endmodule