`include "defines.v"

module keyboard_to_vga_decoder(
	input wire[7:0] kdata,
	output reg[7:0] vdata
);

always @ (*) begin
	case (kdata)
		`ScanCode_0:vdata<=`KEY_0;
		`ScanCode_1:vdata<=`KEY_1;
		`ScanCode_2:vdata<=`KEY_2;
		`ScanCode_3:vdata<=`KEY_3;
		`ScanCode_4:vdata<=`KEY_4;
		`ScanCode_5:vdata<=`KEY_5;
		`ScanCode_6:vdata<=`KEY_6;
		`ScanCode_7:vdata<=`KEY_7;
		`ScanCode_8:vdata<=`KEY_8;
		`ScanCode_9:vdata<=`KEY_9;
		`ScanCode_A:vdata<=`KEY_A;
		`ScanCode_B:vdata<=`KEY_B;
		`ScanCode_C:vdata<=`KEY_C;
		`ScanCode_D:vdata<=`KEY_D;
		`ScanCode_E:vdata<=`KEY_E;
		`ScanCode_F:vdata<=`KEY_F;
		`ScanCode_G:vdata<=`KEY_G;
		`ScanCode_H:vdata<=`KEY_H;
		`ScanCode_I:vdata<=`KEY_I;
		`ScanCode_J:vdata<=`KEY_J;
		`ScanCode_K:vdata<=`KEY_K;
		`ScanCode_L:vdata<=`KEY_L;
		`ScanCode_M:vdata<=`KEY_M;
		`ScanCode_N:vdata<=`KEY_N;
		`ScanCode_O:vdata<=`KEY_O;
		`ScanCode_P:vdata<=`KEY_P;
		`ScanCode_Q:vdata<=`KEY_Q;
		`ScanCode_R:vdata<=`KEY_R;
		`ScanCode_S:vdata<=`KEY_S;
		`ScanCode_T:vdata<=`KEY_T;
		`ScanCode_U:vdata<=`KEY_U;
		`ScanCode_V:vdata<=`KEY_V;
		`ScanCode_W:vdata<=`KEY_W;
		`ScanCode_X:vdata<=`KEY_X;
		`ScanCode_Y:vdata<=`KEY_Y;
		`ScanCode_Z:vdata<=`KEY_Z;
		`ScanCode_Space:vdata<=`KEY_Space;
		`ScanCode_Backspace:vdata<=`KEY_Backspace;
		`ScanCode_Enter:vdata<=`KEY_Enter;
		`ScanCode_Keypad_0:vdata<=`KEY_0;
		`ScanCode_Keypad_1:vdata<=`KEY_1;
		`ScanCode_Keypad_2:vdata<=`KEY_2;
		`ScanCode_Keypad_3:vdata<=`KEY_3;
		`ScanCode_Keypad_4:vdata<=`KEY_4;
		`ScanCode_Keypad_5:vdata<=`KEY_5;
		`ScanCode_Keypad_6:vdata<=`KEY_6;
		`ScanCode_Keypad_7:vdata<=`KEY_7;
		`ScanCode_Keypad_8:vdata<=`KEY_8;
		`ScanCode_Keypad_9:vdata<=`KEY_9;
		default:vdata<=`KEY_Space;
	endcase
end

endmodule