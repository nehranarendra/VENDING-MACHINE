`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NATIONAL INSTITUTE OF TECHNOLOGY WARANGAL
// Engineer: NARENDRA KUMAR NEHRA 
// 
// Create Date: 21.04.2023 23:58:35
// Design Name: 
// Module Name: VENDING_MACHINE
//////////////////////////////////////////////////////////////////////////////////

module VENDING_MACHINE (
    input wire [1:0] user_selection, // User's drink selection (00, 01, 10, 11)
    input wire clk,                // Clock input
    input wire reset,              // Reset input
    input wire coin_inserted,      // Coin insertion signal
    output reg [3:0] balance,      // Remaining balance (0 to 7)
    output reg [1:0] drink_dispensed // Drink selection output
);

// Define the drink prices
parameter DRINK_PRICE = 3; // Price of each drink

// Define the drink codes
parameter DRINK_00 = 2'b00;
parameter DRINK_01 = 2'b01;
parameter DRINK_10 = 2'b10;
parameter DRINK_11 = 2'b11;

// Define the states
reg [1:0] state, next_state;

// Define internal signals
reg [3:0] coin_balance;

// State encoding
parameter IDLE = 2'b00;
parameter DISPENSE_DRINK = 2'b01;
parameter RETURN_BALANCE = 2'b10;

// Initial state
initial begin
    state = IDLE;
    next_state = IDLE;
    balance = 0;
    coin_balance = 0;
    drink_dispensed = 2'b00;
end

// Sequential logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        next_state <= IDLE;
        balance <= 0;
        coin_balance <= 0;
        drink_dispensed <= 2'b00;
    end else begin
        state <= next_state;
        balance <= coin_balance;
        drink_dispensed <= user_selection;
    end
end

// Combinational logic
always @(*) begin
    next_state = state;
    coin_balance = balance;

    case (state)
        IDLE: begin
            if (coin_inserted) begin
                if (user_selection == DRINK_00) begin
                    if (coin_balance >= DRINK_PRICE) begin
                        coin_balance = coin_balance - DRINK_PRICE;
                        next_state = DISPENSE_DRINK;
                    end
                end else if (user_selection == DRINK_01) begin
                    if (coin_balance >= DRINK_PRICE) begin
                        coin_balance = coin_balance - DRINK_PRICE;
                        next_state = DISPENSE_DRINK;
                    end
                end else if (user_selection == DRINK_10) begin
                    if (coin_balance >= DRINK_PRICE) begin
                        coin_balance = coin_balance - DRINK_PRICE;
                        next_state = DISPENSE_DRINK;
                    end
                end else if (user_selection == DRINK_11) begin
                    if (coin_balance >= DRINK_PRICE) begin
                        coin_balance = coin_balance - DRINK_PRICE;
                        next_state = DISPENSE_DRINK;
                    end
                end
            end
        end
        DISPENSE_DRINK: begin
            next_state = RETURN_BALANCE;
        end
        RETURN_BALANCE: begin
            if (coin_inserted) begin
                coin_balance = coin_balance + 3; // Return 3 rupees
                next_state = IDLE;
            end
        end
    endcase
end

endmodule



