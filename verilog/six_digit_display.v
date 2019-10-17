module six_digit_display(
			 input 	      clk,
			 input [19:0] sauce,
			 input [8:0]  X,
			 input [8:0]  Y,
			 input [8:0]  H_pos,
			 input [8:0]  V_pos,
			 output       six_digit_number
			 );
   
   reg [3:0] 			      six_digit_reg[0:5];
   reg [19:0] 			      displayed_score=0;
   reg 				      ready_reg;
   
   wire 			      digit0;
   wire 			      digit1;
   wire 			      digit2;
   wire 			      digit3;
   wire 			      digit4;
   wire 			      digit5;
   
   integer 			      k;
   

   sprite_gen dig0(
		   .sprite_table(1),
		   .sprite_number({5'b00000,six_digit_reg[0]}),
		   .X(X+20),
		   .Y(Y),
		   .H_pos(H_pos),
		   .V_pos(V_pos),
		   .state(digit0)
		   );
   
   sprite_gen dig1(
		   .sprite_table(1),
		   .sprite_number({5'b00000,six_digit_reg[1]}),
		   .X(X+16),
		   .Y(Y),
		   .H_pos(H_pos),
		   .V_pos(V_pos),
		   .state(digit1)
		   );
   sprite_gen dig2(
		   .sprite_table(1),
		   .sprite_number({5'b00000,six_digit_reg[2]}),
		   .X(X+12),
		   .Y(Y),
		   .H_pos(H_pos),
		   .V_pos(V_pos),
		   .state(digit2)
		   );

   sprite_gen dig3(
		   .sprite_table(1),
		   .sprite_number({5'b00000,six_digit_reg[3]}),
		   .X(X+8),
		   .Y(Y),
		   .H_pos(H_pos),
		   .V_pos(V_pos),
		   .state(digit3)
		   );
   
   sprite_gen dig4(
		   .sprite_table(1),
		   .sprite_number({5'b00000,six_digit_reg[4]}),
		   .X(X+4),
		   .Y(Y),
		   .H_pos(H_pos),
		   .V_pos(V_pos),
		   .state(digit4)
		   );
   sprite_gen dig5(
		   .sprite_table(1),
		   .sprite_number({5'b00000,six_digit_reg[5]}),
		   .X(X),
		   .Y(Y),
		   .H_pos(H_pos),
		   .V_pos(V_pos),
		   .state(digit5)
		   );

   
   always@(posedge clk)
     begin	
	if(displayed_score<sauce)
	  begin
	     displayed_score<=displayed_score+1;
	     ready_reg<=0;
	     if(six_digit_reg[0]<9)six_digit_reg[0]<=six_digit_reg[0]+1;
	     else
	       begin
		  six_digit_reg[0]<=0;
		  if(six_digit_reg[1]<9) six_digit_reg[1]<=six_digit_reg[1]+1;
		  else
		    begin
		       six_digit_reg[1]<=0;
		       if(six_digit_reg[2]<9) six_digit_reg[2]<=six_digit_reg[2]+1;
		       else
			 begin
			    six_digit_reg[2]<=0;
			    if(six_digit_reg[3]<9) six_digit_reg[3]<=six_digit_reg[3]+1;
			    else
			      begin
				 six_digit_reg[3]<=0;
				 if(six_digit_reg[4]<9) six_digit_reg[4]<=six_digit_reg[4]+1;
				 else
				   begin
				      six_digit_reg[4]<=0;
				      if(six_digit_reg[5]<9) six_digit_reg[5]<=six_digit_reg[5]+1;
				      else
					begin 
					   six_digit_reg[5]<=0;
					   displayed_score<=0;
					end
				   end // else: !if(six_digit_reg[4]<9)
			      end // else: !if(six_digit_reg[3]<9)
			 end // else: !if(six_digit_reg[2]<9)
		    end // else: !if(six_digit_reg[1]<9)
	       end // else: !if(six_digit_reg[0]<9)
	  end // if (displayed_score<sauce)
	else if (displayed_score>sauce)
	  begin
	     displayed_score<=0;
	     for(k=0;k<6;k=k+1)six_digit_reg[k]<=0;
	     ready_reg<=0;
	  end
	else ready_reg<=1;
     end // always@ (clk)

   assign six_digit_number=digit0|digit1|digit2|digit3|digit4|digit5;
   
   
endmodule // six_digit_display
