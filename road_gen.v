module road_gen(
		  input [8:0] sprite_number,
		  input [8:0] X,
		  input [8:0] Y,
		  input [8:0] H_pos,
		  input [8:0] V_pos,
		  input       mirror,
		  output      state
		  );

   reg 			      sprite[0:3][0:15][0:15];
   wire 		      show_this_sprite[0:3];

   
   initial begin
      $readmemb("sprites16", sprite);
   end
   
   assign show_this_sprite[0] = (H_pos-X<16) & sprite[sprite_number][(V_pos-Y)&4'b1111][H_pos-X];
   assign show_this_sprite[1] = (H_pos-X<16) & sprite[sprite_number][(V_pos-Y)&4'b1111][15-H_pos+X];
   assign show_this_sprite[2] = (H_pos-X<16) & ~sprite[sprite_number][(V_pos-Y)&4'b1111][H_pos-X];
   assign show_this_sprite[3] = (H_pos-X<16) & ~sprite[sprite_number][(V_pos-Y)&4'b1111][15-H_pos+X];

   assign state=show_this_sprite[mirror+((((V_pos-Y)&5'b11111)>15)<<1)];
   
   
   endmodule // sprite_gen

		  
