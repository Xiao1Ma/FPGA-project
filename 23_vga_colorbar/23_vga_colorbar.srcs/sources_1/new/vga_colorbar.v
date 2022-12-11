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
   .vga_clk   (vga_clk  )  ,   //VGA时钟信号
   .sys_rst_n (rst_n    )  ,   //复位信号
   .pix_data  (pix_data )  ,   //图像信息

   .pix_x     (pix_x    )  ,   //横坐标
   .pix_y     (pix_y    )  ,   //纵坐标
   .hsync     (hsync    )  ,   //行同步信号
   .vsync     (vsync    )  ,   //场同步信号
   .rgb       (rgb      )      //有效图像信息
    );

vga_pic     vga_pic_inst(
    .sys_clk    (sys_clk  ) ,
    .sys_rst_n  (rst_n) ,
    .pix_x      (pix_x    ) ,
    .pix_y      (pix_y    ) ,

    .pix_data   (pix_data )
    );
endmodule
