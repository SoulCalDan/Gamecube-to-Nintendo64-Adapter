module bounce (
    input clk , line , enable , 
    output debounced
    ); //This module fixes the inconsistent polling of the GC or GC adapter for use in other modules

reg debounced = 0; reg [2:0] low = 2'b000; reg [2:0] high = 2'b000; 

always @ ( posedge clk ) begin
    if ( enable == 0 ) begin
        if ( line == 1 ) begin
            high <= high + 1; low <= 3'b000;
        end
        if ( line == 0 ) begin
            low <= low + 1; high <= 3'b000;
        end
        if ( high == 3'b111 ) begin
            debounced <= 1;
        end
        if ( low == 3'b111 ) begin
            debounced <= 0;
        end
    end
    else begin
        low <= 3'b000; high <= 3'b000;
    end
end

endmodule