module AnalogGC (
    input [15:0] JoyL , input [15:0] JoyR ,
    input analog_check ,
    output [19:0] A
);
reg CL,CR,CU,CD; 
reg [7:0] x = 8'd0; 
reg [7:0] y = 8'd0; 
assign A[19:0] = {CD,CU,CL,CR,x,y};

always @ ( * ) begin
    if ( analog_check == 0 ) begin
    case ( JoyL[15:08] )
        8'd0: x <= 8'd155;8'd1: x <= 8'd156;8'd2: x <= 8'd157;8'd3: x <= 8'd157;8'd4: x <= 8'd158;8'd5: x <= 8'd159;8'd6: x <= 8'd160;8'd7: x <= 8'd160;8'd8: x <= 8'd161;8'd9: x <= 8'd162;8'd10: x <= 8'd163;8'd11: x <= 8'd164;8'd12: x <= 8'd164;8'd13: x <= 8'd165;8'd14: x <= 8'd166;8'd15: x <= 8'd167;8'd16: x <= 8'd168;8'd17: x <= 8'd168;8'd18: x <= 8'd169;8'd19: x <= 8'd170;8'd20: x <= 8'd171;8'd21: x <= 8'd171;8'd22: x <= 8'd172;8'd23: x <= 8'd173;8'd24: x <= 8'd174;8'd25: x <= 8'd175;8'd26: x <= 8'd175;8'd27: x <= 8'd176;8'd28: x <= 8'd177;8'd29: x <= 8'd178;8'd30: x <= 8'd178;8'd31: x <= 8'd179;8'd32: x <= 8'd180;8'd33: x <= 8'd181;8'd34: x <= 8'd182;8'd35: x <= 8'd182;8'd36: x <= 8'd183;8'd37: x <= 8'd184;8'd38: x <= 8'd185;8'd39: x <= 8'd185;8'd40: x <= 8'd186;8'd41: x <= 8'd187;8'd42: x <= 8'd188;8'd43: x <= 8'd189;8'd44: x <= 8'd189;8'd45: x <= 8'd190;8'd46: x <= 8'd191;8'd47: x <= 8'd192;8'd48: x <= 8'd193;8'd49: x <= 8'd193;8'd50: x <= 8'd194;8'd51: x <= 8'd195;8'd52: x <= 8'd196;8'd53: x <= 8'd196;8'd54: x <= 8'd197;8'd55: x <= 8'd198;8'd56: x <= 8'd199;8'd57: x <= 8'd200;8'd58: x <= 8'd200;8'd59: x <= 8'd201;8'd60: x <= 8'd202;8'd61: x <= 8'd203;8'd62: x <= 8'd203;8'd63: x <= 8'd204;8'd64: x <= 8'd205;8'd65: x <= 8'd206;8'd66: x <= 8'd207;8'd67: x <= 8'd207;8'd68: x <= 8'd208;8'd69: x <= 8'd209;8'd70: x <= 8'd210;8'd71: x <= 8'd210;8'd72: x <= 8'd211;8'd73: x <= 8'd212;8'd74: x <= 8'd213;8'd75: x <= 8'd214;8'd76: x <= 8'd214;8'd77: x <= 8'd215;8'd78: x <= 8'd216;8'd79: x <= 8'd217;8'd80: x <= 8'd218;8'd81: x <= 8'd218;8'd82: x <= 8'd219;8'd83: x <= 8'd220;8'd84: x <= 8'd221;8'd85: x <= 8'd221;8'd86: x <= 8'd222;8'd87: x <= 8'd223;8'd88: x <= 8'd224;8'd89: x <= 8'd225;8'd90: x <= 8'd225;8'd91: x <= 8'd226;8'd92: x <= 8'd227;8'd93: x <= 8'd228;8'd94: x <= 8'd228;8'd95: x <= 8'd229;8'd96: x <= 8'd230;8'd97: x <= 8'd231;8'd98: x <= 8'd232;8'd99: x <= 8'd232;8'd100: x <= 8'd233;8'd101: x <= 8'd234;8'd102: x <= 8'd235;8'd103: x <= 8'd235;8'd104: x <= 8'd236;8'd105: x <= 8'd237;8'd106: x <= 8'd238;8'd107: x <= 8'd239;8'd108: x <= 8'd239;8'd109: x <= 8'd240;8'd110: x <= 8'd241;8'd111: x <= 8'd242;8'd112: x <= 8'd243;8'd113: x <= 8'd243;8'd114: x <= 8'd244;8'd115: x <= 8'd245;8'd116: x <= 8'd246;8'd117: x <= 8'd246;8'd118: x <= 8'd247;8'd119: x <= 8'd248;8'd120: x <= 8'd249;8'd121: x <= 8'd250;8'd122: x <= 8'd250;8'd123: x <= 8'd251;8'd124: x <= 8'd252;8'd125: x <= 8'd253;8'd126: x <= 8'd253;8'd127: x <= 8'd254;8'd128: x <= 8'd255;8'd129: x <= 8'd0;8'd130: x <= 8'd1;8'd131: x <= 8'd2;8'd132: x <= 8'd3;8'd133: x <= 8'd3;8'd134: x <= 8'd4;8'd135: x <= 8'd5;8'd136: x <= 8'd6;8'd137: x <= 8'd7;8'd138: x <= 8'd7;8'd139: x <= 8'd8;8'd140: x <= 8'd9;8'd141: x <= 8'd10;8'd142: x <= 8'd10;8'd143: x <= 8'd11;8'd144: x <= 8'd12;8'd145: x <= 8'd13;8'd146: x <= 8'd14;8'd147: x <= 8'd14;8'd148: x <= 8'd15;8'd149: x <= 8'd16;8'd150: x <= 8'd17;8'd151: x <= 8'd17;8'd152: x <= 8'd18;8'd153: x <= 8'd19;8'd154: x <= 8'd20;8'd155: x <= 8'd21;8'd156: x <= 8'd21;8'd157: x <= 8'd22;8'd158: x <= 8'd23;8'd159: x <= 8'd24;8'd160: x <= 8'd25;8'd161: x <= 8'd25;8'd162: x <= 8'd26;8'd163: x <= 8'd27;8'd164: x <= 8'd28;8'd165: x <= 8'd28;8'd166: x <= 8'd29;8'd167: x <= 8'd30;8'd168: x <= 8'd31;8'd169: x <= 8'd32;8'd170: x <= 8'd32;8'd171: x <= 8'd33;8'd172: x <= 8'd34;8'd173: x <= 8'd35;8'd174: x <= 8'd35;8'd175: x <= 8'd36;8'd176: x <= 8'd37;8'd177: x <= 8'd38;8'd178: x <= 8'd39;8'd179: x <= 8'd39;8'd180: x <= 8'd40;8'd181: x <= 8'd41;8'd182: x <= 8'd42;8'd183: x <= 8'd42;8'd184: x <= 8'd43;8'd185: x <= 8'd44;8'd186: x <= 8'd45;8'd187: x <= 8'd46;8'd188: x <= 8'd46;8'd189: x <= 8'd47;8'd190: x <= 8'd48;8'd191: x <= 8'd49;8'd192: x <= 8'd50;8'd193: x <= 8'd50;8'd194: x <= 8'd51;8'd195: x <= 8'd52;8'd196: x <= 8'd53;8'd197: x <= 8'd53;8'd198: x <= 8'd54;8'd199: x <= 8'd55;8'd200: x <= 8'd56;8'd201: x <= 8'd57;8'd202: x <= 8'd57;8'd203: x <= 8'd58;8'd204: x <= 8'd59;8'd205: x <= 8'd60;8'd206: x <= 8'd60;8'd207: x <= 8'd61;8'd208: x <= 8'd62;8'd209: x <= 8'd63;8'd210: x <= 8'd64;8'd211: x <= 8'd64;8'd212: x <= 8'd65;8'd213: x <= 8'd66;8'd214: x <= 8'd67;8'd215: x <= 8'd67;8'd216: x <= 8'd68;8'd217: x <= 8'd69;8'd218: x <= 8'd70;8'd219: x <= 8'd71;8'd220: x <= 8'd71;8'd221: x <= 8'd72;8'd222: x <= 8'd73;8'd223: x <= 8'd74;8'd224: x <= 8'd75;8'd225: x <= 8'd75;8'd226: x <= 8'd76;8'd227: x <= 8'd77;8'd228: x <= 8'd78;8'd229: x <= 8'd78;8'd230: x <= 8'd79;8'd231: x <= 8'd80;8'd232: x <= 8'd81;8'd233: x <= 8'd82;8'd234: x <= 8'd82;8'd235: x <= 8'd83;8'd236: x <= 8'd84;8'd237: x <= 8'd85;8'd238: x <= 8'd85;8'd239: x <= 8'd86;8'd240: x <= 8'd87;8'd241: x <= 8'd88;8'd242: x <= 8'd89;8'd243: x <= 8'd89;8'd244: x <= 8'd90;8'd245: x <= 8'd91;8'd246: x <= 8'd92;8'd247: x <= 8'd92;8'd248: x <= 8'd93;8'd249: x <= 8'd94;8'd250: x <= 8'd95;8'd251: x <= 8'd96;8'd252: x <= 8'd96;8'd253: x <= 8'd97;8'd254: x <= 8'd98;8'd255: x <= 8'd99;
        default x <= 8'd0;
    endcase
    
    case ( JoyL[07:00] )
        8'd0: y <= 8'd155;8'd1: y <= 8'd156;8'd2: y <= 8'd157;8'd3: y <= 8'd157;8'd4: y <= 8'd158;8'd5: y <= 8'd159;8'd6: y <= 8'd160;8'd7: y <= 8'd160;8'd8: y <= 8'd161;8'd9: y <= 8'd162;8'd10: y <= 8'd163;8'd11: y <= 8'd164;8'd12: y <= 8'd164;8'd13: y <= 8'd165;8'd14: y <= 8'd166;8'd15: y <= 8'd167;8'd16: y <= 8'd168;8'd17: y <= 8'd168;8'd18: y <= 8'd169;8'd19: y <= 8'd170;8'd20: y <= 8'd171;8'd21: y <= 8'd171;8'd22: y <= 8'd172;8'd23: y <= 8'd173;8'd24: y <= 8'd174;8'd25: y <= 8'd175;8'd26: y <= 8'd175;8'd27: y <= 8'd176;8'd28: y <= 8'd177;8'd29: y <= 8'd178;8'd30: y <= 8'd178;8'd31: y <= 8'd179;8'd32: y <= 8'd180;8'd33: y <= 8'd181;8'd34: y <= 8'd182;8'd35: y <= 8'd182;8'd36: y <= 8'd183;8'd37: y <= 8'd184;8'd38: y <= 8'd185;8'd39: y <= 8'd185;8'd40: y <= 8'd186;8'd41: y <= 8'd187;8'd42: y <= 8'd188;8'd43: y <= 8'd189;8'd44: y <= 8'd189;8'd45: y <= 8'd190;8'd46: y <= 8'd191;8'd47: y <= 8'd192;8'd48: y <= 8'd193;8'd49: y <= 8'd193;8'd50: y <= 8'd194;8'd51: y <= 8'd195;8'd52: y <= 8'd196;8'd53: y <= 8'd196;8'd54: y <= 8'd197;8'd55: y <= 8'd198;8'd56: y <= 8'd199;8'd57: y <= 8'd200;8'd58: y <= 8'd200;8'd59: y <= 8'd201;8'd60: y <= 8'd202;8'd61: y <= 8'd203;8'd62: y <= 8'd203;8'd63: y <= 8'd204;8'd64: y <= 8'd205;8'd65: y <= 8'd206;8'd66: y <= 8'd207;8'd67: y <= 8'd207;8'd68: y <= 8'd208;8'd69: y <= 8'd209;8'd70: y <= 8'd210;8'd71: y <= 8'd210;8'd72: y <= 8'd211;8'd73: y <= 8'd212;8'd74: y <= 8'd213;8'd75: y <= 8'd214;8'd76: y <= 8'd214;8'd77: y <= 8'd215;8'd78: y <= 8'd216;8'd79: y <= 8'd217;8'd80: y <= 8'd218;8'd81: y <= 8'd218;8'd82: y <= 8'd219;8'd83: y <= 8'd220;8'd84: y <= 8'd221;8'd85: y <= 8'd221;8'd86: y <= 8'd222;8'd87: y <= 8'd223;8'd88: y <= 8'd224;8'd89: y <= 8'd225;8'd90: y <= 8'd225;8'd91: y <= 8'd226;8'd92: y <= 8'd227;8'd93: y <= 8'd228;8'd94: y <= 8'd228;8'd95: y <= 8'd229;8'd96: y <= 8'd230;8'd97: y <= 8'd231;8'd98: y <= 8'd232;8'd99: y <= 8'd232;8'd100: y <= 8'd233;8'd101: y <= 8'd234;8'd102: y <= 8'd235;8'd103: y <= 8'd235;8'd104: y <= 8'd236;8'd105: y <= 8'd237;8'd106: y <= 8'd238;8'd107: y <= 8'd239;8'd108: y <= 8'd239;8'd109: y <= 8'd240;8'd110: y <= 8'd241;8'd111: y <= 8'd242;8'd112: y <= 8'd243;8'd113: y <= 8'd243;8'd114: y <= 8'd244;8'd115: y <= 8'd245;8'd116: y <= 8'd246;8'd117: y <= 8'd246;8'd118: y <= 8'd247;8'd119: y <= 8'd248;8'd120: y <= 8'd249;8'd121: y <= 8'd250;8'd122: y <= 8'd250;8'd123: y <= 8'd251;8'd124: y <= 8'd252;8'd125: y <= 8'd253;8'd126: y <= 8'd253;8'd127: y <= 8'd254;8'd128: y <= 8'd255;8'd129: y <= 8'd0;8'd130: y <= 8'd1;8'd131: y <= 8'd2;8'd132: y <= 8'd3;8'd133: y <= 8'd3;8'd134: y <= 8'd4;8'd135: y <= 8'd5;8'd136: y <= 8'd6;8'd137: y <= 8'd7;8'd138: y <= 8'd7;8'd139: y <= 8'd8;8'd140: y <= 8'd9;8'd141: y <= 8'd10;8'd142: y <= 8'd10;8'd143: y <= 8'd11;8'd144: y <= 8'd12;8'd145: y <= 8'd13;8'd146: y <= 8'd14;8'd147: y <= 8'd14;8'd148: y <= 8'd15;8'd149: y <= 8'd16;8'd150: y <= 8'd17;8'd151: y <= 8'd17;8'd152: y <= 8'd18;8'd153: y <= 8'd19;8'd154: y <= 8'd20;8'd155: y <= 8'd21;8'd156: y <= 8'd21;8'd157: y <= 8'd22;8'd158: y <= 8'd23;8'd159: y <= 8'd24;8'd160: y <= 8'd25;8'd161: y <= 8'd25;8'd162: y <= 8'd26;8'd163: y <= 8'd27;8'd164: y <= 8'd28;8'd165: y <= 8'd28;8'd166: y <= 8'd29;8'd167: y <= 8'd30;8'd168: y <= 8'd31;8'd169: y <= 8'd32;8'd170: y <= 8'd32;8'd171: y <= 8'd33;8'd172: y <= 8'd34;8'd173: y <= 8'd35;8'd174: y <= 8'd35;8'd175: y <= 8'd36;8'd176: y <= 8'd37;8'd177: y <= 8'd38;8'd178: y <= 8'd39;8'd179: y <= 8'd39;8'd180: y <= 8'd40;8'd181: y <= 8'd41;8'd182: y <= 8'd42;8'd183: y <= 8'd42;8'd184: y <= 8'd43;8'd185: y <= 8'd44;8'd186: y <= 8'd45;8'd187: y <= 8'd46;8'd188: y <= 8'd46;8'd189: y <= 8'd47;8'd190: y <= 8'd48;8'd191: y <= 8'd49;8'd192: y <= 8'd50;8'd193: y <= 8'd50;8'd194: y <= 8'd51;8'd195: y <= 8'd52;8'd196: y <= 8'd53;8'd197: y <= 8'd53;8'd198: y <= 8'd54;8'd199: y <= 8'd55;8'd200: y <= 8'd56;8'd201: y <= 8'd57;8'd202: y <= 8'd57;8'd203: y <= 8'd58;8'd204: y <= 8'd59;8'd205: y <= 8'd60;8'd206: y <= 8'd60;8'd207: y <= 8'd61;8'd208: y <= 8'd62;8'd209: y <= 8'd63;8'd210: y <= 8'd64;8'd211: y <= 8'd64;8'd212: y <= 8'd65;8'd213: y <= 8'd66;8'd214: y <= 8'd67;8'd215: y <= 8'd67;8'd216: y <= 8'd68;8'd217: y <= 8'd69;8'd218: y <= 8'd70;8'd219: y <= 8'd71;8'd220: y <= 8'd71;8'd221: y <= 8'd72;8'd222: y <= 8'd73;8'd223: y <= 8'd74;8'd224: y <= 8'd75;8'd225: y <= 8'd75;8'd226: y <= 8'd76;8'd227: y <= 8'd77;8'd228: y <= 8'd78;8'd229: y <= 8'd78;8'd230: y <= 8'd79;8'd231: y <= 8'd80;8'd232: y <= 8'd81;8'd233: y <= 8'd82;8'd234: y <= 8'd82;8'd235: y <= 8'd83;8'd236: y <= 8'd84;8'd237: y <= 8'd85;8'd238: y <= 8'd85;8'd239: y <= 8'd86;8'd240: y <= 8'd87;8'd241: y <= 8'd88;8'd242: y <= 8'd89;8'd243: y <= 8'd89;8'd244: y <= 8'd90;8'd245: y <= 8'd91;8'd246: y <= 8'd92;8'd247: y <= 8'd92;8'd248: y <= 8'd93;8'd249: y <= 8'd94;8'd250: y <= 8'd95;8'd251: y <= 8'd96;8'd252: y <= 8'd96;8'd253: y <= 8'd97;8'd254: y <= 8'd98;8'd255: y <= 8'd99;
        default y <= 8'd0;
    endcase
    end
    else begin
        x <= 1; y <= 1;
    end
	
    if ( JoyR[15:08] < 8'd55 ) begin //Cstick X
        CL = 1'b1;  
        CR = 1'b0;
    end
    else if ( JoyR[15:08] > 8'd200 ) begin
        CL = 1'b0;  
        CR = 1'b1;
    end
    else begin
        CL = 1'b0;  
        CR = 1'b0;
    end
    if ( JoyR[07:00] < 8'd55 ) begin //Cstick Y
        CU = 1'b1;  
        CD = 1'b0;
    end
    else if ( JoyR[07:00] > 8'd200 ) begin
        CU = 1'b0;  
        CD = 1'b1;
    end
    else begin
        CU = 1'b0;  
        CD = 1'b0;
    end    
end

endmodule