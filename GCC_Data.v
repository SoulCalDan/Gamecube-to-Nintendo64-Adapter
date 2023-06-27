module GCC_Data ( input clk , input poll , input enable ,// output reset_polling ,
output [15:0] JoyL , output [15:0] JoyR , output [12:0] GCbuttons , output outtest
);

assign outtest = data[bits];
parameter bit_value = 80; 
reg [12:0] GCbuttons = 13'b0; 
reg [15:0] JoyL = 8'b0; 
reg [15:0] JoyR = 8'b0;
reg [80:0] data = 0;
reg [7:0] bits = 8'd80; 
reg [11:0] HC = 8'b0; 
reg [7:0] LC = 8'b0; 
reg prev_poll; reg prev_enable; reg [2:0] poll_fail = 3'b0; reg reset_polling = 0; 
reg [3:0] no_con; // counts if no controller has been detected for multiple polling periods
//reg CU = 0; reg CD = 0; reg CL = 0; reg CR = 0;
always @ ( * ) begin
    JoyL[15:0] = data[63:48]; 
    JoyR[15:0] = data[47:32]; //ShL[7:0] = data[31:24]; ShR[7:0] = data[23:16]; 
    GCbuttons[12:0] = data[76:64];
end

always @ ( posedge clk ) begin
    prev_poll <= poll; prev_enable <= enable;
    if ( enable && ~prev_enable ) begin
        bits <= bit_value;
    end
    else begin
        if ( prev_poll && ~poll ) begin //negedge detected
            bits <= bits - 1;
        end
    end
    
    if ( poll && ~prev_poll ) begin //posedge detected
        if ( LC > 50 ) begin
            data[bits] <= 0; 
        end
        else begin
            data[bits] <= 1; 
        end
    end
    
    if ( poll == 0 ) begin
        LC <= LC + 1;
        if ( LC > 4 ) begin
            HC <= 0;
        end
        if ( LC > 250 ) begin
            LC <= 250; //LC should never get this large!
        end
    end
   
    if ( poll == 1 ) begin
        HC <= HC + 1;
        if ( HC > 4 ) begin
            LC <= 0;
        end
        if ( HC > 2500 ) begin
            HC <= 2500;
        end
    end

    //if ( prev_enable && ~enable ) begin //Controller's turn to talk. This block is just to check if a controller is here at all.

end

endmodule