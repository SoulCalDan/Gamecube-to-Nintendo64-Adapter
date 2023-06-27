module Control (
	input clk , 
    input [12:0] GCbuttons ,
    input [4:0] Response ,
    input [19:0] A , 
	output enable , output clk_en , output analog_check ,
    output N64_Controller //N64 controller data order is A,B,Z,S,DU,DD,DL,DR,RESET,RESERVED,L,R,CU,CD,CL,CR,JX,JY
);

reg analog_check = 1; //the purpose of analog check is to stop GCC analog data from updating during a N64 write of analog data
reg [8:0] LetsGetReadyToRumble; reg bittest = 0; reg [7:0] E=8'b1000_0000;
reg [32:0] Controller;
reg [24:0] Status;
reg [8:0] PeriInsert; reg [8:0] PeriInsert2;
reg [264:0] PakResponse;
reg B_toggle = 0;
//parameter PakSize = 264;
reg [1:0] bit_place = 2'b11;
initial begin
	N64_Controller = 1'bz;
	Controller = 33'b0000_0000_0000_0000_00000000_00000000_1; 
	Status     = 25'b0000_0101_0000_0000_0000_0001_1; // stop bit should be 2us, I think
    PeriInsert = 9'b1110_0001_1; //stop bit should be 2us // xE1 is something inserted , x1E is nothing
    PeriInsert2= 9'b1011_1000_1; //stop bit should be 2us // xB8 for Rumble inserted?
	//PakResponse2= 	{F,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,B,M};
    PakResponse = 265'b10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10111000_1;
    //{E,8'hFF,8'hCC,8'h55,8'h99,E,E,8'h77,E,E,E,E,E,E,E,E,E,E,E,E,E,E,E,E,E,E,E,E,E,E,E,E,8'hb8,1};	//
    //PakResponse = {{32{8'h80}},8'hB8,1}; // Rumble returns x80, apparently, need to verify. Last bit should be 2us low 
    //PakResponse= {{32{8'h80}},8'hb8,1}; // Rumble returns x80, apparently, need to verify. Last bit should be 2us low 
    LetsGetReadyToRumble    = 9'b1000_0000_1;

end

always @ ( * ) begin
    Controller[32] = GCbuttons[08]; // A 
    Controller[31] = GCbuttons[09]; // B
    Controller[30] = GCbuttons[06]; // Z  should be 04, but swapped with L to be like VC
    Controller[29] = GCbuttons[12]; // Start
    Controller[28] = GCbuttons[03]; // DU
    Controller[27] = GCbuttons[02]; // DD
    Controller[26] = GCbuttons[00]; // DL
    Controller[25] = GCbuttons[01]; // DR
    Controller[24] = 2'b00;// Reset - always 0 except L+R+S
    Controller[23] = 2'b00;// Reserved - always 0
    Controller[22] = GCbuttons[00] && GCbuttons[04]; // L swapped with Z to be like VC
    Controller[21] = GCbuttons[05]; // R   
    Controller[20] = A[19]; // CU
    Controller[19] = GCbuttons[04] || A[18]; // CD or Z
    Controller[18] = A[17] || GCbuttons[11]; // CL or GC_Y
    Controller[17] = A[16] || GCbuttons[10]; // CR or GC_X
    Controller[16:09] = A[15:08]; // X on Joystick
    Controller[08:01] = A[07:00]; // Y on Joystick

	//if ( B_toggle ) begin
    //    PakResponse = {{32{8'h80}},{8{0}},1};
	//end
	//else begin
    //    PakResponse = {{32{8'h00}},{8{0}},1};
	//end
end

