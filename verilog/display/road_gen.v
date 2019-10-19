module road_gen(
		  input [1:0] sprite_number,
		  input [8:0] X,
		  input [4:0] Y,
		  input [8:0] H_pos,
		  input [8:0] V_pos,
		  input       mirror,
		  output      state
		  );

   reg 			      sprite[0:3][0:15][0:15];
   wire 		      show_this_sprite[0:3];
   wire [4:0] 		      Y_diff=V_pos[4:0]-Y;
   wire [3:0] 		      X_diff=H_pos[3:0]-X[3:0];
   wire [4:0] 		      X_diffm=15-H_pos[4:0]+X[4:0];
   
   
   initial begin
      $readmemb("ROM/sprites16", sprite);
   end
   
   assign show_this_sprite[0] = (H_pos-X<16) & sprite[sprite_number][Y_diff[3:0]][X_diff];
   assign show_this_sprite[1] = (H_pos-X<16) & sprite[sprite_number][Y_diff[3:0]][X_diffm[3:0]];//mirrored
   assign show_this_sprite[2] = (H_pos-X<16) & ~sprite[sprite_number][Y_diff[3:0]][X_diff];//color inverted
   assign show_this_sprite[3] = (H_pos-X<16) & ~sprite[sprite_number][Y_diff[3:0]][X_diffm[3:0]];//mirror and color inverted

   assign state=show_this_sprite[{(Y_diff>15),mirror}];
   
   
   endmodule // sprite_gen

		  
