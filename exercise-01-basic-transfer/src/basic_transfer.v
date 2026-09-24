module ahb_basic_tb;

    // AHB signals
    logic        HCLK;
    logic        HRESETn;
    logic [31:0] HADDR;
    logic [1:0]  HTRANS;
    logic        HWRITE;
    logic        HREADY;

    // HTRANS values
    localparam IDLE   = 2'b00;
    localparam BUSY   = 2'b01;
    localparam NONSEQ = 2'b10;
    localparam SEQ    = 2'b11;

    // Clock generation
    initial begin
        HCLK = 1'b0;
        forever #5 HCLK = ~HCLK;
    end
    

    // Test
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, ahb_basic_tb);
        // Initial values
        HRESETn = 1'b0;
        HADDR   = 32'h0;
        HTRANS  = IDLE;
        HWRITE  = 1'b0;
        HREADY  = 1'b1;

        // Reset
        #20;
        HRESETn = 1'b1;

        // AHB transfer
        @(posedge HCLK);

        HADDR  = 32'h0000_0100;
        HTRANS = NONSEQ;
        HWRITE = 1'b1;

        @(posedge HCLK);

        // Return to IDLE
        HADDR  = 32'h0;
        HTRANS = IDLE;
        HWRITE = 1'b0;

        #20;

        $finish;
    end

    // Display signals
    initial begin
        $monitor("Time=%0t HRESETn=%b HADDR=%h HTRANS=%b HWRITE=%b HREADY=%b",
                 $time, HRESETn, HADDR, HTRANS, HWRITE, HREADY);
    end

endmodule
