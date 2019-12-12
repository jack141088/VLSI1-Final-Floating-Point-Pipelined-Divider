module G_DIV(
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
    reg     [24:0]  N_r, D_r, F_r;
    reg     [24:0]  N_w, D_w, F_w;
    wire    [24:0]  N_o, D_o;
    //reg     [31:0]  A_prev, B_prev;
    reg             finish;
    // buffer
    reg     [2:0]   ctr_r, ctr_w;           // counter for iteration
    wire    [2:0]   ctr_o, ctr_p;           // next counter output
    reg             d_r, d_w;               // divide enable
    wire            d_o, d_p;               // divide enable output
    reg     [9:0]   remain_r, remain_w;     // remain part(sign + exponent + AB_comp)
    wire    [9:0]   remain_o, remain_p;     // remain part output

    // result
    assign  C = ((finish == 1'b1)) ? {remain_o[9], remain_o[8:1], mantissa_C} : 32'bz;
    
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
    //assign F0 = ~D0 + 25'b1;
    assign F0 = ~D0;
    assign mantissa_C = (remain_o[0] == 1'b0) ? N_o[23:1] : N_o[22:0];
    
    MUL_PL mul_N(clk, rst, N_r, F_r, ctr_r, d_r, remain_r, ctr_o, d_o, remain_o, N_o);
    MUL_PL mul_D(clk, rst, D_r, F_r, ctr_r, d_r, remain_r, ctr_p, d_p, remain_p, D_o);

    always@(*) begin
        if(D == 1'b1) begin         // Divide operation enable; set initial Value
            N_w = N0;
            D_w = D0;
            F_w = F0;
            d_w = 1'b1;
            ctr_w = 3'b0;
            remain_w = {sign_C, exponent_C, AB_comp[0]};
            finish = 1'b0;
        end
        else if(ctr_o != 3'b110) begin
            if(d_o == 1'b0) begin   // Result not yet showed
                N_w = N_r;
                D_w = D_r;
                F_w = F_r;
                ctr_w = 3'b0;
                d_w = 1'b0;
                remain_w = 10'b0;
            end
            else begin              // Result showed
                N_w = N_o;
                D_w = D_o;
                //F_w = ~D_o+25'b1;
                F_w = ~D_o;
                ctr_w = ctr_o;
                d_w = d_o;
                remain_w = remain_o;
            end
            finish = 1'b0;
        end
        else begin
            N_w = N_r;
            D_w = D_r;
            F_w = F_r;
            d_w = 1'b0;
            ctr_w = 3'b0;
            remain_w = 10'b0;
            finish = 1'b1;
        end
    end

    always@(posedge clk) begin
        if(!rst) begin
            d_r <= 1'b0;
            ctr_r <= 3'b0;
            remain_r <= 10'b0;
            N_r <= 25'b0;
            D_r <= 25'b0;
            F_r <= 25'b0;
        end
        else begin
            d_r <= d_w;
            ctr_r <= ctr_w;
            remain_r <= remain_w;
            N_r <= N_w;
            D_r <= D_w;
            F_r <= F_w;
            //A_prev <= A;
            //B_prev <= B;
        end
    end

endmodule
