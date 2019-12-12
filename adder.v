module FA(
    input   A,
    input   B,
    input   Cin,
    output  S,
    output  Cout);

    wire    M;
    wire    T0, T1;

    xor2$    x0(M, A, B);
    xor2$    x1(S, M, Cin);
    nand2$   n0(T0, A, B);
    nand2$   n1(T1, M, Cin);
    nand2$   n2(Cout, T0, T1);

endmodule

module HA(
    input   A,
    input   B,
    output  S,
    output  C);

    or2$    o0(S, A, B);
    and2$   a0(C, A, B);
    //assign  S = A ^ B;
    //assign  C = A & B;

endmodule

module GP(
    input   A,
    input   B,
    output  G,
    output  P);

    and2$   a0(G, A, B);
    xor2$   x0(P, A, B);

endmodule

module Processor(
    input   g0,
    input   g1,
    input   p0,
    input   p1,
    output  go,
    output  po);

    wire    M, N, T;

    nand2$  n0(M, p0, g1);
    inv1$   i0(N, g0);
    nand2$  n1(go, M, N);
    nand2$  n2(T, p0, p1);
    inv1$   i1(po, T);

endmodule

module a1_adder(
    input   [2:0]   A,
    output  [2:0]   B);

    wire    I, T0, T1, T2;

    inv1$   i0(B[0], A[0]);
    xor2$   x0(B[1], A[1], A[0]);
    inv1$   i1(I, A[2]);
    nand3$  n1(T0, I, A[1], A[0]);
    nand2$  n2(T1, A[1], A[0]);
    nand2$  n3(T2, A[2], T1);
    nand2$  n4(B[2], T0, T2);

endmodule
