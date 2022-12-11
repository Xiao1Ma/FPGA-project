`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/24 17:03:45
// Design Name: 
// Module Name: vga_pic
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


module vga_pic(
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   ,
    input   wire    [9:0]   pix_x       ,
    input   wire    [9:0]   pix_y       ,
    
    output  reg     [15:0]  pix_data
    );
//分辨率参数的定义
parameter   H_VALID = 10'd640   ,
             V_VALID = 10'D480   ;
//颜色参数的定义
parameter   RED     = 16'hF800  ,
             ORANGE  = 16'hFC00  , 
             YELLOW  = 16'hFFE0  ,
             GREEN   = 16'h07E0  ,
             CYAN    = 16'h07FF  ,
             BLUE    = 16'h001F  ,
             PURPPLE = 16'hF81F  ,
             BLACK   = 16'h0000  ,
             WHITE   = 16'hFFFF  ,
             GRAY    = 16'hD69A  ;

//对输出的图像信息进行赋值
always @(posedge sys_clk or negedge sys_rst_n)  begin
    if(sys_rst_n == 1'b0)
        pix_data    <=  16'h0000;
    else    if((pix_x >= (H_VALID / 10) * 0) && (pix_x < (H_VALID / 10) * 1))
        pix_data    <=  RED;
    else    if((pix_x >= (H_VALID / 10) * 1) && (pix_x < (H_VALID / 10) * 2))
        pix_data    <=  ORANGE;
    else    if((pix_x >= (H_VALID / 10) * 2) && (pix_x < (H_VALID / 10) * 3))
        pix_data    <=  YELLOW;
    else    if((pix_x >= (H_VALID / 10) * 3) && (pix_x < (H_VALID / 10) * 4))
        pix_data    <=  GREEN;
    else    if((pix_x >= (H_VALID / 10) * 4) && (pix_x < (H_VALID / 10) * 5))
        pix_data    <=  CYAN;
    else    if((pix_x >= (H_VALID / 10) * 5) && (pix_x < (H_VALID / 10) * 6))
        pix_data    <=  BLUE;
    else    if((pix_x >= (H_VALID / 10) * 6) && (pix_x < (H_VALID / 10) * 7))
        pix_data    <=  PURPPLE;
    else    if((pix_x >= (H_VALID / 10) * 7) && (pix_x < (H_VALID / 10) * 8))
        pix_data    <=  BLACK;
    else    if((pix_x >= (H_VALID / 10) * 8) && (pix_x < (H_VALID / 10) * 9))
        pix_data    <=  WHITE;
    else    if((pix_x >= (H_VALID / 10) * 9) && (pix_x < (H_VALID / 10) * 10))
        pix_data    <=  GRAY;
    else
        pix_data    <=  16'h0000;
end
endmodule
