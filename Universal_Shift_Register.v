// Universal_Shift_Register.v
module Universal_Shift_Register (
    input clk,
    input reset,
    input [2:0] mode,
    input data_in,
    input parallel_in_0,
    input parallel_in_1,
    input parallel_in_2,
    input parallel_in_3,
    output reg [3:0] Q
);

    wire mux_out;
    wire Q0, Q1, Q2, Q3; // Intermediate wires

    Mux_8_to_1 mux (
        .in ({parallel_in_3, parallel_in_2, parallel_in_1, parallel_in_0, data_in, Q[3], Q[0], 1'b0}),
        .sel(mode),
        .out(mux_out)
    );

    D_FlipFlop ff0 (
        .clk(clk),
        .reset(reset),
        .D(mux_out),
        .Q(Q0) // Connect to wire Q0
    );

    D_FlipFlop ff1 (
        .clk(clk),
        .reset(reset),
        .D(Q0), // Connect wire Q0
        .Q(Q1) // Connect to wire Q1
    );

    D_FlipFlop ff2 (
        .clk(clk),
        .reset(reset),
        .D(Q1), // Connect wire Q1
        .Q(Q2) // Connect to wire Q2
    );

    D_FlipFlop ff3 (
        .clk(clk),
        .reset(reset),
        .D(Q2), // Connect wire Q2
        .Q(Q3) // Connect to wire Q3
    );

    always @(*) begin // Assign the wires to the output reg
        Q[0] = Q0;
        Q[1] = Q1;
        Q[2] = Q2;
        Q[3] = Q3;
    end

endmodule