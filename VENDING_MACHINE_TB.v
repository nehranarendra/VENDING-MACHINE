`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NATIONAL INSTITUTE OF TECHNOLOGY WARANGAL
// Engineer: NARENDRA KUMAR NEHRA 
// 
// Create Date: 21.04.2023 23:58:35
// Design Name: 
// Module Name: VENDING_MACHINE_TB
//////////////////////////////////////////////////////////////////////////////////


module VENDING_MACHINE_TB();
      
     reg [2:0] coin ,SEL_P;
     reg clk,rst;
     wire [2:0] prod;
       wire [2:0] balance;
     
     VENDING_MACHINE  VM (coin ,SEL_P,rst,clk  , prod, balance );
     always #5 clk = ~clk;
     initial 
         begin 
            coin =0;
            clk = 0;
            rst = 0;
            SEL_P= 1;
            
         end 
      
   

   // always #10 rst = ~rst;
 initial 
 begin    
  #10 coin = 0;
  #10 coin  =1;
  #10 coin = 0;
  #10 coin = 1;
  #10 coin = 2;
  #10 coin = 0;
  #10 coin = 2;
  #10 coin = 0;
  #10 coin = 1;
  #10 coin = 5;
  #10 coin = 0;
  #20 coin = 5;
  #20 coin = 0;
  #10 coin = 4;
  #10 coin = 6;
  #10 coin  = 7;
   $finish;
   end 
   

 
endmodule