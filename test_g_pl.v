module test;
    reg         clock, clear;
    reg [31:0]  in_A, in_B;
    reg         D;
    wire [31:0] out;

    initial begin
        clock = 1'b0;
        clear = 1'b0;
        @(posedge clock);
        #1;
        @(posedge clock);
        in_A = 32'h00000008;
        in_B = 32'h00000001;
        clear = 1'b1;
        D = 1'b0;
        #20
        D = 1'b1;
        in_A = 32'h40000000;    // 2            e
        in_B = 32'h3F800000;    // 1            e
                                // Ans: 0x40000000
        #40
        in_A = 32'h3F8F5C29;    // 1.12
        in_B = 32'h3FC80000;    // 1.5625       m
                                // Ans: 0x3F378034 (0.7168)
        #40
        in_A = 32'h447A0000;    // 1000         m
        in_B = 32'h3F800000;    // 1
                                // Ans: 0x447A0000 (1000)
        #40
        in_A = 32'h3DCCCCCD;    // 0.1          m
        in_B = 32'h42480000;    // 50
                                // Ans: 0x3B03126F (0.002)
        #40
        in_A = 32'h42000000;    // 32           e
        in_B = 32'h40000000;    // 2            e
                                // Ans: 0x41800000 (16)
        #40
        in_A = 32'h3FC00000;    // 1.5          m
        in_B = 32'h3E000000;    // 0.125
                                // Ans: 0x41400000 (12)
        #40
        in_A = 32'h41100000;    // 9            
        in_B = 32'h3EA8F5C3;    // 0.33         m
                                // Ans: 0x41DA2E8B (0.272726)
        #40
        in_A = 32'h43200000;    // 9            
        in_B = 32'h32100000;    // 0.33         m
                                // Ans: 0x41DA2E8B (0.272726)
        #40
        in_A = 32'h42200000;    // 9            
        in_B = 32'h98765543;    // 0.33         m
                                // Ans: 0x41DA2E8B (0.272726)
        #40
        D = 1'b0;
    end

    always  #20 clock = ~clock;

    initial #10000 $finish;

    G_DIV gold_div(
        .clk(clock),
        .rst(clear),
        .A(in_A),
        .B(in_B),
        .D(D),
        .C(out)); 

endmodule