reg [8:0] bits = 8'd35; reg [8:0] bits2 = 9'd268; //PakSize; 
reg N64_Controller; reg enable;
always @ ( posedge clk ) begin

	if ( clk_en && Response[4:0] == 5'b10001 ) begin
        if ( bits < 34 ) begin
            if ( bit_place == 2'b00 ) begin
                N64_Controller <= 0; bit_place <= bit_place + 1;
            end
            else if ( bit_place == 2'b11 ) begin
                N64_Controller <= 1; bit_place <= bit_place + 1;
            end
            else begin
                N64_Controller <= Controller[bits]; bit_place <= bit_place + 1;
            end
        end
		if ( bits > 0  && bit_place == 2'b11  ) begin
			bits <= bits - 1; enable <= 1;
		end
		if ( bits == 0 && bit_place == 2'b11 ) begin
			bits <= 0; N64_Controller <= 1'b1;	enable <= 0; bit_place <= 2'b11;
		end
		if ( bits > 1 && bits < 20 ) begin
			analog_check <= 0;
		end
		else begin
			analog_check <= 1;
		end
	end

	else if ( clk_en && Response[4:0] == 5'b10010 ) begin
        if ( bits < 26 ) begin
            if ( bit_place == 2'b00 ) begin
                N64_Controller <= 0; bit_place <= bit_place + 1;
            end
            else if ( bit_place == 2'b11 ) begin
                N64_Controller <= 1; bit_place <= bit_place + 1;
            end
            else begin
                N64_Controller <= Status[bits]; bit_place <= bit_place + 1;
            end
        end
		if ( ( bits > 0 && bit_place == 2'b11 ) ) begin
			bits <= bits - 1; enable <= 1;
		end
		if ( bits == 0 && bit_place == 2'b11 ) begin
			bits <= 0; N64_Controller <= 1'b1;	enable <= 0; bit_place <= 2'b11;
		end
	end

	else if ( clk_en && Response[4:0] == 5'b10100 ) begin
        if ( bits < 10 ) begin
            if ( bit_place == 2'b00 ) begin
                N64_Controller <= 0; bit_place <= bit_place + 1;
            end
            else if ( bit_place == 2'b11 ) begin
                N64_Controller <= 1; bit_place <= bit_place + 1;
            end
            else begin
                N64_Controller <= PeriInsert[bits]; bit_place <= bit_place + 1;
            end
        end
		if (bits > 11 ) begin
			bits <= 11;
		end
		if ( ( bits > 0 && bits < 12 && bit_place == 2'b11 ) ) begin
			bits <= bits - 1; enable <= 1;
		end
		if ( bits == 0 && bit_place == 2'b11 ) begin
			bits <= 0; N64_Controller <= 1'b1;	enable <= 0; bit_place <= 2'b11;
		end
	end

	else if ( clk_en && Response[4:0] == 5'b10101 ) begin
        if ( bits < 10 ) begin
            if ( bit_place == 2'b00 ) begin
                N64_Controller <= 0; bit_place <= bit_place + 1;
            end
            else if ( bit_place == 2'b11 ) begin
                N64_Controller <= 1; bit_place <= bit_place + 1;
            end
            else begin
                N64_Controller <= PeriInsert2[bits]; bit_place <= bit_place + 1;
            end
        end
		if (bits > 11 ) begin
			bits <= 11;
		end
		if ( ( bits > 0 && bits < 12 && bit_place == 2'b11 ) ) begin
			bits <= bits - 1; enable <= 1;
		end
		if ( bits == 0 && bit_place == 2'b11 ) begin
			bits <= 0; N64_Controller <= 1'b1;	enable <= 0; bit_place <= 2'b11;
		end
	end
	
	else if ( clk_en && Response[4:0] == 5'b10110 ) begin
        if ( bits2 == 264 ) begin
            bittest <= 1;
        end
        if ( bits2 == 0 ) begin
            bittest <= 0;
        end
        if ( bits2 < 266 ) begin // Paksize=264 , PakResponse = [264:0] wide
            if ( bit_place == 2'b00 ) begin
                N64_Controller <= 0; bit_place <= bit_place + 1;
            end
            else if ( bit_place == 2'b11 ) begin
                N64_Controller <= 1; bit_place <= bit_place + 1;
            end
            else begin
                N64_Controller <= PakResponse[bits2]; bit_place <= bit_place + 1;
            end
        end
		if (bits2 > 264 + 3 ) begin
			bits2 <= 264 + 3; //PakSize + 3; 
		end
		if ( ( bits2 > 0 && bits2 < 268 && bit_place == 2'b11 ) ) begin //PakSize + 4
			bits2 <= bits2 - 1; enable <= 1; 
		end
		if ( bits2 == 0 && bit_place == 2'b11 ) begin
			bits2 <= 0; N64_Controller <= 1'b1;	enable <= 0; bit_place <= 2'b11; //B_toggle <= ~B_toggle;
		end
	end
	else if ( clk_en && Response[4:0] == 5'b10111 ) begin
        if ( bits < 10 ) begin
            if ( bit_place == 2'b00 ) begin
                N64_Controller <= 0; bit_place <= bit_place + 1;
            end
            else if ( bit_place == 2'b11 ) begin
                N64_Controller <= 1; bit_place <= bit_place + 1;
            end
            else begin
                N64_Controller <= LetsGetReadyToRumble[bits]; bit_place <= bit_place + 1;
            end
        end
		if (bits > 11 ) begin
			bits <= 11;
		end
		if ( ( bits > 0 && bits < 12 && bit_place == 2'b11 ) ) begin
			bits <= bits - 1; enable <= 1;
		end
		if ( bits == 0 && bit_place == 2'b11 ) begin
			bits <= 0; N64_Controller <= 1'b1;	enable <= 0; bit_place <= 2'b11;
		end
	end
	else if ( clk_en && Response[4] == 1'b0 ) begin //Response[4] is only 0 when no other poll conditions are not active
		bits <= 35; bits2 <= 264 + 4; bit_place <= 2'b11;
	end
end

reg [5:0] clk_div = 0; reg clk_en = 0;
always @ ( posedge clk ) begin // clk at 1_MHz
	clk_en <= 1'b0;	clk_div <= clk_div + 1;
	if ( clk_div > 26 ) begin
		clk_div <= 0; clk_en <= 1;
	end
end
		

 
endmodule