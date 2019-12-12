module G_DIV(
    input           clk,
    input           rst,
    input   [31:0]  A,
    input   [31:0]  B,
    output  [31:0]  C);

    wire            sign_A, sign_B, sign_C;
    wire    [7:0]   exponent_A, exponent_B, exponent_C;
    wire    [22:0]  mantissa_A, mantissa_B, mantissa_C;
    
    // for multiplier
    wire    [24:0]  N0, D0, F0;
    wire    [1:0]   AB_comp;
    reg     [2:0]   ctr_r, ctr_w;
    reg     [24:0]  N_r, D_r, F_r;
    reg     [24:0]  N_w, D_w, F_w;
    wire    [24:0]  N_o, D_o;
    reg     [31:0]  A_prev, B_prev;
    reg             finish_r, finish_w;

    // result
    assign  C = ((ctr_r == 3'b110) & (A == A_prev) & (B == B_prev) & (finish_r == 1'b1)) ? {sign_C, exponent_C, mantissa_C} : 32'bz;
    
    // quotient range
    assign  mantissa_A = A[22:0];
    assign  mantissa_B = B[22:0];
    
    COMP    comp(mantissa_A, mantissa_B, AB_comp);

    // sign
    assign  sign_A = A[31];
    assign  sign_B = B[31];
    assign  sign_C = sign_A ^ sign_B;

    // exponent
    assign  exponent_A = A[30:23];
    assign  exponent_B = B[30:23];
    assign  exponent_C = (AB_comp == 2'b10) ? (exponent_A - exponent_B + 8'd127) : (exponent_A - exponent_B + 8'd126);
    
    // mantissa
    assign N0 = {2'b01, mantissa_A};
    assign D0 = {2'b01, mantissa_B};
    assign F0 = ~D0 + 25'b1;
    assign  mantissa_C = (AB_comp[0] == 1'b0) ? N_o[23:1] : N_o[22:0];
    
    MUL mul_N(clk, rst, N_r, F_r, N_o);
    MUL mul_D(clk, rst, D_r, F_r, D_o);

    always@(*) begin
        if(ctr_r == 3'b0) begin
            N_w = N0;
            D_w = D0;
            F_w = F0;
            ctr_w = ctr_r + 3'b1;
            finish_w = 1'b0;
        end
        else if(ctr_r != 3'b110) begin
            N_w = N_o;
            D_w = D_o;
            F_w = ~D_o + 25'b1;
            ctr_w = ctr_r + 3'b1;
            finish_w = 1'b0;
        end
        else begin
            N_w = N_r;
            D_w = D_r;
            F_w = ~D_r;
            if((A_prev != A) | (B_prev != B)) begin
                ctr_w = 3'b0;
                finish_w = 1'b0;
            end
            else begin
                ctr_w = 3'b110;
                finish_w = 1'b1;
            end
        end
    end

    always@(posedge clk) begin
        if(!rst) begin
            ctr_r <= 3'b111;
            N_r <= 25'b0;
            D_r <= 25'b0;
            F_r <= 25'b0;
        end
        else begin
            ctr_r <= ctr_w;
            N_r <= N_w;
            D_r <= D_w;
            F_r <= F_w;
            A_prev <= A;
            B_prev <= B;
            finish_r <= finish_w;
        end
    end

endmodule
