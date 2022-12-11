`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/25 09:13:51
// Design Name: 
// Module Name: vga_colorbar
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_colorbar(
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   ,
    
    output  wire            hsync       ,
    output  wire            vsync       ,
    output  wire    [15:0]  rgb
    );

wire            vga_clk     ;
wire            locked      ;
wire            rst_n       ;

assign rst_n = (sys_rst_n && locked);

wire    [15:0]  pix_data    ;
wire    [9:0]   pix_x       ;
wire    [9:0]   pix_y       ;

clk_d_2 clk_d_2_inst
   (
    // Clock out ports
    .clk_out1   (vga_clk    ),     // output clk_out1
    // Status and control signals
    .reset      (~sys_rst_n ), // input reset
    .locked     (locked     ),       // output locked
   // Clock in ports
    .clk_in1    (sys_clk    )      // input clk_in1
    );


vga_ctrl    vga_ctrl_inst(
   .vga_clk   (vga_clk  )  ,   //VGAʱ���ź�
   .sys_rst_n (rst_n    )  ,   //��λ�ź�
   .pix_data  (pix_data )  ,   //ͼ����Ϣ

   .pix_x     (pix_x    )  ,   //������
   .pix_y     (pix_y    )  ,   //������
   .hsync     (hsync    )  ,   //��ͬ���ź�
   .vsync     (vsync    )  ,   //��ͬ���ź�
   .rgb       (rgb      )      //��Чͼ����Ϣ
    );

vga_pic     vga_pic_inst(
    .sys_clk    (sys_clk  ) ,
    .sys_rst_n  (rst_n) ,
    .pix_x      (pix_x    ) ,
    .pix_y      (pix_y    ) ,

    .pix_data   (pix_data )
    );
endmodule
