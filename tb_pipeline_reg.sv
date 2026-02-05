`timescale 1ns/1ps

module tb_pipeline_reg;

    parameter DATA_WIDTH = 32;

    logic clk;
    logic rst_n;

    logic [DATA_WIDTH-1:0] in_data;
    logic in_valid;
    logic in_ready;

    logic [DATA_WIDTH-1:0] out_data;
    logic out_valid;
    logic out_ready;

    // DUT
    pipeline_reg #(.DATA_WIDTH(DATA_WIDTH)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .in_data(in_data),
        .in_valid(in_valid),
        .in_ready(in_ready),
        .out_data(out_data),
        .out_valid(out_valid),
        .out_ready(out_ready)
    );
    // Clock
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Assertions
    property hold_data_when_stalled;
        @(posedge clk)
        out_valid && !out_ready |-> $stable(out_data);
    endproperty
    assert property(hold_data_when_stalled);

    property reset_clears_valid;
        @(posedge clk)
        !rst_n |=> !out_valid;
    endproperty
    assert property(reset_clears_valid);

    // Stimulus
    initial begin

        rst_n = 0;
        in_valid = 0;
        out_ready = 0;
        in_data = 0;

        #20 rst_n = 1;

        // Normal transfer
        out_ready = 1;
        @(posedge clk);
        in_data  = 32'hAAAA0001;
        in_valid = 1;

        @(posedge clk);
        in_valid = 0;

        // Backpressure
        @(posedge clk);
        in_data  = 32'hBBBB0002;
        in_valid = 1;
        out_ready = 0;

        repeat(3) @(posedge clk);

        out_ready = 1;
        @(posedge clk);
        in_valid = 0;

        // Streaming
        repeat(5) begin
            @(posedge clk);
            in_valid = 1;
            in_data  = $random;
        end

        @(posedge clk);
        in_valid = 0;

        // Reset mid-run
        @(posedge clk);
        rst_n = 0;

        @(posedge clk);
        rst_n = 1;

        #50 $finish;
    end

endmodule

