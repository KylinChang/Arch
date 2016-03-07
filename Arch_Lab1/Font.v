`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:06 03/02/2016 
// Design Name: 
// Module Name:    Font 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Font(
input wire[7:0] ascii,
input wire[2:0] col,
input wire[2:0] row,
output reg font
    );

reg[63:0] data_20,data_21,data_22,data_23,data_24,data_25,data_26,data_27,data_28,data_29,
data_2a,data_2b,data_2c,data_2d,data_2e,data_2f,data_30,data_31,data_32,data_33,
data_34,data_35,data_36,data_37,data_38,data_39,data_3a,data_3b,data_3c,data_3d,
data_3e,data_3f,data_40,data_41,data_42,data_43,data_44,data_45,data_46,data_47,
data_48,data_49,data_4a,data_4b,data_4c,data_4d,data_4e,data_4f,data_50,data_51,
data_52,data_53,data_54,data_55,data_56,data_57,data_58,data_59,data_5a,data_5b,
data_5c,data_5d,data_5e,data_5f,data_60,data_61,data_62,data_63,data_64,data_65,
data_66,data_67,data_68,data_69,data_6a,data_6b,data_6c,data_6d,data_6e,data_6f,
data_70,data_71,data_72,data_73,data_74,data_75,data_76,data_77,data_78,data_79,
data_7a,data_7b,data_7c,data_7d,data_7e,data_7f;
	                                                                                 
	 parameter HN=8;
	 
	 initial begin
data_20=    {8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};           /* <SPACE>  20   */
data_21=    {8'h18,8'h18,8'h18,8'h18,8'h00,8'h18,8'h18,8'h00};           /*    !     21   */
data_22=    {8'h6c,8'h6c,8'h48,8'h00,8'h00,8'h00,8'h00,8'h00};           /*    "     22   */
data_23=    {8'h6c,8'h6c,8'hfe,8'h6c,8'hfe,8'h6c,8'h6c,8'h00};           /*    #     23   */
data_24=    {8'h18,8'h7e,8'hd8,8'h7e,8'h1b,8'h7e,8'h18,8'h00};           /*    $     24   */
data_25=    {8'h62,8'h66,8'h0c,8'h18,8'h30,8'h66,8'h46,8'h00};           /*    %     25   */
data_26=    {8'h38,8'h6c,8'h68,8'h76,8'hdc,8'hcc,8'h76,8'h00};           /*    &     26   */
data_27=    {8'h18,8'h18,8'h30,8'h00,8'h00,8'h00,8'h00,8'h00};           /*    '     27   */
data_28=    {8'h0c,8'h18,8'h30,8'h30,8'h30,8'h18,8'h0c,8'h00};           /*    (     28   */
data_29=    {8'h30,8'h18,8'h0c,8'h0c,8'h0c,8'h18,8'h30,8'h00};           /*    )     29   */
data_2a=    {8'h00,8'h6c,8'h38,8'hfe,8'h38,8'h6c,8'h00,8'h00};           /*    *     2a   */
data_2b=    {8'h00,8'h18,8'h18,8'h7e,8'h18,8'h18,8'h00,8'h00};           /*    +     2b   */
data_2c=    {8'h00,8'h00,8'h00,8'h00,8'h00,8'h18,8'h18,8'h10};           /*    ;     2c   */
data_2d=    {8'h00,8'h00,8'h00,8'h7e,8'h00,8'h00,8'h00,8'h00};           /*    -     2d   */
data_2e=    {8'h00,8'h00,8'h00,8'h00,8'h00,8'h18,8'h18,8'h00};           /*    .     2e   */
data_2f=    {8'h02,8'h06,8'h0c,8'h18,8'h30,8'h60,8'h40,8'h00};           /*    /     2f   */
data_30=    {8'h3c,8'h66,8'h6e,8'h76,8'h66,8'h66,8'h3c,8'h00};           /*    0     30   */
data_31=    {8'h18,8'h18,8'h38,8'h18,8'h18,8'h18,8'h3c,8'h00};           /*    1     31   */
data_32=    {8'h7c,8'h06,8'h06,8'h3c,8'h60,8'h60,8'h7c,8'h00};           /*    2     32   */
data_33=    {8'h7c,8'h06,8'h06,8'h3c,8'h06,8'h06,8'h7c,8'h00};           /*    3     33   */
data_34=    {8'h66,8'h66,8'h66,8'h7e,8'h06,8'h06,8'h06,8'h00};           /*    4     34   */
data_35=    {8'h7e,8'h60,8'h60,8'h7c,8'h06,8'h06,8'h7c,8'h00};           /*    5     35   */
data_36=    {8'h3c,8'h60,8'h60,8'h7c,8'h66,8'h66,8'h3c,8'h00};           /*    6     36   */
data_37=    {8'h7e,8'h06,8'h0c,8'h18,8'h18,8'h18,8'h18,8'h00};           /*    7     37   */
data_38=    {8'h3c,8'h66,8'h66,8'h3c,8'h66,8'h66,8'h3c,8'h00};           /*    8     38   */
data_39=    {8'h3c,8'h66,8'h66,8'h3e,8'h06,8'h06,8'h3c,8'h00};           /*    9     39   */
data_3a=    {8'h00,8'h18,8'h18,8'h00,8'h18,8'h18,8'h00,8'h00};           /*    :     3a   */
data_3b=    {8'h00,8'h00,8'h18,8'h18,8'h00,8'h18,8'h18,8'h10};           /*    ;     3b   */
data_3c=    {8'h0c,8'h18,8'h30,8'h60,8'h30,8'h18,8'h0c,8'h00};           /*    <     3c   */
data_3d=    {8'h00,8'h00,8'h7e,8'h00,8'h7e,8'h00,8'h00,8'h00};           /*    =     3d   */
data_3e=    {8'h30,8'h18,8'h0c,8'h06,8'h0c,8'h18,8'h30,8'h00};           /*    >     3e   */
data_3f=    {8'h3c,8'h66,8'h06,8'h1c,8'h18,8'h00,8'h18,8'h00};           /*    ?     3f   */
data_40=    {8'h3c,8'h66,8'h6e,8'h6a,8'h6e,8'h60,8'h3e,8'h00};           /*    @     40   */
data_41=    {8'h3c,8'h66,8'h66,8'h7e,8'h66,8'h66,8'h66,8'h00};           /*    A     41   */
data_42=    {8'h7c,8'h66,8'h66,8'h7c,8'h66,8'h66,8'h7c,8'h00};           /*    B     42   */
data_43=    {8'h3c,8'h66,8'h60,8'h60,8'h60,8'h66,8'h3c,8'h00};           /*    C     43   */
data_44=    {8'h7c,8'h66,8'h66,8'h66,8'h66,8'h66,8'h7c,8'h00};           /*    D     44   */
data_45=    {8'h7e,8'h60,8'h60,8'h7c,8'h60,8'h60,8'h7e,8'h00};           /*    E     45   */
data_46=    {8'h7e,8'h60,8'h60,8'h7c,8'h60,8'h60,8'h60,8'h00};           /*    F     46   */
data_47=    {8'h3c,8'h66,8'h60,8'h6e,8'h66,8'h66,8'h3c,8'h00};           /*    G     47   */
data_48=    {8'h66,8'h66,8'h66,8'h7e,8'h66,8'h66,8'h66,8'h00};           /*    H     48   */
data_49=    {8'h3c,8'h18,8'h18,8'h18,8'h18,8'h18,8'h3c,8'h00};           /*    I     49   */
data_4a=    {8'h3e,8'h0c,8'h0c,8'h0c,8'h0c,8'h6c,8'h38,8'h00};           /*    J     4a   */
data_4b=    {8'h66,8'h6c,8'h78,8'h70,8'h78,8'h6c,8'h66,8'h00};           /*    K     4b   */
data_4c=    {8'h60,8'h60,8'h60,8'h60,8'h60,8'h60,8'h7e,8'h00};           /*    L     4c   */
data_4d=    {8'hc6,8'hee,8'hfe,8'hd6,8'hc6,8'hc6,8'hc6,8'h00};           /*    M     4d   */
data_4e=    {8'h66,8'h66,8'h76,8'h7e,8'h6e,8'h66,8'h66,8'h00};           /*    N     4e   */
data_4f=    {8'h3c,8'h66,8'h66,8'h66,8'h66,8'h66,8'h3c,8'h00};           /*    O     4f   */
data_50=    {8'h7c,8'h66,8'h66,8'h7c,8'h60,8'h60,8'h60,8'h00};           /*    P     50   */
data_51=    {8'h3c,8'h66,8'h66,8'h66,8'h6e,8'h66,8'h3e,8'h00};           /*    Q     51   */
data_52=    {8'h7c,8'h66,8'h66,8'h7c,8'h66,8'h66,8'h66,8'h00};           /*    R     52   */
data_53=    {8'h3e,8'h60,8'h60,8'h3c,8'h06,8'h06,8'h7c,8'h00};           /*    S     53   */
data_54=    {8'h7e,8'h18,8'h18,8'h18,8'h18,8'h18,8'h18,8'h00};           /*    T     54   */
data_55=    {8'h66,8'h66,8'h66,8'h66,8'h66,8'h66,8'h3c,8'h00};           /*    U     55   */
data_56=    {8'h66,8'h66,8'h66,8'h66,8'h3c,8'h3c,8'h18,8'h00};           /*    V     56   */
data_57=    {8'hc6,8'hc6,8'hd6,8'hd6,8'hfe,8'hee,8'h44,8'h00};           /*    W     57   */
data_58=    {8'h66,8'h66,8'h3c,8'h18,8'h3c,8'h66,8'h66,8'h00};           /*    X     58   */
data_59=    {8'h66,8'h66,8'h66,8'h3c,8'h18,8'h18,8'h18,8'h00};           /*    Y     59   */
data_5a=    {8'h7e,8'h06,8'h0c,8'h18,8'h30,8'h60,8'h7e,8'h00};           /*    Z     5a   */
data_5b=    {8'h3c,8'h30,8'h30,8'h30,8'h30,8'h30,8'h3c,8'h00};           /*    [     5b   */
data_5c=    {8'h40,8'h60,8'h30,8'h18,8'h0c,8'h06,8'h02,8'h00};           /*    \     5c   */
data_5d=    {8'h3c,8'h0c,8'h0c,8'h0c,8'h0c,8'h0c,8'h3c,8'h00};           /*    ]     5d   */
data_5e=    {8'h10,8'h38,8'h6c,8'h00,8'h00,8'h00,8'h00,8'h00};           /*    ^     5e   */
data_5f=    {8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'hff};           /*    _     5f   */
data_60=    {8'h18,8'h18,8'h0c,8'h00,8'h00,8'h00,8'h00,8'h00};           /*    `     60   */
data_61=    {8'h00,8'h00,8'h3c,8'h06,8'h3e,8'h66,8'h3a,8'h00};           /*    a     61   */
data_62=    {8'h60,8'h60,8'h7c,8'h66,8'h66,8'h66,8'h7c,8'h00};           /*    b     62   */
data_63=    {8'h00,8'h00,8'h3c,8'h66,8'h60,8'h66,8'h3c,8'h00};           /*    c     63   */
data_64=    {8'h06,8'h06,8'h3e,8'h66,8'h66,8'h66,8'h3e,8'h00};           /*    d     64   */
data_65=    {8'h00,8'h00,8'h3c,8'h66,8'h7c,8'h60,8'h3c,8'h00};           /*    e     65   */
data_66=    {8'h0e,8'h18,8'h18,8'h3e,8'h18,8'h18,8'h18,8'h00};           /*    f     66   */
data_67=    {8'h00,8'h00,8'h3e,8'h66,8'h66,8'h3e,8'h06,8'h3c};           /*    g     67   */
data_68=    {8'h60,8'h60,8'h7c,8'h66,8'h66,8'h66,8'h66,8'h00};           /*    h     68   */
data_69=    {8'h18,8'h00,8'h18,8'h18,8'h18,8'h18,8'h18,8'h00};           /*    i     69   */
data_6a=    {8'h18,8'h00,8'h18,8'h18,8'h18,8'h18,8'h18,8'h70};           /*    j     6a   */
data_6b=    {8'h60,8'h60,8'h66,8'h6c,8'h78,8'h6c,8'h66,8'h00};           /*    k     6b   */
data_6c=    {8'h30,8'h30,8'h30,8'h30,8'h30,8'h30,8'h1c,8'h00};           /*    l     6c   */
data_6d=    {8'h00,8'h00,8'hcc,8'hfe,8'hd6,8'hc6,8'hc6,8'h00};           /*    m     6d   */
data_6e=    {8'h00,8'h00,8'h7c,8'h66,8'h66,8'h66,8'h66,8'h00};           /*    n     6e   */
data_6f=    {8'h00,8'h00,8'h3c,8'h66,8'h66,8'h66,8'h3c,8'h00};           /*    o     6f   */
data_70=    {8'h00,8'h00,8'h7c,8'h66,8'h66,8'h7c,8'h60,8'h60};           /*    p     70   */
data_71=    {8'h00,8'h00,8'h3e,8'h66,8'h66,8'h3e,8'h06,8'h06};           /*    q     71   */
data_72=    {8'h00,8'h00,8'h36,8'h38,8'h30,8'h30,8'h30,8'h00};           /*    r     72   */
data_73=    {8'h00,8'h00,8'h3e,8'h60,8'h3c,8'h06,8'h7c,8'h00};           /*    s     73   */
data_74=    {8'h18,8'h18,8'h3c,8'h18,8'h18,8'h18,8'h0c,8'h00};           /*    t     74   */
data_75=    {8'h00,8'h00,8'h66,8'h66,8'h66,8'h66,8'h3c,8'h00};           /*    u     75   */
data_76=    {8'h00,8'h00,8'h66,8'h66,8'h66,8'h3c,8'h18,8'h00};           /*    v     76   */
data_77=    {8'h00,8'h00,8'hc6,8'hd6,8'hd6,8'h7c,8'h28,8'h00};           /*    w     77   */
data_78=    {8'h00,8'h00,8'h66,8'h3c,8'h18,8'h3c,8'h66,8'h00};           /*    x     78   */
data_79=    {8'h00,8'h00,8'h66,8'h66,8'h66,8'h3e,8'h06,8'h7c};           /*    y     79   */
data_7a=    {8'h00,8'h00,8'h7e,8'h0c,8'h18,8'h30,8'h7e,8'h00};           /*    z     7a   */
data_7b=    {8'h1c,8'h30,8'h30,8'h60,8'h30,8'h30,8'h1c,8'h00};           /*    {     7b   */
data_7c=    {8'h18,8'h18,8'h18,8'h18,8'h18,8'h18,8'h18,8'h00};           /*    |     7c   */
data_7d=    {8'h38,8'h0c,8'h0c,8'h06,8'h0c,8'h0c,8'h38,8'h00};           /*    }     7d   */
data_7e=    {8'h00,8'h32,8'h4c,8'h00,8'h00,8'h00,8'h00,8'h00};           /*    ~     7e   */
data_7f=    {8'hff,8'hff,8'hff,8'hff,8'hff,8'hff,8'hff,8'hff};            /*  <DEL>   7f   */
end

