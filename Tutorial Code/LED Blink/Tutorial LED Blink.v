//LED blinker

module tutorial_led_blink
    (
    i_clock,
    i_enable,
    i_switch_1,
    i_switch_2,
    o_led_drive
    );

    input i_clock;
    input i_enable;
    input i_switch_1;
    input i_switch_2;
    output o_led_drive;

    //constant values 
    //input clock is 25kHz, can be any value
    //Formula is 25 khz/100hz * 50% duty cycle 
    //for 100 hz: 25,000 / 100 * 0.5 = 125
    parameter c_CNT_100HZ = 125;
    parameter c_CNT_50HZ = 250;
    parameter c_CNT_10HZ = 1250;
    parameter c_CNT_1HZ = 12500;

    //counter signals 
    reg [31:0] r_CNT_100HZ = 0;
    reg [31:0] r_CNT_50HZ = 0;
    reg [31:0] r_CNT_10HZ = 0;
    reg [31:0] r_CNT_1HZ = 0;

    //signals to toggle the frequencies
    reg r_TOGGLE_100HZ = 1'b0;
    reg r_TOGGLE_50HZ = 1'b0;
    reg r_TOGGLE_10HZ = 1'b0;
    reg r_TOGGLE_1HZ = 1'b0;

    //one bit select
    reg r_LED_SELECT;
    //wire w_LED_SELECT;


//always blocks toggle a specific signal at a diff freq
//all run continuously even if switches are not selectin their output 
    always @ (posedge i_clock)
        begin
            if(r_CNT_100HZ == c_CNT_100HZ-1)
                begin
                    r_TOGGLE_100HZ <= !r_TOGGLE_100HZ;
                    r_CNT_100HZ <= 0;
                end
            else
                r_CNT_100HZ <= r_CNT_100HZ + 1;
        end

    always @ (posedge i_clock)
        begin
            if(r_CNT_50HZ == c_CNT_50HZ-1)
                begin
                    r_TOGGLE_50HZ <= !r_TOGGLE_50HZ;
                    r_CNT_50HZ <= 0;
                end
            else
                r_CNT_50HZ <= r_CNT_50HZ + 1;
        end

    always @ (posedge i_clock)
        begin
            if(r_CNT_10HZ == c_CNT_10HZ-1)
                begin
                    r_TOGGLE_10HZ <= !r_TOGGLE_10HZ;
                    r_CNT_10HZ <= 0;
                end
            else
                r_CNT_10HZ <= r_CNT_10HZ + 1;
        end

    always @ (posedge i_clock)
        begin
            if(r_CNT_1HZ == c_CNT_1HZ-1)
                begin
                    r_TOGGLE_1HZ <= !r_TOGGLE_1HZ;
                    r_CNT_1HZ <= 0;
                end
            else
                r_CNT_1HZ <= r_CNT_1HZ + 1;
        end

    //multiplexer on switch inputs 
    always @ (*)
    begin 
        case ({i_switch_1, i_switch_2}) //concatenation operator
            2'b11 : r_LED_SELECT = r_TOGGLE_1HZ;
            2'b10 : r_LED_SELECT = r_TOGGLE_10HZ;
            2'b01 : r_LED_SELECT = r_TOGGLE_50HZ;
            2'b00 : r_LED_SELECT = r_TOGGLE_100HZ;
        endcase     
    end

    assign o_led_drive = r_LED_SELECT & i_enable;



endmodule
