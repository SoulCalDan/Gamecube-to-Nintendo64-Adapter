module N64_ID (
    input clk , data ,
    output [4:0] Response , output Rumble //, output [2:0] pak
);

reg prev_data; reg [4:0] Response = 5'b00000; reg Rumble = 0;
reg [7:0] LC = 0; reg [7:0] HC = 0; // low count and high count
reg [8:0] IDcounter = 9'b0; 
reg [300:0] ID = 26'b0; reg bc = 1;
//reg [2:0] pak; //type of pak inserted. 000 for none, 001 for rumble, 002 for saves. Good luck implementing GameBoy pak!!!

always @ ( posedge clk ) begin

    prev_data <= data;
    if ( prev_data && ~data ) begin // negedge detected
        if ( HC > 150 ) begin //if high count is rather large, the data line has been pulled high for a while
            IDcounter <= 0;
			ID[31:0] <= 32'b0;
        end
        else begin
            IDcounter <= IDcounter + 1;
        end
    end
    if ( data && ~prev_data ) begin // posedge detected
        if ( LC > 50 ) begin //try to sample in middle of bit (when low count has been low for a couple microseconds)
            ID[IDcounter] <= 0;
        end
        else begin
            ID[IDcounter] <= 1;
        end
    end
    
    if ( data == 1 ) begin
        HC <= HC + 1;
        if ( HC > 4 ) begin // reset low count
            LC <= 0;
        end
        if ( HC > 201 ) begin
            HC <= 250; // the data line being high a long time means no recent polling has occurred. Typical is 30-60 polls per second for N64 games.
        end
    end
    if ( data == 0 ) begin    
        LC <= LC + 1;
        if ( LC > 4 ) begin // reset high count
            HC <= 0;
        end
        if ( LC > 201 ) begin 
            LC <= 250; // the data line should never be low for more than 3us or else something is wrong!
        end
    end

end

always @ ( negedge clk ) begin
    if ( IDcounter == 8 && ID[7:0] == 8'b10000000 ) begin //standard N64 polling. Respond with 32 bits of controller data
        Response[4:0] <= 5'b10001;
    end
    else if ( IDcounter == 8 && ( (ID[7:0] == 8'b00000000) || (ID[7:0] == 8'b11111111) ) ) begin //24 bit response of controller status
        Response[4:0] <= 5'b10010; //x00 N64 command for controller testing? Controller responds with 3 bytes , 0x05_00, then the last byte is 0x04 for CRC error, 0x02 controller pak removed, 0x01 is some type of pak (controller or rumble) connected , 0x00 is no pak at power on
    end 
    else if ( IDcounter == 8 && ID[7:0] == 8'b00000010 ) begin // N64 is doing a controller pak read
        Response[4:0] <= 5'b10011;
    end
    else if ( IDcounter == 280 && ID[31:0] == 32'b0111_1111_1000_0000_0000_0001_1100_0000 ) begin // x038001 //n64 asking for rumble or controller pak
        Response[4:0] <= 5'b10100; // N64 asking what type of peripheral, followed by 32 bytes of xFE
    end
    else if ( IDcounter == 280 && ID[31:0] == 32'b0000_0001_1000_0000_0000_0001_1100_0000 ) begin // x038001 //n64 asking for rumble or controller pak
        Response[4:0] <= 5'b10101; // N64 asking what type of peripheral, followed by 32 bytes of x80. Response is xB8
    end
    else if ( IDcounter == 24 && ID[23:0] == 24'b1000_0000_0000_0001_0100_0000 ) begin // x028001 //n64 asking for rumble or controller pak
        Response[4:0] <= 5'b10110; // N64 asking for data from rumble or controller pak
	end
	else if ( IDcounter == 279 && ( (ID[31:0] == 32'b1000_0000_1101_1000_0000_0011_1100_0000) || (ID[31:0] == 32'b0000_0000_1101_1000_0000_0011_1100_0000) ) ) begin //turn rumble on/off
		Response[4:0] <= 5'b10111; Rumble <= ID[31]; //technically the 010101 pattern is 32bytes, but they repeat. No need to check them all!
	end
    else if ( IDcounter == 0 ) begin
        Response[4:0] <= 5'b00000;
    end
end

endmodule