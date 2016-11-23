all : ass lsb2msb
	rm inst_rom_LSB.data

.PHONY : ass 
ass : 
	Assembleler.exe inst.s inst_rom_LSB.data

.PHONY : lsb2msb
lsb2msb : 
	LSB2MSB.exe inst_rom_LSB.data ram2.data

.PHONY : compile_lsb2msb
compile_lsb2msb : 
	g++ LSB2MSB.cpp -o LSB2MSB.exe

.PHONY: clean
clean:
	rm *.data