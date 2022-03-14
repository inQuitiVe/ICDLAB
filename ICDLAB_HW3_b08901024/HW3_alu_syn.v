/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : R-2020.09-SP5
// Date      : Mon Mar  7 18:51:59 2022
/////////////////////////////////////////////////////////////


module alu_DW_mult_uns_0 ( a, b, product );
  input [15:0] a;
  input [15:0] b;
  output [31:0] product;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n30,
         n31, n35, n56, n57, n58, n59, n61, n63, n65, n80, n81, n82, n83, n84,
         n85, n87, n89, n91, n95, n97, n102, n103, n104, n105, n107, n108,
         n109, n110, n111, n114, n115, n117, n122, n123, n124, n125, n126,
         n127, n129, n132, n133, n134, n135, n137, n140, n141, n142, n143,
         n144, n145, n146, n147, n148, n149, n150, n151, n153, n156, n157,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n167, n169,
         n170, n171, n172, n173, n174, n175, n176, n177, n178, n179, n180,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191,
         n192, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202,
         n203, n204, n205, n206, n207, n208, n209, n210, n211, n252, n256,
         n261, n262, n263, n264, n265, n266, n271, n272, n273, n274, n275,
         n276, n277, n282, n283, n284, n285, n286, n287, n288, n289, n295,
         n296, n297, n298, n299, n300, n301, n302, n309, n310, n311, n312,
         n313, n314, n315, n316, n324, n325, n326, n327, n328, n329, n330,
         n331, n340, n341, n342, n343, n344, n345, n346, n447, n448, n449,
         n450, n451, n452, n453, n454, n455, n456, n457, n458, n459, n460,
         n461, n462, n463, n464, n465, n466, n467, n468, n469, n470, n471,
         n472, n473, n474, n475, n476, n477, n478, n479;

  FA1S U3 ( .A(n56), .B(n31), .CI(n3), .CO(n2), .S(product[14]) );
  FA1S U4 ( .A(n80), .B(n57), .CI(n4), .CO(n3), .S(product[13]) );
  FA1S U5 ( .A(n102), .B(n81), .CI(n5), .CO(n4), .S(product[12]) );
  FA1S U6 ( .A(n122), .B(n103), .CI(n6), .CO(n5), .S(product[11]) );
  FA1S U7 ( .A(n140), .B(n123), .CI(n7), .CO(n6), .S(product[10]) );
  FA1S U8 ( .A(n156), .B(n141), .CI(n8), .CO(n7), .S(product[9]) );
  FA1S U9 ( .A(n170), .B(n157), .CI(n9), .CO(n8), .S(product[8]) );
  FA1S U10 ( .A(n182), .B(n171), .CI(n10), .CO(n9), .S(product[7]) );
  FA1S U11 ( .A(n192), .B(n183), .CI(n11), .CO(n10), .S(product[6]) );
  FA1S U12 ( .A(n200), .B(n193), .CI(n12), .CO(n11), .S(product[5]) );
  FA1S U13 ( .A(n206), .B(n201), .CI(n13), .CO(n12), .S(product[4]) );
  FA1S U14 ( .A(n209), .B(n14), .CI(n207), .CO(n13), .S(product[3]) );
  FA1S U15 ( .A(n316), .B(n15), .CI(n211), .CO(n14), .S(product[2]) );
  HA1 U16 ( .A(n331), .B(n346), .C(n15), .S(product[1]) );
  FA1S U44 ( .A(n61), .B(n82), .CI(n59), .CO(n56), .S(n57) );
  FA1S U45 ( .A(n65), .B(n84), .CI(n63), .CO(n58), .S(n59) );
  FA1S U56 ( .A(n85), .B(n104), .CI(n83), .CO(n80), .S(n81) );
  FA1S U58 ( .A(n110), .B(n91), .CI(n108), .CO(n84), .S(n85) );
  FA1S U60 ( .A(n114), .B(n95), .CI(n97), .CO(n61), .S(n89) );
  FA1S U67 ( .A(n124), .B(n107), .CI(n105), .CO(n102), .S(n103) );
  FA1S U68 ( .A(n111), .B(n109), .CI(n126), .CO(n104), .S(n105) );
  FA1S U77 ( .A(n142), .B(n127), .CI(n125), .CO(n122), .S(n123) );
  FA1S U79 ( .A(n137), .B(n148), .CI(n146), .CO(n126), .S(n127) );
  FA1S U80 ( .A(n150), .B(n133), .CI(n135), .CO(n107), .S(n129) );
  FA1S U86 ( .A(n145), .B(n158), .CI(n143), .CO(n140), .S(n141) );
  FA1S U87 ( .A(n149), .B(n160), .CI(n147), .CO(n142), .S(n143) );
  FA1S U88 ( .A(n151), .B(n153), .CI(n162), .CO(n144), .S(n145) );
  FA1S U91 ( .A(n273), .B(n263), .CI(n284), .CO(n150), .S(n151) );
  FA1S U94 ( .A(n172), .B(n161), .CI(n159), .CO(n156), .S(n157) );
  FA1S U95 ( .A(n167), .B(n163), .CI(n174), .CO(n158), .S(n159) );
  FA1S U96 ( .A(n178), .B(n176), .CI(n165), .CO(n160), .S(n161) );
  FA1S U97 ( .A(n297), .B(n180), .CI(n169), .CO(n162), .S(n163) );
  FA1S U98 ( .A(n285), .B(n310), .CI(n274), .CO(n164), .S(n165) );
  FA1S U101 ( .A(n184), .B(n175), .CI(n173), .CO(n170), .S(n171) );
  FA1S U102 ( .A(n177), .B(n179), .CI(n186), .CO(n172), .S(n173) );
  FA1S U103 ( .A(n190), .B(n181), .CI(n188), .CO(n174), .S(n175) );
  FA1S U104 ( .A(n311), .B(n286), .CI(n298), .CO(n176), .S(n177) );
  FA1S U105 ( .A(n340), .B(n275), .CI(n325), .CO(n178), .S(n179) );
  HA1 U106 ( .A(n265), .B(n256), .C(n180), .S(n181) );
  FA1S U107 ( .A(n194), .B(n187), .CI(n185), .CO(n182), .S(n183) );
  FA1S U108 ( .A(n191), .B(n196), .CI(n189), .CO(n184), .S(n185) );
  FA1S U109 ( .A(n312), .B(n299), .CI(n198), .CO(n186), .S(n187) );
  FA1S U110 ( .A(n341), .B(n287), .CI(n326), .CO(n188), .S(n189) );
  HA1 U111 ( .A(n276), .B(n266), .C(n190), .S(n191) );
  FA1S U112 ( .A(n202), .B(n197), .CI(n195), .CO(n192), .S(n193) );
  FA1S U113 ( .A(n327), .B(n204), .CI(n199), .CO(n194), .S(n195) );
  FA1S U114 ( .A(n342), .B(n300), .CI(n313), .CO(n196), .S(n197) );
  HA1 U115 ( .A(n288), .B(n277), .C(n198), .S(n199) );
  FA1S U116 ( .A(n208), .B(n205), .CI(n203), .CO(n200), .S(n201) );
  FA1S U117 ( .A(n343), .B(n314), .CI(n328), .CO(n202), .S(n203) );
  HA1 U118 ( .A(n301), .B(n289), .C(n204), .S(n205) );
  FA1S U119 ( .A(n344), .B(n329), .CI(n210), .CO(n206), .S(n207) );
  HA1 U120 ( .A(n315), .B(n302), .C(n208), .S(n209) );
  HA1 U121 ( .A(n345), .B(n330), .C(n210), .S(n211) );
  INV1S U292 ( .I(a[0]), .O(n447) );
  INV1S U293 ( .I(b[2]), .O(n448) );
  INV1S U294 ( .I(b[2]), .O(n449) );
  INV1S U295 ( .I(a[1]), .O(n450) );
  INV1S U296 ( .I(b[1]), .O(n451) );
  INV1S U297 ( .I(b[1]), .O(n452) );
  INV1S U298 ( .I(n479), .O(n453) );
  INV1S U299 ( .I(n453), .O(n454) );
  INV1S U300 ( .I(b[4]), .O(n455) );
  INV1S U301 ( .I(b[4]), .O(n456) );
  INV1S U302 ( .I(a[2]), .O(n457) );
  INV1S U303 ( .I(a[4]), .O(n458) );
  INV1S U304 ( .I(b[3]), .O(n459) );
  INV1S U305 ( .I(b[3]), .O(n460) );
  INV1S U306 ( .I(a[5]), .O(n461) );
  INV1S U307 ( .I(a[3]), .O(n462) );
  INV1S U308 ( .I(b[6]), .O(n463) );
  INV1S U309 ( .I(b[6]), .O(n464) );
  INV1S U310 ( .I(b[5]), .O(n465) );
  INV1S U311 ( .I(b[5]), .O(n466) );
  INV1S U312 ( .I(a[6]), .O(n467) );
  INV1S U313 ( .I(b[7]), .O(n468) );
  INV1S U314 ( .I(b[7]), .O(n469) );
  INV1S U315 ( .I(a[7]), .O(n470) );
  INV1S U316 ( .I(a[0]), .O(n478) );
  INV1S U317 ( .I(a[1]), .O(n477) );
  INV1S U318 ( .I(b[0]), .O(n479) );
  INV1S U319 ( .I(a[2]), .O(n476) );
  INV1S U320 ( .I(a[4]), .O(n474) );
  INV1S U321 ( .I(a[5]), .O(n473) );
  INV1S U322 ( .I(a[3]), .O(n475) );
  INV1S U323 ( .I(a[6]), .O(n472) );
  INV1S U324 ( .I(a[7]), .O(n471) );
  XOR2HS U325 ( .I1(n30), .I2(n2), .O(product[15]) );
  AN2 U326 ( .I1(n144), .I2(n129), .O(n124) );
  XOR2HS U327 ( .I1(n144), .I2(n129), .O(n125) );
  AN2 U328 ( .I1(n166), .I2(n164), .O(n146) );
  XOR2HS U329 ( .I1(n166), .I2(n164), .O(n147) );
  AN2 U330 ( .I1(n264), .I2(n324), .O(n166) );
  XOR2HS U331 ( .I1(n264), .I2(n324), .O(n167) );
  AN2 U332 ( .I1(n296), .I2(n309), .O(n148) );
  XOR2HS U333 ( .I1(n296), .I2(n309), .O(n149) );
  AN2 U334 ( .I1(n87), .I2(n89), .O(n82) );
  XOR2HS U335 ( .I1(n87), .I2(n89), .O(n83) );
  AN2 U336 ( .I1(n58), .I2(n35), .O(n30) );
  XOR2HS U337 ( .I1(n58), .I2(n35), .O(n31) );
  AN2 U338 ( .I1(n115), .I2(n117), .O(n108) );
  XOR2HS U339 ( .I1(n115), .I2(n117), .O(n109) );
  AN2 U340 ( .I1(n132), .I2(n134), .O(n110) );
  XOR2HS U341 ( .I1(n132), .I2(n134), .O(n111) );
  AN2 U342 ( .I1(n283), .I2(n262), .O(n134) );
  XOR2HS U343 ( .I1(n283), .I2(n262), .O(n135) );
  AN2 U344 ( .I1(n272), .I2(n295), .O(n132) );
  XOR2HS U345 ( .I1(n272), .I2(n295), .O(n133) );
  AN2 U346 ( .I1(n271), .I2(n282), .O(n114) );
  XOR2HS U347 ( .I1(n271), .I2(n282), .O(n115) );
  AN2 U348 ( .I1(n261), .I2(n252), .O(n91) );
  XOR2HS U349 ( .I1(n261), .I2(n252), .O(n117) );
  NR2 U350 ( .I1(n454), .I2(n447), .O(product[0]) );
  NR2 U351 ( .I1(n451), .I2(n478), .O(n346) );
  NR2 U352 ( .I1(n478), .I2(n448), .O(n345) );
  NR2 U353 ( .I1(n447), .I2(n459), .O(n344) );
  NR2 U354 ( .I1(n455), .I2(n447), .O(n343) );
  NR2 U355 ( .I1(n465), .I2(n447), .O(n342) );
  NR2 U356 ( .I1(n463), .I2(n447), .O(n341) );
  NR2 U357 ( .I1(n447), .I2(n468), .O(n340) );
  NR2 U358 ( .I1(n479), .I2(n477), .O(n331) );
  NR2 U359 ( .I1(n451), .I2(n477), .O(n330) );
  NR2 U360 ( .I1(n449), .I2(n450), .O(n329) );
  NR2 U361 ( .I1(n450), .I2(n459), .O(n328) );
  NR2 U362 ( .I1(n455), .I2(n450), .O(n327) );
  NR2 U363 ( .I1(n465), .I2(n450), .O(n326) );
  NR2 U364 ( .I1(n463), .I2(n450), .O(n325) );
  NR2 U365 ( .I1(n450), .I2(n468), .O(n324) );
  NR2 U366 ( .I1(n479), .I2(n476), .O(n316) );
  NR2 U367 ( .I1(n452), .I2(n457), .O(n315) );
  NR2 U368 ( .I1(n448), .I2(n476), .O(n314) );
  NR2 U369 ( .I1(n460), .I2(n457), .O(n313) );
  NR2 U370 ( .I1(n456), .I2(n457), .O(n312) );
  NR2 U371 ( .I1(n466), .I2(n457), .O(n311) );
  NR2 U372 ( .I1(n464), .I2(n457), .O(n310) );
  NR2 U373 ( .I1(n469), .I2(n457), .O(n309) );
  NR2 U374 ( .I1(n454), .I2(n475), .O(n302) );
  NR2 U375 ( .I1(n452), .I2(n475), .O(n301) );
  NR2 U376 ( .I1(n449), .I2(n462), .O(n300) );
  NR2 U377 ( .I1(n462), .I2(n460), .O(n299) );
  NR2 U378 ( .I1(n456), .I2(n462), .O(n298) );
  NR2 U379 ( .I1(n466), .I2(n462), .O(n297) );
  NR2 U380 ( .I1(n464), .I2(n462), .O(n296) );
  NR2 U381 ( .I1(n462), .I2(n469), .O(n295) );
  NR2 U382 ( .I1(n454), .I2(n474), .O(n289) );
  NR2 U383 ( .I1(n452), .I2(n474), .O(n288) );
  NR2 U384 ( .I1(n449), .I2(n458), .O(n287) );
  NR2 U385 ( .I1(n458), .I2(n460), .O(n286) );
  NR2 U386 ( .I1(n456), .I2(n458), .O(n285) );
  NR2 U387 ( .I1(n466), .I2(n458), .O(n284) );
  NR2 U388 ( .I1(n464), .I2(n458), .O(n283) );
  NR2 U389 ( .I1(n469), .I2(n458), .O(n282) );
  NR2 U390 ( .I1(n454), .I2(n461), .O(n277) );
  NR2 U391 ( .I1(n452), .I2(n461), .O(n276) );
  NR2 U392 ( .I1(n449), .I2(n461), .O(n275) );
  NR2 U393 ( .I1(n473), .I2(n460), .O(n274) );
  NR2 U394 ( .I1(n456), .I2(n473), .O(n273) );
  NR2 U395 ( .I1(n466), .I2(n473), .O(n272) );
  NR2 U396 ( .I1(n464), .I2(n473), .O(n271) );
  NR2 U397 ( .I1(n469), .I2(n473), .O(n87) );
  NR2 U398 ( .I1(n454), .I2(n467), .O(n266) );
  NR2 U399 ( .I1(n452), .I2(n467), .O(n265) );
  NR2 U400 ( .I1(n449), .I2(n467), .O(n264) );
  NR2 U401 ( .I1(n472), .I2(n460), .O(n263) );
  NR2 U402 ( .I1(n456), .I2(n472), .O(n262) );
  NR2 U403 ( .I1(n466), .I2(n472), .O(n261) );
  NR2 U404 ( .I1(n464), .I2(n472), .O(n97) );
  NR2 U405 ( .I1(n472), .I2(n469), .O(n65) );
  NR2 U406 ( .I1(n454), .I2(n470), .O(n256) );
  NR2 U407 ( .I1(n452), .I2(n470), .O(n169) );
  NR2 U408 ( .I1(n449), .I2(n470), .O(n153) );
  NR2 U409 ( .I1(n471), .I2(n460), .O(n137) );
  NR2 U410 ( .I1(n456), .I2(n471), .O(n252) );
  NR2 U411 ( .I1(n466), .I2(n471), .O(n95) );
  NR2 U412 ( .I1(n464), .I2(n471), .O(n63) );
  NR2 U413 ( .I1(n471), .I2(n469), .O(n35) );
