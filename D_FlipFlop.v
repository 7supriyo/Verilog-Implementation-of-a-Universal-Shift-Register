// D_FlipFlop.v
module D_FlipFlop (
    input clk,
    input reset,
    input D,
    output reg Q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0;
        end else begin
            Q <= D;
        end
    end

endmodule