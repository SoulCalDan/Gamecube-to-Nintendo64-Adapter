module top ( 
    input clk ,
    inout line_GC1 , line_GC2 , //line_GC3 , line_GC4 ,
    inout line_N1 , line_N2 , //line_N3 , line_N4 ,
    );

wire [4:0] Response1; wire [15:0] JoyL1; wire [15:0] JoyR1; wire [12:0] GCbuttons1; wire [19:0] A1; wire Rumble1;
wire [4:0] Response2; wire [15:0] JoyL2; wire [15:0] JoyR2; wire [12:0] GCbuttons2; wire [19:0] A2; wire Rumble2;
//wire [4:0] Response3; wire [15:0] JoyL3; wire [15:0] JoyR3; wire [12:0] GCbuttons3; wire [19:0] A3; wire Rumble3;
//wire [4:0] Response4; wire [15:0] JoyL4; wire [15:0] JoyR4; wire [12:0] GCbuttons4; wire [19:0] A4; wire Rumble4;

//Module List - GC1
GC_PollGen  GC_PollGen1     (.clk(clk),.GC_poll(GC_poll1),.GC_enable(GC_enable1),.Rumble(Rumble1));//,.reset_polling(reset_polling1));
bounce      bounce_GCC1     (.clk(clk),.line(line_GC1),.enable(GC_enable1),.debounced(data_GCC1));
GCC_Data    GCC_Data1       (.clk(clk),.poll(data_GCC1),.enable(GC_enable1),.JoyL(JoyL1),.JoyR(JoyR1),.GCbuttons(GCbuttons1)); 
AnalogGC    Analog1         (.JoyL(JoyL1),.JoyR(JoyR1),.A(A1),.analog_check(analog_check1));

//Module List - N64_1
bounce      bounce_N1      (.clk(clk),.enable(enable64_1),.line(line_N1),.debounced(data_N1));
N64_ID      N64_ID1          (.clk(clk),.data(data_N1),.Response(Response1),.Rumble(Rumble1));
Control     Control1         (.clk(clk),.GCbuttons(GCbuttons1),.Response(Response1),.N64_Controller(N64_Controller1),.enable(enable64_1),.analog_check(analog_check1),.A(A1));

//Module List - GC2
GC_PollGen  GC_PollGen2     (.clk(clk),.GC_poll(GC_poll2),.GC_enable(GC_enable2),.Rumble(Rumble2));//,.reset_polling(reset_polling2));
bounce      bounce_GCC2     (.clk(clk),.line(line_GC2),.enable(GC_enable2),.debounced(data_GCC2));
GCC_Data    GCC_Data2       (.clk(clk),.poll(data_GCC2),.enable(GC_enable2),.JoyL(JoyL2),.JoyR(JoyR2),.GCbuttons(GCbuttons2)); 
AnalogGC    Analog2         (.JoyL(JoyL2),.JoyR(JoyR2),.A(A2),.analog_check(analog_check2));

//Module List - N64_2
bounce      bounce_N2      (.clk(clk),.enable(enable64_2),.line(line_N2),.debounced(data_N2));
N64_ID      N64_ID2          (.clk(clk),.data(data_N2),.Response(Response2),.Rumble(Rumble2));
Control     Control2         (.clk(clk),.GCbuttons(GCbuttons2),.Response(Response2),.N64_Controller(N64_Controller2),.enable(enable64_2),.analog_check(analog_check2),.A(A2));

//Module List - GC3
//GC_PollGen  GC_PollGen3     (.clk(clk),.GC_poll(GC_poll3),.GC_enable(GC_enable3),.Rumble(Rumble3));//,.reset_polling(reset_polling3));
//bounce      bounce_GCC3     (.clk(clk),.line(line_GC3),.enable(GC_enable3),.debounced(data_GCC3));
//GCC_Data    GCC_Data3       (.clk(clk),.poll(data_GCC3),.enable(GC_enable3),.JoyL(JoyL3),.JoyR(JoyR3),.GCbuttons(GCbuttons3)); 
//AnalogGC    Analog3         (.JoyL(JoyL3),.JoyR(JoyR3),.A(A3),.analog_check(analog_check3));

//Module List - N64_3
//bounce      bounce_N3      (.clk(clk),.enable(enable64_3),.line(line_N3),.debounced(data_N3));
//N64_ID      N64_ID3          (.clk(clk),.data(data_N3),.Response(Response3),.Rumble(Rumble3));
//Control     Control3         (.clk(clk),.GCbuttons(GCbuttons3),.Response(Response3),.N64_Controller(N64_Controller3),.enable(enable64_3),.analog_check(analog_check3),.A(A3));

//Module List - GC4
//GC_PollGen  GC_PollGen4     (.clk(clk),.GC_poll(GC_poll4),.GC_enable(GC_enable4),.Rumble(Rumble4));//,.reset_polling(reset_polling4));
//bounce      bounce_GCC4     (.clk(clk),.line(line_GC4),.enable(GC_enable4),.debounced(data_GCC4));
//GCC_Data    GCC_Data4       (.clk(clk),.poll(data_GCC4),.enable(GC_enable4),.JoyL(JoyL4),.JoyR(JoyR4),.GCbuttons(GCbuttons4)); 
//AnalogGC    Analog4         (.JoyL(JoyL4),.JoyR(JoyR4),.A(A4),.analog_check(analog_check4));

//Module List - N64_4
//bounce      bounce_N4      (.clk(clk),.enable(enable64_4),.line(line_N4),.debounced(data_N4));
//N64_ID      N64_ID4          (.clk(clk),.data(data_N4),.Response(Response4),.Rumble(Rumble4));
//Control     Control4         (.clk(clk),.GCbuttons(GCbuttons4),.Response(Response4),.N64_Controller(N64_Controller4),.enable(enable64_4),.analog_check(analog_check4),.A(A4));


//GC Controller Ports
assign line_GC1 = GC_enable1 ? GC_poll1 : 1'bZ; // need to fix this pullup in final code!!! GC_poll should be 0 or z, never 1
assign line_GC2 = GC_enable2 ? GC_poll2 : 1'bZ;
//assign line_GC3 = GC_enable3 ? GC_poll3 : 1'bZ;
//assign line_GC4 = GC_enable4 ? GC_poll4 : 1'bZ;

//N64 Controller Ports
assign N64out1 = ( enable64_1 && ~N64_Controller1 ); assign line_N1 = N64out1 ? 1'b0 : 1'bZ; //pulls line to 0 if true, rises to z if false
assign N64out2 = ( enable64_2 && ~N64_Controller2 ); assign line_N2 = N64out2 ? 1'b0 : 1'bZ;
//assign N64out3 = ( enable64_3 && ~N64_Controller3 ); assign line_N3 = N64out3 ? 1'b0 : 1'bZ;
//assign N64out4 = ( enable64_4 && ~N64_Controller4 ); assign line_N4 = N64out4 ? 1'b0 : 1'bZ;

endmodule    