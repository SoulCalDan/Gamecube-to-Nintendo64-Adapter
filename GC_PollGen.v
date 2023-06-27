module GC_PollGen ( input clk , output reg GC_poll , output reg GC_enable , input Rumble //, input reset_polling 
);

//reg [35:0] Connect =    36'b0001_0001_0001_0001_0001_0001_0001_0001_0111;
//reg [35:0] Sync =       36'b0001_0111_0001_0001_0001_0001_0001_0111_0111;
reg [24:0] Data =   25'b0100_0000_0000_0011_0000_0000_1; 
reg GC_poll = 1;

initial begin
	poll_period = 1000; //poll period of 1000 is about 1ms polling
end
parameter bits = 11; parameter bits_reset = 1000; reg [11:0] poll_period;
reg [bits:0] bit_counter = bits_reset; reg [1:0] bit_place = 0;
reg [3:0] clk_counter = 0; 
reg GC = 0; reg clk1MHz = 0; reg last_successful_poll = 0; reg [bits:0] last_successful_count;

always @ ( posedge GC ) begin
	if ( bit_counter < 25 ) begin 
        if ( bit_place == 2'b00 ) begin
		GC_poll <= 1'b0;
        end else if ( bit_place == 2'b11 ) begin
            GC_poll <= 1'b1; 
            bit_counter <= bit_counter - 1; 
        end else begin
            GC_poll <= Data[bit_counter];
        end
		bit_place <= bit_place + 1;
	end
	else begin
        bits_place <= 2'b11;
		if ( bit_counter > bits_reset ) begin //&& last_successful_poll == 0 ) begin // counter wrapped 
				bit_counter <= bits_reset;
		end
		else begin
			bit_counter <= bit_counter - 1; 
		end
	end
end

always @ ( posedge clk ) begin //divides the 27MHz clk to 1MHz
	clk_counter <= clk_counter + 1; clk1MHz <= 1'b0;
	if ( clk_counter == 12 ) begin 
		clk1MHz <= 1'b1; clk_counter <= 0;
	end
    if ( clk1MHz ) begin
        GC <= ~ GC;
        if ( bit_counter < 27 ) begin
            if ( bit_place > 2'b01 && bit_counter == 0 ) begin
			    GC_enable <= 0; //FPGA gives control of the data line to Gamecube controller
            end else begin
                GC_enable <= 1;
            end
		end
		else begin
            GC_enable <= 0;
		end
    end
end

always @ ( * ) begin
	Data[1] = Rumble;
end

endmodule