always@* begin
case(ascii[7:0])
8'h20:font <= data_20[255-row*HN-col];
8'h21:font <= data_21[255-row*HN-col];
8'h22:font <= data_22[255-row*HN-col];
8'h23:font <= data_23[255-row*HN-col];
8'h24:font <= data_24[255-row*HN-col];
8'h25:font <= data_25[255-row*HN-col];
8'h26:font <= data_26[255-row*HN-col];
8'h27:font <= data_27[255-row*HN-col];
8'h28:font <= data_28[255-row*HN-col];
8'h29:font <= data_29[255-row*HN-col];
8'h2a:font <= data_2a[255-row*HN-col];
8'h2b:font <= data_2b[255-row*HN-col];
8'h2c:font <= data_2c[255-row*HN-col];
8'h2d:font <= data_2d[255-row*HN-col];
8'h2e:font <= data_2e[255-row*HN-col];
8'h2f:font <= data_2f[255-row*HN-col];
8'h30:font <= data_30[255-row*HN-col];
8'h31:font <= data_31[255-row*HN-col];
8'h32:font <= data_32[255-row*HN-col];
8'h33:font <= data_33[255-row*HN-col];
8'h34:font <= data_34[255-row*HN-col];
8'h35:font <= data_35[255-row*HN-col];
8'h36:font <= data_36[255-row*HN-col];
8'h37:font <= data_37[255-row*HN-col];
8'h38:font <= data_38[255-row*HN-col];
8'h39:font <= data_39[255-row*HN-col];
8'h3a:font <= data_3a[255-row*HN-col];
8'h3b:font <= data_3b[255-row*HN-col];
8'h3c:font <= data_3c[255-row*HN-col];
8'h3d:font <= data_3d[255-row*HN-col];
8'h3e:font <= data_3e[255-row*HN-col];
8'h3f:font <= data_3f[255-row*HN-col];
8'h40:font <= data_40[255-row*HN-col];
8'h41:font <= data_41[255-row*HN-col];
8'h42:font <= data_42[255-row*HN-col];
8'h43:font <= data_43[255-row*HN-col];
8'h44:font <= data_44[255-row*HN-col];
8'h45:font <= data_45[255-row*HN-col];
8'h46:font <= data_46[255-row*HN-col];
8'h47:font <= data_47[255-row*HN-col];
8'h48:font <= data_48[255-row*HN-col];
8'h49:font <= data_49[255-row*HN-col];
8'h4a:font <= data_4a[255-row*HN-col];
8'h4b:font <= data_4b[255-row*HN-col];
8'h4c:font <= data_4c[255-row*HN-col];
8'h4d:font <= data_4d[255-row*HN-col];
8'h4e:font <= data_4e[255-row*HN-col];
8'h4f:font <= data_4f[255-row*HN-col];
8'h50:font <= data_50[255-row*HN-col];
8'h51:font <= data_51[255-row*HN-col];
8'h52:font <= data_52[255-row*HN-col];
8'h53:font <= data_53[255-row*HN-col];
8'h54:font <= data_54[255-row*HN-col];
8'h55:font <= data_55[255-row*HN-col];
8'h56:font <= data_56[255-row*HN-col];
8'h57:font <= data_57[255-row*HN-col];
8'h58:font <= data_58[255-row*HN-col];
8'h59:font <= data_59[255-row*HN-col];
8'h5a:font <= data_5a[255-row*HN-col];
8'h5b:font <= data_5b[255-row*HN-col];
8'h5c:font <= data_5c[255-row*HN-col];
8'h5d:font <= data_5d[255-row*HN-col];
8'h5e:font <= data_5e[255-row*HN-col];
8'h5f:font <= data_5f[255-row*HN-col];
8'h60:font <= data_60[255-row*HN-col];
8'h61:font <= data_61[255-row*HN-col];
8'h62:font <= data_62[255-row*HN-col];
8'h63:font <= data_63[255-row*HN-col];
8'h64:font <= data_64[255-row*HN-col];
8'h65:font <= data_65[255-row*HN-col];
8'h66:font <= data_66[255-row*HN-col];
8'h67:font <= data_67[255-row*HN-col];
8'h68:font <= data_68[255-row*HN-col];
8'h69:font <= data_69[255-row*HN-col];
8'h6a:font <= data_6a[255-row*HN-col];
8'h6b:font <= data_6b[255-row*HN-col];
8'h6c:font <= data_6c[255-row*HN-col];
8'h6d:font <= data_6d[255-row*HN-col];
8'h6e:font <= data_6e[255-row*HN-col];
8'h6f:font <= data_6f[255-row*HN-col];
8'h70:font <= data_70[255-row*HN-col];
8'h71:font <= data_71[255-row*HN-col];
8'h72:font <= data_72[255-row*HN-col];
8'h73:font <= data_73[255-row*HN-col];
8'h74:font <= data_74[255-row*HN-col];
8'h75:font <= data_75[255-row*HN-col];
8'h76:font <= data_76[255-row*HN-col];
8'h77:font <= data_77[255-row*HN-col];
8'h78:font <= data_78[255-row*HN-col];
8'h79:font <= data_79[255-row*HN-col];
8'h7a:font <= data_7a[255-row*HN-col];
8'h7b:font <= data_7b[255-row*HN-col];
8'h7c:font <= data_7c[255-row*HN-col];
8'h7d:font <= data_7d[255-row*HN-col];
8'h7e:font <= data_7e[255-row*HN-col];
8'h7f:font <= data_7f[255-row*HN-col];
default:font <= data_20[255-row*HN-col];
	endcase
end

endmodule
