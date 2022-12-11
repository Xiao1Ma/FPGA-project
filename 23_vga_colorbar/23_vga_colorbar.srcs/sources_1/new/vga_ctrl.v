`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/22 22:31:31
// Design Name: 
// Module Name: vga_ctrl
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


module vga_ctrl(
    input   wire            vga_clk     ,   //VGA时钟信号
    input   wire            sys_rst_n   ,   //复位信号
    input   wire    [15:0]  pix_data    ,   //图像信息
    
    output  wire    [9:0]   pix_x       ,   //横坐标
    output  wire    [9:0]   pix_y       ,   //纵坐标
    output  wire            hsync       ,   //行同步信号
    output  wire            vsync       ,   //场同步信号
    output  wire    [15:0]  rgb             //有效图像信息
    );
parameter  H_SYNC  = 10'd96 ,
            H_BACK  = 10'd40 ,
            H_LEFT  = 10'd8  ,
            H_VALID = 10'd640,
            H_RIGHT = 10'd8  ,
            H_FRONT = 10'd8  ,
            H_TOTAL = 10'd800;

parameter  V_SYNC  = 10'd2  ,
            V_BACK  = 10'd25 ,
            V_TOP   = 10'd8  ,
            V_VALID = 10'd480,
            V_BOTTOM= 10'd8  ,
            V_FRONT = 10'd2  ,
            V_TOTAL = 10'd525;

reg     [9:0]   cnt_h       ;   //行扫描周期计数器
reg     [9:0]   cnt_v       ;   //场扫描周期计数器
wire            rgb_valid   ;   //图像有效信号

//对行扫描周期计数器进行赋值
always @(posedge vga_clk or negedge sys_rst_n)  begin
    if(sys_rst_n == 1'b0)
        cnt_h   <=  10'd0;
    else    if(cnt_h == H_TOTAL - 10'd1)
        cnt_h   <=  10'd0;
    else
        cnt_h   <=  cnt_h   +   10'd1;
end

//对场扫描周期计数器进行赋值
always @(posedge vga_clk or negedge sys_rst_n)  begin
    if(sys_rst_n == 1'b0)
        cnt_v   <=  10'd0;
    else    if((cnt_v == V_TOTAL - 10'd1) && (cnt_h == H_TOTAL - 10'd1))
        cnt_v   <=  10'd0;
    else    if(cnt_h == H_TOTAL - 10'd1)
        cnt_v   <=  cnt_v   +   10'd1;
    else
        cnt_v   <=  cnt_v;
end

//对图像有效信号进行赋值
assign rgb_valid    =   (((cnt_h >= H_SYNC + H_BACK + H_LEFT)
                            && (cnt_h <= H_SYNC + H_BACK + H_LEFT + H_VALID - 10'd1))
                            &&((cnt_v >= V_SYNC + V_BACK + V_TOP)
                            &&(cnt_v <= V_SYNC + V_BACK + V_TOP + V_VALID - 10'd1))
                            ) ? 1'b1:1'b0;

//对两路坐标信号进行赋值
assign  pix_x   =   (rgb_valid == 1'b1) ?   (cnt_h - H_SYNC - H_BACK - H_LEFT + 10'd1) : 10'h3ff;
assign  pix_y   =   (rgb_valid == 1'b1) ?   (cnt_v - V_SYNC - V_BACK - V_TOP ) : 10'h3ff;

//对行场同步信号进行赋值
assign  hsync   =   (cnt_h == H_SYNC - 10'd1) ? 1'b1 : 1'b0;
assign  vsync   =   (cnt_h == V_SYNC - 10'd1) ? 1'b1 : 1'b0;

//对图像信号进行赋值
assign  rgb     =   (rgb_valid == 1'b1) ?   pix_data : 16'h0000;
endmodule
