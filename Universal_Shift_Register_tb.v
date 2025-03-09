`timescale 1ns / 1ps

module Universal_Shift_Register_tb;

    reg clk;
    reg reset;
    reg [2:0] mode;
    reg data_in;
    reg parallel_in_0;
    reg parallel_in_1;
    reg parallel_in_2;
    reg parallel_in_3;
    wire [3:0] Q;

    Universal_Shift_Register uut (
        .clk(clk),
        .reset(reset),
        .mode(mode),
        .data_in(data_in),
        .parallel_in_0(parallel_in_0),
        .parallel_in_1(parallel_in_1),
        .parallel_in_2(parallel_in_2),
        .parallel_in_3(parallel_in_3),
        .Q(Q)
    );

    initial begin
        $dumpfile("dump.vcd"); // Add this line
        $dumpvars(0, Universal_Shift_Register_tb); // Add this line

        clk = 0;
        reset = 1;
        mode = 3'b000;
        data_in = 1'b0;
        parallel_in_0 = 1'b0;
        parallel_in_1 = 1'b0;
        parallel_in_2 = 1'b0;
        parallel_in_3 = 1'b0;

        #10;
        reset = 0;
        #10;

        mode = 3'b000;
        #20;

        mode = 3'b001;
        data_in = 1'b1;
        #10;
        data_in = 1'b0;
        #10;
        data_in = 1'b1;
        #10;

        mode = 3'b100;
        data_in = 1'b1;
        #10;
        data_in = 1'b0;
        #10;
        data_in = 1'b1;
        #10;

        mode = 3'b010;
        parallel_in_0 = 1'b1;
        parallel_in_1 = 1'b0;
        parallel_in_2 = 1'b1;
        parallel_in_3 = 1'b0;
        #20;

        mode = 3'b011;
        #30;

        $finish;
    end

    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t, reset=%b, mode=%b, data_in=%b, parallel_in=%b%b%b%b, Q=%b",
                 $time, reset, mode, data_in, parallel_in_3, parallel_in_2, parallel_in_1, parallel_in_0, Q);
    end

endmodule