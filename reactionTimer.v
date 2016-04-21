//Jake Johnson 2016

//Reaction timer circuit made for ECEN 2350: Digital Logic

module reactionTimer(Clock, Reset, Pushn, LEDn, Digit1, Digit0);

	input Clock, Reset,Pushn;
	output wire LED;
	output wire [1:7]Digit1,Digit0;
	//reg LED;								//when you make a register, is it 
	wire [3:0]BCD1,BCD0;					//essentially adding a d-fliplop
	wire c9; 								//or some flip-flop to the circuit
	wire Q;									//to store the value?
	
	always@(posedge Clock)
	begin
		if(Q == 0)
			LED<=1;
		else if(Q == 1)
			LED<=0
	
	end
	
	
	/*
	always @(posedge Clock)
	begin
		if(!Pushn||Reset)
			LED<=1;
		else begin
			LED<=0;
		end
	end
	*/

	//assign LEDn = ~LED;

	clockDivider hundredHertz(Clock,c9); //divide clock to get our frequency

	BCDcount counter(c9,Reset,~LED,BCD1,BCD0);
	seg7 seg1(BCD1,Digit1);
	seg7 seg0(BCD0,Digit0);


/*
wire x,y,Q;

mux muxyMux(w,Q,1,x)

assign y = button & x & ~reset

flipflop flippyFlop(y,Clock,Q)
*/

endmodule



module BCDcount(Clock,Clear,E,BCD1,BCD0);
	input Clock,Clear,E;
	output reg [3:0]BCD1,BCD0;

	always@(posedge Clock)
	begin
		if(Clear) //if clear, set everything to 0
		begin
			BCD1<=0;
			BCD0<=0;
		end
		else if (E) //if enable...
			if(BCD0==4'b1001)//if BCD0 is 9 (left digit)
			begin
				BCD0<=0; //set it back to 0
				if(BCD1==4'b1001) //if BCD1 9
					BCD1<=0; //set back to 0
				else 
					BCD1<=BCD1+1; //otherwise increment
			end
		else 
			BCD0<=BCD0+1; //if !Clear and E, then increment BCD0
	end

	//note: as long as BCD0!=9, it increments on clockedge 
	//and BCD1 remains in its state, so BCDO goes up to 9
	//before BCD1 increments


	//ALSO: I think we could just add another BCD (BCD2) and make that 
	//increment everytime BCD1 gets to 9 (just put this incrementation 
	//inside an if statement exactly like what we did for BCD1 and BCD0)

endmodule

module seg7(bcd,leds);
	input [3:0]bcd;
	output reg[1:7] leds;

	always@(bcd)
		case(bcd)  //whenever bcd changes, change led outputs accordingly
					//abcdefg
			0: leds=7'b0000001;//1111110;
			1: leds=7'b1001111;//0110000;
			2: leds=7'b0010010;//1101101;
			3: leds=7'b0000110;//1111001;
			4: leds=7'b1001100;//0110011;
			5: leds=7'b0100100;//1011011;
			6: leds=7'b0100000;//1011111;
			7: leds=7'b0001111;//1110000;
			8: leds=7'b0000000;//1111111;
			9: leds=7'b0000100;//1111011;
			default: leds=7'bx;
		endcase

endmodule


//////////////////////Clock Divider///////////////////////////////////////////////////////
////////////takes in Clock and effectively outputs that frequency%10 ///////////////////////


module clockDivider(Clock,c19);
	input Clock;
	reg [19:0]Q;
	output reg c19;

	always@(posedge Clock)
	begin
		Q <= Q+1;
		
		c19 = Q[19];
	end

endmodule


		
////////////////////////////////////////
/////Extras/////////////// Extras///////
////////////////////////////////////////
////////////////EXTRAS//////////////////
////////////////////////////////////////
/////Extras////////////////Extras///////
////////////////////////////////////////
////////////////////////////////////////
/////Extras/////////////// Extras///////
////////////////////////////////////////
////////////////EXTRAS//////////////////
////////////////////////////////////////
/////Extras////////////////Extras///////
////////////////////////////////////////
////////////////////////////////////////
/////Extras/////////////// Extras///////
////////////////////////////////////////
////////////////EXTRAS//////////////////
////////////////////////////////////////
/////Extras////////////////Extras///////
////////////////////////////////////////
////////////////////////////////////////
/////Extras/////////////// Extras///////
////////////////////////////////////////
////////////////EXTRAS//////////////////
////////////////////////////////////////
/////Extras////////////////Extras///////
////////////////////////////////////////


///////////////////FLIP FLOP//////////////////////////////////
////D FLIPFLOP with asynchronous reset.//////////////////

module flipflop(D,Clock,Q);
	input D,Clock;
	output reg Q;

	always@(posedge Clock)
		Q=D;

endmodule


//////2-1 mux attached to D Flipflop/////////////////

module muxdff(D0,D1,Sel,Clock,Q);
	input D0,D1,Sel,Clock;
	output reg Q;

	always@(posedge Clock)
		if(!Sel)
			Q<=D0;
		else
			Q<=D1;

endmodule

/////////////////////////MUX///////////////////////////////////////
module mux(s,w0,w1,f);
	input s,w0,w1;
	output reg f;

	always@(s)
	begin
		if (s)
			f = w1;
		else
			f = w0;
	end

endmodule


////////////////////////////////////////////////

/*
module buttonPressLogic(button,w,Clock,reset);

always@(posedge Clock)
	D

endmodule
*/


/////////////////////////////////////////////

/*


module ParLoadCounter(enable,d0,d1,d2,d3,load,clock,q0,q1,q2,q3);

input(enable,d0,d1,d2,d3,load,clock,q0,q1,q2,q3);
output(q0,q1,q2,q3);
wire [0:7];



//load is 1 for a reset (see figure 5.24)


endmodule

*/







