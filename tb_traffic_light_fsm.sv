`timescale 1ns / 1ps


module tb_traffic_light_fsm();

        reg enable = 0;
        reg clk = 0;
        reg rst = 1;
        wire [1:0] light;
        
        traffic_light_fsm FSM(
                .enable (enable),
                .clk (clk),
                .rst (rst),
                .light (light)
                );
                
        initial begin
            forever begin
                #1 clk = ~clk;
            end
        end
        
        initial begin
            #10;
            enable = 1;
            #100;
            #100;
            enable = 0;
            #100;
            enable = 1;
            #100;
            rst = 0;
            #10;
            rst = 1;
        
        end


endmodule
