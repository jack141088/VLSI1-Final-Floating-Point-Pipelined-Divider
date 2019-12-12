module NR_DIV(
    input           clk,
    input           rst,
    input   [31:0]  A,
    input   [31:0]  B,
    input           D,
    output  [31:0]  C);

    wire            sign_A, sign_B, sign_C;
    wire    [7:0]   exponent_A, exponent_B, exponent_C;
    wire    [22:0]  mantissa_A, mantissa_B, mantissa_C;
    
    // for multiplier
    wire    [24:0]  N0, D0, F0;
    wire    [1:0]   AB_comp;
    reg     [24:0]  F_r, F_w;
    wire    [25:0]  T_o, F_o, N_o;
    reg     [24:0]  T_r;
    wire    [24:0]  T;
    //reg     [31:0]  A_prev, B_prev;
    reg             finish;
    wire            finish_o;
    //buffer
    reg     [2:0]   ctr1_r, ctr1_w;             // 1st counter for iteration
    wire    [2:0]   ctr1_o;                     // 1st next counter output
    reg     [2:0]   ctr2_r, ctr2_w;             // 2nd counter for iteration
    wire    [2:0]   ctr2_o;                     // 2nd next counter output
    reg             d1_r, d1_w;                 // 1st divide enable
    wire            d1_o;                       // 1st divide enable output
    reg             d2_r, d2_w;                 // 2nd divide enable
    wire            d2_o;                       // 2nd divide enable output
    reg     [9:0]   remain1_r, remain1_w;       // 1st remain part
    wire    [9:0]   remain1_o;                  // 1st remain part output
    reg     [9:0]   remain2_r, remain2_w;       // 2nd remain part
    wire    [9:0]   remain2_o;                  // 2nd remain part output
    //reg     [9:0]   remain3_r;                  // final remain part
    wire    [9:0]   remain3_o;                  // final remain part output
    reg     [24:0]  F1_r, F1_w;                 // 1st F_r value for iteration
    wire    [24:0]  F1_o;                       // 1st F_r output
    reg     [24:0]  F2_r, F2_w;                 // 2nd F_r value for iteration
    wire    [24:0]  F2_o;                       // 2nd F_r output
    reg     [24:0]  N1_r, N1_w;                 // 1st N0 value for iteration
    wire    [24:0]  N1_o;                       // 1st N0 output
    reg     [24:0]  N2_r, N2_w;                 // 2nd N0 value for iteration
    wire    [24:0]  N2_o;                       // 2nd N0 output
    reg     [24:0]  D1_r, D1_w;                 // 1st D0 value for iteration
    wire    [24:0]  D1_o;                       // 1st D0 output
    reg     [24:0]  D2_r, D2_w;                 // 2nd D0 value for iteration
    wire    [24:0]  D2_o;                       // 2nd D0 output
    reg     [24:0]  Din_r, Din_w;

    wire    [2:0]   ctr2_o_1;
    // useless
    wire    [2:0]   ctr_ul;
    wire            d_ul;
    wire    [9:0]   remain_ul;
    wire    [24:0]  F_ul;
    wire    [24:0]  N_ul;
    wire    [24:0]  D_ul;
    a1_adder    A0(ctr2_o, ctr2_o_1);

    // result
    assign  C = ((finish_o == 1'b1)) ? {remain3_o[9], remain3_o[8:1], mantissa_C} : 32'bz;
    
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
    assign  exponent_C = (AB_comp[0] == 1'b0) ? (exponent_A - exponent_B + 8'd127) : (exponent_A - exponent_B + 8'd126);
    
    // mantissa
    assign N0 = {3'b1, mantissa_A[22:1]};
    assign D0 = {3'b1, mantissa_B[22:1]};
    assign F0 = 25'b1011101001111110111110011 - {2'b01, mantissa_B};
    assign  mantissa_C = (remain3_o[0] == 1'b0) ? N_o[23:1] : N_o[22:0];
    //assign  mantissa_C = (AB_comp[0] == 1'b0) ? N_o[23:1] : N_o[22:0];

    assign T = 25'h1000000 - T_o[25:1];
    MUL_PL mul_XD(clk, rst, F_r, Din_r, ctr1_r, d1_r, remain1_r, F1_r, N1_r, D1_r, ctr1_o, d1_o, remain1_o, F1_o, N1_o, D1_o, T_o);
    MUL_PL mul_XDD(clk, rst, F2_r, T_r, ctr2_r, d2_r, remain2_r, F2_r, N2_r, D2_r, ctr2_o, d2_o, remain2_o, F2_o, N2_o, D2_o, F_o);
    MUL_PL mul_NX(clk, rst, F2_o, N2_o, 3'b0, finish, remain2_o, 25'b0, 25'b0, 25'b0, ctr_ul, finish_o, remain3_o, F_ul, N_ul, D_ul, N_o);
    
    always@(*) begin
        if(D == 1'b1) begin         // Initial Value
            F_w = F0;
            F1_w = F0;
            N1_w = N0;
            D1_w = D0;
            ctr1_w = 3'b0;
            d1_w = 1'b1;
            remain1_w = {sign_C, exponent_C, AB_comp[0]};
            F2_w = F1_o;
            N2_w = N1_o;
            D2_w = D1_o;
            ctr2_w = ctr1_o;
            d2_w = d1_o;
            remain2_w = remain1_o;
            Din_w = D0;
            finish = 1'b0;
        end
        else if(ctr2_o != 3'b110) begin
            if(d2_o == 1'b0) begin   // Result not yet showed
                F_w = F_r;
                F1_w = F1_r;
                N1_w = N1_r;
                D1_w = D1_r;
                ctr1_w = 3'b0;
                d1_w = 1'b0;
                remain1_w = 10'b0;
                F2_w = F1_o;
                N2_w = N1_o;
                D2_w = D1_o;
                ctr2_w = ctr1_o;
                d2_w = d1_o;
                remain2_w = remain1_o;
                Din_w = 25'b0;
            end
            else begin              // Result showed
                F_w = F_o[25:1];
                F1_w = F_o[25:1];
                N1_w = N2_o;
                D1_w = D2_o;
                ctr1_w = ctr2_o_1;
                d1_w = d2_o;
                remain1_w = remain2_o;
                F2_w = F1_o;
                N2_w = N1_o;
                D2_w = D1_o;
                ctr2_w = ctr1_o;
                d2_w = d1_o;
                remain2_w = remain1_o;
                Din_w = D2_o;
            end
            finish = 1'b0;
        end
        else begin
            F_w = F_r;
            F1_w = F1_r;
            N1_w = N1_r;
            D1_w = D1_r;
            ctr1_w = 3'b0;
            d1_w = 1'b0;
            remain1_w = 10'b0;
            F2_w = F1_o;
            N2_w = N1_o;
            D2_w = D1_o;
            ctr2_w = ctr1_o;
            d2_w = d1_o;
            remain2_w = remain1_o;
            Din_w = 25'b0;
            finish = 1'b1;
        end
    end

    always@(posedge clk) begin
        if(!rst) begin
            d1_r <= 1'b0;
            ctr1_r <= 3'd7;
            remain1_r <= 10'b0;
            F1_r <= 25'b0;
            N1_r <= 25'b0;
            D1_r <= 25'b0;
            d2_r <= 1'b0;
            ctr2_r <= 3'd7;
            remain2_r <= 10'b0;
            F2_r <= 25'b0;
            N2_r <= 25'b0;
            D2_r <= 25'b0;
            F_r <= 25'b0;
            Din_r <= 25'b0;
            T_r <= 25'b0;
        end
        else begin
            d1_r <= d1_w;
            ctr1_r <= ctr1_w;
            remain1_r <= remain1_w;
            F1_r <= F1_w;
            N1_r <= N1_w;
            D1_r <= D1_w;
            d2_r <= d2_w;
            ctr2_r <= ctr2_w;
            remain2_r <= remain2_w;
            F2_r <= F2_w;
            N2_r <= N2_w;
            D2_r <= D2_w;
            F_r <= F_w;
            Din_r <= Din_w;
            T_r <= T;
        end
    end

endmodule
