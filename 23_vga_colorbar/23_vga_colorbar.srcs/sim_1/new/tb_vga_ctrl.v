`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/23 07:36:30
// Design Name: 
// Module Name: tb_vga_ctrl
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


module tb_vga_ctrl();
reg         sys_clk     ;
reg         sys_rst_n   ;
wire [15:0] pix_data    ;

wire        vga_clk     ;
wire        locked      ;
wire        rst_n       ;
wire [9:0]  pix_x       ;
wire [9:0]  pix_y       ;
wire        hsync       ;
wire        vsync       ;
wire [15:0] rgb         ;

initial
    begin
        sys_clk      =  1'b1;
        sys_rst_n   <=  1'b0;
        #20
        sys_rst_n   <=  1'b1;
    end

always #10 sys_clk = ~sys_clk;

assign  rst_n = (sys_rst_n && locked);

////通过横纵坐标信号对图像信息进行赋值
//always  @(posedge vga_clk or negedge sys_rst_n) begin
//    if(sys_rst_n == 1'b0)
//        pix_data    <=  16'h0000;
//    else    if(((pix_x >= 10'd0) && (pix_x <= 10'd639))
//                && ((pix_y >= 10'd0) && (pix_y <= 10'd479)))
//        pix_data    <=  16'hffff;
//    else
//        pix_data    <=  16'h0000;
//end

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
