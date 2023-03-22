`timescale 1ns / 1ps

module traffic_light_fsm(
    input enable,
    input clk,
    input rst,
    output reg [1:0] light
    );
    
    reg [1:0] state = 2'b00;   
    reg [7:0] timer = 8'd0;
    
    parameter [1:0] OFF = 2'b00, //0 for off
                    RED = 2'b01, //1 for red
                    YELLOW = 2'b10, //2 for yellow
                    GREEN  = 2'b11; //3 for green
                    
    always @(*)
    begin
    $display("timer:%0d ,state:%0d", timer, state); // for testbench purposes
        if (!rst) 
            begin
                state = 2'b00;
                timer = 8'd0;
            end
    
        case (state)
            OFF :   begin
                        light = OFF;
                        if (enable) state = RED;
                        timer = 8'd0;
                    end
            RED :   begin
                        light = RED;
                        if (!enable) state = OFF;
                        if (timer == 8'd50)
                        begin 
                            state = YELLOW;
                            timer = 8'd0;
                        end
                    end
            YELLOW :    begin
                            light = YELLOW;
                            if (!enable) state = OFF;
                            if (timer == 8'd10)
                            begin 
                                state = GREEN;
                                timer = 8'd0;
                            end
                        end
            GREEN : begin
                        light = GREEN;
                            if (!enable) state = OFF;
                            if (timer == 8'd30)
                            begin 
                                state = RED;
                                timer = 8'd0;
                            end
                    end
        endcase
    end
    
    always @(posedge clk)
    begin
            timer = timer + 8'd1;      
    end
    
endmodule
