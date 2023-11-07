`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NATIONAL INSTITUTE OF TECHNOLOGY WARANGAL
// Engineer: NARENDRA KUMAR NEHRA 
// 
// Create Date: 21.04.2023 23:58:35
// Design Name: 
// Module Name: VENDING_MACHINE_TB
//////////////////////////////////////////////////////////////////////////////////


module VENDING_MACHINE_TB;

    reg clk;
    reg reset;
    reg coin_inserted;
    reg [1:0] user_selection;
    wire [3:0] balance;
    wire [1:0] drink_dispensed;

    // Instantiate the vending machine
    VENDING_MACHINE vending_machine (
        .user_selection(user_selection),
        .clk(clk),
        .reset(reset),
        .coin_inserted(coin_inserted),
        .balance(balance),
        .drink_dispensed(drink_dispensed)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test cases
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        coin_inserted = 0;

        // Test case 1: User selects a drink with exact change
        user_selection = 2'b00; // Select drink 00
        coin_inserted = 1;     // Insert 1 coin (3 rupees)
        #10 coin_inserted = 0;  // Stop inserting coins
        #20;                   // Wait for drink to be dispensed
        user_selection = 2'b00; // Should receive drink 00
        #10;                   // Wait for balance return

        // Test case 2: User selects a drink with insufficient change
        reset = 1;              // Reset the vending machine
        coin_inserted = 0;      // No coin inserted
        #10 reset = 0;          // Release the reset
        user_selection = 2'b01; // Select drink 01
        coin_inserted = 0;      // No coins inserted
        #10 coin_inserted = 1;  // Insert 1 coin (1 rupee)
        #10 coin_inserted = 0;  // Stop inserting coins
        #20;                   // Wait for balance return
        user_selection = 2'b01; // Should not receive a drink
        #10;                   // Wait for balance return

        // Test case 3: User selects a drink with extra change
        reset = 1;              // Reset the vending machine
        coin_inserted = 0;      // No coin inserted
        #10 reset = 0;          // Release the reset
        user_selection = 2'b10; // Select drink 10
        coin_inserted = 1;      // Insert 1 coin (3 rupees)
        #10 coin_inserted = 0;  // Stop inserting coins
        #20;                   // Wait for drink to be dispensed
        user_selection = 2'b10; // Should receive drink 10
        #10;                   // Wait for balance return

        // Test case 4: User selects a drink and cancels the transaction
        reset = 1;              // Reset the vending machine
        coin_inserted = 0;      // No coin inserted
        #10 reset = 0;          // Release the reset
        user_selection = 2'b11; // Select drink 11
        coin_inserted = 1;      // Insert 1 coin (3 rupees)
        #10 user_selection = 2'b00; // Cancel the selection
        #10 coin_inserted = 0;      // Stop inserting coins
        #20;                       // Wait for balance return

        // Finish the simulation
        $finish;
    end

endmodule
