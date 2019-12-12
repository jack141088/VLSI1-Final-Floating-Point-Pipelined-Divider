module MUL_PL(
    input           clk,
    input           rst,
    input   [24:0]  A,
    input   [24:0]  B,
    input   [2:0]   ctr_in,
    input           D_in,
    input   [9:0]   remain_in,
    output  [2:0]   ctr_out,
    output          D_out,
    output  [9:0]   remain_out,
    output  [24:0]  C);

    wire    [24:0]  P[24:0];
    genvar ii;
    genvar jj;
    integer i;
    
    for (ii = 0; ii < 25; ii = ii + 1) begin
        for (jj = 0; jj < 25; jj = jj + 1) begin
            assign P[ii][jj] = A[jj] & B[ii];
        end
    end

    //////////////////////////////////////////////////////////////////////////////
    /////                      pipeline parameter                            /////
    //////////////////////////////////////////////////////////////////////////////
    reg     [2:0]   ctr_l1_r, ctr_l2_r, ctr_l3_r, ctr_l4_r;
    reg     [2:0]   ctr_l5_r, ctr_l6_r, ctr_l7_r;
    wire    [2:0]   ctr_final;
    reg             d_l1_r, d_l2_r, d_l3_r, d_l4_r;
    reg             d_l5_r, d_l6_r, d_l7_r;
    wire            d_final;
    reg     [9:0]   remain_l1_r, remain_l2_r, remain_l3_r, remain_l4_r;
    reg     [9:0]   remain_l5_r, remain_l6_r, remain_l7_r;
    wire    [9:0]   remain_final;
    
    //assign  ctr_out = ctr_final + 3'b1;
    a1_adder    A0(ctr_final, ctr_out);
    assign  D_out = d_final;
    assign  remain_out = remain_final;

    always@(posedge clk) begin
        if(!rst) begin
            ctr_l1_r <= 3'b0; 
            ctr_l2_r <= 3'b0;
            ctr_l3_r <= 3'b0;
            ctr_l4_r <= 3'b0;
            ctr_l5_r <= 3'b0;
            ctr_l6_r <= 3'b0;
            ctr_l7_r <= 3'b0;
            d_l1_r <= 1'b0;
            d_l2_r <= 1'b0;
            d_l3_r <= 1'b0;
            d_l4_r <= 1'b0;
            d_l5_r <= 1'b0;
            d_l6_r <= 1'b0;
            d_l7_r <= 1'b0;
            remain_l1_r <= 1'b0;
            remain_l2_r <= 1'b0;
            remain_l3_r <= 1'b0;
            remain_l4_r <= 1'b0;
            remain_l5_r <= 1'b0;
            remain_l6_r <= 1'b0;
            remain_l7_r <= 1'b0;
        end
        else begin
            ctr_l1_r <= ctr_in;
            ctr_l2_r <= ctr_l1_r;
            ctr_l3_r <= ctr_l2_r;
            ctr_l4_r <= ctr_l3_r;
            ctr_l5_r <= ctr_l4_r;
            ctr_l6_r <= ctr_l5_r;
            ctr_l7_r <= ctr_l6_r;
            d_l1_r <= D_in;
            d_l2_r <= d_l1_r;
            d_l3_r <= d_l2_r;
            d_l4_r <= d_l3_r;
            d_l5_r <= d_l4_r;
            d_l6_r <= d_l5_r;
            d_l7_r <= d_l6_r;
            remain_l1_r <= remain_in;
            remain_l2_r <= remain_l1_r;
            remain_l3_r <= remain_l2_r;
            remain_l4_r <= remain_l3_r;
            remain_l5_r <= remain_l4_r;
            remain_l6_r <= remain_l5_r;
            remain_l7_r <= remain_l6_r;
        end
    end

    //////////////////////////////////////////////////////////////////////////////
    /////                               loop 1                               /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [191:0] FA_S1, FA_C1;
    wire            HA_S1, HA_C1;

    reg     [191:0] FA_S1_l1_r, FA_C1_l1_r;
    reg             HA_S1_l1_r, HA_C1_l1_r;
    reg     [46:0]  P1_r;

    HA ha0(P[0][1], P[1][0], HA_S1, HA_C1);

    // loop 1, level 1 (#: 0 - 44, Total: 45)
    FA fa1_0(P[22][24], P[23][23], P[24][22], FA_S1[0], FA_C1[0]);
    FA fa1_1(P[21][24], P[22][23], P[23][22], FA_S1[1], FA_C1[1]);
    FA fa1_2(P[20][24], P[21][23], P[22][22], FA_S1[2], FA_C1[2]);
    FA fa1_3(P[19][24], P[20][23], P[21][22], FA_S1[3], FA_C1[3]);
    FA fa1_4(P[18][24], P[19][23], P[20][22], FA_S1[4], FA_C1[4]);
    FA fa1_5(P[17][24], P[18][23], P[19][22], FA_S1[5], FA_C1[5]);
    FA fa1_6(P[16][24], P[17][23], P[18][22], FA_S1[6], FA_C1[6]);
    FA fa1_7(P[15][24], P[16][23], P[17][22], FA_S1[7], FA_C1[7]);
    FA fa1_8(P[14][24], P[15][23], P[16][22], FA_S1[8], FA_C1[8]);
    FA fa1_9(P[13][24], P[14][23], P[15][22], FA_S1[9], FA_C1[9]);
    FA fa1_10(P[12][24], P[13][23], P[14][22], FA_S1[10], FA_C1[10]);
    FA fa1_11(P[11][24], P[12][23], P[13][22], FA_S1[11], FA_C1[11]);
    FA fa1_12(P[10][24], P[11][23], P[12][22], FA_S1[12], FA_C1[12]);
    FA fa1_13(P[9][24], P[10][23], P[11][22], FA_S1[13], FA_C1[13]);
    FA fa1_14(P[8][24], P[9][23], P[10][22], FA_S1[14], FA_C1[14]);
    FA fa1_15(P[7][24], P[8][23], P[9][22], FA_S1[15], FA_C1[15]);
    FA fa1_16(P[6][24], P[7][23], P[8][22], FA_S1[16], FA_C1[16]);
    FA fa1_17(P[5][24], P[6][23], P[7][22], FA_S1[17], FA_C1[17]);
    FA fa1_18(P[4][24], P[5][23], P[6][22], FA_S1[18], FA_C1[18]);
    FA fa1_19(P[3][24], P[4][23], P[5][22], FA_S1[19], FA_C1[19]);
    FA fa1_20(P[2][24], P[3][23], P[4][22], FA_S1[20], FA_C1[20]);
    FA fa1_21(P[1][24], P[2][23], P[3][22], FA_S1[21], FA_C1[21]);
    FA fa1_22(P[0][24], P[1][23], P[2][22], FA_S1[22], FA_C1[22]);
    FA fa1_23(P[0][23], P[1][22], P[2][21], FA_S1[23], FA_C1[23]);
    FA fa1_24(P[0][22], P[1][21], P[2][20], FA_S1[24], FA_C1[24]);
    FA fa1_25(P[0][21], P[1][20], P[2][19], FA_S1[25], FA_C1[25]);
    FA fa1_26(P[0][20], P[1][19], P[2][18], FA_S1[26], FA_C1[26]);
    FA fa1_27(P[0][19], P[1][18], P[2][17], FA_S1[27], FA_C1[27]);
    FA fa1_28(P[0][18], P[1][17], P[2][16], FA_S1[28], FA_C1[28]);
    FA fa1_29(P[0][17], P[1][16], P[2][15], FA_S1[29], FA_C1[29]);
    FA fa1_30(P[0][16], P[1][15], P[2][14], FA_S1[30], FA_C1[30]);
    FA fa1_31(P[0][15], P[1][14], P[2][13], FA_S1[31], FA_C1[31]);
    FA fa1_32(P[0][14], P[1][13], P[2][12], FA_S1[32], FA_C1[32]);
    FA fa1_33(P[0][13], P[1][12], P[2][11], FA_S1[33], FA_C1[33]);
    FA fa1_34(P[0][12], P[1][11], P[2][10], FA_S1[34], FA_C1[34]);
    FA fa1_35(P[0][11], P[1][10], P[2][9], FA_S1[35], FA_C1[35]);
    FA fa1_36(P[0][10], P[1][9], P[2][8], FA_S1[36], FA_C1[36]);
    FA fa1_37(P[0][9], P[1][8], P[2][7], FA_S1[37], FA_C1[37]);
    FA fa1_38(P[0][8], P[1][7], P[2][6], FA_S1[38], FA_C1[38]);
    FA fa1_39(P[0][7], P[1][6], P[2][5], FA_S1[39], FA_C1[39]);
    FA fa1_40(P[0][6], P[1][5], P[2][4], FA_S1[40], FA_C1[40]);
    FA fa1_41(P[0][5], P[1][4], P[2][3], FA_S1[41], FA_C1[41]);
    FA fa1_42(P[0][4], P[1][3], P[2][2], FA_S1[42], FA_C1[42]);
    FA fa1_43(P[0][3], P[1][2], P[2][1], FA_S1[43], FA_C1[43]);
    FA fa1_44(P[0][2], P[1][1], P[2][0], FA_S1[44], FA_C1[44]);
    
    // loop 1, level 2 (#: 45 - 83, Total: 39)
    FA fa1_45(P[22][21], P[23][20], P[24][19], FA_S1[45], FA_C1[45]);
    FA fa1_46(P[21][21], P[22][20], P[23][19], FA_S1[46], FA_C1[46]);
    FA fa1_47(P[20][21], P[21][20], P[22][19], FA_S1[47], FA_C1[47]);
    FA fa1_48(P[19][21], P[20][20], P[21][19], FA_S1[48], FA_C1[48]);
    FA fa1_49(P[18][21], P[19][20], P[20][19], FA_S1[49], FA_C1[49]);
    FA fa1_50(P[17][21], P[18][20], P[19][19], FA_S1[50], FA_C1[50]);
    FA fa1_51(P[16][21], P[17][20], P[18][19], FA_S1[51], FA_C1[51]);
    FA fa1_52(P[15][21], P[16][20], P[17][19], FA_S1[52], FA_C1[52]);
    FA fa1_53(P[14][21], P[15][20], P[16][19], FA_S1[53], FA_C1[53]);
    FA fa1_54(P[13][21], P[14][20], P[15][19], FA_S1[54], FA_C1[54]);
    FA fa1_55(P[12][21], P[13][20], P[14][19], FA_S1[55], FA_C1[55]);
    FA fa1_56(P[11][21], P[12][20], P[13][19], FA_S1[56], FA_C1[56]);
    FA fa1_57(P[10][21], P[11][20], P[12][19], FA_S1[57], FA_C1[57]);
    FA fa1_58(P[9][21], P[10][20], P[11][19], FA_S1[58], FA_C1[58]);
    FA fa1_59(P[8][21], P[9][20], P[10][19], FA_S1[59], FA_C1[59]);
    FA fa1_60(P[7][21], P[8][20], P[9][19], FA_S1[60], FA_C1[60]);
    FA fa1_61(P[6][21], P[7][20], P[8][19], FA_S1[61], FA_C1[61]);
    FA fa1_62(P[5][21], P[6][20], P[7][19], FA_S1[62], FA_C1[62]);
    FA fa1_63(P[4][21], P[5][20], P[6][19], FA_S1[63], FA_C1[63]);
    FA fa1_64(P[3][21], P[4][20], P[5][19], FA_S1[64], FA_C1[64]);
    FA fa1_65(P[3][20], P[4][19], P[5][18], FA_S1[65], FA_C1[65]);
    FA fa1_66(P[3][19], P[4][18], P[5][17], FA_S1[66], FA_C1[66]);
    FA fa1_67(P[3][18], P[4][17], P[5][16], FA_S1[67], FA_C1[67]);
    FA fa1_68(P[3][17], P[4][16], P[5][15], FA_S1[68], FA_C1[68]);
    FA fa1_69(P[3][16], P[4][15], P[5][14], FA_S1[69], FA_C1[69]);
    FA fa1_70(P[3][15], P[4][14], P[5][13], FA_S1[70], FA_C1[70]);
    FA fa1_71(P[3][14], P[4][13], P[5][12], FA_S1[71], FA_C1[71]);
    FA fa1_72(P[3][13], P[4][12], P[5][11], FA_S1[72], FA_C1[72]);
    FA fa1_73(P[3][12], P[4][11], P[5][10], FA_S1[73], FA_C1[73]);
    FA fa1_74(P[3][11], P[4][10], P[5][9], FA_S1[74], FA_C1[74]);
    FA fa1_75(P[3][10], P[4][9], P[5][8], FA_S1[75], FA_C1[75]);
    FA fa1_76(P[3][9], P[4][8], P[5][7], FA_S1[76], FA_C1[76]);
    FA fa1_77(P[3][8], P[4][7], P[5][6], FA_S1[77], FA_C1[77]);
    FA fa1_78(P[3][7], P[4][6], P[5][5], FA_S1[78], FA_C1[78]);
    FA fa1_79(P[3][6], P[4][5], P[5][4], FA_S1[79], FA_C1[79]);
    FA fa1_80(P[3][5], P[4][4], P[5][3], FA_S1[80], FA_C1[80]);
    FA fa1_81(P[3][4], P[4][3], P[5][2], FA_S1[81], FA_C1[81]);
    FA fa1_82(P[3][3], P[4][2], P[5][1], FA_S1[82], FA_C1[82]);
    FA fa1_83(P[3][2], P[4][1], P[5][0], FA_S1[83], FA_C1[83]);
    
    // loop 1, level 3 (#: 84 - 116, Total: 33)
    FA fa1_84(P[22][18], P[23][17], P[24][16], FA_S1[84], FA_C1[84]);
    FA fa1_85(P[21][18], P[22][17], P[23][16], FA_S1[85], FA_C1[85]);
    FA fa1_86(P[20][18], P[21][17], P[22][16], FA_S1[86], FA_C1[86]);
    FA fa1_87(P[19][18], P[20][17], P[21][16], FA_S1[87], FA_C1[87]);
    FA fa1_88(P[18][18], P[19][17], P[20][16], FA_S1[88], FA_C1[88]);
    FA fa1_89(P[17][18], P[18][17], P[19][16], FA_S1[89], FA_C1[89]);
    FA fa1_90(P[16][18], P[17][17], P[18][16], FA_S1[90], FA_C1[90]);
    FA fa1_91(P[15][18], P[16][17], P[17][16], FA_S1[91], FA_C1[91]);
    FA fa1_92(P[14][18], P[15][17], P[16][16], FA_S1[92], FA_C1[92]);
    FA fa1_93(P[13][18], P[14][17], P[15][16], FA_S1[93], FA_C1[93]);
    FA fa1_94(P[12][18], P[13][17], P[14][16], FA_S1[94], FA_C1[94]);
    FA fa1_95(P[11][18], P[12][17], P[13][16], FA_S1[95], FA_C1[95]);
    FA fa1_96(P[10][18], P[11][17], P[12][16], FA_S1[96], FA_C1[96]);
    FA fa1_97(P[9][18], P[10][17], P[11][16], FA_S1[97], FA_C1[97]);
    FA fa1_98(P[8][18], P[9][17], P[10][16], FA_S1[98], FA_C1[98]);
    FA fa1_99(P[7][18], P[8][17], P[9][16], FA_S1[99], FA_C1[99]);
    FA fa1_100(P[6][18], P[7][17], P[8][16], FA_S1[100], FA_C1[100]);
    FA fa1_101(P[6][17], P[7][16], P[8][15], FA_S1[101], FA_C1[101]);
    FA fa1_102(P[6][16], P[7][15], P[8][14], FA_S1[102], FA_C1[102]);
    FA fa1_103(P[6][15], P[7][14], P[8][13], FA_S1[103], FA_C1[103]);
    FA fa1_104(P[6][14], P[7][13], P[8][12], FA_S1[104], FA_C1[104]);
    FA fa1_105(P[6][13], P[7][12], P[8][11], FA_S1[105], FA_C1[105]);
    FA fa1_106(P[6][12], P[7][11], P[8][10], FA_S1[106], FA_C1[106]);
    FA fa1_107(P[6][11], P[7][10], P[8][9], FA_S1[107], FA_C1[107]);
    FA fa1_108(P[6][10], P[7][9], P[8][8], FA_S1[108], FA_C1[108]);
    FA fa1_109(P[6][9], P[7][8], P[8][7], FA_S1[109], FA_C1[109]);
    FA fa1_110(P[6][8], P[7][7], P[8][6], FA_S1[110], FA_C1[110]);
    FA fa1_111(P[6][7], P[7][6], P[8][5], FA_S1[111], FA_C1[111]);
    FA fa1_112(P[6][6], P[7][5], P[8][4], FA_S1[112], FA_C1[112]);
    FA fa1_113(P[6][5], P[7][4], P[8][3], FA_S1[113], FA_C1[113]);
    FA fa1_114(P[6][4], P[7][3], P[8][2], FA_S1[114], FA_C1[114]);
    FA fa1_115(P[6][3], P[7][2], P[8][1], FA_S1[115], FA_C1[115]);
    FA fa1_116(P[6][2], P[7][1], P[8][0], FA_S1[116], FA_C1[116]);

    // loop 1, level 4 (#: 117 - 143, Total: 27)
    FA fa1_117(P[22][15], P[23][14], P[24][13], FA_S1[117], FA_C1[117]);
    FA fa1_118(P[21][15], P[22][14], P[23][13], FA_S1[118], FA_C1[118]);
    FA fa1_119(P[20][15], P[21][14], P[22][13], FA_S1[119], FA_C1[119]);
    FA fa1_120(P[19][15], P[20][14], P[21][13], FA_S1[120], FA_C1[120]);
    FA fa1_121(P[18][15], P[19][14], P[20][13], FA_S1[121], FA_C1[121]);
    FA fa1_122(P[17][15], P[18][14], P[19][13], FA_S1[122], FA_C1[122]);
    FA fa1_123(P[16][15], P[17][14], P[18][13], FA_S1[123], FA_C1[123]);
    FA fa1_124(P[15][15], P[16][14], P[17][13], FA_S1[124], FA_C1[124]);
    FA fa1_125(P[14][15], P[15][14], P[16][13], FA_S1[125], FA_C1[125]);
    FA fa1_126(P[13][15], P[14][14], P[15][13], FA_S1[126], FA_C1[126]);
    FA fa1_127(P[12][15], P[13][14], P[14][13], FA_S1[127], FA_C1[127]);
    FA fa1_128(P[11][15], P[12][14], P[13][13], FA_S1[128], FA_C1[128]);
    FA fa1_129(P[10][15], P[11][14], P[12][13], FA_S1[129], FA_C1[129]);
    FA fa1_130(P[9][15], P[10][14], P[11][13], FA_S1[130], FA_C1[130]);
    FA fa1_131(P[9][14], P[10][13], P[11][12], FA_S1[131], FA_C1[131]);
    FA fa1_132(P[9][13], P[10][12], P[11][11], FA_S1[132], FA_C1[132]);
    FA fa1_133(P[9][12], P[10][11], P[11][10], FA_S1[133], FA_C1[133]);
    FA fa1_134(P[9][11], P[10][10], P[11][9], FA_S1[134], FA_C1[134]);
    FA fa1_135(P[9][10], P[10][9], P[11][8], FA_S1[135], FA_C1[135]);
    FA fa1_136(P[9][9], P[10][8], P[11][7], FA_S1[136], FA_C1[136]);
    FA fa1_137(P[9][8], P[10][7], P[11][6], FA_S1[137], FA_C1[137]);
    FA fa1_138(P[9][7], P[10][6], P[11][5], FA_S1[138], FA_C1[138]);
    FA fa1_139(P[9][6], P[10][5], P[11][4], FA_S1[139], FA_C1[139]);
    FA fa1_140(P[9][5], P[10][4], P[11][3], FA_S1[140], FA_C1[140]);
    FA fa1_141(P[9][4], P[10][3], P[11][2], FA_S1[141], FA_C1[141]);
    FA fa1_142(P[9][3], P[10][2], P[11][1], FA_S1[142], FA_C1[142]);
    FA fa1_143(P[9][2], P[10][1], P[11][0], FA_S1[143], FA_C1[143]);

    // loop 1, level 5 (#: 144 - 164, Total: 21)
    FA fa1_144(P[22][12], P[23][11], P[24][10], FA_S1[144], FA_C1[144]);
    FA fa1_145(P[21][12], P[22][11], P[23][10], FA_S1[145], FA_C1[145]);
    FA fa1_146(P[20][12], P[21][11], P[22][10], FA_S1[146], FA_C1[146]);
    FA fa1_147(P[19][12], P[20][11], P[21][10], FA_S1[147], FA_C1[147]);
    FA fa1_148(P[18][12], P[19][11], P[20][10], FA_S1[148], FA_C1[148]);
    FA fa1_149(P[17][12], P[18][11], P[19][10], FA_S1[149], FA_C1[149]);
    FA fa1_150(P[16][12], P[17][11], P[18][10], FA_S1[150], FA_C1[150]);
    FA fa1_151(P[15][12], P[16][11], P[17][10], FA_S1[151], FA_C1[151]);
    FA fa1_152(P[14][12], P[15][11], P[16][10], FA_S1[152], FA_C1[152]);
    FA fa1_153(P[13][12], P[14][11], P[15][10], FA_S1[153], FA_C1[153]);
    FA fa1_154(P[12][12], P[13][11], P[14][10], FA_S1[154], FA_C1[154]);
    FA fa1_155(P[12][11], P[13][10], P[14][9], FA_S1[155], FA_C1[155]);
    FA fa1_156(P[12][10], P[13][9], P[14][8], FA_S1[156], FA_C1[156]);
    FA fa1_157(P[12][9], P[13][8], P[14][7], FA_S1[157], FA_C1[157]);
    FA fa1_158(P[12][8], P[13][7], P[14][6], FA_S1[158], FA_C1[158]);
    FA fa1_159(P[12][7], P[13][6], P[14][5], FA_S1[159], FA_C1[159]);
    FA fa1_160(P[12][6], P[13][5], P[14][4], FA_S1[160], FA_C1[160]);
    FA fa1_161(P[12][5], P[13][4], P[14][3], FA_S1[161], FA_C1[161]);
    FA fa1_162(P[12][4], P[13][3], P[14][2], FA_S1[162], FA_C1[162]);
    FA fa1_163(P[12][3], P[13][2], P[14][1], FA_S1[163], FA_C1[163]);
    FA fa1_164(P[12][2], P[13][1], P[14][0], FA_S1[164], FA_C1[164]);

    // loop 1, level 6 (#: 165 - 179, Total: 15)
    FA fa1_165(P[22][9], P[23][8], P[24][7], FA_S1[165], FA_C1[165]);
    FA fa1_166(P[21][9], P[22][8], P[23][7], FA_S1[166], FA_C1[166]);
    FA fa1_167(P[20][9], P[21][8], P[22][7], FA_S1[167], FA_C1[167]);
    FA fa1_168(P[19][9], P[20][8], P[21][7], FA_S1[168], FA_C1[168]);
    FA fa1_169(P[18][9], P[19][8], P[20][7], FA_S1[169], FA_C1[169]);
    FA fa1_170(P[17][9], P[18][8], P[19][7], FA_S1[170], FA_C1[170]);
    FA fa1_171(P[16][9], P[17][8], P[18][7], FA_S1[171], FA_C1[171]);
    FA fa1_172(P[15][9], P[16][8], P[17][7], FA_S1[172], FA_C1[172]);
    FA fa1_173(P[15][8], P[16][7], P[17][6], FA_S1[173], FA_C1[173]);
    FA fa1_174(P[15][7], P[16][6], P[17][5], FA_S1[174], FA_C1[174]);
    FA fa1_175(P[15][6], P[16][5], P[17][4], FA_S1[175], FA_C1[175]);
    FA fa1_176(P[15][5], P[16][4], P[17][3], FA_S1[176], FA_C1[176]);
    FA fa1_177(P[15][4], P[16][3], P[17][2], FA_S1[177], FA_C1[177]);
    FA fa1_178(P[15][3], P[16][2], P[17][1], FA_S1[178], FA_C1[178]);
    FA fa1_179(P[15][2], P[16][1], P[17][0], FA_S1[179], FA_C1[179]);

    // loop 1, level 7 (#: 180 - 188, Total: 9)
    FA fa1_180(P[22][6], P[23][5], P[24][4], FA_S1[180], FA_C1[180]);
    FA fa1_181(P[21][6], P[22][5], P[23][4], FA_S1[181], FA_C1[181]);
    FA fa1_182(P[20][6], P[21][5], P[22][4], FA_S1[182], FA_C1[182]);
    FA fa1_183(P[19][6], P[20][5], P[21][4], FA_S1[183], FA_C1[183]);
    FA fa1_184(P[18][6], P[19][5], P[20][4], FA_S1[184], FA_C1[184]);
    FA fa1_185(P[18][5], P[19][4], P[20][3], FA_S1[185], FA_C1[185]);
    FA fa1_186(P[18][4], P[19][3], P[20][2], FA_S1[186], FA_C1[186]);
    FA fa1_187(P[18][3], P[19][2], P[20][1], FA_S1[187], FA_C1[187]);
    FA fa1_188(P[18][2], P[19][1], P[20][0], FA_S1[188], FA_C1[188]);

    // loop 1, level 8 (#: 189 - 191, Total: 3)
    FA fa1_189(P[22][3], P[23][2], P[24][1], FA_S1[189], FA_C1[189]);
    FA fa1_190(P[21][3], P[22][2], P[23][1], FA_S1[190], FA_C1[190]);
    FA fa1_191(P[21][2], P[22][1], P[23][0], FA_S1[191], FA_C1[191]);


    //////////////////////////////////////////////////////////////////////////////
    /////                               loop 2                               /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [127:0] FA_S2, FA_C2;
    wire            HA_S2, HA_C2;

    reg     [6:0]   FA_S1_l2_r;
    reg     [15:0]  FA_C1_l2_r;
    reg             HA_S1_l2_r;
    reg     [127:0] FA_S2_l2_r, FA_C2_l2_r;
    reg             HA_S2_l2_r, HA_C2_l2_r;
    reg     [22:0]  P2_r;
    

    HA ha1(FA_S1_l1_r[44], HA_C1_l1_r, HA_S2, HA_C2);
    
    // loop 2, level 1 (#: 0 - 43, Total: 44)
    FA fa2_0(P1_r[29], P1_r[45], FA_C1_l1_r[0], FA_S2[0], FA_C2[0]);
    FA fa2_1(FA_S1_l1_r[1], FA_C1_l1_r[2], P1_r[44], FA_S2[1], FA_C2[1]);
    FA fa2_2(FA_S1_l1_r[2], FA_C1_l1_r[3], P1_r[28], FA_S2[2], FA_C2[2]);
    FA fa2_3(FA_S1_l1_r[3], FA_C1_l1_r[4], FA_S1_l1_r[45], FA_S2[3], FA_C2[3]);
    FA fa2_4(FA_S1_l1_r[4], FA_C1_l1_r[5], FA_S1_l1_r[46], FA_S2[4], FA_C2[4]);
    FA fa2_5(FA_S1_l1_r[5], FA_C1_l1_r[6], FA_S1_l1_r[47], FA_S2[5], FA_C2[5]);
    FA fa2_6(FA_S1_l1_r[6], FA_C1_l1_r[7], FA_S1_l1_r[48], FA_S2[6], FA_C2[6]);
    FA fa2_7(FA_S1_l1_r[7], FA_C1_l1_r[8], FA_S1_l1_r[49], FA_S2[7], FA_C2[7]);
    FA fa2_8(FA_S1_l1_r[8], FA_C1_l1_r[9], FA_S1_l1_r[50], FA_S2[8], FA_C2[8]);
    FA fa2_9(FA_S1_l1_r[9], FA_C1_l1_r[10], FA_S1_l1_r[51], FA_S2[9], FA_C2[9]);
    FA fa2_10(FA_S1_l1_r[10], FA_C1_l1_r[11], FA_S1_l1_r[52], FA_S2[10], FA_C2[10]);
    FA fa2_11(FA_S1_l1_r[11], FA_C1_l1_r[12], FA_S1_l1_r[53], FA_S2[11], FA_C2[11]);
    FA fa2_12(FA_S1_l1_r[12], FA_C1_l1_r[13], FA_S1_l1_r[54], FA_S2[12], FA_C2[12]);
    FA fa2_13(FA_S1_l1_r[13], FA_C1_l1_r[14], FA_S1_l1_r[55], FA_S2[13], FA_C2[13]);
    FA fa2_14(FA_S1_l1_r[14], FA_C1_l1_r[15], FA_S1_l1_r[56], FA_S2[14], FA_C2[14]);
    FA fa2_15(FA_S1_l1_r[15], FA_C1_l1_r[16], FA_S1_l1_r[57], FA_S2[15], FA_C2[15]);
    FA fa2_16(FA_S1_l1_r[16], FA_C1_l1_r[17], FA_S1_l1_r[58], FA_S2[16], FA_C2[16]);
    FA fa2_17(FA_S1_l1_r[17], FA_C1_l1_r[18], FA_S1_l1_r[59], FA_S2[17], FA_C2[17]);
    FA fa2_18(FA_S1_l1_r[18], FA_C1_l1_r[19], FA_S1_l1_r[60], FA_S2[18], FA_C2[18]);
    FA fa2_19(FA_S1_l1_r[19], FA_C1_l1_r[20], FA_S1_l1_r[61], FA_S2[19], FA_C2[19]);
    FA fa2_20(FA_S1_l1_r[20], FA_C1_l1_r[21], FA_S1_l1_r[62], FA_S2[20], FA_C2[20]);
    FA fa2_21(FA_S1_l1_r[21], FA_C1_l1_r[22], FA_S1_l1_r[63], FA_S2[21], FA_C2[21]);
    FA fa2_22(FA_S1_l1_r[22], FA_C1_l1_r[23], FA_S1_l1_r[64], FA_S2[22], FA_C2[22]);
    FA fa2_23(FA_S1_l1_r[23], FA_C1_l1_r[24], FA_S1_l1_r[65], FA_S2[23], FA_C2[23]);
    FA fa2_24(FA_S1_l1_r[24], FA_C1_l1_r[25], FA_S1_l1_r[66], FA_S2[24], FA_C2[24]);
    FA fa2_25(FA_S1_l1_r[25], FA_C1_l1_r[26], FA_S1_l1_r[67], FA_S2[25], FA_C2[25]);
    FA fa2_26(FA_S1_l1_r[26], FA_C1_l1_r[27], FA_S1_l1_r[68], FA_S2[26], FA_C2[26]);
    FA fa2_27(FA_S1_l1_r[27], FA_C1_l1_r[28], FA_S1_l1_r[69], FA_S2[27], FA_C2[27]);
    FA fa2_28(FA_S1_l1_r[28], FA_C1_l1_r[29], FA_S1_l1_r[70], FA_S2[28], FA_C2[28]);
    FA fa2_29(FA_S1_l1_r[29], FA_C1_l1_r[30], FA_S1_l1_r[71], FA_S2[29], FA_C2[29]);
    FA fa2_30(FA_S1_l1_r[30], FA_C1_l1_r[31], FA_S1_l1_r[72], FA_S2[30], FA_C2[30]);
    FA fa2_31(FA_S1_l1_r[31], FA_C1_l1_r[32], FA_S1_l1_r[73], FA_S2[31], FA_C2[31]);
    FA fa2_32(FA_S1_l1_r[32], FA_C1_l1_r[33], FA_S1_l1_r[74], FA_S2[32], FA_C2[32]);
    FA fa2_33(FA_S1_l1_r[33], FA_C1_l1_r[34], FA_S1_l1_r[75], FA_S2[33], FA_C2[33]);
    FA fa2_34(FA_S1_l1_r[34], FA_C1_l1_r[35], FA_S1_l1_r[76], FA_S2[34], FA_C2[34]);
    FA fa2_35(FA_S1_l1_r[35], FA_C1_l1_r[36], FA_S1_l1_r[77], FA_S2[35], FA_C2[35]);
    FA fa2_36(FA_S1_l1_r[36], FA_C1_l1_r[37], FA_S1_l1_r[78], FA_S2[36], FA_C2[36]);
    FA fa2_37(FA_S1_l1_r[37], FA_C1_l1_r[38], FA_S1_l1_r[79], FA_S2[37], FA_C2[37]);
    FA fa2_38(FA_S1_l1_r[38], FA_C1_l1_r[39], FA_S1_l1_r[80], FA_S2[38], FA_C2[38]);
    FA fa2_39(FA_S1_l1_r[39], FA_C1_l1_r[40], FA_S1_l1_r[81], FA_S2[39], FA_C2[39]);
    FA fa2_40(FA_S1_l1_r[40], FA_C1_l1_r[41], FA_S1_l1_r[82], FA_S2[40], FA_C2[40]);
    FA fa2_41(FA_S1_l1_r[41], FA_C1_l1_r[42], FA_S1_l1_r[83], FA_S2[41], FA_C2[41]);
    FA fa2_42(FA_S1_l1_r[42], FA_C1_l1_r[43], P1_r[2], FA_S2[42], FA_C2[42]);
    FA fa2_43(FA_S1_l1_r[43], FA_C1_l1_r[44], P1_r[1], FA_S2[43], FA_C2[43]);

    // loop 2, level 2 (#: 44 - 77, Total: 34)
    FA fa2_44(P1_r[27], FA_C1_l1_r[48], FA_C1_l1_r[84], FA_S2[44], FA_C2[44]);
    FA fa2_45(FA_C1_l1_r[49], FA_S1_l1_r[84], FA_C1_l1_r[85], FA_S2[45], FA_C2[45]);
    FA fa2_46(FA_C1_l1_r[50], FA_S1_l1_r[85], FA_C1_l1_r[86], FA_S2[46], FA_C2[46]);
    FA fa2_47(FA_C1_l1_r[51], FA_S1_l1_r[86], FA_C1_l1_r[87], FA_S2[47], FA_C2[47]);
    FA fa2_48(FA_C1_l1_r[52], FA_S1_l1_r[87], FA_C1_l1_r[88], FA_S2[48], FA_C2[48]);
    FA fa2_49(FA_C1_l1_r[53], FA_S1_l1_r[88], FA_C1_l1_r[89], FA_S2[49], FA_C2[49]);
    FA fa2_50(FA_C1_l1_r[54], FA_S1_l1_r[89], FA_C1_l1_r[90], FA_S2[50], FA_C2[50]);
    FA fa2_51(FA_C1_l1_r[55], FA_S1_l1_r[90], FA_C1_l1_r[91], FA_S2[51], FA_C2[51]);
    FA fa2_52(FA_C1_l1_r[56], FA_S1_l1_r[91], FA_C1_l1_r[92], FA_S2[52], FA_C2[52]);
    FA fa2_53(FA_C1_l1_r[57], FA_S1_l1_r[92], FA_C1_l1_r[93], FA_S2[53], FA_C2[53]);
    FA fa2_54(FA_C1_l1_r[58], FA_S1_l1_r[93], FA_C1_l1_r[94], FA_S2[54], FA_C2[54]);
    FA fa2_55(FA_C1_l1_r[59], FA_S1_l1_r[94], FA_C1_l1_r[95], FA_S2[55], FA_C2[55]);
    FA fa2_56(FA_C1_l1_r[60], FA_S1_l1_r[95], FA_C1_l1_r[96], FA_S2[56], FA_C2[56]);
    FA fa2_57(FA_C1_l1_r[61], FA_S1_l1_r[96], FA_C1_l1_r[97], FA_S2[57], FA_C2[57]);
    FA fa2_58(FA_C1_l1_r[62], FA_S1_l1_r[97], FA_C1_l1_r[98], FA_S2[58], FA_C2[58]);
    FA fa2_59(FA_C1_l1_r[63], FA_S1_l1_r[98], FA_C1_l1_r[99], FA_S2[59], FA_C2[59]);
    FA fa2_60(FA_C1_l1_r[64], FA_S1_l1_r[99], FA_C1_l1_r[100], FA_S2[60], FA_C2[60]);
    FA fa2_61(FA_C1_l1_r[65], FA_S1_l1_r[100], FA_C1_l1_r[101], FA_S2[61], FA_C2[61]);
    FA fa2_62(FA_C1_l1_r[66], FA_S1_l1_r[101], FA_C1_l1_r[102], FA_S2[62], FA_C2[62]);
    FA fa2_63(FA_C1_l1_r[67], FA_S1_l1_r[102], FA_C1_l1_r[103], FA_S2[63], FA_C2[63]);
    FA fa2_64(FA_C1_l1_r[68], FA_S1_l1_r[103], FA_C1_l1_r[104], FA_S2[64], FA_C2[64]);
    FA fa2_65(FA_C1_l1_r[69], FA_S1_l1_r[104], FA_C1_l1_r[105], FA_S2[65], FA_C2[65]);
    FA fa2_66(FA_C1_l1_r[70], FA_S1_l1_r[105], FA_C1_l1_r[106], FA_S2[66], FA_C2[66]);
    FA fa2_67(FA_C1_l1_r[71], FA_S1_l1_r[106], FA_C1_l1_r[107], FA_S2[67], FA_C2[67]);
    FA fa2_68(FA_C1_l1_r[72], FA_S1_l1_r[107], FA_C1_l1_r[108], FA_S2[68], FA_C2[68]);
    FA fa2_69(FA_C1_l1_r[73], FA_S1_l1_r[108], FA_C1_l1_r[109], FA_S2[69], FA_C2[69]);
    FA fa2_70(FA_C1_l1_r[74], FA_S1_l1_r[109], FA_C1_l1_r[110], FA_S2[70], FA_C2[70]);
    FA fa2_71(FA_C1_l1_r[75], FA_S1_l1_r[110], FA_C1_l1_r[111], FA_S2[71], FA_C2[71]);
    FA fa2_72(FA_C1_l1_r[76], FA_S1_l1_r[111], FA_C1_l1_r[112], FA_S2[72], FA_C2[72]);
    FA fa2_73(FA_C1_l1_r[77], FA_S1_l1_r[112], FA_C1_l1_r[113], FA_S2[73], FA_C2[73]);
    FA fa2_74(FA_C1_l1_r[78], FA_S1_l1_r[113], FA_C1_l1_r[114], FA_S2[74], FA_C2[74]);
    FA fa2_75(FA_C1_l1_r[79], FA_S1_l1_r[114], FA_C1_l1_r[115], FA_S2[75], FA_C2[75]);
    FA fa2_76(FA_C1_l1_r[80], FA_S1_l1_r[115], FA_C1_l1_r[116], FA_S2[76], FA_C2[76]);
    FA fa2_77(FA_C1_l1_r[82], P1_r[5], P1_r[6], FA_S2[77], FA_C2[77]);
   
    // loop 2, level 3 (#: 78 - 103, Total: 26)
    FA fa2_78(P1_r[26], FA_C1_l1_r[117], P1_r[39], FA_S2[78], FA_C2[78]);
    FA fa2_79(FA_S1_l1_r[118], FA_C1_l1_r[119], P1_r[38], FA_S2[79], FA_C2[79]);
    FA fa2_80(FA_S1_l1_r[119], FA_C1_l1_r[120], P1_r[25], FA_S2[80], FA_C2[80]);
    FA fa2_81(FA_S1_l1_r[120], FA_C1_l1_r[121], FA_S1_l1_r[144], FA_S2[81], FA_C2[81]);
    FA fa2_82(FA_S1_l1_r[121], FA_C1_l1_r[122], FA_S1_l1_r[145], FA_S2[82], FA_C2[82]);
    FA fa2_83(FA_S1_l1_r[122], FA_C1_l1_r[123], FA_S1_l1_r[146], FA_S2[83], FA_C2[83]);
    FA fa2_84(FA_S1_l1_r[123], FA_C1_l1_r[124], FA_S1_l1_r[147], FA_S2[84], FA_C2[84]);
    FA fa2_85(FA_S1_l1_r[124], FA_C1_l1_r[125], FA_S1_l1_r[148], FA_S2[85], FA_C2[85]);
    FA fa2_86(FA_S1_l1_r[125], FA_C1_l1_r[126], FA_S1_l1_r[149], FA_S2[86], FA_C2[86]);
    FA fa2_87(FA_S1_l1_r[126], FA_C1_l1_r[127], FA_S1_l1_r[150], FA_S2[87], FA_C2[87]);
    FA fa2_88(FA_S1_l1_r[127], FA_C1_l1_r[128], FA_S1_l1_r[151], FA_S2[88], FA_C2[88]);
    FA fa2_89(FA_S1_l1_r[128], FA_C1_l1_r[129], FA_S1_l1_r[152], FA_S2[89], FA_C2[89]);
    FA fa2_90(FA_S1_l1_r[129], FA_C1_l1_r[130], FA_S1_l1_r[153], FA_S2[90], FA_C2[90]);
    FA fa2_91(FA_S1_l1_r[130], FA_C1_l1_r[131], FA_S1_l1_r[154], FA_S2[91], FA_C2[91]);
    FA fa2_92(FA_S1_l1_r[131], FA_C1_l1_r[132], FA_S1_l1_r[155], FA_S2[92], FA_C2[92]);
    FA fa2_93(FA_S1_l1_r[132], FA_C1_l1_r[133], FA_S1_l1_r[156], FA_S2[93], FA_C2[93]);
    FA fa2_94(FA_S1_l1_r[133], FA_C1_l1_r[134], FA_S1_l1_r[157], FA_S2[94], FA_C2[94]);
    FA fa2_95(FA_S1_l1_r[134], FA_C1_l1_r[135], FA_S1_l1_r[158], FA_S2[95], FA_C2[95]);
    FA fa2_96(FA_S1_l1_r[135], FA_C1_l1_r[136], FA_S1_l1_r[159], FA_S2[96], FA_C2[96]);
    FA fa2_97(FA_S1_l1_r[136], FA_C1_l1_r[137], FA_S1_l1_r[160], FA_S2[97], FA_C2[97]);
    FA fa2_98(FA_S1_l1_r[137], FA_C1_l1_r[138], FA_S1_l1_r[161], FA_S2[98], FA_C2[98]);
    FA fa2_99(FA_S1_l1_r[138], FA_C1_l1_r[139], FA_S1_l1_r[162], FA_S2[99], FA_C2[99]);
    FA fa2_100(FA_S1_l1_r[139], FA_C1_l1_r[140], FA_S1_l1_r[163], FA_S2[100], FA_C2[100]);
    FA fa2_101(FA_S1_l1_r[140], FA_C1_l1_r[141], FA_S1_l1_r[164], FA_S2[101], FA_C2[101]);
    FA fa2_102(FA_S1_l1_r[141], FA_C1_l1_r[142], P1_r[11], FA_S2[102], FA_C2[102]);
    FA fa2_103(FA_S1_l1_r[142], FA_C1_l1_r[143], P1_r[10], FA_S2[103], FA_C2[103]);

    // loop 2, level 4 (#: 104 - 119, Total: 16)
    FA fa2_104(FA_C1_l1_r[147], P1_r[24], FA_C1_l1_r[165], FA_S2[104], FA_C2[104]);
    FA fa2_105(FA_C1_l1_r[148], FA_S1_l1_r[165], FA_C1_l1_r[166], FA_S2[105], FA_C2[105]);
    FA fa2_106(FA_C1_l1_r[149], FA_S1_l1_r[166], FA_C1_l1_r[167], FA_S2[106], FA_C2[106]);
    FA fa2_107(FA_C1_l1_r[150], FA_S1_l1_r[167], FA_C1_l1_r[168], FA_S2[107], FA_C2[107]);
    FA fa2_108(FA_C1_l1_r[151], FA_S1_l1_r[168], FA_C1_l1_r[169], FA_S2[108], FA_C2[108]);
    FA fa2_109(FA_C1_l1_r[152], FA_S1_l1_r[169], FA_C1_l1_r[170], FA_S2[109], FA_C2[109]);
    FA fa2_110(FA_C1_l1_r[153], FA_S1_l1_r[170], FA_C1_l1_r[171], FA_S2[110], FA_C2[110]);
    FA fa2_111(FA_C1_l1_r[154], FA_S1_l1_r[171], FA_C1_l1_r[172], FA_S2[111], FA_C2[111]);
    FA fa2_112(FA_C1_l1_r[155], FA_S1_l1_r[172], FA_C1_l1_r[173], FA_S2[112], FA_C2[112]);
    FA fa2_113(FA_C1_l1_r[156], FA_S1_l1_r[173], FA_C1_l1_r[174], FA_S2[113], FA_C2[113]);
    FA fa2_114(FA_C1_l1_r[157], FA_S1_l1_r[174], FA_C1_l1_r[175], FA_S2[114], FA_C2[114]);
    FA fa2_115(FA_C1_l1_r[158], FA_S1_l1_r[175], FA_C1_l1_r[176], FA_S2[115], FA_C2[115]);
    FA fa2_116(FA_C1_l1_r[159], FA_S1_l1_r[176], FA_C1_l1_r[177], FA_S2[116], FA_C2[116]);
    FA fa2_117(FA_C1_l1_r[160], FA_S1_l1_r[177], FA_C1_l1_r[178], FA_S2[117], FA_C2[117]);
    FA fa2_118(FA_C1_l1_r[161], FA_S1_l1_r[178], FA_C1_l1_r[179], FA_S2[118], FA_C2[118]);
    FA fa2_119(FA_C1_l1_r[163], P1_r[14], P1_r[15], FA_S2[119], FA_C2[119]);

    // loop 2, level 5 (#: 120 - 127, Total: 8)
    FA fa2_120(P1_r[23], FA_C1_l1_r[180], P1_r[33], FA_S2[120], FA_C2[120]);
    FA fa2_121(FA_S1_l1_r[181], FA_C1_l1_r[182], P1_r[32], FA_S2[121], FA_C2[121]);
    FA fa2_122(FA_S1_l1_r[182], FA_C1_l1_r[183], P1_r[22], FA_S2[122], FA_C2[122]);
    FA fa2_123(FA_S1_l1_r[183], FA_C1_l1_r[184], FA_S1_l1_r[189], FA_S2[123], FA_C2[123]);
    FA fa2_124(FA_S1_l1_r[184], FA_C1_l1_r[185], FA_S1_l1_r[190], FA_S2[124], FA_C2[124]);
    FA fa2_125(FA_S1_l1_r[185], FA_C1_l1_r[186], FA_S1_l1_r[191], FA_S2[125], FA_C2[125]);
    FA fa2_126(FA_S1_l1_r[186], FA_C1_l1_r[187], P1_r[20], FA_S2[126], FA_C2[126]);
    FA fa2_127(FA_S1_l1_r[187], FA_C1_l1_r[188], P1_r[19], FA_S2[127], FA_C2[127]);
    
    //////////////////////////////////////////////////////////////////////////////
    /////                               loop 3                               /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [84:0]  FA_S3, FA_C3;
    wire            HA_S3, HA_C3;
    
    reg     [1:0]   FA_S1_l3_r;
    reg     [5:0]   FA_C1_l3_r;
    reg     [7:0]   FA_S2_l3_r;
    reg     [16:0]  FA_C2_l3_r;
    reg             HA_S1_l3_r;
    reg             HA_S2_l3_r;
    reg     [84:0]  FA_S3_l3_r, FA_C3_l3_r;
    reg             HA_S3_l3_r, HA_C3_l3_r;
    reg     [12:0]  P3_r;

    HA ha2(FA_S2_l2_r[43], HA_C2_l2_r, HA_S3, HA_C3);
    
    // loop 3, level 1 (#: 0 - 40, Total: 41)
    FA fa3_0(FA_S1_l2_r[0], FA_C1_l2_r[0], FA_C2_l2_r[1], FA_S3[0], FA_C3[0]);
    FA fa3_1(FA_S2_l2_r[2], FA_C2_l2_r[3], FA_C1_l2_r[1], FA_S3[1], FA_C3[1]);
    FA fa3_2(FA_S2_l2_r[3], FA_C2_l2_r[4], FA_C1_l2_r[2], FA_S3[2], FA_C3[2]);
    FA fa3_3(FA_S2_l2_r[4], FA_C2_l2_r[5], FA_C1_l2_r[3], FA_S3[3], FA_C3[3]);
    FA fa3_4(FA_S2_l2_r[5], FA_C2_l2_r[6], FA_S2_l2_r[44], FA_S3[4], FA_C3[4]);
    FA fa3_5(FA_S2_l2_r[6], FA_C2_l2_r[7], FA_S2_l2_r[45], FA_S3[5], FA_C3[5]);
    FA fa3_6(FA_S2_l2_r[7], FA_C2_l2_r[8], FA_S2_l2_r[46], FA_S3[6], FA_C3[6]);
    FA fa3_7(FA_S2_l2_r[8], FA_C2_l2_r[9], FA_S2_l2_r[47], FA_S3[7], FA_C3[7]);
    FA fa3_8(FA_S2_l2_r[9], FA_C2_l2_r[10], FA_S2_l2_r[48], FA_S3[8], FA_C3[8]);
    FA fa3_9(FA_S2_l2_r[10], FA_C2_l2_r[11], FA_S2_l2_r[49], FA_S3[9], FA_C3[9]);
    FA fa3_10(FA_S2_l2_r[11], FA_C2_l2_r[12], FA_S2_l2_r[50], FA_S3[10], FA_C3[10]);
    FA fa3_11(FA_S2_l2_r[12], FA_C2_l2_r[13], FA_S2_l2_r[51], FA_S3[11], FA_C3[11]);
    FA fa3_12(FA_S2_l2_r[13], FA_C2_l2_r[14], FA_S2_l2_r[52], FA_S3[12], FA_C3[12]);
    FA fa3_13(FA_S2_l2_r[14], FA_C2_l2_r[15], FA_S2_l2_r[53], FA_S3[13], FA_C3[13]);
    FA fa3_14(FA_S2_l2_r[15], FA_C2_l2_r[16], FA_S2_l2_r[54], FA_S3[14], FA_C3[14]);
    FA fa3_15(FA_S2_l2_r[16], FA_C2_l2_r[17], FA_S2_l2_r[55], FA_S3[15], FA_C3[15]);
    FA fa3_16(FA_S2_l2_r[17], FA_C2_l2_r[18], FA_S2_l2_r[56], FA_S3[16], FA_C3[16]);
    FA fa3_17(FA_S2_l2_r[18], FA_C2_l2_r[19], FA_S2_l2_r[57], FA_S3[17], FA_C3[17]);
    FA fa3_18(FA_S2_l2_r[19], FA_C2_l2_r[20], FA_S2_l2_r[58], FA_S3[18], FA_C3[18]);
    FA fa3_19(FA_S2_l2_r[20], FA_C2_l2_r[21], FA_S2_l2_r[59], FA_S3[19], FA_C3[19]);
    FA fa3_20(FA_S2_l2_r[21], FA_C2_l2_r[22], FA_S2_l2_r[60], FA_S3[20], FA_C3[20]);
    FA fa3_21(FA_S2_l2_r[22], FA_C2_l2_r[23], FA_S2_l2_r[61], FA_S3[21], FA_C3[21]);
    FA fa3_22(FA_S2_l2_r[23], FA_C2_l2_r[24], FA_S2_l2_r[62], FA_S3[22], FA_C3[22]);
    FA fa3_23(FA_S2_l2_r[24], FA_C2_l2_r[25], FA_S2_l2_r[63], FA_S3[23], FA_C3[23]);
    FA fa3_24(FA_S2_l2_r[25], FA_C2_l2_r[26], FA_S2_l2_r[64], FA_S3[24], FA_C3[24]);
    FA fa3_25(FA_S2_l2_r[26], FA_C2_l2_r[27], FA_S2_l2_r[65], FA_S3[25], FA_C3[25]);
    FA fa3_26(FA_S2_l2_r[27], FA_C2_l2_r[28], FA_S2_l2_r[66], FA_S3[26], FA_C3[26]);
    FA fa3_27(FA_S2_l2_r[28], FA_C2_l2_r[29], FA_S2_l2_r[67], FA_S3[27], FA_C3[27]);
    FA fa3_28(FA_S2_l2_r[29], FA_C2_l2_r[30], FA_S2_l2_r[68], FA_S3[28], FA_C3[28]);
    FA fa3_29(FA_S2_l2_r[30], FA_C2_l2_r[31], FA_S2_l2_r[69], FA_S3[29], FA_C3[29]);
    FA fa3_30(FA_S2_l2_r[31], FA_C2_l2_r[32], FA_S2_l2_r[70], FA_S3[30], FA_C3[30]);
    FA fa3_31(FA_S2_l2_r[32], FA_C2_l2_r[33], FA_S2_l2_r[71], FA_S3[31], FA_C3[31]);
    FA fa3_32(FA_S2_l2_r[33], FA_C2_l2_r[34], FA_S2_l2_r[72], FA_S3[32], FA_C3[32]);
    FA fa3_33(FA_S2_l2_r[34], FA_C2_l2_r[35], FA_S2_l2_r[73], FA_S3[33], FA_C3[33]);
    FA fa3_34(FA_S2_l2_r[35], FA_C2_l2_r[36], FA_S2_l2_r[74], FA_S3[34], FA_C3[34]);
    FA fa3_35(FA_S2_l2_r[36], FA_C2_l2_r[37], FA_S2_l2_r[75], FA_S3[35], FA_C3[35]);
    FA fa3_36(FA_S2_l2_r[37], FA_C2_l2_r[38], FA_S2_l2_r[76], FA_S3[36], FA_C3[36]);
    FA fa3_37(FA_S2_l2_r[38], FA_C2_l2_r[39], FA_C1_l2_r[4], FA_S3[37], FA_C3[37]);
    FA fa3_38(FA_S2_l2_r[39], FA_C2_l2_r[40], FA_S2_l2_r[77], FA_S3[38], FA_C3[38]);
    FA fa3_39(FA_S2_l2_r[40], FA_C2_l2_r[41], FA_C1_l2_r[5], FA_S3[39], FA_C3[39]);
    FA fa3_40(FA_S2_l2_r[42], FA_C2_l2_r[43], P2_r[1], FA_S3[40], FA_C3[40]);

    // loop 3, level 2 (#: 41 - 67, Total: 27)
    FA fa3_41(FA_C2_l2_r[47], P2_r[18], FA_C2_l2_r[78], FA_S3[41], FA_C3[41]);
    FA fa3_42(FA_C2_l2_r[49], FA_S1_l2_r[1], FA_C2_l2_r[79], FA_S3[42], FA_C3[42]);
    FA fa3_43(FA_C2_l2_r[50], FA_S2_l2_r[79], FA_C2_l2_r[80], FA_S3[43], FA_C3[43]);
    FA fa3_44(FA_C2_l2_r[51], FA_S2_l2_r[80], FA_C2_l2_r[81], FA_S3[44], FA_C3[44]);
    FA fa3_45(FA_C2_l2_r[52], FA_S2_l2_r[81], FA_C2_l2_r[82], FA_S3[45], FA_C3[45]);
    FA fa3_46(FA_C2_l2_r[53], FA_S2_l2_r[82], FA_C2_l2_r[83], FA_S3[46], FA_C3[46]);
    FA fa3_47(FA_C2_l2_r[54], FA_S2_l2_r[83], FA_C2_l2_r[84], FA_S3[47], FA_C3[47]);
    FA fa3_48(FA_C2_l2_r[55], FA_S2_l2_r[84], FA_C2_l2_r[85], FA_S3[48], FA_C3[48]);
    FA fa3_49(FA_C2_l2_r[56], FA_S2_l2_r[85], FA_C2_l2_r[86], FA_S3[49], FA_C3[49]);
    FA fa3_50(FA_C2_l2_r[57], FA_S2_l2_r[86], FA_C2_l2_r[87], FA_S3[50], FA_C3[50]);
    FA fa3_51(FA_C2_l2_r[58], FA_S2_l2_r[87], FA_C2_l2_r[88], FA_S3[51], FA_C3[51]);
    FA fa3_52(FA_C2_l2_r[59], FA_S2_l2_r[88], FA_C2_l2_r[89], FA_S3[52], FA_C3[52]);
    FA fa3_53(FA_C2_l2_r[60], FA_S2_l2_r[89], FA_C2_l2_r[90], FA_S3[53], FA_C3[53]);
    FA fa3_54(FA_C2_l2_r[61], FA_S2_l2_r[90], FA_C2_l2_r[91], FA_S3[54], FA_C3[54]);
    FA fa3_55(FA_C2_l2_r[62], FA_S2_l2_r[91], FA_C2_l2_r[92], FA_S3[55], FA_C3[55]);
    FA fa3_56(FA_C2_l2_r[63], FA_S2_l2_r[92], FA_C2_l2_r[93], FA_S3[56], FA_C3[56]);
    FA fa3_57(FA_C2_l2_r[64], FA_S2_l2_r[93], FA_C2_l2_r[94], FA_S3[57], FA_C3[57]);
    FA fa3_58(FA_C2_l2_r[65], FA_S2_l2_r[94], FA_C2_l2_r[95], FA_S3[58], FA_C3[58]);
    FA fa3_59(FA_C2_l2_r[66], FA_S2_l2_r[95], FA_C2_l2_r[96], FA_S3[59], FA_C3[59]);
    FA fa3_60(FA_C2_l2_r[67], FA_S2_l2_r[96], FA_C2_l2_r[97], FA_S3[60], FA_C3[60]);
    FA fa3_61(FA_C2_l2_r[68], FA_S2_l2_r[97], FA_C2_l2_r[98], FA_S3[61], FA_C3[61]);
    FA fa3_62(FA_C2_l2_r[69], FA_S2_l2_r[98], FA_C2_l2_r[99], FA_S3[62], FA_C3[62]);
    FA fa3_63(FA_C2_l2_r[70], FA_S2_l2_r[99], FA_C2_l2_r[100], FA_S3[63], FA_C3[63]);
    FA fa3_64(FA_C2_l2_r[71], FA_S2_l2_r[100], FA_C2_l2_r[101], FA_S3[64], FA_C3[64]);
    FA fa3_65(FA_C2_l2_r[72], FA_S2_l2_r[101], FA_C2_l2_r[102], FA_S3[65], FA_C3[65]);
    FA fa3_66(FA_C2_l2_r[73], FA_S2_l2_r[102], FA_C2_l2_r[103], FA_S3[66], FA_C3[66]);
    FA fa3_67(FA_C2_l2_r[76], P2_r[4], P2_r[5], FA_S3[67], FA_C3[67]);
    
    // loop 3, level 3 (#: 68 - 82, Total: 15)
    FA fa3_68(FA_C1_l2_r[6], FA_C2_l2_r[104], P2_r[16], FA_S3[68], FA_C3[68]);
    FA fa3_69(FA_S2_l2_r[104], FA_C2_l2_r[105], P2_r[15], FA_S3[69], FA_C3[69]);
    FA fa3_70(FA_S2_l2_r[106], FA_C2_l2_r[107], P2_r[14], FA_S3[70], FA_C3[70]);
    FA fa3_71(FA_S2_l2_r[107], FA_C2_l2_r[108], FA_S2_l2_r[120], FA_S3[71], FA_C3[71]);
    FA fa3_72(FA_S2_l2_r[108], FA_C2_l2_r[109], FA_S1_l2_r[3], FA_S3[72], FA_C3[72]);
    FA fa3_73(FA_S2_l2_r[109], FA_C2_l2_r[110], FA_S2_l2_r[121], FA_S3[73], FA_C3[73]);
    FA fa3_74(FA_S2_l2_r[110], FA_C2_l2_r[111], FA_S2_l2_r[122], FA_S3[74], FA_C3[74]);
    FA fa3_75(FA_S2_l2_r[111], FA_C2_l2_r[112], FA_S2_l2_r[123], FA_S3[75], FA_C3[75]);
    FA fa3_76(FA_S2_l2_r[112], FA_C2_l2_r[113], FA_S2_l2_r[124], FA_S3[76], FA_C3[76]);
    FA fa3_77(FA_S2_l2_r[113], FA_C2_l2_r[114], FA_S2_l2_r[125], FA_S3[77], FA_C3[77]);
    FA fa3_78(FA_S2_l2_r[114], FA_C2_l2_r[115], FA_S2_l2_r[126], FA_S3[78], FA_C3[78]);
    FA fa3_79(FA_S2_l2_r[115], FA_C2_l2_r[116], FA_S2_l2_r[127], FA_S3[79], FA_C3[79]);
    FA fa3_80(FA_S2_l2_r[116], FA_C2_l2_r[117], FA_S1_l2_r[4], FA_S3[80], FA_C3[80]);
    FA fa3_81(FA_S2_l2_r[117], FA_C2_l2_r[118], P2_r[9], FA_S3[81], FA_C3[81]);
    FA fa3_82(FA_C1_l2_r[7], FA_C2_l2_r[119], FA_S1_l2_r[2], FA_S3[82], FA_C3[82]);
    
    // loop 3, level 4 (#: 83 - 84, Total: 2)
    FA fa3_83(FA_C2_l2_r[123], FA_C1_l2_r[8], P2_r[13], FA_S3[83], FA_C3[83]);
    FA fa3_84(FA_C2_l2_r[125], FA_C1_l2_r[9], P2_r[12], FA_S3[84], FA_C3[84]);
    
    
    //////////////////////////////////////////////////////////////////////////////
    /////                               loop 4                               /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [56:0]  FA_S4, FA_C4;
    wire            HA_S4, HA_C4;

    reg     [1:0]   FA_S1_l4_r;
    reg     [1:0]   FA_C1_l4_r;
    reg     [3:0]   FA_S2_l4_r;
    reg     [6:0]   FA_C2_l4_r;
    reg     [7:0]   FA_S3_l4_r;
    reg     [12:0]  FA_C3_l4_r;
    reg             HA_S1_l4_r;
    reg             HA_S2_l4_r;
    reg             HA_S3_l4_r;
    reg     [56:0]  FA_S4_l4_r, FA_C4_l4_r;
    reg             HA_S4_l4_r, HA_C4_l4_r;
    reg     [7:0]   P4_r;
    
    HA ha3(FA_S3_l3_r[40], HA_C3_l3_r, HA_S4, HA_C4);
    
    // loop 4, level 1 (#: 0 - 37, Total: 38)
    FA fa4_0(FA_S2_l3_r[0], FA_C3_l3_r[1], FA_C2_l3_r[0], FA_S4[0], FA_C4[0]);
    FA fa4_1(FA_S3_l3_r[1], FA_C3_l3_r[2], P3_r[11], FA_S4[1], FA_C4[1]);
    FA fa4_2(FA_S3_l3_r[3], FA_C3_l3_r[4], FA_C2_l3_r[2], FA_S4[2], FA_C4[2]);
    FA fa4_3(FA_S3_l3_r[4], FA_C3_l3_r[5], FA_C2_l3_r[3], FA_S4[3], FA_C4[3]);
    FA fa4_4(FA_S3_l3_r[5], FA_C3_l3_r[6], FA_C2_l3_r[4], FA_S4[4], FA_C4[4]);
    FA fa4_5(FA_S3_l3_r[6], FA_C3_l3_r[7], FA_S3_l3_r[41], FA_S4[5], FA_C4[5]);
    FA fa4_6(FA_S3_l3_r[7], FA_C3_l3_r[8], FA_C2_l3_r[5], FA_S4[6], FA_C4[6]);
    FA fa4_7(FA_S3_l3_r[8], FA_C3_l3_r[9], FA_S3_l3_r[42], FA_S4[7], FA_C4[7]);
    FA fa4_8(FA_S3_l3_r[9], FA_C3_l3_r[10], FA_S3_l3_r[43], FA_S4[8], FA_C4[8]);
    FA fa4_9(FA_S3_l3_r[10], FA_C3_l3_r[11], FA_S3_l3_r[44], FA_S4[9], FA_C4[9]);
    FA fa4_10(FA_S3_l3_r[11], FA_C3_l3_r[12], FA_S3_l3_r[45], FA_S4[10], FA_C4[10]);
    FA fa4_11(FA_S3_l3_r[12], FA_C3_l3_r[13], FA_S3_l3_r[46], FA_S4[11], FA_C4[11]);
    FA fa4_12(FA_S3_l3_r[13], FA_C3_l3_r[14], FA_S3_l3_r[47], FA_S4[12], FA_C4[12]);
    FA fa4_13(FA_S3_l3_r[14], FA_C3_l3_r[15], FA_S3_l3_r[48], FA_S4[13], FA_C4[13]);
    FA fa4_14(FA_S3_l3_r[15], FA_C3_l3_r[16], FA_S3_l3_r[49], FA_S4[14], FA_C4[14]);
    FA fa4_15(FA_S3_l3_r[16], FA_C3_l3_r[17], FA_S3_l3_r[50], FA_S4[15], FA_C4[15]);
    FA fa4_16(FA_S3_l3_r[17], FA_C3_l3_r[18], FA_S3_l3_r[51], FA_S4[16], FA_C4[16]);
    FA fa4_17(FA_S3_l3_r[18], FA_C3_l3_r[19], FA_S3_l3_r[52], FA_S4[17], FA_C4[17]);
    FA fa4_18(FA_S3_l3_r[19], FA_C3_l3_r[20], FA_S3_l3_r[53], FA_S4[18], FA_C4[18]);
    FA fa4_19(FA_S3_l3_r[20], FA_C3_l3_r[21], FA_S3_l3_r[54], FA_S4[19], FA_C4[19]);
    FA fa4_20(FA_S3_l3_r[21], FA_C3_l3_r[22], FA_S3_l3_r[55], FA_S4[20], FA_C4[20]);
    FA fa4_21(FA_S3_l3_r[22], FA_C3_l3_r[23], FA_S3_l3_r[56], FA_S4[21], FA_C4[21]);
    FA fa4_22(FA_S3_l3_r[23], FA_C3_l3_r[24], FA_S3_l3_r[57], FA_S4[22], FA_C4[22]);
    FA fa4_23(FA_S3_l3_r[24], FA_C3_l3_r[25], FA_S3_l3_r[58], FA_S4[23], FA_C4[23]);
    FA fa4_24(FA_S3_l3_r[25], FA_C3_l3_r[26], FA_S3_l3_r[59], FA_S4[24], FA_C4[24]);
    FA fa4_25(FA_S3_l3_r[26], FA_C3_l3_r[27], FA_S3_l3_r[60], FA_S4[25], FA_C4[25]);
    FA fa4_26(FA_S3_l3_r[27], FA_C3_l3_r[28], FA_S3_l3_r[61], FA_S4[26], FA_C4[26]);
    FA fa4_27(FA_S3_l3_r[28], FA_C3_l3_r[29], FA_S3_l3_r[62], FA_S4[27], FA_C4[27]);
    FA fa4_28(FA_S3_l3_r[29], FA_C3_l3_r[30], FA_S3_l3_r[63], FA_S4[28], FA_C4[28]);
    FA fa4_29(FA_S3_l3_r[30], FA_C3_l3_r[31], FA_S3_l3_r[64], FA_S4[29], FA_C4[29]);
    FA fa4_30(FA_S3_l3_r[31], FA_C3_l3_r[32], FA_S3_l3_r[65], FA_S4[30], FA_C4[30]);
    FA fa4_31(FA_S3_l3_r[32], FA_C3_l3_r[33], FA_S3_l3_r[66], FA_S4[31], FA_C4[31]);
    FA fa4_32(FA_S3_l3_r[33], FA_C3_l3_r[34], FA_C2_l3_r[6], FA_S4[32], FA_C4[32]);
    FA fa4_33(FA_S3_l3_r[34], FA_C3_l3_r[35], FA_C2_l3_r[7], FA_S4[33], FA_C4[33]);
    FA fa4_34(FA_S3_l3_r[35], FA_C3_l3_r[36], FA_S3_l3_r[67], FA_S4[34], FA_C4[34]);
    FA fa4_35(FA_S3_l3_r[36], FA_C3_l3_r[37], P3_r[2], FA_S4[35], FA_C4[35]);
    FA fa4_36(FA_S3_l3_r[37], FA_C3_l3_r[38], FA_C2_l3_r[8], FA_S4[36], FA_C4[36]);
    FA fa4_37(FA_S2_l3_r[1], FA_C3_l3_r[40], FA_C2_l3_r[1], FA_S4[37], FA_C4[37]);

    // loop 4, level 2 (#: 38 - 55, Total: 18)
    FA fa4_38(FA_C3_l3_r[45], FA_C1_l3_r[0], P3_r[8], FA_S4[38], FA_C4[38]);
    FA fa4_39(FA_C3_l3_r[46], FA_C1_l3_r[1], FA_C3_l3_r[68], FA_S4[39], FA_C4[39]);
    FA fa4_40(FA_C3_l3_r[47], FA_S3_l3_r[68], FA_C3_l3_r[69], FA_S4[40], FA_C4[40]);
    FA fa4_41(FA_C3_l3_r[49], FA_S2_l3_r[2], FA_C3_l3_r[70], FA_S4[41], FA_C4[41]);
    FA fa4_42(FA_C3_l3_r[50], FA_S3_l3_r[70], FA_C3_l3_r[71], FA_S4[42], FA_C4[42]);
    FA fa4_43(FA_C3_l3_r[51], FA_S3_l3_r[71], FA_C3_l3_r[72], FA_S4[43], FA_C4[43]);
    FA fa4_44(FA_C3_l3_r[52], FA_S3_l3_r[72], FA_C3_l3_r[73], FA_S4[44], FA_C4[44]);
    FA fa4_45(FA_C3_l3_r[53], FA_S3_l3_r[73], FA_C3_l3_r[74], FA_S4[45], FA_C4[45]);
    FA fa4_46(FA_C3_l3_r[54], FA_S3_l3_r[74], FA_C3_l3_r[75], FA_S4[46], FA_C4[46]);
    FA fa4_47(FA_C3_l3_r[55], FA_S3_l3_r[75], FA_C3_l3_r[76], FA_S4[47], FA_C4[47]);
    FA fa4_48(FA_C3_l3_r[56], FA_S3_l3_r[76], FA_C3_l3_r[77], FA_S4[48], FA_C4[48]);
    FA fa4_49(FA_C3_l3_r[57], FA_S3_l3_r[77], FA_C3_l3_r[78], FA_S4[49], FA_C4[49]);
    FA fa4_50(FA_C3_l3_r[58], FA_S3_l3_r[78], FA_C3_l3_r[79], FA_S4[50], FA_C4[50]);
    FA fa4_51(FA_C3_l3_r[59], FA_S3_l3_r[79], FA_C3_l3_r[80], FA_S4[51], FA_C4[51]);
    FA fa4_52(FA_C3_l3_r[60], FA_S3_l3_r[80], FA_C3_l3_r[81], FA_S4[52], FA_C4[52]);
    FA fa4_53(FA_C3_l3_r[61], FA_S3_l3_r[81], P3_r[6], FA_S4[53], FA_C4[53]);
    FA fa4_54(FA_C3_l3_r[62], FA_S2_l3_r[3], FA_C3_l3_r[82], FA_S4[54], FA_C4[54]);
    FA fa4_55(FA_C3_l3_r[65], FA_C1_l3_r[2], P3_r[4], FA_S4[55], FA_C4[55]);

    // loop 4, level 3 (#: 56, Total: 1)
    FA fa4_56(FA_C2_l3_r[9], FA_C3_l3_r[84], FA_C1_l3_r[3], FA_S4[56], FA_C4[56]);
   

    //////////////////////////////////////////////////////////////////////////////
    /////                               loop 5                               /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [36:0]  FA_S5, FA_C5;
    wire    [3:0]   HA_S5, HA_C5;

    reg     [1:0]   FA_S1_l5_r;
    reg             FA_C1_l5_r;
    reg     [2:0]   FA_S2_l5_r;
    reg     [2:0]   FA_C2_l5_r;
    reg     [3:0]   FA_S3_l5_r;
    reg     [1:0]   FA_C3_l5_r;
    reg     [5:0]   FA_S4_l5_r;
    reg     [15:0]  FA_C4_l5_r;
    reg             HA_S1_l5_r;
    reg             HA_S2_l5_r;
    reg             HA_S3_l5_r;
    reg             HA_S4_l5_r;
    reg     [36:0]  FA_S5_l5_r, FA_C5_l5_r;
    reg     [3:0]   HA_S5_l5_r, HA_C5_l5_r;
    reg     [2:0]   P5_r;
    
    HA ha4(FA_S4_l4_r[37], HA_C4_l4_r, HA_S5[0], HA_C5[0]);
    HA ha5(FA_C4_l4_r[48], FA_S4_l4_r[56], HA_S5[1], HA_C5[1]);
    HA ha6(FA_C4_l4_r[49], FA_S3_l4_r[3], HA_S5[2], HA_C5[2]);
    HA ha7(FA_C4_l4_r[50], FA_C2_l4_r[2], HA_S5[3], HA_C5[3]);
    
    // loop 5, level 1 (#: 0 - 32, Total: 33)
    FA fa5_0(FA_S3_l4_r[0], FA_C4_l4_r[2], FA_C3_l4_r[0], FA_S5[0], FA_C5[0]);
    FA fa5_1(FA_S4_l4_r[2], FA_C4_l4_r[3], P4_r[6], FA_S5[1], FA_C5[1]);
    FA fa5_2(FA_S4_l4_r[3], FA_C4_l4_r[4], P4_r[5], FA_S5[2], FA_C5[2]);
    FA fa5_3(FA_S4_l4_r[4], FA_C4_l4_r[5], FA_C3_l4_r[1], FA_S5[3], FA_C5[3]);
    FA fa5_4(FA_S4_l4_r[6], FA_C4_l4_r[7], FA_C3_l4_r[2], FA_S5[4], FA_C5[4]);
    FA fa5_5(FA_S4_l4_r[7], FA_C4_l4_r[8], FA_C3_l4_r[3], FA_S5[5], FA_C5[5]);
    FA fa5_6(FA_S4_l4_r[8], FA_C4_l4_r[9], FA_C3_l4_r[4], FA_S5[6], FA_C5[6]);
    FA fa5_7(FA_S4_l4_r[9], FA_C4_l4_r[10], FA_S4_l4_r[38], FA_S5[7], FA_C5[7]);
    FA fa5_8(FA_S4_l4_r[10], FA_C4_l4_r[11], FA_S4_l4_r[39], FA_S5[8], FA_C5[8]);
    FA fa5_9(FA_S4_l4_r[11], FA_C4_l4_r[12], FA_S4_l4_r[40], FA_S5[9], FA_C5[9]);
    FA fa5_10(FA_S4_l4_r[12], FA_C4_l4_r[13], FA_C3_l4_r[5], FA_S5[10], FA_C5[10]);
    FA fa5_11(FA_S4_l4_r[13], FA_C4_l4_r[14], FA_S4_l4_r[41], FA_S5[11], FA_C5[11]);
    FA fa5_12(FA_S4_l4_r[14], FA_C4_l4_r[15], FA_S4_l4_r[42], FA_S5[12], FA_C5[12]);
    FA fa5_13(FA_S4_l4_r[15], FA_C4_l4_r[16], FA_S4_l4_r[43], FA_S5[13], FA_C5[13]);
    FA fa5_14(FA_S4_l4_r[16], FA_C4_l4_r[17], FA_S4_l4_r[44], FA_S5[14], FA_C5[14]);
    FA fa5_15(FA_S4_l4_r[17], FA_C4_l4_r[18], FA_S4_l4_r[45], FA_S5[15], FA_C5[15]);
    FA fa5_16(FA_S4_l4_r[18], FA_C4_l4_r[19], FA_S4_l4_r[46], FA_S5[16], FA_C5[16]);
    FA fa5_17(FA_S4_l4_r[19], FA_C4_l4_r[20], FA_S4_l4_r[47], FA_S5[17], FA_C5[17]);
    FA fa5_18(FA_S4_l4_r[20], FA_C4_l4_r[21], FA_S4_l4_r[48], FA_S5[18], FA_C5[18]);
    FA fa5_19(FA_S4_l4_r[21], FA_C4_l4_r[22], FA_S4_l4_r[49], FA_S5[19], FA_C5[19]);
    FA fa5_20(FA_S4_l4_r[22], FA_C4_l4_r[23], FA_S4_l4_r[50], FA_S5[20], FA_C5[20]);
    FA fa5_21(FA_S4_l4_r[23], FA_C4_l4_r[24], FA_S4_l4_r[51], FA_S5[21], FA_C5[21]);
    FA fa5_22(FA_S4_l4_r[24], FA_C4_l4_r[25], FA_S4_l4_r[52], FA_S5[22], FA_C5[22]);
    FA fa5_23(FA_S4_l4_r[25], FA_C4_l4_r[26], FA_S4_l4_r[53], FA_S5[23], FA_C5[23]);
    FA fa5_24(FA_S4_l4_r[26], FA_C4_l4_r[27], FA_S4_l4_r[54], FA_S5[24], FA_C5[24]);
    FA fa5_25(FA_S4_l4_r[27], FA_C4_l4_r[28], FA_C3_l4_r[6], FA_S5[25], FA_C5[25]);
    FA fa5_26(FA_S4_l4_r[28], FA_C4_l4_r[29], FA_C3_l4_r[7], FA_S5[26], FA_C5[26]);
    FA fa5_27(FA_S4_l4_r[29], FA_C4_l4_r[30], FA_S4_l4_r[55], FA_S5[27], FA_C5[27]);
    FA fa5_28(FA_S4_l4_r[30], FA_C4_l4_r[31], FA_C3_l4_r[8], FA_S5[28], FA_C5[28]);
    FA fa5_29(FA_S4_l4_r[31], FA_C4_l4_r[32], P4_r[2], FA_S5[29], FA_C5[29]);
    FA fa5_30(FA_S4_l4_r[32], FA_C4_l4_r[33], FA_S2_l4_r[0], FA_S5[30], FA_C5[30]);
    FA fa5_31(FA_S4_l4_r[33], FA_C4_l4_r[34], FA_C3_l4_r[9], FA_S5[31], FA_C5[31]);
    FA fa5_32(FA_S3_l4_r[1], FA_C4_l4_r[37], P4_r[1], FA_S5[32], FA_C5[32]);

    // loop 5, level 2 (#: 33 - 36, Total: 4)
    FA fa5_33(FA_C4_l4_r[45], FA_C2_l4_r[0], FA_C1_l4_r[0], FA_S5[33], FA_C5[33]);
    FA fa5_34(FA_C4_l4_r[46], FA_C2_l4_r[1], FA_C3_l4_r[10], FA_S5[34], FA_C5[34]);
    FA fa5_35(FA_C4_l4_r[47], FA_S3_l4_r[2], FA_C4_l4_r[56], FA_S5[35], FA_C5[35]);
    FA fa5_36(FA_C4_l4_r[51], FA_C2_l4_r[3], P4_r[4], FA_S5[36], FA_C5[36]);
    
    //////////////////////////////////////////////////////////////////////////////
    /////                               loop 6                               /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [23:0]  FA_S6, FA_C6;
    wire             HA_S6, HA_C6;

    reg     [1:0]   FA_S1_l6_r;
    reg     [1:0]   FA_S2_l6_r;
    reg     [2:0]   FA_C2_l6_r;
    reg     [1:0]   FA_S3_l6_r;
    reg             FA_C3_l6_r;
    reg     [4:0]   FA_S4_l6_r;
    reg     [3:0]   FA_C4_l6_r;
    reg     [9:0]   FA_S5_l6_r;
    reg     [12:0]  FA_C5_l6_r;
    reg             HA_S1_l6_r;
    reg             HA_S2_l6_r;
    reg             HA_S3_l6_r;
    reg             HA_S4_l6_r;
    reg             HA_S5_l6_r;
    reg     [2:0]   HA_C5_l6_r;
    reg     [23:0]  FA_S6_l6_r, FA_C6_l6_r;
    reg             HA_S6_l6_r, HA_C6_l6_r;
    reg     [1:0]   P6_r;

    HA ha8(FA_S5_l5_r[32], HA_C5_l5_r[0], HA_S6, HA_C6);
    
    // loop 6, level 1 (#: 0 - 23, Total: 24)
    FA fa6_0(FA_S4_l5_r[0], FA_C5_l5_r[4], FA_C4_l5_r[0], FA_S6[0], FA_C6[0]);
    FA fa6_1(FA_S5_l5_r[4], FA_C5_l5_r[5], FA_S2_l5_r[0], FA_S6[1], FA_C6[1]);
    FA fa6_2(FA_S5_l5_r[5], FA_C5_l5_r[6], FA_C1_l5_r, FA_S6[2], FA_C6[2]);
    FA fa6_3(FA_S5_l5_r[6], FA_C5_l5_r[7], FA_C4_l5_r[1], FA_S6[3], FA_C6[3]);
    FA fa6_4(FA_S5_l5_r[7], FA_C5_l5_r[8], FA_C4_l5_r[2], FA_S6[4], FA_C6[4]);
    FA fa6_5(FA_S5_l5_r[8], FA_C5_l5_r[9], FA_C4_l5_r[3], FA_S6[5], FA_C6[5]);
    FA fa6_6(FA_S5_l5_r[10], FA_C5_l5_r[11], FA_C4_l5_r[4], FA_S6[6], FA_C6[6]);
    FA fa6_7(FA_S5_l5_r[11], FA_C5_l5_r[12], FA_C4_l5_r[5], FA_S6[7], FA_C6[7]);
    FA fa6_8(FA_S5_l5_r[12], FA_C5_l5_r[13], FA_C4_l5_r[6], FA_S6[8], FA_C6[8]);
    FA fa6_9(FA_S5_l5_r[13], FA_C5_l5_r[14], FA_C4_l5_r[7], FA_S6[9], FA_C6[9]);
    FA fa6_10(FA_S5_l5_r[14], FA_C5_l5_r[15], FA_S5_l5_r[33], FA_S6[10], FA_C6[10]);
    FA fa6_11(FA_S5_l5_r[15], FA_C5_l5_r[16], FA_S5_l5_r[34], FA_S6[11], FA_C6[11]);
    FA fa6_12(FA_S5_l5_r[16], FA_C5_l5_r[17], FA_S5_l5_r[35], FA_S6[12], FA_C6[12]);
    FA fa6_13(FA_S5_l5_r[17], FA_C5_l5_r[18], HA_S5_l5_r[1], FA_S6[13], FA_C6[13]);
    FA fa6_14(FA_S5_l5_r[18], FA_C5_l5_r[19], HA_S5_l5_r[2], FA_S6[14], FA_C6[14]);
    FA fa6_15(FA_S5_l5_r[19], FA_C5_l5_r[20], HA_S5_l5_r[3], FA_S6[15], FA_C6[15]);
    FA fa6_16(FA_S5_l5_r[20], FA_C5_l5_r[21], FA_S5_l5_r[36], FA_S6[16], FA_C6[16]);
    FA fa6_17(FA_S5_l5_r[21], FA_C5_l5_r[22], FA_C4_l5_r[8], FA_S6[17], FA_C6[17]);
    FA fa6_18(FA_S5_l5_r[22], FA_C5_l5_r[23], FA_C4_l5_r[9], FA_S6[18], FA_C6[18]);
    FA fa6_19(FA_S5_l5_r[23], FA_C5_l5_r[24], FA_C4_l5_r[10], FA_S6[19], FA_C6[19]);
    FA fa6_20(FA_S5_l5_r[24], FA_C5_l5_r[25], P5_r[1], FA_S6[20], FA_C6[20]);
    FA fa6_21(FA_S5_l5_r[25], FA_C5_l5_r[26], FA_S3_l5_r[1], FA_S6[21], FA_C6[21]);
    FA fa6_22(FA_S5_l5_r[26], FA_C5_l5_r[27], FA_C4_l5_r[11], FA_S6[22], FA_C6[22]);
    FA fa6_23(FA_S3_l5_r[0], FA_C5_l5_r[32], FA_C3_l5_r[0], FA_S6[23], FA_C6[23]);
    
    
    //////////////////////////////////////////////////////////////////////////////
    /////                               loop 7                               /////
    //////////////////////////////////////////////////////////////////////////////
    wire    [11:0]  FA_S7, FA_C7;
    wire    [14:0]  HA_S7, HA_C7;
    
    reg             FA_S2_l7_r;
    reg             FA_C2_l7_r;
    reg             FA_S3_l7_r;
    reg             FA_C3_l7_r;
    reg     [1:0]   FA_S4_l7_r;
    reg     [1:0]   FA_C4_l7_r;
    reg     [3:0]   FA_S5_l7_r;
    reg     [3:0]   FA_C5_l7_r;
    reg     [5:0]   FA_S6_l7_r;
    reg     [5:0]   FA_C6_l7_r;
    reg             HA_S1_l7_r;
    reg             HA_S2_l7_r;
    reg             HA_S3_l7_r;
    reg             HA_S4_l7_r;
    reg             HA_S5_l7_r;
    reg             HA_S6_l7_r;
    reg     [11:0]  FA_S7_l7_r, FA_C7_l7_r;
    reg     [14:0]  HA_S7_l7_r, HA_C7_l7_r;
    reg     [1:0]   P7_r;

    HA ha9(FA_S6_l6_r[16], FA_C6_l6_r[17], HA_S7[0], HA_C7[0]);
    HA ha10(FA_S6_l6_r[17], FA_C6_l6_r[18], HA_S7[1], HA_C7[1]);
    HA ha11(FA_S6_l6_r[18], FA_C6_l6_r[19], HA_S7[2], HA_C7[2]);
    HA ha12(FA_S6_l6_r[19], FA_C6_l6_r[20], HA_S7[3], HA_C7[3]);
    HA ha13(FA_S6_l6_r[20], FA_C6_l6_r[21], HA_S7[4], HA_C7[4]);
    HA ha14(FA_S6_l6_r[21], FA_C6_l6_r[22], HA_S7[5], HA_C7[5]);
    HA ha15(FA_S6_l6_r[22], FA_S2_l6_r[0], HA_S7[6], HA_C7[6]);
    HA ha16(FA_S5_l6_r[1], FA_C5_l6_r[1], HA_S7[7], HA_C7[7]);
    HA ha17(FA_S5_l6_r[2], FA_C5_l6_r[2], HA_S7[8], HA_C7[8]);
    HA ha18(FA_S5_l6_r[3], FA_C5_l6_r[3], HA_S7[9], HA_C7[9]);
    HA ha19(FA_S5_l6_r[4], FA_C5_l6_r[4], HA_S7[10], HA_C7[10]);
    HA ha20(FA_S5_l6_r[5], FA_S1_l6_r[1], HA_S7[11], HA_C7[11]);
    HA ha21(FA_S4_l6_r[0], FA_C4_l6_r[0], HA_S7[12], HA_C7[12]);
    HA ha22(FA_S4_l6_r[1], FA_C4_l6_r[1], HA_S7[13], HA_C7[13]);
    HA ha23(FA_S6_l6_r[23], HA_C6_l6_r, HA_S7[14], HA_C7[14]);

    // loop 7, level 1 (#: 0 - 11, Total: 12)
    FA fa7_0(FA_S5_l6_r[0], FA_C6_l6_r[6], FA_C5_l6_r[0], FA_S7[0], FA_C7[0]);
    FA fa7_1(FA_S6_l6_r[6], FA_C6_l6_r[7], FA_S3_l6_r[0], FA_S7[1], FA_C7[1]);
    FA fa7_2(FA_S6_l6_r[7], FA_C6_l6_r[8], FA_C2_l6_r[0], FA_S7[2], FA_C7[2]);
    FA fa7_3(FA_S6_l6_r[8], FA_C6_l6_r[9], FA_C2_l6_r[1], FA_S7[3], FA_C7[3]);
    FA fa7_4(FA_S6_l6_r[9], FA_C6_l6_r[10], FA_C5_l6_r[5], FA_S7[4], FA_C7[4]);
    FA fa7_5(FA_S6_l6_r[10], FA_C6_l6_r[11], FA_C5_l6_r[6], FA_S7[5], FA_C7[5]);
    FA fa7_6(FA_S6_l6_r[11], FA_C6_l6_r[12], FA_C5_l6_r[7], FA_S7[6], FA_C7[6]);
    FA fa7_7(FA_S6_l6_r[12], FA_C6_l6_r[13], HA_C5_l6_r[0], FA_S7[7], FA_C7[7]);
    FA fa7_8(FA_S6_l6_r[13], FA_C6_l6_r[14], HA_C5_l6_r[1], FA_S7[8], FA_C7[8]);
    FA fa7_9(FA_S6_l6_r[14], FA_C6_l6_r[15], HA_C5_l6_r[2], FA_S7[9], FA_C7[9]);
    FA fa7_10(FA_S6_l6_r[15], FA_C6_l6_r[16], FA_C5_l6_r[8], FA_S7[10], FA_C7[10]);
    FA fa7_11(FA_S4_l6_r[2], FA_C6_l6_r[23], FA_S1_l6_r[0], FA_S7[11], FA_C7[11]);


    //////////////////////////////////////////////////////////////////////////////
    /////                                CPA                                 /////
    //////////////////////////////////////////////////////////////////////////////

    wire    [48:0]  outputA;
    wire    [48:0]  outputB;
    wire    [48:0]  outputC;
    wire            carry;

    assign outputA[48] = P7_r[1];
    assign outputA[47] = FA_S2_l7_r;
    assign outputA[46] = FA_S3_l7_r;
    assign outputA[45] = FA_S4_l7_r[0];
    assign outputA[44] = FA_S4_l7_r[1];
    assign outputA[43] = FA_S5_l7_r[0];
    assign outputA[42] = FA_S5_l7_r[1];
    assign outputA[41] = FA_S5_l7_r[2];
    assign outputA[40] = FA_S5_l7_r[3];
    assign outputA[39] = FA_S6_l7_r[0];
    assign outputA[38] = FA_S6_l7_r[1];
    assign outputA[37] = FA_S6_l7_r[2];
    assign outputA[36] = FA_S6_l7_r[3];
    assign outputA[35] = FA_S6_l7_r[4];
    assign outputA[34] = FA_S6_l7_r[5];
    assign outputA[33] = FA_S7_l7_r[0];
    assign outputA[32] = FA_S7_l7_r[1];
    assign outputA[31] = FA_S7_l7_r[2];
    assign outputA[30] = FA_S7_l7_r[3];
    assign outputA[29] = FA_S7_l7_r[4];
    assign outputA[28] = FA_S7_l7_r[5];
    assign outputA[27] = FA_S7_l7_r[6];
    assign outputA[26] = FA_S7_l7_r[7];
    assign outputA[25] = FA_S7_l7_r[8];
    assign outputA[24] = FA_S7_l7_r[9];
    assign outputA[23] = FA_S7_l7_r[10];
    assign outputA[22] = HA_S7_l7_r[0];
    assign outputA[21] = HA_S7_l7_r[1];
    assign outputA[20] = HA_S7_l7_r[2];
    assign outputA[19] = HA_S7_l7_r[3];
    assign outputA[18] = HA_S7_l7_r[4];
    assign outputA[17] = HA_S7_l7_r[5];
    assign outputA[16] = HA_S7_l7_r[6];
    assign outputA[15] = HA_S7_l7_r[7];
    assign outputA[14] = HA_S7_l7_r[8];
    assign outputA[13] = HA_S7_l7_r[9];
    assign outputA[12] = HA_S7_l7_r[10];
    assign outputA[11] = HA_S7_l7_r[11];
    assign outputA[10] = HA_S7_l7_r[12];
    assign outputA[9] = HA_S7_l7_r[13];
    assign outputA[8] = FA_S7_l7_r[11];
    assign outputA[7] = HA_S7_l7_r[14];
    assign outputA[6] = HA_S6_l7_r;
    assign outputA[5] = HA_S5_l7_r;
    assign outputA[4] = HA_S4_l7_r;
    assign outputA[3] = HA_S3_l7_r;
    assign outputA[2] = HA_S2_l7_r;
    assign outputA[1] = HA_S1_l7_r;
    assign outputA[0] = P7_r[0];
    
    assign outputB[48] = FA_C2_l7_r;
    assign outputB[47] = FA_C3_l7_r;
    assign outputB[46] = FA_C4_l7_r[0];
    assign outputB[45] = FA_C4_l7_r[1];
    assign outputB[44] = FA_C5_l7_r[0];
    assign outputB[43] = FA_C5_l7_r[1];
    assign outputB[42] = FA_C5_l7_r[2];
    assign outputB[41] = FA_C5_l7_r[3];
    assign outputB[40] = FA_C6_l7_r[0];
    assign outputB[39] = FA_C6_l7_r[1];
    assign outputB[38] = FA_C6_l7_r[2];
    assign outputB[37] = FA_C6_l7_r[3];
    assign outputB[36] = FA_C6_l7_r[4];
    assign outputB[35] = FA_C6_l7_r[5];
    assign outputB[34] = FA_C7_l7_r[0];
    assign outputB[33] = FA_C7_l7_r[1];
    assign outputB[32] = FA_C7_l7_r[2];
    assign outputB[31] = FA_C7_l7_r[3];
    assign outputB[30] = FA_C7_l7_r[4];
    assign outputB[29] = FA_C7_l7_r[5];
    assign outputB[28] = FA_C7_l7_r[6];
    assign outputB[27] = FA_C7_l7_r[7];
    assign outputB[26] = FA_C7_l7_r[8];
    assign outputB[25] = FA_C7_l7_r[9];
    assign outputB[24] = FA_C7_l7_r[10];
    assign outputB[23] = HA_C7_l7_r[0];
    assign outputB[22] = HA_C7_l7_r[1];
    assign outputB[21] = HA_C7_l7_r[2];
    assign outputB[20] = HA_C7_l7_r[3];
    assign outputB[19] = HA_C7_l7_r[4];
    assign outputB[18] = HA_C7_l7_r[5];
    assign outputB[17] = HA_C7_l7_r[6];
    assign outputB[16] = HA_C7_l7_r[7];
    assign outputB[15] = HA_C7_l7_r[8];
    assign outputB[14] = HA_C7_l7_r[9];
    assign outputB[13] = HA_C7_l7_r[10];
    assign outputB[12] = HA_C7_l7_r[11];
    assign outputB[11] = HA_C7_l7_r[12];
    assign outputB[10] = HA_C7_l7_r[13];
    assign outputB[9] = FA_C7_l7_r[11];
    assign outputB[8] = HA_C7_l7_r[14];
    assign outputB[7] = 1'b0;
    assign outputB[6] = 1'b0;
    assign outputB[5] = 1'b0;
    assign outputB[4] = 1'b0;
    assign outputB[3] = 1'b0;
    assign outputB[2] = 1'b0;
    assign outputB[1] = 1'b0;
    assign outputB[0] = 1'b0;

    /*
    assign {carry, outputC} = outputA + outputB;
    
    assign C = outputC[48:24];
   */
    ADD_PL(clk, rst, outputA[48:17], outputB[48:17], 
            ctr_l7_r, d_l7_r, remain_l7_r,
            ctr_final, d_final, remain_final, C);

    //////////////////////////////////////////////////////////////////////////////
    /////                               pipeline                             /////
    //////////////////////////////////////////////////////////////////////////////

    always@(posedge clk) begin
        if(!rst) begin
            // loop 1
            for (i = 0; i < 192; i = i + 1) begin
                FA_S1_l1_r[i] <= 1'b0;
                FA_C1_l1_r[i] <= 1'b0;
            end
            HA_S1_l1_r <= 1'b0;
            HA_C1_l1_r <= 1'b0;
            P1_r[0] <= 1'b0;
            P1_r[1] <= 1'b0;
            P1_r[2] <= 1'b0;
            P1_r[3] <= 1'b0;
            P1_r[4] <= 1'b0;
            P1_r[5] <= 1'b0;
            P1_r[6] <= 1'b0;
            P1_r[7] <= 1'b0;
            P1_r[8] <= 1'b0;
            P1_r[9] <= 1'b0;
            P1_r[10] <= 1'b0;
            P1_r[11] <= 1'b0;
            P1_r[12] <= 1'b0;
            P1_r[13] <= 1'b0;
            P1_r[14] <= 1'b0;
            P1_r[15] <= 1'b0;
            P1_r[16] <= 1'b0;
            P1_r[17] <= 1'b0;
            P1_r[18] <= 1'b0;
            P1_r[19] <= 1'b0;
            P1_r[20] <= 1'b0;
            P1_r[21] <= 1'b0;
            P1_r[22] <= 1'b0;
            P1_r[23] <= 1'b0;
            P1_r[24] <= 1'b0;
            P1_r[25] <= 1'b0;
            P1_r[26] <= 1'b0;
            P1_r[27] <= 1'b0;
            P1_r[28] <= 1'b0;
            P1_r[29] <= 1'b0;
            P1_r[30] <= 1'b0;
            P1_r[31] <= 1'b0;
            P1_r[32] <= 1'b0;
            P1_r[33] <= 1'b0;
            P1_r[34] <= 1'b0;
            P1_r[35] <= 1'b0;
            P1_r[36] <= 1'b0;
            P1_r[37] <= 1'b0;
            P1_r[38] <= 1'b0;
            P1_r[39] <= 1'b0;
            P1_r[40] <= 1'b0;
            P1_r[41] <= 1'b0;
            P1_r[42] <= 1'b0;
            P1_r[43] <= 1'b0;
            P1_r[44] <= 1'b0;
            P1_r[45] <= 1'b0;
            P1_r[46] <= 1'b0;
            
            // loop 2
            FA_S1_l2_r[0] <= 1'b0;
            FA_S1_l2_r[1] <= 1'b0;
            FA_S1_l2_r[2] <= 1'b0;
            FA_S1_l2_r[3] <= 1'b0;
            FA_S1_l2_r[4] <= 1'b0;
            FA_S1_l2_r[5] <= 1'b0;
            FA_S1_l2_r[6] <= 1'b0;
            
            FA_C1_l2_r[0] <= 1'b0; 
            FA_C1_l2_r[1] <= 1'b0; 
            FA_C1_l2_r[2] <= 1'b0; 
            FA_C1_l2_r[3] <= 1'b0; 
            FA_C1_l2_r[4] <= 1'b0; 
            FA_C1_l2_r[5] <= 1'b0; 
            FA_C1_l2_r[6] <= 1'b0; 
            FA_C1_l2_r[7] <= 1'b0;
            FA_C1_l2_r[8] <= 1'b0;
            FA_C1_l2_r[9] <= 1'b0;
            FA_C1_l2_r[10] <= 1'b0;
            FA_C1_l2_r[11] <= 1'b0;
            FA_C1_l2_r[12] <= 1'b0;
            FA_C1_l2_r[13] <= 1'b0;
            FA_C1_l2_r[14] <= 1'b0;
            FA_C1_l2_r[15] <= 1'b0;
            
            HA_S1_l2_r <= 1'b0;
            
            for (i = 0; i < 128; i = i + 1) begin
                FA_S2_l2_r[i] <= 1'b0;
                FA_C2_l2_r[i] <= 1'b0;
            end
            
            HA_S2_l2_r <= 1'b0;
            HA_C2_l2_r <= 1'b0;
            
            P2_r[0] <= 1'b0; 
            P2_r[1] <= 1'b0; 
            P2_r[2] <= 1'b0; 
            P2_r[3] <= 1'b0; 
            P2_r[4] <= 1'b0; 
            P2_r[5] <= 1'b0; 
            P2_r[6] <= 1'b0; 
            P2_r[7] <= 1'b0; 
            P2_r[8] <= 1'b0; 
            P2_r[9] <= 1'b0; 
            P2_r[10] <= 1'b0; 
            P2_r[11] <= 1'b0;
            P2_r[12] <= 1'b0;
            P2_r[13] <= 1'b0;
            P2_r[14] <= 1'b0;
            P2_r[15] <= 1'b0;
            P2_r[16] <= 1'b0;
            P2_r[17] <= 1'b0;
            P2_r[18] <= 1'b0;
            P2_r[19] <= 1'b0;
            P2_r[20] <= 1'b0;
            P2_r[21] <= 1'b0;
            P2_r[22] <= 1'b0;
        
            // loop 3
            FA_S1_l3_r[0] <= 1'b0; 
            FA_S1_l3_r[1] <= 1'b0;
            
            FA_C1_l3_r[0] <= 1'b0;
            FA_C1_l3_r[1] <= 1'b0;
            FA_C1_l3_r[2] <= 1'b0;
            FA_C1_l3_r[3] <= 1'b0;
            FA_C1_l3_r[4] <= 1'b0;
            FA_C1_l3_r[5] <= 1'b0;
            
            FA_S2_l3_r[0] <= 1'b0;
            FA_S2_l3_r[1] <= 1'b0;
            FA_S2_l3_r[2] <= 1'b0;
            FA_S2_l3_r[3] <= 1'b0;
            FA_S2_l3_r[4] <= 1'b0;
            FA_S2_l3_r[5] <= 1'b0;
            FA_S2_l3_r[6] <= 1'b0;
            FA_S2_l3_r[7] <= 1'b0;
            
            FA_C2_l3_r[0] <= 1'b0;
            FA_C2_l3_r[1] <= 1'b0;
            FA_C2_l3_r[2] <= 1'b0;
            FA_C2_l3_r[3] <= 1'b0;
            FA_C2_l3_r[4] <= 1'b0;
            FA_C2_l3_r[5] <= 1'b0;
            FA_C2_l3_r[6] <= 1'b0;
            FA_C2_l3_r[7] <= 1'b0;
            FA_C2_l3_r[8] <= 1'b0;
            FA_C2_l3_r[9] <= 1'b0;
            FA_C2_l3_r[10] <= 1'b0;
            FA_C2_l3_r[11] <= 1'b0;
            FA_C2_l3_r[12] <= 1'b0;
            FA_C2_l3_r[13] <= 1'b0;
            FA_C2_l3_r[14] <= 1'b0;
            FA_C2_l3_r[15] <= 1'b0;
            FA_C2_l3_r[16] <= 1'b0;
            
            HA_S1_l3_r <= 1'b0;
            HA_S2_l3_r <= 1'b0;
            
            for (i = 0; i < 85; i = i + 1) begin
                FA_S3_l3_r[i] <= 1'b0;
                FA_C3_l3_r[i] <= 1'b0;
            end
            
            HA_S3_l3_r <= 1'b0;
            HA_C3_l3_r <= 1'b0;
            
            P3_r[0] <= 1'b0; 
            P3_r[1] <= 1'b0;
            P3_r[2] <= 1'b0;
            P3_r[3] <= 1'b0;
            P3_r[4] <= 1'b0;
            P3_r[5] <= 1'b0;
            P3_r[6] <= 1'b0;
            P3_r[7] <= 1'b0;
            P3_r[8] <= 1'b0;
            P3_r[9] <= 1'b0;
            P3_r[10] <= 1'b0;
            P3_r[11] <= 1'b0;
            P3_r[12] <= 1'b0;
            
            // loop 4
            FA_S1_l4_r[0] <= 1'b0;
            FA_S1_l4_r[1] <= 1'b0;
            
            FA_C1_l4_r[0] <= 1'b0;
            FA_C1_l4_r[1] <= 1'b0;
            
            FA_S2_l4_r[0] <= 1'b0;
            FA_S2_l4_r[1] <= 1'b0;
            FA_S2_l4_r[2] <= 1'b0;
            FA_S2_l4_r[3] <= 1'b0;

            FA_C2_l4_r[0] <= 1'b0;
            FA_C2_l4_r[1] <= 1'b0;
            FA_C2_l4_r[2] <= 1'b0;
            FA_C2_l4_r[3] <= 1'b0;
            FA_C2_l4_r[4] <= 1'b0;
            FA_C2_l4_r[5] <= 1'b0;
            FA_C2_l4_r[6] <= 1'b0;
            
            FA_S3_l4_r[0] <= 1'b0;
            FA_S3_l4_r[1] <= 1'b0;
            FA_S3_l4_r[2] <= 1'b0;
            FA_S3_l4_r[3] <= 1'b0;
            FA_S3_l4_r[4] <= 1'b0;
            FA_S3_l4_r[5] <= 1'b0;
            FA_S3_l4_r[6] <= 1'b0;
            FA_S3_l4_r[7] <= 1'b0;
           
            FA_C3_l4_r[0] <= 1'b0;
            FA_C3_l4_r[1] <= 1'b0;
            FA_C3_l4_r[2] <= 1'b0;
            FA_C3_l4_r[3] <= 1'b0;
            FA_C3_l4_r[4] <= 1'b0;
            FA_C3_l4_r[5] <= 1'b0;
            FA_C3_l4_r[6] <= 1'b0;
            FA_C3_l4_r[7] <= 1'b0;
            FA_C3_l4_r[8] <= 1'b0;
            FA_C3_l4_r[9] <= 1'b0;
            FA_C3_l4_r[10] <= 1'b0;
            FA_C3_l4_r[11] <= 1'b0;
            FA_C3_l4_r[12] <= 1'b0;

            HA_S1_l4_r <= 1'b0;
            HA_S2_l4_r <= 1'b0;
            HA_S3_l4_r <= 1'b0;

            for (i = 0; i < 57; i = i + 1) begin
                FA_S4_l4_r[i] <= 1'b0;
                FA_C4_l4_r[i] <= 1'b0;
            end

            HA_S4_l4_r <= 1'b0;
            HA_C4_l4_r <= 1'b0;
            
            P4_r[0] <= 1'b0;
            P4_r[1] <= 1'b0;
            P4_r[2] <= 1'b0;
            P4_r[3] <= 1'b0;
            P4_r[4] <= 1'b0;
            P4_r[5] <= 1'b0;
            P4_r[6] <= 1'b0;
            P4_r[7] <= 1'b0;
            
            // loop 5
            FA_S1_l5_r[0] <= 1'b0;
            FA_S1_l5_r[1] <= 1'b0;
            
            FA_C1_l5_r <= 1'b0;
            
            FA_S2_l5_r[0] <= 1'b0;
            FA_S2_l5_r[1] <= 1'b0;
            FA_S2_l5_r[2] <= 1'b0;

            FA_C2_l5_r[0] <= 1'b0;
            FA_C2_l5_r[1] <= 1'b0;
            FA_C2_l5_r[2] <= 1'b0;
            
            FA_S3_l5_r[0] <= 1'b0;
            FA_S3_l5_r[1] <= 1'b0;
            FA_S3_l5_r[2] <= 1'b0;
            FA_S3_l5_r[3] <= 1'b0;
           
            FA_C3_l5_r[0] <= 1'b0;
            FA_C3_l5_r[1] <= 1'b0;

            FA_S4_l5_r[0] <= 1'b0;
            FA_S4_l5_r[1] <= 1'b0;
            FA_S4_l5_r[2] <= 1'b0;
            FA_S4_l5_r[3] <= 1'b0;
            FA_S4_l5_r[4] <= 1'b0;
            FA_S4_l5_r[5] <= 1'b0;

            FA_C4_l5_r[0] <= 1'b0;
            FA_C4_l5_r[1] <= 1'b0;
            FA_C4_l5_r[2] <= 1'b0;
            FA_C4_l5_r[3] <= 1'b0;
            FA_C4_l5_r[4] <= 1'b0;
            FA_C4_l5_r[5] <= 1'b0;
            FA_C4_l5_r[6] <= 1'b0;
            FA_C4_l5_r[7] <= 1'b0;
            FA_C4_l5_r[8] <= 1'b0;
            FA_C4_l5_r[9] <= 1'b0;
            FA_C4_l5_r[10] <= 1'b0;
            FA_C4_l5_r[11] <= 1'b0;
            FA_C4_l5_r[12] <= 1'b0;
            FA_C4_l5_r[13] <= 1'b0;
            FA_C4_l5_r[14] <= 1'b0;
            FA_C4_l5_r[15] <= 1'b0;

            HA_S1_l5_r <= 1'b0;
            HA_S2_l5_r <= 1'b0;
            HA_S3_l5_r <= 1'b0;
            HA_S4_l5_r <= 1'b0;

            for (i = 0; i < 37; i = i + 1) begin
                FA_S5_l5_r[i] <= 1'b0;
                FA_C5_l5_r[i] <= 1'b0;
            end

            for (i = 0; i < 4; i = i + 1) begin
                HA_S5_l5_r[i] <= 1'b0;
                HA_C5_l5_r[i] <= 1'b0;
            end
            
            P5_r[0] <= 1'b0;
            P5_r[1] <= 1'b0;
            P5_r[2] <= 1'b0;
            
            // loop 6
            FA_S1_l6_r[0] <= 1'b0; 
            FA_S1_l6_r[1] <= 1'b0;
            
            FA_S2_l6_r[0] <= 1'b0;
            FA_S2_l6_r[1] <= 1'b0;

            FA_C2_l6_r[0] <= 1'b0;
            FA_C2_l6_r[1] <= 1'b0;
            FA_C2_l6_r[2] <= 1'b0;
            
            FA_S3_l6_r[0] <= 1'b0;
            FA_S3_l6_r[1] <= 1'b0;
           
            FA_C3_l6_r <= 1'b0;

            FA_S4_l6_r[0] <= 1'b0;
            FA_S4_l6_r[1] <= 1'b0;
            FA_S4_l6_r[2] <= 1'b0;
            FA_S4_l6_r[3] <= 1'b0;
            FA_S4_l6_r[4] <= 1'b0;

            FA_C4_l6_r[0] <= 1'b0;
            FA_C4_l6_r[1] <= 1'b0;
            FA_C4_l6_r[2] <= 1'b0;
            FA_C4_l6_r[3] <= 1'b0;

            FA_S5_l6_r[0] <= 1'b0;
            FA_S5_l6_r[1] <= 1'b0;
            FA_S5_l6_r[2] <= 1'b0;
            FA_S5_l6_r[3] <= 1'b0;
            FA_S5_l6_r[4] <= 1'b0;
            FA_S5_l6_r[5] <= 1'b0;
            FA_S5_l6_r[6] <= 1'b0;
            FA_S5_l6_r[7] <= 1'b0;
            FA_S5_l6_r[8] <= 1'b0;
            FA_S5_l6_r[9] <= 1'b0;

            FA_C5_l6_r[0] <= 1'b0;
            FA_C5_l6_r[1] <= 1'b0;
            FA_C5_l6_r[2] <= 1'b0;
            FA_C5_l6_r[3] <= 1'b0;
            FA_C5_l6_r[4] <= 1'b0;
            FA_C5_l6_r[5] <= 1'b0;
            FA_C5_l6_r[6] <= 1'b0;
            FA_C5_l6_r[7] <= 1'b0;
            FA_C5_l6_r[8] <= 1'b0;
            FA_C5_l6_r[9] <= 1'b0;
            FA_C5_l6_r[10] <= 1'b0;
            FA_C5_l6_r[11] <= 1'b0;
            FA_C5_l6_r[12] <= 1'b0;

            HA_S1_l6_r <= 1'b0;
            HA_S2_l6_r <= 1'b0;
            HA_S3_l6_r <= 1'b0;
            HA_S4_l6_r <= 1'b0;
            HA_S5_l6_r <= 1'b0;
            for (i = 0; i < 3; i = i + 1) begin
                HA_C5_l6_r[i] <= 1'b0;
            end

            for (i = 0; i < 24; i = i + 1) begin
                FA_S6_l6_r[i] <= 1'b0;
                FA_C6_l6_r[i] <= 1'b0;
            end

            HA_S6_l6_r <= 1'b0;
            HA_C6_l6_r <= 1'b0;
            
            P6_r[0] <= 1'b0;
            P6_r[1] <= 1'b0;
            
            // loop 7
            FA_S2_l7_r <= 1'b0; 

            FA_C2_l7_r <= 1'b0;
            
            FA_S3_l7_r <= 1'b0;
           
            FA_C3_l7_r <= 1'b0;

            FA_S4_l7_r[0] <= 1'b0; 
            FA_S4_l7_r[1] <= 1'b0;

            FA_C4_l7_r[0] <= 1'b0;
            FA_C4_l7_r[1] <= 1'b0;

            FA_S5_l7_r[0] <= 1'b0;
            FA_S5_l7_r[1] <= 1'b0;
            FA_S5_l7_r[2] <= 1'b0;
            FA_S5_l7_r[3] <= 1'b0;

            FA_C5_l7_r[0] <= 1'b0;
            FA_C5_l7_r[1] <= 1'b0;
            FA_C5_l7_r[2] <= 1'b0;
            FA_C5_l7_r[3] <= 1'b0;
    
            FA_S6_l7_r[0] <= 1'b0;
            FA_S6_l7_r[1] <= 1'b0;
            FA_S6_l7_r[2] <= 1'b0;
            FA_S6_l7_r[3] <= 1'b0;
            FA_S6_l7_r[4] <= 1'b0;
            FA_S6_l7_r[5] <= 1'b0;
            
            FA_C6_l7_r[0] <= 1'b0;
            FA_C6_l7_r[1] <= 1'b0;
            FA_C6_l7_r[2] <= 1'b0;
            FA_C6_l7_r[3] <= 1'b0;
            FA_C6_l7_r[4] <= 1'b0;
            FA_C6_l7_r[5] <= 1'b0;

            HA_S1_l7_r <= 1'b0;
            HA_S2_l7_r <= 1'b0;
            HA_S3_l7_r <= 1'b0;
            HA_S4_l7_r <= 1'b0;
            HA_S5_l7_r <= 1'b0;
            HA_S6_l7_r <= 1'b0;

            for (i = 0; i < 12; i = i + 1) begin
                FA_S7_l7_r[i] <= 1'b0;
                FA_C7_l7_r[i] <= 1'b0;
            end
            
            for (i = 0; i < 15; i = i + 1) begin
                HA_S7_l7_r[i] <= 1'b0;
                HA_C7_l7_r[i] <= 1'b0;
            end
            
            P7_r[0] <= 1'b0;
            P7_r[1] <= 1'b0;
        end
        else begin
            // loop 1
            for (i = 0; i < 192; i = i + 1) begin
                FA_S1_l1_r[i] <= FA_S1[i];
                FA_C1_l1_r[i] <= FA_C1[i];
            end
            HA_S1_l1_r <= HA_S1;
            HA_C1_l1_r <= HA_C1;
            P1_r[0] <= P[0][0];
            P1_r[1] <= P[3][0];
            P1_r[2] <= P[3][1];
            P1_r[3] <= P[4][0];
            P1_r[4] <= P[6][0];
            P1_r[5] <= P[6][1];
            P1_r[6] <= P[7][0];
            P1_r[7] <= P[9][0];
            P1_r[8] <= P[9][1];
            P1_r[9] <= P[10][0];
            P1_r[10] <= P[12][0];
            P1_r[11] <= P[12][1];
            P1_r[12] <= P[13][0];
            P1_r[13] <= P[15][0];
            P1_r[14] <= P[15][1];
            P1_r[15] <= P[16][0];
            P1_r[16] <= P[18][0];
            P1_r[17] <= P[18][1];
            P1_r[18] <= P[19][0];
            P1_r[19] <= P[21][0];
            P1_r[20] <= P[21][1];
            P1_r[21] <= P[22][0];
            P1_r[22] <= P[23][3];
            P1_r[23] <= P[23][6];
            P1_r[24] <= P[23][9];
            P1_r[25] <= P[23][12];
            P1_r[26] <= P[23][15];
            P1_r[27] <= P[23][18];
            P1_r[28] <= P[23][21];
            P1_r[29] <= P[23][24];
            P1_r[30] <= P[24][0];
            P1_r[31] <= P[24][2];
            P1_r[32] <= P[24][3];
            P1_r[33] <= P[24][5];
            P1_r[34] <= P[24][6];
            P1_r[35] <= P[24][8];
            P1_r[36] <= P[24][9];
            P1_r[37] <= P[24][11];
            P1_r[38] <= P[24][12];
            P1_r[39] <= P[24][14];
            P1_r[40] <= P[24][15];
            P1_r[41] <= P[24][17];
            P1_r[42] <= P[24][18];
            P1_r[43] <= P[24][20];
            P1_r[44] <= P[24][21];
            P1_r[45] <= P[24][23];
            P1_r[46] <= P[24][24];
            
            // loop 2
            FA_S1_l2_r[0] <= FA_S1_l1_r[0];
            FA_S1_l2_r[1] <= FA_S1_l1_r[117];
            FA_S1_l2_r[2] <= FA_S1_l1_r[179];
            FA_S1_l2_r[3] <= FA_S1_l1_r[180];
            FA_S1_l2_r[4] <= FA_S1_l1_r[188];
            FA_S1_l2_r[5] <= FA_S1_l1_r[116];
            FA_S1_l2_r[6] <= FA_S1_l1_r[143];
            
            FA_C1_l2_r[0] <= FA_C1_l1_r[1];
            FA_C1_l2_r[1] <= FA_C1_l1_r[45];
            FA_C1_l2_r[2] <= FA_C1_l1_r[46];
            FA_C1_l2_r[3] <= FA_C1_l1_r[47];
            FA_C1_l2_r[4] <= FA_C1_l1_r[81];
            FA_C1_l2_r[5] <= FA_C1_l1_r[83];
            FA_C1_l2_r[6] <= FA_C1_l1_r[146];
            FA_C1_l2_r[7] <= FA_C1_l1_r[162];
            FA_C1_l2_r[8] <= FA_C1_l1_r[189];
            FA_C1_l2_r[9] <= FA_C1_l1_r[191];
            FA_C1_l2_r[10] <= FA_C1_l1_r[144];
            FA_C1_l2_r[11] <= FA_C1_l1_r[145];
            FA_C1_l2_r[12] <= FA_C1_l1_r[164];
            FA_C1_l2_r[13] <= FA_C1_l1_r[190];
            FA_C1_l2_r[14] <= FA_C1_l1_r[181];
            FA_C1_l2_r[15] <= FA_C1_l1_r[118];
            
            HA_S1_l2_r <= HA_S1_l1_r;
            
            for (i = 0; i < 128; i = i + 1) begin
                FA_S2_l2_r[i] <= FA_S2[i];
                FA_C2_l2_r[i] <= FA_C2[i];
            end
            
            HA_S2_l2_r <= HA_S2;
            HA_C2_l2_r <= HA_C2;
            
            P2_r[0] <= P1_r[0];
            P2_r[1] <= P1_r[3];
            P2_r[2] <= P1_r[4];
            P2_r[3] <= P1_r[7];
            P2_r[4] <= P1_r[8];
            P2_r[5] <= P1_r[9];
            P2_r[6] <= P1_r[12];
            P2_r[7] <= P1_r[13];
            P2_r[8] <= P1_r[16];
            P2_r[9] <= P1_r[17];
            P2_r[10] <= P1_r[18];
            P2_r[11] <= P1_r[21];
            P2_r[12] <= P1_r[30];
            P2_r[13] <= P1_r[31];
            P2_r[14] <= P1_r[34];
            P2_r[15] <= P1_r[35];
            P2_r[16] <= P1_r[36];
            P2_r[17] <= P1_r[37];
            P2_r[18] <= P1_r[40];
            P2_r[19] <= P1_r[41];
            P2_r[20] <= P1_r[42];
            P2_r[21] <= P1_r[43];
            P2_r[22] <= P1_r[46];
        
            // loop 3
            FA_S1_l3_r[0] <= FA_S1_l2_r[5];
            FA_S1_l3_r[1] <= FA_S1_l2_r[6];
            
            FA_C1_l3_r[0] <= FA_C1_l2_r[10];
            FA_C1_l3_r[1] <= FA_C1_l2_r[11];
            FA_C1_l3_r[2] <= FA_C1_l2_r[12];
            FA_C1_l3_r[3] <= FA_C1_l2_r[13];
            FA_C1_l3_r[4] <= FA_C1_l2_r[14];
            FA_C1_l3_r[5] <= FA_C1_l2_r[15];
            
            FA_S2_l3_r[0] <= FA_S2_l2_r[1];
            FA_S2_l3_r[1] <= FA_S2_l2_r[41];
            FA_S2_l3_r[2] <= FA_S2_l2_r[105];
            FA_S2_l3_r[3] <= FA_S2_l2_r[118];
            FA_S2_l3_r[4] <= FA_S2_l2_r[103];
            FA_S2_l3_r[5] <= FA_S2_l2_r[78];
            FA_S2_l3_r[6] <= FA_S2_l2_r[119];
            FA_S2_l3_r[7] <= FA_S2_l2_r[0];
            
            FA_C2_l3_r[0] <= FA_C2_l2_r[2];
            FA_C2_l3_r[1] <= FA_C2_l2_r[42];
            FA_C2_l3_r[2] <= FA_C2_l2_r[44];
            FA_C2_l3_r[3] <= FA_C2_l2_r[45];
            FA_C2_l3_r[4] <= FA_C2_l2_r[46];
            FA_C2_l3_r[5] <= FA_C2_l2_r[48];
            FA_C2_l3_r[6] <= FA_C2_l2_r[74];
            FA_C2_l3_r[7] <= FA_C2_l2_r[75];
            FA_C2_l3_r[8] <= FA_C2_l2_r[77];
            FA_C2_l3_r[9] <= FA_C2_l2_r[124];
            FA_C2_l3_r[10] <= FA_C2_l2_r[121];
            FA_C2_l3_r[11] <= FA_C2_l2_r[122];
            FA_C2_l3_r[12] <= FA_C2_l2_r[126];
            FA_C2_l3_r[13] <= FA_C2_l2_r[127];
            FA_C2_l3_r[14] <= FA_C2_l2_r[106];
            FA_C2_l3_r[15] <= FA_C2_l2_r[120];
            FA_C2_l3_r[16] <= FA_C2_l2_r[0];
            
            HA_S1_l3_r <= HA_S1_l2_r;
            HA_S2_l3_r <= HA_S2_l2_r;
            
            for (i = 0; i < 85; i = i + 1) begin
                FA_S3_l3_r[i] <= FA_S3[i];
                FA_C3_l3_r[i] <= FA_C3[i];
            
            end
            
            HA_S3_l3_r <= HA_S3;
            HA_C3_l3_r <= HA_C3;
            
            P3_r[0] <= P2_r[0];
            P3_r[1] <= P2_r[2];
            P3_r[2] <= P2_r[3];
            P3_r[3] <= P2_r[6];
            P3_r[4] <= P2_r[7];
            P3_r[5] <= P2_r[8];
            P3_r[6] <= P2_r[10];
            P3_r[7] <= P2_r[11];
            P3_r[8] <= P2_r[17];
            P3_r[9] <= P2_r[19];
            P3_r[10] <= P2_r[20];
            P3_r[11] <= P2_r[21];
            P3_r[12] <= P2_r[22];
            
            // loop 4
            FA_S1_l4_r[0] <= FA_S1_l3_r[0];
            FA_S1_l4_r[1] <= FA_S1_l3_r[1];
            
            FA_C1_l4_r[0] <= FA_C1_l3_r[4];
            FA_C1_l4_r[1] <= FA_C1_l3_r[5];
            
            FA_S2_l4_r[0] <= FA_S2_l3_r[4];
            FA_S2_l4_r[1] <= FA_S2_l3_r[5];
            FA_S2_l4_r[2] <= FA_S2_l3_r[6];
            FA_S2_l4_r[3] <= FA_S2_l3_r[7];

            FA_C2_l4_r[0] <= FA_C2_l3_r[10];
            FA_C2_l4_r[1] <= FA_C2_l3_r[11];
            FA_C2_l4_r[2] <= FA_C2_l3_r[12];
            FA_C2_l4_r[3] <= FA_C2_l3_r[13];
            FA_C2_l4_r[4] <= FA_C2_l3_r[14];
            FA_C2_l4_r[5] <= FA_C2_l3_r[15];
            FA_C2_l4_r[6] <= FA_C2_l3_r[16];
            
            FA_S3_l4_r[0] <= FA_S3_l3_r[2];
            FA_S3_l4_r[1] <= FA_S3_l3_r[39];
            FA_S3_l4_r[2] <= FA_S3_l3_r[83];
            FA_S3_l4_r[3] <= FA_S3_l3_r[84];
            FA_S3_l4_r[4] <= FA_S3_l3_r[38];
            FA_S3_l4_r[5] <= FA_S3_l3_r[82];
            FA_S3_l4_r[6] <= FA_S3_l3_r[69];
            FA_S3_l4_r[7] <= FA_S3_l3_r[0];
           
            FA_C3_l4_r[0] <= FA_C3_l3_r[3];
            FA_C3_l4_r[1] <= FA_C3_l3_r[41];
            FA_C3_l4_r[2] <= FA_C3_l3_r[42];
            FA_C3_l4_r[3] <= FA_C3_l3_r[43];
            FA_C3_l4_r[4] <= FA_C3_l3_r[44];
            FA_C3_l4_r[5] <= FA_C3_l3_r[48];
            FA_C3_l4_r[6] <= FA_C3_l3_r[63];
            FA_C3_l4_r[7] <= FA_C3_l3_r[64];
            FA_C3_l4_r[8] <= FA_C3_l3_r[66];
            FA_C3_l4_r[9] <= FA_C3_l3_r[67];
            FA_C3_l4_r[10] <= FA_C3_l3_r[83];
            FA_C3_l4_r[11] <= FA_C3_l3_r[39];
            FA_C3_l4_r[12] <= FA_C3_l3_r[0];

            HA_S1_l4_r <= HA_S1_l3_r;
            HA_S2_l4_r <= HA_S2_l3_r;
            HA_S3_l4_r <= HA_S3_l3_r;

            for (i = 0; i < 57; i = i + 1) begin
                FA_S4_l4_r[i] <= FA_S4[i];
                FA_C4_l4_r[i] <= FA_C4[i];
            end

            HA_S4_l4_r <= HA_S4;
            HA_C4_l4_r <= HA_C4;
            
            P4_r[0] <= P3_r[0];
            P4_r[1] <= P3_r[1];
            P4_r[2] <= P3_r[3];
            P4_r[3] <= P3_r[5];
            P4_r[4] <= P3_r[7];
            P4_r[5] <= P3_r[9];
            P4_r[6] <= P3_r[10];
            P4_r[7] <= P3_r[12];
            
            // loop 5
            FA_S1_l5_r[0] <= FA_S1_l4_r[0];
            FA_S1_l5_r[1] <= FA_S1_l4_r[1];
            
            FA_C1_l5_r <= FA_C1_l4_r[1];
            
            FA_S2_l5_r[0] <= FA_S2_l4_r[1];
            FA_S2_l5_r[1] <= FA_S2_l4_r[2];
            FA_S2_l5_r[2] <= FA_S2_l4_r[3];

            FA_C2_l5_r[0] <= FA_C2_l4_r[4];
            FA_C2_l5_r[1] <= FA_C2_l4_r[5];
            FA_C2_l5_r[2] <= FA_C2_l4_r[6];
            
            FA_S3_l5_r[0] <= FA_S3_l4_r[4];
            FA_S3_l5_r[1] <= FA_S3_l4_r[5];
            FA_S3_l5_r[2] <= FA_S3_l4_r[6];
            FA_S3_l5_r[3] <= FA_S3_l4_r[7];
           
            FA_C3_l5_r[0] <= FA_C3_l4_r[11];
            FA_C3_l5_r[1] <= FA_C3_l4_r[12];

            FA_S4_l5_r[0] <= FA_S4_l4_r[5];
            FA_S4_l5_r[1] <= FA_S4_l4_r[34];
            FA_S4_l5_r[2] <= FA_S4_l4_r[35];
            FA_S4_l5_r[3] <= FA_S4_l4_r[36];
            FA_S4_l5_r[4] <= FA_S4_l4_r[0];
            FA_S4_l5_r[5] <= FA_S4_l4_r[1];

            FA_C4_l5_r[0] <= FA_C4_l4_r[6];
            FA_C4_l5_r[1] <= FA_C4_l4_r[38];
            FA_C4_l5_r[2] <= FA_C4_l4_r[39];
            FA_C4_l5_r[3] <= FA_C4_l4_r[40];
            FA_C4_l5_r[4] <= FA_C4_l4_r[41];
            FA_C4_l5_r[5] <= FA_C4_l4_r[42];
            FA_C4_l5_r[6] <= FA_C4_l4_r[43];
            FA_C4_l5_r[7] <= FA_C4_l4_r[44];
            FA_C4_l5_r[8] <= FA_C4_l4_r[52];
            FA_C4_l5_r[9] <= FA_C4_l4_r[53];
            FA_C4_l5_r[10] <= FA_C4_l4_r[54];
            FA_C4_l5_r[11] <= FA_C4_l4_r[55];
            FA_C4_l5_r[12] <= FA_C4_l4_r[35];
            FA_C4_l5_r[13] <= FA_C4_l4_r[36];
            FA_C4_l5_r[14] <= FA_C4_l4_r[0];
            FA_C4_l5_r[15] <= FA_C4_l4_r[1];

            HA_S1_l5_r <= HA_S1_l4_r;
            HA_S2_l5_r <= HA_S2_l4_r;
            HA_S3_l5_r <= HA_S3_l4_r;
            HA_S4_l5_r <= HA_S4_l4_r;

            for (i = 0; i < 37; i = i + 1) begin
                FA_S5_l5_r[i] <= FA_S5[i];
                FA_C5_l5_r[i] <= FA_C5[i];
            end

            for (i = 0; i < 4; i = i + 1) begin
                HA_S5_l5_r[i] <= HA_S5[i];
                HA_C5_l5_r[i] <= HA_C5[i];
            end
            
            P5_r[0] <= P4_r[0];
            P5_r[1] <= P4_r[3];
            P5_r[2] <= P4_r[7];
            
            // loop 6
            FA_S1_l6_r[0] <= FA_S1_l5_r[0];
            FA_S1_l6_r[1] <= FA_S1_l5_r[1];
            
            FA_S2_l6_r[0] <= FA_S2_l5_r[1];
            FA_S2_l6_r[1] <= FA_S2_l5_r[2];

            FA_C2_l6_r[0] <= FA_C2_l5_r[0];
            FA_C2_l6_r[1] <= FA_C2_l5_r[1];
            FA_C2_l6_r[2] <= FA_C2_l5_r[2];
            
            FA_S3_l6_r[0] <= FA_S3_l5_r[2];
            FA_S3_l6_r[1] <= FA_S3_l5_r[3];
           
            FA_C3_l6_r <= FA_C3_l5_r[1];

            FA_S4_l6_r[0] <= FA_S4_l5_r[1];
            FA_S4_l6_r[1] <= FA_S4_l5_r[2];
            FA_S4_l6_r[2] <= FA_S4_l5_r[3];
            FA_S4_l6_r[3] <= FA_S4_l5_r[4];
            FA_S4_l6_r[4] <= FA_S4_l5_r[5];

            FA_C4_l6_r[0] <= FA_C4_l5_r[12];
            FA_C4_l6_r[1] <= FA_C4_l5_r[13];
            FA_C4_l6_r[2] <= FA_C4_l5_r[14];
            FA_C4_l6_r[3] <= FA_C4_l5_r[15];

            FA_S5_l6_r[0] <= FA_S5_l5_r[9];
            FA_S5_l6_r[1] <= FA_S5_l5_r[27];
            FA_S5_l6_r[2] <= FA_S5_l5_r[28];
            FA_S5_l6_r[3] <= FA_S5_l5_r[29];
            FA_S5_l6_r[4] <= FA_S5_l5_r[30];
            FA_S5_l6_r[5] <= FA_S5_l5_r[31];
            FA_S5_l6_r[6] <= FA_S5_l5_r[0];
            FA_S5_l6_r[7] <= FA_S5_l5_r[1];
            FA_S5_l6_r[8] <= FA_S5_l5_r[2];
            FA_S5_l6_r[9] <= FA_S5_l5_r[3];

            FA_C5_l6_r[0] <= FA_C5_l5_r[10];
            FA_C5_l6_r[1] <= FA_C5_l5_r[28];
            FA_C5_l6_r[2] <= FA_C5_l5_r[29];
            FA_C5_l6_r[3] <= FA_C5_l5_r[30];
            FA_C5_l6_r[4] <= FA_C5_l5_r[31];
            FA_C5_l6_r[5] <= FA_C5_l5_r[33];
            FA_C5_l6_r[6] <= FA_C5_l5_r[34];
            FA_C5_l6_r[7] <= FA_C5_l5_r[35];
            FA_C5_l6_r[8] <= FA_C5_l5_r[36];
            FA_C5_l6_r[9] <= FA_C5_l5_r[0];
            FA_C5_l6_r[10] <= FA_C5_l5_r[1];
            FA_C5_l6_r[11] <= FA_C5_l5_r[2];
            FA_C5_l6_r[12] <= FA_C5_l5_r[3];

            HA_S1_l6_r <= HA_S1_l5_r;
            HA_S2_l6_r <= HA_S2_l5_r;
            HA_S3_l6_r <= HA_S3_l5_r;
            HA_S4_l6_r <= HA_S4_l5_r;
            HA_S5_l6_r <= HA_S5_l5_r;
            for (i = 0; i < 3; i = i + 1) begin
                HA_C5_l6_r[i] <= HA_C5_l5_r[i+1];
            end

            for (i = 0; i < 24; i = i + 1) begin
                FA_S6_l6_r[i] <= FA_S6[i];
                FA_C6_l6_r[i] <= FA_C6[i];
            end

            HA_S6_l6_r <= HA_S6;
            HA_C6_l6_r <= HA_C6;
            
            P6_r[0] <= P5_r[0];
            P6_r[1] <= P5_r[2];
            
            // loop 7
            FA_S2_l7_r <= FA_S2_l6_r[1];

            FA_C2_l7_r <= FA_C2_l6_r[2];
            
            FA_S3_l7_r <= FA_S3_l6_r[1];
           
            FA_C3_l7_r <= FA_C3_l6_r;

            FA_S4_l7_r[0] <= FA_S4_l6_r[3];
            FA_S4_l7_r[1] <= FA_S4_l6_r[4];

            FA_C4_l7_r[0] <= FA_C4_l6_r[2];
            FA_C4_l7_r[1] <= FA_C4_l6_r[3];

            FA_S5_l7_r[0] <= FA_S5_l6_r[6];
            FA_S5_l7_r[1] <= FA_S5_l6_r[7];
            FA_S5_l7_r[2] <= FA_S5_l6_r[8];
            FA_S5_l7_r[3] <= FA_S5_l6_r[9];

            FA_C5_l7_r[0] <= FA_C5_l6_r[9];
            FA_C5_l7_r[1] <= FA_C5_l6_r[10];
            FA_C5_l7_r[2] <= FA_C5_l6_r[11];
            FA_C5_l7_r[3] <= FA_C5_l6_r[12];
    
            FA_S6_l7_r[0] <= FA_S6_l6_r[0];
            FA_S6_l7_r[1] <= FA_S6_l6_r[1];
            FA_S6_l7_r[2] <= FA_S6_l6_r[2];
            FA_S6_l7_r[3] <= FA_S6_l6_r[3];
            FA_S6_l7_r[4] <= FA_S6_l6_r[4];
            FA_S6_l7_r[5] <= FA_S6_l6_r[5];
            
            FA_C6_l7_r[0] <= FA_C6_l6_r[0];
            FA_C6_l7_r[1] <= FA_C6_l6_r[1];
            FA_C6_l7_r[2] <= FA_C6_l6_r[2];
            FA_C6_l7_r[3] <= FA_C6_l6_r[3];
            FA_C6_l7_r[4] <= FA_C6_l6_r[4];
            FA_C6_l7_r[5] <= FA_C6_l6_r[5];

            HA_S1_l7_r <= HA_S1_l6_r;
            HA_S2_l7_r <= HA_S2_l6_r;
            HA_S3_l7_r <= HA_S3_l6_r;
            HA_S4_l7_r <= HA_S4_l6_r;
            HA_S5_l7_r <= HA_S5_l6_r;
            HA_S6_l7_r <= HA_S6_l6_r;

            for (i = 0; i < 12; i = i + 1) begin
                FA_S7_l7_r[i] <= FA_S7[i];
                FA_C7_l7_r[i] <= FA_C7[i];
            end
            
            for (i = 0; i < 15; i = i + 1) begin
                HA_S7_l7_r[i] <= HA_S7[i];
                HA_C7_l7_r[i] <= HA_C7[i];
            end
            
            P7_r[0] <= P6_r[0];
            P7_r[1] <= P6_r[1];
        end
    end

endmodule