endmodule


module alu ( clk_p_i, reset_n_i, data_a_i, data_b_i, inst_i, data_o );
  input [7:0] data_a_i;
  input [7:0] data_b_i;
  input [2:0] inst_i;
  output [15:0] data_o;
  input clk_p_i, reset_n_i;
  wire   \data_a[0] , N46, N47, N48, N49, N50, N51, N52, N53, N60, n10, n11,
         n12, n13, n14, n15, n17, n18, n20, n21, n24, n25, n26, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n43, n44, n45,
         n46, n47, n48, n50, n51, n52, n53, n54, n55, n57, n58, n59, n60, n61,
         n62, n64, n65, n66, n67, n68, n69, n71, n72, n73, n74, n75, n76, n78,
         n79, n81, n82, n83, n84, n85, n88, n91, n92, n93, n94, n95, n97, n100,
         n101, n102, n103, n104, n105, n106, n107, n109, n110, n111, n113,
         n114, n115, n116, n117, n118, n119, n120, n121, n122, n123, n124,
         n125, n126, n127, n128, n129, n130, n131, n132, n133, n134, n135,
         n136, n137, n138, n139, N44, N43, N42, N41, N40, N39, N38, N37, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187;
  wire   [15:0] data_b;
  wire   [15:0] out1;
  wire   [15:0] out2;
  wire   [15:0] out3;
  wire   [14:0] out4;
  wire   [2:0] state_r;
  wire   [16:0] \sub_38/carry ;
  wire   [15:1] \add_37/carry ;
  wire   [15:2] \add_0_root_add_43_ni/carry ;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15;

  AO112 U13 ( .C1(data_o[10]), .C2(n152), .A1(n25), .B1(n26), .O(n122) );
  AO112 U16 ( .C1(data_o[11]), .C2(n24), .A1(n29), .B1(n30), .O(n123) );
  AO112 U19 ( .C1(data_o[12]), .C2(n153), .A1(n31), .B1(n32), .O(n124) );
  AO112 U22 ( .C1(data_o[13]), .C2(n152), .A1(n33), .B1(n34), .O(n125) );
  AO112 U25 ( .C1(data_o[14]), .C2(n24), .A1(n35), .B1(n36), .O(n126) );
  OA222 U84 ( .A1(n28), .A2(out2[7]), .B1(n176), .B2(n88), .C1(n187), .C2(n183), .O(n82) );
  AO112 U87 ( .C1(data_o[8]), .C2(n153), .A1(n91), .B1(n92), .O(n134) );
  AO222 U88 ( .A1(out1[8]), .A2(n143), .B1(n156), .B2(n177), .C1(out3[8]), 
        .C2(n21), .O(n92) );
  AO112 U90 ( .C1(data_o[9]), .C2(n152), .A1(n93), .B1(n94), .O(n135) );
  ND2 U93 ( .I1(n95), .I2(n183), .O(n15) );
  AO112 U96 ( .C1(data_o[15]), .C2(n24), .A1(n31), .B1(n100), .O(n136) );
  ND2 U100 ( .I1(state_r[0]), .I2(n183), .O(n79) );
  OA13S U115 ( .B1(inst_i[0]), .B2(inst_i[2]), .B3(n184), .A1(state_r[2]), .O(
        n115) );
  AO12 U130 ( .B1(inst_i[1]), .B2(state_r[1]), .A1(inst_i[2]), .O(n120) );
  ND2 U132 ( .I1(n141), .I2(n186), .O(n97) );
  alu_DW_mult_uns_0 mult_39 ( .a({n140, n140, n140, n140, n140, n140, n140, 
        n140, out4[6:0], \data_a[0] }), .b({n140, n140, n140, n140, n140, n140, 
        n140, n140, data_b[7:0]}), .product({SYNOPSYS_UNCONNECTED__0, 
        SYNOPSYS_UNCONNECTED__1, SYNOPSYS_UNCONNECTED__2, 
        SYNOPSYS_UNCONNECTED__3, SYNOPSYS_UNCONNECTED__4, 
        SYNOPSYS_UNCONNECTED__5, SYNOPSYS_UNCONNECTED__6, 
        SYNOPSYS_UNCONNECTED__7, SYNOPSYS_UNCONNECTED__8, 
        SYNOPSYS_UNCONNECTED__9, SYNOPSYS_UNCONNECTED__10, 
        SYNOPSYS_UNCONNECTED__11, SYNOPSYS_UNCONNECTED__12, 
        SYNOPSYS_UNCONNECTED__13, SYNOPSYS_UNCONNECTED__14, 
        SYNOPSYS_UNCONNECTED__15, out3}) );
  HA1 \add_0_root_add_43_ni/U1_1_1  ( .A(N43), .B(N44), .C(
        \add_0_root_add_43_ni/carry [2]), .S(N46) );
  HA1 \add_0_root_add_43_ni/U1_1_2  ( .A(N42), .B(
        \add_0_root_add_43_ni/carry [2]), .C(\add_0_root_add_43_ni/carry [3]), 
        .S(N47) );
  HA1 \add_0_root_add_43_ni/U1_1_3  ( .A(N41), .B(
        \add_0_root_add_43_ni/carry [3]), .C(\add_0_root_add_43_ni/carry [4]), 
        .S(N48) );
  HA1 \add_0_root_add_43_ni/U1_1_4  ( .A(N40), .B(
        \add_0_root_add_43_ni/carry [4]), .C(\add_0_root_add_43_ni/carry [5]), 
        .S(N49) );
  HA1 \add_0_root_add_43_ni/U1_1_5  ( .A(N39), .B(
        \add_0_root_add_43_ni/carry [5]), .C(\add_0_root_add_43_ni/carry [6]), 
        .S(N50) );
  HA1 \add_0_root_add_43_ni/U1_1_6  ( .A(N38), .B(
        \add_0_root_add_43_ni/carry [6]), .C(\add_0_root_add_43_ni/carry [7]), 
        .S(N51) );
  HA1 \add_0_root_add_43_ni/U1_1_7  ( .A(N37), .B(
        \add_0_root_add_43_ni/carry [7]), .C(\add_0_root_add_43_ni/carry [8]), 
        .S(N52) );
  QDFFRBN \state_r_reg[0]  ( .D(n139), .CK(clk_p_i), .RB(n165), .Q(state_r[0])
         );
  QDFFRBN \state_r_reg[2]  ( .D(n137), .CK(clk_p_i), .RB(n166), .Q(state_r[2])
         );
  QDFFRBN \state_r_reg[1]  ( .D(n138), .CK(clk_p_i), .RB(n165), .Q(state_r[1])
         );
  QDFFRBN \data_a_reg[7]  ( .D(data_a_i[7]), .CK(clk_p_i), .RB(n163), .Q(
        out4[6]) );
  QDFFRBN \data_b_reg[7]  ( .D(data_b_i[7]), .CK(clk_p_i), .RB(n164), .Q(
        data_b[7]) );
  QDFFRBN \data_a_reg[6]  ( .D(data_a_i[6]), .CK(clk_p_i), .RB(n163), .Q(
        out4[5]) );
  QDFFRBN \data_b_reg[5]  ( .D(data_b_i[5]), .CK(clk_p_i), .RB(n164), .Q(
        data_b[5]) );
  QDFFRBN \data_b_reg[6]  ( .D(data_b_i[6]), .CK(clk_p_i), .RB(n164), .Q(
        data_b[6]) );
  QDFFRBN \data_a_reg[3]  ( .D(data_a_i[3]), .CK(clk_p_i), .RB(n163), .Q(
        out4[2]) );
  QDFFRBN \data_a_reg[5]  ( .D(data_a_i[5]), .CK(clk_p_i), .RB(n163), .Q(
        out4[4]) );
  QDFFRBN \data_b_reg[3]  ( .D(data_b_i[3]), .CK(clk_p_i), .RB(n165), .Q(
        data_b[3]) );
  QDFFRBN \data_a_reg[4]  ( .D(data_a_i[4]), .CK(clk_p_i), .RB(n163), .Q(
        out4[3]) );
  QDFFRBN \data_a_reg[2]  ( .D(data_a_i[2]), .CK(clk_p_i), .RB(n163), .Q(
        out4[1]) );
  QDFFRBN \data_b_reg[4]  ( .D(data_b_i[4]), .CK(clk_p_i), .RB(n164), .Q(
        data_b[4]) );
  QDFFRBN \data_b_reg[0]  ( .D(data_b_i[0]), .CK(clk_p_i), .RB(n165), .Q(
        data_b[0]) );
  QDFFRBN \data_b_reg[1]  ( .D(data_b_i[1]), .CK(clk_p_i), .RB(n165), .Q(
        data_b[1]) );
  QDFFRBN \data_a_reg[1]  ( .D(data_a_i[1]), .CK(clk_p_i), .RB(n164), .Q(
        out4[0]) );
  QDFFRBN \data_b_reg[2]  ( .D(data_b_i[2]), .CK(clk_p_i), .RB(n165), .Q(
        data_b[2]) );
  QDFFRBN \data_a_reg[0]  ( .D(data_a_i[0]), .CK(clk_p_i), .RB(n164), .Q(
        \data_a[0] ) );
  QDFFRBT \out_r_reg[0]  ( .D(n121), .CK(clk_p_i), .RB(reset_n_i), .Q(
        data_o[0]) );
  QDFFRBT \out_r_reg[1]  ( .D(n127), .CK(clk_p_i), .RB(n167), .Q(data_o[1]) );
  QDFFRBT \out_r_reg[2]  ( .D(n128), .CK(clk_p_i), .RB(n167), .Q(data_o[2]) );
  QDFFRBT \out_r_reg[3]  ( .D(n129), .CK(clk_p_i), .RB(n167), .Q(data_o[3]) );
  QDFFRBT \out_r_reg[4]  ( .D(n130), .CK(clk_p_i), .RB(n167), .Q(data_o[4]) );
  QDFFRBT \out_r_reg[5]  ( .D(n131), .CK(clk_p_i), .RB(n167), .Q(data_o[5]) );
  QDFFRBT \out_r_reg[6]  ( .D(n132), .CK(clk_p_i), .RB(n166), .Q(data_o[6]) );
  QDFFRBT \out_r_reg[10]  ( .D(n122), .CK(clk_p_i), .RB(reset_n_i), .Q(
        data_o[10]) );
  QDFFRBT \out_r_reg[11]  ( .D(n123), .CK(clk_p_i), .RB(reset_n_i), .Q(
        data_o[11]) );
  QDFFRBT \out_r_reg[12]  ( .D(n124), .CK(clk_p_i), .RB(reset_n_i), .Q(
        data_o[12]) );
  QDFFRBT \out_r_reg[13]  ( .D(n125), .CK(clk_p_i), .RB(reset_n_i), .Q(
        data_o[13]) );
  QDFFRBT \out_r_reg[14]  ( .D(n126), .CK(clk_p_i), .RB(n167), .Q(data_o[14])
         );
  QDFFRBT \out_r_reg[8]  ( .D(n134), .CK(clk_p_i), .RB(n166), .Q(data_o[8]) );
  QDFFRBT \out_r_reg[9]  ( .D(n135), .CK(clk_p_i), .RB(n166), .Q(data_o[9]) );
  QDFFRBT \out_r_reg[15]  ( .D(n136), .CK(clk_p_i), .RB(n166), .Q(data_o[15])
         );
  QDFFRBT \out_r_reg[7]  ( .D(n133), .CK(clk_p_i), .RB(n166), .Q(data_o[7]) );
  TIE0 U151 ( .O(n140) );
  AN2 U152 ( .I1(state_r[2]), .I2(state_r[1]), .O(n103) );
  ND2 U153 ( .I1(state_r[0]), .I2(n103), .O(n159) );
  INV1S U154 ( .I(state_r[1]), .O(n141) );
  INV1S U155 ( .I(n15), .O(n142) );
  ND2 U156 ( .I1(n102), .I2(n141), .O(n17) );
  INV1S U157 ( .I(n17), .O(n143) );
  INV1S U158 ( .I(n17), .O(n144) );
  INV1S U159 ( .I(n28), .O(n161) );
  INV1S U160 ( .I(n161), .O(n145) );
  ND2 U161 ( .I1(n95), .I2(n183), .O(n146) );
  INV1S U162 ( .I(n88), .O(n147) );
  INV1S U163 ( .I(n88), .O(n148) );
  INV1S U164 ( .I(state_r[0]), .O(n149) );
  INV1S U165 ( .I(n21), .O(n162) );
  INV1S U166 ( .I(n162), .O(n150) );
  INV1S U167 ( .I(n162), .O(n151) );
  INV1S U168 ( .I(n159), .O(n152) );
  INV1S U169 ( .I(n159), .O(n153) );
  BUF1CK U170 ( .I(n20), .O(n154) );
  INV1S U171 ( .I(\sub_38/carry [8]), .O(n155) );
  INV1S U172 ( .I(\sub_38/carry [8]), .O(n156) );
  INV1S U173 ( .I(\sub_38/carry [8]), .O(n157) );
  INV1S U174 ( .I(n81), .O(n158) );
  INV1S U175 ( .I(n88), .O(n178) );
  INV1S U176 ( .I(n15), .O(n177) );
  ND3 U177 ( .I1(n103), .I2(n183), .I3(n157), .O(n88) );
  INV1S U178 ( .I(N52), .O(n176) );
  INV1S U179 ( .I(n103), .O(n185) );
  INV1S U180 ( .I(n24), .O(n183) );
  INV1S U181 ( .I(n81), .O(n182) );
  OAI22S U182 ( .A1(n155), .A2(n185), .B1(n97), .B2(n184), .O(n95) );
  ND3 U183 ( .I1(n82), .I2(n83), .I3(n84), .O(n133) );
  AOI22S U184 ( .A1(out1[7]), .A2(n144), .B1(out3[7]), .B2(n150), .O(n84) );
  AOI22S U185 ( .A1(n81), .A2(n85), .B1(out2[7]), .B2(n142), .O(n83) );
  INV1S U186 ( .I(out2[7]), .O(N37) );
  MOAI1S U187 ( .A1(n146), .A2(N43), .B1(out1[1]), .B2(n144), .O(n41) );
  MOAI1S U188 ( .A1(n15), .A2(N42), .B1(out1[2]), .B2(n143), .O(n48) );
  MOAI1S U189 ( .A1(n146), .A2(N41), .B1(out1[3]), .B2(n144), .O(n55) );
  MOAI1S U190 ( .A1(n15), .A2(N40), .B1(out1[4]), .B2(n143), .O(n62) );
  MOAI1S U191 ( .A1(n146), .A2(N39), .B1(out1[5]), .B2(n144), .O(n69) );
  MOAI1S U192 ( .A1(n15), .A2(N38), .B1(out1[6]), .B2(n144), .O(n76) );
  INV1S U193 ( .I(out2[6]), .O(N38) );
  INV1S U194 ( .I(out2[5]), .O(N39) );
  INV1S U195 ( .I(out2[4]), .O(N40) );
  INV1S U196 ( .I(out2[3]), .O(N41) );
  INV1S U197 ( .I(out2[2]), .O(N42) );
  INV1S U198 ( .I(out2[1]), .O(N43) );
  INV1S U199 ( .I(n159), .O(n24) );
  MOAI1S U200 ( .A1(n184), .A2(n179), .B1(n184), .B2(n109), .O(n107) );
  OAI12HS U201 ( .B1(n109), .B2(n185), .A1(n105), .O(n110) );
  NR2 U202 ( .I1(n79), .I2(n186), .O(n81) );
  NR2 U203 ( .I1(n79), .I2(n141), .O(n20) );
  INV1S U204 ( .I(n145), .O(n181) );
  BUF1CK U205 ( .I(n160), .O(n167) );
  BUF1CK U206 ( .I(n160), .O(n166) );
  BUF1CK U207 ( .I(n160), .O(n165) );
  BUF1CK U208 ( .I(n160), .O(n164) );
  BUF1CK U209 ( .I(n160), .O(n163) );
  NR2 U210 ( .I1(n79), .I2(n97), .O(n101) );
  MOAI1S U211 ( .A1(n156), .A2(n145), .B1(N60), .B2(n147), .O(n35) );
  MOAI1S U212 ( .A1(n157), .A2(n145), .B1(N60), .B2(n178), .O(n33) );
  MOAI1S U213 ( .A1(n155), .A2(n28), .B1(N60), .B2(n178), .O(n31) );
  MOAI1S U214 ( .A1(n156), .A2(n28), .B1(N60), .B2(n148), .O(n29) );
  MOAI1S U215 ( .A1(n157), .A2(n145), .B1(N60), .B2(n147), .O(n25) );
  FA1S U216 ( .A(data_b[7]), .B(n175), .CI(\sub_38/carry [7]), .CO(
        \sub_38/carry [8]), .S(out2[7]) );
  INV1S U217 ( .I(out4[6]), .O(n175) );
  MOAI1S U218 ( .A1(n155), .A2(n28), .B1(N53), .B2(n147), .O(n91) );
  FA1S U219 ( .A(data_b[1]), .B(n169), .CI(\sub_38/carry [1]), .CO(
        \sub_38/carry [2]), .S(out2[1]) );
  INV1S U220 ( .I(out4[0]), .O(n169) );
  FA1S U221 ( .A(data_b[2]), .B(n170), .CI(\sub_38/carry [2]), .CO(
        \sub_38/carry [3]), .S(out2[2]) );
  INV1S U222 ( .I(out4[1]), .O(n170) );
  FA1S U223 ( .A(data_b[3]), .B(n171), .CI(\sub_38/carry [3]), .CO(
        \sub_38/carry [4]), .S(out2[3]) );
  INV1S U224 ( .I(out4[2]), .O(n171) );
  FA1S U225 ( .A(data_b[4]), .B(n172), .CI(\sub_38/carry [4]), .CO(
        \sub_38/carry [5]), .S(out2[4]) );
  INV1S U226 ( .I(out4[3]), .O(n172) );
  FA1S U227 ( .A(data_b[5]), .B(n173), .CI(\sub_38/carry [5]), .CO(
        \sub_38/carry [6]), .S(out2[5]) );
  INV1S U228 ( .I(out4[4]), .O(n173) );
  FA1S U229 ( .A(data_b[6]), .B(n174), .CI(\sub_38/carry [6]), .CO(
        \sub_38/carry [7]), .S(out2[6]) );
  INV1S U230 ( .I(out4[5]), .O(n174) );
  INV1S U231 ( .I(\data_a[0] ), .O(n168) );
  MOAI1S U232 ( .A1(n156), .A2(n28), .B1(N60), .B2(n148), .O(n93) );
  MOAI1S U233 ( .A1(n146), .A2(N44), .B1(out1[0]), .B2(n144), .O(n14) );
  ND3 U234 ( .I1(n10), .I2(n11), .I3(n12), .O(n121) );
  AOI22S U235 ( .A1(n161), .A2(N44), .B1(data_o[0]), .B2(n153), .O(n10) );
  AOI22S U236 ( .A1(out3[0]), .A2(n151), .B1(out2[0]), .B2(n148), .O(n11) );
  NR2 U237 ( .I1(n13), .I2(n14), .O(n12) );
  ND3 U238 ( .I1(n37), .I2(n38), .I3(n39), .O(n127) );
  AOI22S U239 ( .A1(n181), .A2(N43), .B1(data_o[1]), .B2(n152), .O(n37) );
  AOI22S U240 ( .A1(out3[1]), .A2(n150), .B1(N46), .B2(n178), .O(n38) );
  NR2 U241 ( .I1(n40), .I2(n41), .O(n39) );
  ND3 U242 ( .I1(n44), .I2(n45), .I3(n46), .O(n128) );
  AOI22S U243 ( .A1(n181), .A2(N42), .B1(data_o[2]), .B2(n24), .O(n44) );
  AOI22S U244 ( .A1(out3[2]), .A2(n151), .B1(N47), .B2(n147), .O(n45) );
  NR2 U245 ( .I1(n47), .I2(n48), .O(n46) );
  ND3 U246 ( .I1(n51), .I2(n52), .I3(n53), .O(n129) );
  AOI22S U247 ( .A1(n181), .A2(N41), .B1(data_o[3]), .B2(n153), .O(n51) );
  AOI22S U248 ( .A1(out3[3]), .A2(n150), .B1(N48), .B2(n148), .O(n52) );
  NR2 U249 ( .I1(n54), .I2(n55), .O(n53) );
  ND3 U250 ( .I1(n58), .I2(n59), .I3(n60), .O(n130) );
  AOI22S U251 ( .A1(n181), .A2(N40), .B1(data_o[4]), .B2(n152), .O(n58) );
  AOI22S U252 ( .A1(out3[4]), .A2(n151), .B1(N49), .B2(n178), .O(n59) );
  NR2 U253 ( .I1(n61), .I2(n62), .O(n60) );
  ND3 U254 ( .I1(n65), .I2(n66), .I3(n67), .O(n131) );
  AOI22S U255 ( .A1(n181), .A2(N39), .B1(data_o[5]), .B2(n24), .O(n65) );
  AOI22S U256 ( .A1(out3[5]), .A2(n150), .B1(N50), .B2(n147), .O(n66) );
  NR2 U257 ( .I1(n68), .I2(n69), .O(n67) );
  ND3 U258 ( .I1(n72), .I2(n73), .I3(n74), .O(n132) );
  AOI22S U259 ( .A1(n181), .A2(N38), .B1(data_o[6]), .B2(n153), .O(n72) );
  AOI22S U260 ( .A1(out3[6]), .A2(n151), .B1(N51), .B2(n148), .O(n73) );
  NR2 U261 ( .I1(n75), .I2(n76), .O(n74) );
  FA1S U262 ( .A(out4[0]), .B(data_b[1]), .CI(\add_37/carry [1]), .CO(
        \add_37/carry [2]), .S(out1[1]) );
  FA1S U263 ( .A(out4[1]), .B(data_b[2]), .CI(\add_37/carry [2]), .CO(
        \add_37/carry [3]), .S(out1[2]) );
  FA1S U264 ( .A(out4[2]), .B(data_b[3]), .CI(\add_37/carry [3]), .CO(
        \add_37/carry [4]), .S(out1[3]) );
  FA1S U265 ( .A(out4[3]), .B(data_b[4]), .CI(\add_37/carry [4]), .CO(
        \add_37/carry [5]), .S(out1[4]) );
  FA1S U266 ( .A(out4[4]), .B(data_b[5]), .CI(\add_37/carry [5]), .CO(
        \add_37/carry [6]), .S(out1[5]) );
  FA1S U267 ( .A(out4[5]), .B(data_b[6]), .CI(\add_37/carry [6]), .CO(
        \add_37/carry [7]), .S(out1[6]) );
  FA1S U268 ( .A(out4[6]), .B(data_b[7]), .CI(\add_37/carry [7]), .CO(out1[8]), 
        .S(out1[7]) );
  INV1S U269 ( .I(state_r[2]), .O(n186) );
  INV1S U270 ( .I(state_r[0]), .O(n184) );
  INV1S U271 ( .I(inst_i[0]), .O(n180) );
  MOAI1S U272 ( .A1(n104), .A2(n186), .B1(n105), .B2(n106), .O(n137) );
  NR2 U273 ( .I1(n110), .I2(n111), .O(n104) );
  OA12 U274 ( .B1(n141), .B2(n107), .A1(inst_i[2]), .O(n106) );
  MOAI1S U275 ( .A1(n179), .A2(n180), .B1(n149), .B2(n180), .O(n111) );
  NR2 U276 ( .I1(n180), .I2(inst_i[1]), .O(n109) );
  AOI13HS U277 ( .B1(inst_i[1]), .B2(inst_i[0]), .B3(inst_i[2]), .A1(n152), 
        .O(n105) );
  MOAI1S U278 ( .A1(n113), .A2(n141), .B1(n114), .B2(n105), .O(n138) );
  NR2 U279 ( .I1(n115), .I2(n179), .O(n114) );
  NR2 U280 ( .I1(n116), .I2(n110), .O(n113) );
  AOI22S U281 ( .A1(n117), .A2(n105), .B1(n118), .B2(n149), .O(n139) );
  AOI13HS U282 ( .B1(n97), .B2(n119), .B3(n120), .A1(inst_i[0]), .O(n117) );
  OAI112HS U283 ( .C1(n186), .C2(n179), .A1(inst_i[0]), .B1(n105), .O(n118) );
  ND3 U284 ( .I1(inst_i[1]), .I2(state_r[1]), .I3(inst_i[2]), .O(n119) );
  INV1S U285 ( .I(inst_i[1]), .O(n179) );
  OA12 U286 ( .B1(state_r[0]), .B2(n180), .A1(inst_i[2]), .O(n116) );
  MOAI1S U287 ( .A1(n18), .A2(n158), .B1(n154), .B2(out4[0]), .O(n13) );
  XNR2HS U288 ( .I1(data_b[0]), .I2(\data_a[0] ), .O(n18) );
  MOAI1S U289 ( .A1(n43), .A2(n182), .B1(n20), .B2(out4[1]), .O(n40) );
  XNR2HS U290 ( .I1(out4[0]), .I2(data_b[1]), .O(n43) );
  MOAI1S U291 ( .A1(n50), .A2(n182), .B1(n20), .B2(out4[2]), .O(n47) );
  XNR2HS U292 ( .I1(out4[1]), .I2(data_b[2]), .O(n50) );
  MOAI1S U293 ( .A1(n57), .A2(n182), .B1(n20), .B2(out4[3]), .O(n54) );
  XNR2HS U294 ( .I1(out4[2]), .I2(data_b[3]), .O(n57) );
  MOAI1S U295 ( .A1(n64), .A2(n182), .B1(n20), .B2(out4[4]), .O(n61) );
  XNR2HS U296 ( .I1(out4[3]), .I2(data_b[4]), .O(n64) );
  MOAI1S U297 ( .A1(n71), .A2(n182), .B1(n20), .B2(out4[5]), .O(n68) );
  XNR2HS U298 ( .I1(out4[4]), .I2(data_b[5]), .O(n71) );
  MOAI1S U299 ( .A1(n78), .A2(n182), .B1(n154), .B2(out4[6]), .O(n75) );
  XNR2HS U300 ( .I1(out4[5]), .I2(data_b[6]), .O(n78) );
  INV1S U301 ( .I(data_o[7]), .O(n187) );
  ND3 U302 ( .I1(n184), .I2(n141), .I3(state_r[2]), .O(n28) );
  NR2 U303 ( .I1(state_r[0]), .I2(state_r[2]), .O(n102) );
  AN2 U304 ( .I1(n102), .I2(state_r[1]), .O(n21) );
  XOR2HS U305 ( .I1(out4[6]), .I2(data_b[7]), .O(n85) );
  BUF1CK U306 ( .I(reset_n_i), .O(n160) );
  AN2 U307 ( .I1(data_b[0]), .I2(\data_a[0] ), .O(\add_37/carry [1]) );
  XOR2HS U308 ( .I1(data_b[0]), .I2(\data_a[0] ), .O(out1[0]) );
  OR2 U309 ( .I1(n168), .I2(data_b[0]), .O(\sub_38/carry [1]) );
  XNR2HS U310 ( .I1(data_b[0]), .I2(n168), .O(out2[0]) );
  INV1S U311 ( .I(out2[0]), .O(N44) );
  XOR2HS U312 ( .I1(\add_0_root_add_43_ni/carry [8]), .I2(\sub_38/carry [8]), 
        .O(N53) );
  NR2 U313 ( .I1(\add_0_root_add_43_ni/carry [8]), .I2(n155), .O(N60) );
  AO22 U314 ( .A1(n157), .A2(n177), .B1(out3[10]), .B2(n21), .O(n26) );
  AO22 U315 ( .A1(n156), .A2(n177), .B1(out3[11]), .B2(n151), .O(n30) );
  AO22 U316 ( .A1(n156), .A2(n142), .B1(out3[12]), .B2(n150), .O(n32) );
  AO22 U317 ( .A1(n157), .A2(n177), .B1(out3[13]), .B2(n21), .O(n34) );
  AO22 U318 ( .A1(n155), .A2(n177), .B1(out3[14]), .B2(n150), .O(n36) );
  AO22 U319 ( .A1(n155), .A2(n177), .B1(out3[9]), .B2(n21), .O(n94) );
  AO22 U320 ( .A1(n101), .A2(n157), .B1(out3[15]), .B2(n151), .O(n100) );
endmodule

