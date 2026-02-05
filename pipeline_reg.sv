module pipeline_reg #(
    parameter DATA_WIDTH = 32
)(
    input  logic clk,
    input  logic rst_n,

    // Input side
    input  logic [DATA_WIDTH-1:0] in_data,
    input  logic in_valid,
    output logic in_ready,

    // Output side
    output logic [DATA_WIDTH-1:0] out_data,
    output logic out_valid,
    input  logic out_ready
);

    logic [DATA_WIDTH-1:0] data_reg;
    logic valid_reg;

    // Combinational
    assign out_data  = data_reg;
    assign out_valid = valid_reg;

    // Ready when empty 
    assign in_ready = ~valid_reg || out_ready;
    
    // Sequential
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_reg <= 1'b0;
            data_reg  <= '0;
        end
        else begin
            if (in_valid && in_ready) begin
                data_reg  <= in_data;
                valid_reg <= 1'b1;
            end
            else if (out_ready && valid_reg) begin
                valid_reg <= 1'b0;
            end
        end
    end

endmodule

