`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NATIONAL INSTITUTE OF TECHNOLOGY WARANGAL
// Engineer: NARENDRA KUMAR NEHRA 
// 
// Create Date: 21.04.2023 23:58:35
// Design Name: 
// Module Name: VENDING_MACHINE
//////////////////////////////////////////////////////////////////////////////////

 module VENDING_MACHINE( input [2:0] COIN,SEL_P,input  RST ,CLK ,output reg [2:0] PRODUCT,reg [2:0] BALANCE);
 

parameter idle   = 3'b000,
          ONE    = 3'b001,
          TWO    = 3'b010,
          THREE  = 3'b011,
          FOUR   = 3'b100,
          FIVE   = 3'b101,
          SIX    = 3'b110,
          RET_2  = 3'b111;
         
         
reg [2:0] state, next_state;
       parameter [1:0]  NONE  =2'b00,
                        pepsi =2'b01,
                        cock = 2'b10,
                        DEW  = 2'b11;

 initial 
     begin 
          state     = 3'b000;
          next_state= 3'b000;
     end 
   always @(posedge CLK or  posedge RST )
          
             if(RST)
                next_state = idle;
                else if(SEL_P == NONE || COIN == 0 )
                begin
                  PRODUCT = 0;
                  BALANCE = COIN;
                  state = idle;
                end 
              
              else 
                state = next_state;
            
        
         always @(state or COIN)
                if(COIN !=1 && COIN!=2 && COIN!=5)
                 begin
                   PRODUCT = 0;
                   BALANCE = COIN;
                   next_state = idle;
                 end 
                else 
             case(state)
                   
                      idle:
                       case(COIN)
                         idle:
                            begin
                               PRODUCT = 0;
                               BALANCE = 0;
                               next_state = idle;
                             end   
                            ONE:  next_state = ONE;
                            TWO:  next_state = TWO;
                            FIVE: next_state = FIVE;
                       endcase
                            
                      ONE: 
                          case(COIN)
                        idle:
                            begin
                               PRODUCT = 0;
                               BALANCE = 1;
                               next_state = idle;
                             end 
                              
                            ONE:  
                             begin
                               PRODUCT = 1;
                               BALANCE = 0;
                               next_state = idle;
                               
                             end 
                            TWO:  
                             begin
                               PRODUCT = SEL_P;
                               BALANCE = 1;
                               next_state = idle;
                             end 
                           FIVE:
                             begin
                               PRODUCT = 0;
                               BALANCE = 2;
                               next_state = RET_2;
                             end
                            endcase
                              
                       TWO:   
                              begin
                               PRODUCT = SEL_P;
                               BALANCE = 0;
                               next_state = idle;
                              end 
                       
                         FIVE:   
                              begin
                               PRODUCT = 0;
                               BALANCE = 1;
                               next_state = RET_2;
                              end      
                       RET_2:
                              begin
                                next_state = idle;
                                PRODUCT = SEL_P;
                                BALANCE = 2;
                               end
                  
                      
          endcase
          

endmodule


