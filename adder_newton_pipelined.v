module ADD_PL(
    input           clk,
    input           rst,
    input   [31:0]  A,
    input   [31:0]  B,
    input   [2:0]   ctr_in,
    input           d_in,
    input   [9:0]   remain_in,
    output  [2:0]   ctr_out,
    output          d_out,
    output  [9:0]   remain_out,
    input   [24:0]  F_in,
    output  [24:0]  F_out,
    input   [24:0]  N_in,
    output  [24:0]  N_out,
    input   [24:0]  D_in,
    output  [24:0]  D_out,
    output  [25:0]  C);

    //////////////////////////////////////////////////////////////////////////////
    /////                      pipeline parameter                            /////
    //////////////////////////////////////////////////////////////////////////////
    reg     [2:0]   ctr_l1_r, ctr_l2_r, ctr_l3_r;
    reg             d_l1_r, d_l2_r, d_l3_r;
    reg     [9:0]   remain_l1_r, remain_l2_r, remain_l3_r;
    reg     [24:0]  F_l1_r, F_l2_r, F_l3_r;
    reg     [24:0]  N_l1_r, N_l2_r, N_l3_r;
    reg     [24:0]  D_l1_r, D_l2_r, D_l3_r;
    
    assign  ctr_out = ctr_l3_r;
    assign  d_out = d_l3_r;
    assign  remain_out = remain_l3_r;
    assign  F_out = F_l3_r;
    assign  N_out = N_l3_r;
    assign  D_out = D_l3_r;

    always@(posedge clk) begin
        if(!rst) begin
            ctr_l1_r <= 3'b0; 
            ctr_l2_r <= 3'b0;
            ctr_l3_r <= 3'b0;
            d_l1_r <= 1'b0;
            d_l2_r <= 1'b0;
            d_l3_r <= 1'b0;
            remain_l1_r <= 1'b0;
            remain_l2_r <= 1'b0;
            remain_l3_r <= 1'b0;
            F_l1_r <= 24'b0;
            F_l2_r <= 24'b0;
            F_l3_r <= 24'b0;
            N_l1_r <= 24'b0;
            N_l2_r <= 24'b0;
            N_l3_r <= 24'b0;
            D_l1_r <= 24'b0;
            D_l2_r <= 24'b0;
            D_l3_r <= 24'b0;
        end
        else begin
            ctr_l1_r <= ctr_in;
            ctr_l2_r <= ctr_l1_r;
            ctr_l3_r <= ctr_l2_r;
            d_l1_r <= d_in;
            d_l2_r <= d_l1_r;
            d_l3_r <= d_l2_r;
            remain_l1_r <= remain_in;
            remain_l2_r <= remain_l1_r;
            remain_l3_r <= remain_l2_r;
            F_l1_r <= F_in;
            F_l2_r <= F_l1_r;
            F_l3_r <= F_l2_r;
            N_l1_r <= N_in;
            N_l2_r <= N_l1_r;
            N_l3_r <= N_l2_r;
            D_l1_r <= D_in;
            D_l2_r <= D_l1_r;
            D_l3_r <= D_l2_r;
        end
    end
    
    //////////////////////////////////////////////////////////////////////////////
    /////                               pipe 1                               /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [31:0]  G_l0, P_l0;
    wire    [31:0]  G_l1, P_l1;

    reg     [31:0]  G_l1_r, P_l1_r, p_l1_r;

    GP  gp1(A[31], B[31], G_l0[31], P_l0[31]);
    GP  gp2(A[30], B[30], G_l0[30], P_l0[30]);
    GP  gp3(A[29], B[29], G_l0[29], P_l0[29]);
    GP  gp4(A[28], B[28], G_l0[28], P_l0[28]);
    GP  gp5(A[27], B[27], G_l0[27], P_l0[27]);
    GP  gp6(A[26], B[26], G_l0[26], P_l0[26]);
    GP  gp7(A[25], B[25], G_l0[25], P_l0[25]);
    GP  gp8(A[24], B[24], G_l0[24], P_l0[24]);
    GP  gp9(A[23], B[23], G_l0[23], P_l0[23]);
    GP  gp10(A[22], B[22], G_l0[22], P_l0[22]);
    GP  gp11(A[21], B[21], G_l0[21], P_l0[21]);
    GP  gp12(A[20], B[20], G_l0[20], P_l0[20]);
    GP  gp13(A[19], B[19], G_l0[19], P_l0[19]);
    GP  gp14(A[18], B[18], G_l0[18], P_l0[18]);
    GP  gp15(A[17], B[17], G_l0[17], P_l0[17]);
    GP  gp16(A[16], B[16], G_l0[16], P_l0[16]);
    GP  gp17(A[15], B[15], G_l0[15], P_l0[15]);
    GP  gp18(A[14], B[14], G_l0[14], P_l0[14]);
    GP  gp19(A[13], B[13], G_l0[13], P_l0[13]);
    GP  gp20(A[12], B[12], G_l0[12], P_l0[12]);
    GP  gp21(A[11], B[11], G_l0[11], P_l0[11]);
    GP  gp22(A[10], B[10], G_l0[10], P_l0[10]);
    GP  gp23(A[9], B[9], G_l0[9], P_l0[9]);
    GP  gp24(A[8], B[8], G_l0[8], P_l0[8]);
    GP  gp25(A[7], B[7], G_l0[7], P_l0[7]);
    GP  gp26(A[6], B[6], G_l0[6], P_l0[6]);
    GP  gp27(A[5], B[5], G_l0[5], P_l0[5]);
    GP  gp28(A[4], B[4], G_l0[4], P_l0[4]);
    GP  gp29(A[3], B[3], G_l0[3], P_l0[3]);
    GP  gp30(A[2], B[2], G_l0[2], P_l0[2]);
    GP  gp31(A[1], B[1], G_l0[1], P_l0[1]);
    GP  gp32(A[0], B[0], G_l0[0], P_l0[0]);

    Processor   p1_0(G_l0[31], G_l0[30], P_l0[31], P_l0[30], G_l1[31], P_l1[31]);
    Processor   p1_1(G_l0[29], G_l0[28], P_l0[29], P_l0[28], G_l1[29], P_l1[29]);
    Processor   p1_2(G_l0[27], G_l0[26], P_l0[27], P_l0[26], G_l1[27], P_l1[27]);
    Processor   p1_3(G_l0[25], G_l0[24], P_l0[25], P_l0[24], G_l1[25], P_l1[25]);
    Processor   p1_4(G_l0[23], G_l0[22], P_l0[23], P_l0[22], G_l1[23], P_l1[23]);
    Processor   p1_5(G_l0[21], G_l0[20], P_l0[21], P_l0[20], G_l1[21], P_l1[21]);
    Processor   p1_6(G_l0[19], G_l0[18], P_l0[19], P_l0[18], G_l1[19], P_l1[19]);
    Processor   p1_7(G_l0[17], G_l0[16], P_l0[17], P_l0[16], G_l1[17], P_l1[17]);
    Processor   p1_8(G_l0[15], G_l0[14], P_l0[15], P_l0[14], G_l1[15], P_l1[15]);
    Processor   p1_9(G_l0[13], G_l0[12], P_l0[13], P_l0[12], G_l1[13], P_l1[13]);
    Processor   p1_10(G_l0[11], G_l0[10], P_l0[11], P_l0[10], G_l1[11], P_l1[11]);
    Processor   p1_11(G_l0[9], G_l0[8], P_l0[9], P_l0[8], G_l1[9], P_l1[9]);
    Processor   p1_12(G_l0[7], G_l0[6], P_l0[7], P_l0[6], G_l1[7], P_l1[7]);
    Processor   p1_13(G_l0[5], G_l0[4], P_l0[5], P_l0[4], G_l1[5], P_l1[5]);
    Processor   p1_14(G_l0[3], G_l0[2], P_l0[3], P_l0[2], G_l1[3], P_l1[3]);
    Processor   p1_15(G_l0[1], G_l0[0], P_l0[1], P_l0[0], G_l1[1], P_l1[1]);
    assign  G_l1[30] = G_l0[30];
    assign  G_l1[28] = G_l0[28];
    assign  G_l1[26] = G_l0[26];
    assign  G_l1[24] = G_l0[24];
    assign  G_l1[22] = G_l0[22];
    assign  G_l1[20] = G_l0[20];
    assign  G_l1[18] = G_l0[18];
    assign  G_l1[16] = G_l0[16];
    assign  G_l1[14] = G_l0[14];
    assign  G_l1[12] = G_l0[12];
    assign  G_l1[10] = G_l0[10];
    assign  G_l1[8] = G_l0[8];
    assign  G_l1[6] = G_l0[6];
    assign  G_l1[4] = G_l0[4];
    assign  G_l1[2] = G_l0[2];
    assign  G_l1[0] = G_l0[0];
    assign  P_l1[30] = P_l0[30];
    assign  P_l1[28] = P_l0[28];
    assign  P_l1[26] = P_l0[26];
    assign  P_l1[24] = P_l0[24];
    assign  P_l1[22] = P_l0[22];
    assign  P_l1[20] = P_l0[20];
    assign  P_l1[18] = P_l0[18];
    assign  P_l1[16] = P_l0[16];
    assign  P_l1[14] = P_l0[14];
    assign  P_l1[12] = P_l0[12];
    assign  P_l1[10] = P_l0[10];
    assign  P_l1[8] = P_l0[8];
    assign  P_l1[6] = P_l0[6];
    assign  P_l1[4] = P_l0[4];
    assign  P_l1[2] = P_l0[2];
    assign  P_l1[0] = P_l0[0];

    //////////////////////////////////////////////////////////////////////////////
    /////                               pipe 2                               /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [31:0]  G_l2, P_l2;
    wire    [31:0]  G_l3, P_l3;

    reg     [31:0]  G_l3_r, P_l3_r, p_l3_r;

    Processor   p2_0(G_l1_r[31], G_l1_r[29], P_l1_r[31], P_l1_r[29], G_l2[31], P_l2[31]);
    Processor   p2_1(G_l1_r[30], G_l1_r[29], P_l1_r[30], P_l1_r[29], G_l2[30], P_l2[30]);
    Processor   p2_2(G_l1_r[27], G_l1_r[25], P_l1_r[27], P_l1_r[25], G_l2[27], P_l2[27]);
    Processor   p2_3(G_l1_r[26], G_l1_r[25], P_l1_r[26], P_l1_r[25], G_l2[26], P_l2[26]);
    Processor   p2_4(G_l1_r[23], G_l1_r[21], P_l1_r[23], P_l1_r[21], G_l2[23], P_l2[23]);
    Processor   p2_5(G_l1_r[22], G_l1_r[21], P_l1_r[22], P_l1_r[21], G_l2[22], P_l2[22]);
    Processor   p2_6(G_l1_r[19], G_l1_r[17], P_l1_r[19], P_l1_r[17], G_l2[19], P_l2[19]);
    Processor   p2_7(G_l1_r[18], G_l1_r[17], P_l1_r[18], P_l1_r[17], G_l2[18], P_l2[18]);
    Processor   p2_8(G_l1_r[15], G_l1_r[13], P_l1_r[15], P_l1_r[13], G_l2[15], P_l2[15]);
    Processor   p2_9(G_l1_r[14], G_l1_r[13], P_l1_r[14], P_l1_r[13], G_l2[14], P_l2[14]);
    Processor   p2_10(G_l1_r[11], G_l1_r[9], P_l1_r[11], P_l1_r[9], G_l2[11], P_l2[11]);
    Processor   p2_11(G_l1_r[10], G_l1_r[9], P_l1_r[10], P_l1_r[9], G_l2[10], P_l2[10]);
    Processor   p2_12(G_l1_r[7], G_l1_r[5], P_l1_r[7], P_l1_r[6], G_l2[7], P_l2[7]);
    Processor   p2_13(G_l1_r[6], G_l1_r[5], P_l1_r[6], P_l1_r[6], G_l2[6], P_l2[6]);
    Processor   p2_14(G_l1_r[3], G_l1_r[1], P_l1_r[3], P_l1_r[1], G_l2[3], P_l2[3]);
    Processor   p2_15(G_l1_r[2], G_l1_r[1], P_l1_r[2], P_l1_r[1], G_l2[2], P_l2[2]);
    assign  G_l2[29] = G_l1_r[29];
    assign  G_l2[28] = G_l1_r[28];
    assign  G_l2[25] = G_l1_r[25];
    assign  G_l2[24] = G_l1_r[24];
    assign  G_l2[21] = G_l1_r[21];
    assign  G_l2[20] = G_l1_r[20];
    assign  G_l2[17] = G_l1_r[17];
    assign  G_l2[16] = G_l1_r[16];
    assign  G_l2[13] = G_l1_r[13];
    assign  G_l2[12] = G_l1_r[12];
    assign  G_l2[9] = G_l1_r[9];
    assign  G_l2[8] = G_l1_r[8];
    assign  G_l2[5] = G_l1_r[5];
    assign  G_l2[4] = G_l1_r[4];
    assign  G_l2[1] = G_l1_r[1];
    assign  G_l2[0] = G_l1_r[0];
    assign  P_l2[29] = P_l1_r[29];
    assign  P_l2[28] = P_l1_r[28];
    assign  P_l2[25] = P_l1_r[25];
    assign  P_l2[24] = P_l1_r[24];
    assign  P_l2[21] = P_l1_r[21];
    assign  P_l2[20] = P_l1_r[20];
    assign  P_l2[17] = P_l1_r[17];
    assign  P_l2[16] = P_l1_r[16];
    assign  P_l2[13] = P_l1_r[13];
    assign  P_l2[12] = P_l1_r[12];
    assign  P_l2[9] = P_l1_r[9];
    assign  P_l2[8] = P_l1_r[8];
    assign  P_l2[5] = P_l1_r[5];
    assign  P_l2[4] = P_l1_r[4];
    assign  P_l2[1] = P_l1_r[1];
    assign  P_l2[0] = P_l1_r[0];
    
    Processor   p3_0(G_l2[31], G_l2[27], P_l2[31], P_l2[27], G_l3[31], P_l3[31]);
    Processor   p3_1(G_l2[30], G_l2[27], P_l2[30], P_l2[27], G_l3[30], P_l3[30]);
    Processor   p3_2(G_l2[29], G_l2[27], P_l2[29], P_l2[27], G_l3[29], P_l3[29]);
    Processor   p3_3(G_l2[28], G_l2[27], P_l2[28], P_l2[27], G_l3[28], P_l3[28]);
    Processor   p3_4(G_l2[23], G_l2[19], P_l2[23], P_l2[19], G_l3[23], P_l3[23]);
    Processor   p3_5(G_l2[22], G_l2[19], P_l2[22], P_l2[19], G_l3[22], P_l3[22]);
    Processor   p3_6(G_l2[21], G_l2[19], P_l2[21], P_l2[19], G_l3[21], P_l3[21]);
    Processor   p3_7(G_l2[20], G_l2[19], P_l2[20], P_l2[19], G_l3[20], P_l3[20]);
    Processor   p3_8(G_l2[15], G_l2[11], P_l2[15], P_l2[11], G_l3[15], P_l3[15]);
    Processor   p3_9(G_l2[14], G_l2[11], P_l2[14], P_l2[11], G_l3[14], P_l3[14]);
    Processor   p3_10(G_l2[13], G_l2[11], P_l2[13], P_l2[11], G_l3[13], P_l3[13]);
    Processor   p3_11(G_l2[12], G_l2[11], P_l2[12], P_l2[11], G_l3[12], P_l3[12]);
    Processor   p3_12(G_l2[7], G_l2[3], P_l2[7], P_l2[3], G_l3[7], P_l3[7]);
    Processor   p3_13(G_l2[6], G_l2[3], P_l2[6], P_l2[3], G_l3[6], P_l3[6]);
    Processor   p3_14(G_l2[5], G_l2[3], P_l2[5], P_l2[3], G_l3[5], P_l3[5]);
    Processor   p3_15(G_l2[4], G_l2[3], P_l2[4], P_l2[3], G_l3[4], P_l3[4]);
    assign  G_l3[27] = G_l2[27];
    assign  G_l3[26] = G_l2[26];
    assign  G_l3[25] = G_l2[25];
    assign  G_l3[24] = G_l2[24];
    assign  G_l3[19] = G_l2[19];
    assign  G_l3[18] = G_l2[18];
    assign  G_l3[17] = G_l2[17];
    assign  G_l3[16] = G_l2[16];
    assign  G_l3[11] = G_l2[11];
    assign  G_l3[10] = G_l2[10];
    assign  G_l3[9] = G_l2[9];
    assign  G_l3[8] = G_l2[8];
    assign  G_l3[3] = G_l2[3];
    assign  G_l3[2] = G_l2[2];
    assign  G_l3[1] = G_l2[1];
    assign  G_l3[0] = G_l2[0];
    assign  P_l3[27] = P_l2[27];
    assign  P_l3[26] = P_l2[26];
    assign  P_l3[25] = P_l2[25];
    assign  P_l3[24] = P_l2[24];
    assign  P_l3[19] = P_l2[19];
    assign  P_l3[18] = P_l2[18];
    assign  P_l3[17] = P_l2[17];
    assign  P_l3[16] = P_l2[16];
    assign  P_l3[11] = P_l2[11];
    assign  P_l3[10] = P_l2[10];
    assign  P_l3[9] = P_l2[9];
    assign  P_l3[8] = P_l2[8];
    assign  P_l3[3] = P_l2[3];
    assign  P_l3[2] = P_l2[2];
    assign  P_l3[1] = P_l2[1];
    assign  P_l3[0] = P_l2[0];
    
    //////////////////////////////////////////////////////////////////////////////
    /////                               pipe 3                               /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [31:0]  G_l4, P_l4;
    wire    [31:0]  G_l5, P_l5;

    reg     [31:0]  G_l5_r, P_l5_r, p_l5_r;

    Processor   p4_0(G_l3_r[31], G_l3_r[23], P_l3_r[31], P_l3_r[23], G_l4[31], P_l4[31]);
    Processor   p4_1(G_l3_r[30], G_l3_r[23], P_l3_r[30], P_l3_r[23], G_l4[30], P_l4[30]);
    Processor   p4_2(G_l3_r[29], G_l3_r[23], P_l3_r[29], P_l3_r[23], G_l4[29], P_l4[29]);
    Processor   p4_3(G_l3_r[28], G_l3_r[23], P_l3_r[28], P_l3_r[23], G_l4[28], P_l4[28]);
    Processor   p4_4(G_l3_r[27], G_l3_r[23], P_l3_r[27], P_l3_r[23], G_l4[27], P_l4[27]);
    Processor   p4_5(G_l3_r[26], G_l3_r[23], P_l3_r[26], P_l3_r[23], G_l4[26], P_l4[26]);
    Processor   p4_6(G_l3_r[25], G_l3_r[23], P_l3_r[25], P_l3_r[23], G_l4[25], P_l4[25]);
    Processor   p4_7(G_l3_r[24], G_l3_r[23], P_l3_r[24], P_l3_r[23], G_l4[24], P_l4[24]);
    Processor   p4_8(G_l3_r[15], G_l3_r[7], P_l3_r[15], P_l3_r[7], G_l4[15], P_l4[15]);
    Processor   p4_9(G_l3_r[14], G_l3_r[7], P_l3_r[14], P_l3_r[7], G_l4[14], P_l4[14]);
    Processor   p4_10(G_l3_r[13], G_l3_r[7], P_l3_r[13], P_l3_r[7], G_l4[13], P_l4[13]);
    Processor   p4_11(G_l3_r[12], G_l3_r[7], P_l3_r[12], P_l3_r[7], G_l4[12], P_l4[12]);
    Processor   p4_12(G_l3_r[11], G_l3_r[7], P_l3_r[11], P_l3_r[7], G_l4[11], P_l4[11]);
    Processor   p4_13(G_l3_r[10], G_l3_r[7], P_l3_r[10], P_l3_r[7], G_l4[10], P_l4[10]);
    Processor   p4_14(G_l3_r[9], G_l3_r[7], P_l3_r[9], P_l3_r[7], G_l4[9], P_l4[9]);
    Processor   p4_15(G_l3_r[8], G_l3_r[7], P_l3_r[8], P_l3_r[7], G_l4[8], P_l4[8]);
    assign  G_l4[23] = G_l3_r[23];
    assign  G_l4[22] = G_l3_r[22];
    assign  G_l4[21] = G_l3_r[21];
    assign  G_l4[20] = G_l3_r[20];
    assign  G_l4[19] = G_l3_r[19];
    assign  G_l4[18] = G_l3_r[18];
    assign  G_l4[17] = G_l3_r[17];
    assign  G_l4[16] = G_l3_r[16];
    assign  G_l4[7] = G_l3_r[7];
    assign  G_l4[6] = G_l3_r[6];
    assign  G_l4[5] = G_l3_r[5];
    assign  G_l4[4] = G_l3_r[4];
    assign  G_l4[3] = G_l3_r[3];
    assign  G_l4[2] = G_l3_r[2];
    assign  G_l4[1] = G_l3_r[1];
    assign  G_l4[0] = G_l3_r[0];
    assign  P_l4[23] = P_l3_r[23];
    assign  P_l4[22] = P_l3_r[22];
    assign  P_l4[21] = P_l3_r[21];
    assign  P_l4[20] = P_l3_r[20];
    assign  P_l4[19] = P_l3_r[19];
    assign  P_l4[18] = P_l3_r[18];
    assign  P_l4[17] = P_l3_r[17];
    assign  P_l4[16] = P_l3_r[16];
    assign  P_l4[7] = P_l3_r[7];
    assign  P_l4[6] = P_l3_r[6];
    assign  P_l4[5] = P_l3_r[5];
    assign  P_l4[4] = P_l3_r[4];
    assign  P_l4[3] = P_l3_r[3];
    assign  P_l4[2] = P_l3_r[2];
    assign  P_l4[1] = P_l3_r[1];
    assign  P_l4[0] = P_l3_r[0];
    
    Processor   p5_0(G_l4[31], G_l4[15], P_l4[31], P_l4[15], G_l5[31], P_l5[31]);
    Processor   p5_1(G_l4[30], G_l4[15], P_l4[30], P_l4[15], G_l5[30], P_l5[30]);
    Processor   p5_2(G_l4[29], G_l4[15], P_l4[29], P_l4[15], G_l5[29], P_l5[29]);
    Processor   p5_3(G_l4[28], G_l4[15], P_l4[28], P_l4[15], G_l5[28], P_l5[28]);
    Processor   p5_4(G_l4[27], G_l4[15], P_l4[27], P_l4[15], G_l5[27], P_l5[27]);
    Processor   p5_5(G_l4[26], G_l4[15], P_l4[26], P_l4[15], G_l5[26], P_l5[26]);
    Processor   p5_6(G_l4[25], G_l4[15], P_l4[25], P_l4[15], G_l5[25], P_l5[25]);
    Processor   p5_7(G_l4[24], G_l4[15], P_l4[24], P_l4[15], G_l5[24], P_l5[24]);
    Processor   p5_8(G_l4[23], G_l4[15], P_l4[23], P_l4[15], G_l5[23], P_l5[23]);
    Processor   p5_9(G_l4[22], G_l4[15], P_l4[22], P_l4[15], G_l5[22], P_l5[22]);
    Processor   p5_10(G_l4[21], G_l4[15], P_l4[21], P_l4[15], G_l5[21], P_l5[21]);
    Processor   p5_11(G_l4[20], G_l4[15], P_l4[20], P_l4[15], G_l5[20], P_l5[20]);
    Processor   p5_12(G_l4[19], G_l4[15], P_l4[19], P_l4[15], G_l5[19], P_l5[19]);
    Processor   p5_13(G_l4[18], G_l4[15], P_l4[18], P_l4[15], G_l5[18], P_l5[18]);
    Processor   p5_14(G_l4[17], G_l4[15], P_l4[17], P_l4[15], G_l5[17], P_l5[17]);
    Processor   p5_15(G_l4[16], G_l4[15], P_l4[16], P_l4[15], G_l5[16], P_l5[16]);
    assign  G_l5[15] = G_l4[15];
    assign  G_l5[14] = G_l4[14];
    assign  G_l5[13] = G_l4[13];
    assign  G_l5[12] = G_l4[12];
    assign  G_l5[11] = G_l4[11];
    assign  G_l5[10] = G_l4[10];
    assign  G_l5[9] = G_l4[9];
    assign  G_l5[8] = G_l4[8];
    assign  G_l5[7] = G_l4[7];
    assign  G_l5[6] = G_l4[6];
    assign  G_l5[5] = G_l4[5];
    assign  G_l5[4] = G_l4[4];
    assign  G_l5[3] = G_l4[3];
    assign  G_l5[2] = G_l4[2];
    assign  G_l5[1] = G_l4[1];
    assign  G_l5[0] = G_l4[0];
    assign  P_l5[15] = P_l4[15];
    assign  P_l5[14] = P_l4[14];
    assign  P_l5[13] = P_l4[13];
    assign  P_l5[12] = P_l4[12];
    assign  P_l5[11] = P_l4[11];
    assign  P_l5[10] = P_l4[10];
    assign  P_l5[9] = P_l4[9];
    assign  P_l5[8] = P_l4[8];
    assign  P_l5[7] = P_l4[7];
    assign  P_l5[6] = P_l4[6];
    assign  P_l5[5] = P_l4[5];
    assign  P_l5[4] = P_l4[4];
    assign  P_l5[3] = P_l4[3];
    assign  P_l5[2] = P_l4[2];
    assign  P_l5[1] = P_l4[1];
    assign  P_l5[0] = P_l4[0];

    
    //////////////////////////////////////////////////////////////////////////////
    /////                       post processing                              /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [31:0]  Cm, Sm;
    genvar  ii;
    assign  Sm[0] = p_l5_r[0];
    for (ii = 1; ii < 32; ii = ii + 1) begin
        assign  Sm[ii] = p_l5_r[ii] ^ G_l5_r[ii-1];
    end

    assign  C = Sm[31:6];

    //////////////////////////////////////////////////////////////////////////////
    /////                               pipeline                             /////
    //////////////////////////////////////////////////////////////////////////////

    integer i;

    always@(posedge clk) begin
        if(!rst) begin
            // pipe 1
            for (i = 0; i < 32; i = i + 1) begin
                G_l1_r[i] <= 1'b0;
                P_l1_r[i] <= 1'b0;
                p_l1_r[i] <= 1'b0;
            end
            // pipe 2
            for (i = 0; i < 32; i = i + 1) begin
                G_l3_r[i] <= 1'b0; 
                P_l3_r[i] <= 1'b0;
                p_l3_r[i] <= 1'b0;
            end
            // pipe 3
            for (i = 0; i < 32; i = i + 1) begin
                G_l5_r[i] <= 1'b0;
                P_l5_r[i] <= 1'b0;
                p_l5_r[i] <= 1'b0;
            end
        end
        else begin
            // pipe 1
            for (i = 0; i < 32; i = i + 1) begin
                G_l1_r[i] <= G_l1[i];
                P_l1_r[i] <= P_l1[i];
                p_l1_r[i] <= P_l0[i];
            end
            // pipe 2
            for (i = 0; i < 32; i = i + 1) begin
                G_l3_r[i] <= G_l3[i];
                P_l3_r[i] <= P_l3[i];
                p_l3_r[i] <= p_l1_r[i];
            end
            // pipe 3
            for (i = 0; i < 32; i = i + 1) begin
                G_l5_r[i] <= G_l5[i];
                P_l5_r[i] <= P_l5[i];
                p_l5_r[i] <= p_l3_r[i];
            end
        end
    end

endmodule
