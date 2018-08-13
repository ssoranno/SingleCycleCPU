# Single Cycle CPU
Single Cycle CPU VHDL project created for Computer Systems Design course.<br>
GHDL is required to simulate VHDL on Windows, Mac, or Linux

## How to install GHDL:
If you want to use GHDL, you can download it from http://ghdl.free.fr. The site provides pre-compiled<br>
packages for Linux, Windows and MacOS. You can also download the source and compile/install from<br>
there.<br>

## How to use GHDL:
Assume GHDL is installed under the directory /usr/local/bin. Assuming we have "shift_reg.vhdl", which is<br>
the implementation of a 4-bit shift register, and "shift_reg_tb.vhdl", which is the test bench for our<br>
implementation, there are three steps to run the test bench:<br>

1. Analyze: Compile the two vhdl files<br>
"/usr/local/bin/ghdl -a shift_reg.vhdl"<br>
"/usr/local/bin/ghdl -a shift_reg_tb.vhdl"<br>
If you use any IEEE libraries, add "--ieee= standard" after "-a".<br>
2. Generate the executable for the test bench:
"/usr/local/bin/ghdl -e shift_reg_tb"
If you use any IEEE libraries, add "--ieee= standard" after "-e".
3. Run the test bench:
"/usr/local/bin/ghdl -r shift_reg_tb"
If you want to dump waveform files, add “--vcd=shift_reg.vcd”. You can use “gtkwave” or any other
waveform viewers to open the “shift_reg.vcd” file.
