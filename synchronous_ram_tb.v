`timescale 1ns / 1ps

module synchronous_ram_tb;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    reg clk;
    reg we, re;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;

    // Instantiate the RAM
    synchronous_ram #(DATA_WIDTH, ADDR_WIDTH) uut (
        .clk(clk),
        .we(we),
        .re(re),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        $dumpfile("synchronous_ram.vcd");
        $dumpvars(0, synchronous_ram_tb);

        we = 0; re = 0; addr = 0; din = 0;

        // Write values
        #10;
        we = 1; re = 0;
        addr = 4'h3; din = 8'hAA; #10;
        addr = 4'h4; din = 8'hBB; #10;
        addr = 4'h5; din = 8'hCC; #10;

        // Read values
        we = 0; re = 1;
        addr = 4'h3; #10;
        addr = 4'h4; #10;
        addr = 4'h5; #10;

        // End simulation
        $display("Simulation complete");
        $finish;
    end

endmodule
