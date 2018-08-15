# Single Cycle CPU
Single Cycle CPU VHDL project created for Computer Systems Design course.<br>
In this project a custom 8-bit Calculator ISA was developed and implemented in a single-cycle datapath. The input for the calculator is 8-bit instructions written and a clock signal written in a testbench file and outputs decimal values when instructed. The ISA supports 5 instructions: add, subtract, load, display, and compare(beq).<br>
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
2. Generate the executable for the test bench:<br>
"/usr/local/bin/ghdl -e shift_reg_tb"<br>
If you use any IEEE libraries, add "--ieee= standard" after "-e".<br>
3. Run the test bench:<br>
"/usr/local/bin/ghdl -r shift_reg_tb"<br>
If you want to dump waveform files, add “--vcd=shift_reg.vcd”. You can use “gtkwave” or any other<br>
waveform viewers to open the “shift_reg.vcd” file.<br>

# Detailed Strategy
Our original ISA worked off of 8-bit binary input using the first two bits to identify the instructions and the others to represent immediate or register values depending on the instruction. Our add instruction was 00 and then held the destination register and the two registers being added in the remaining bits respectively. Our subtraction function had the opcode of 01 and the rest worked the same as the add. The load function was 10 and then used the next two bits for the destination register and the last four for a two’s complement immediate. The compare function used 11 and then had the two registers being compared and two bits to determine one skip or two. Finally the print function had an opcode of 11 followed by four 0 bits then the register being printed. This was all kept the same from our original ISA. 

The datapath that we built was largely based off of the standard MIPS datapath. Our idea was to use an instruction decoder to determine instructions and registers being used, a register file to handle storing and retrieving of values in the register, and an ALU to handle all arithmetic operations. The main difference was the addition of a print component and the components necessary for handling instruction skip.

The controller was created based off a truth table that showed which signals needed to be on and off for certain instructions. We took in the input bits then used the necessary logic gates to create that truth table and fed the signals out to various components that worked off of those signals.

The instruction decoder would take in the 8 bit input instruction and determines which bits are sent to certain inputs in the register file.  The muxes looked at the the opcode bits to determine where to place the register values.

The register file receives the register values from the instruction decode to decide which flip-flop will hold a value corresponding to the register. The destination register feeds into a write back demux to put the value in the corresponding register. An enable feeds into the register file to keep the flip flops from saving values when the compare function is skipping instructions.

The ALU received two 8 bit values out of the register and added or subtracted depending on the add/sub signal that came from the controller. This component (figure 5) was 8 full adders (figure 6) linked together to handle each of the 8 bits with the corresponding bit of the other register value. The add/sub signal gets xor’d with the second value to create a two’s complement addition to handle subtraction. The result gets sent to the print function or looped back around to a mux that determines if an immediate or the result will be written back into the register.

The compare function was designed to use the ALU to subtract the two registers and check for a zero value. This value is passed to a mux which checks to see if the compare function has been called and passes an immediate to represent the amount of instructions to skip. We store this value in a shift register that is looped back around and shifted until 0. That value is or’d to determine when it is 0 and is used to stop the clock that feeds into the register file to keep instructions from being stored and saving values and also act as an enable to keep the print component from running.

For the print function, we input a 8 bit value to be printed, an enable bit and a clock signal.  The function then outputs the value to the screen.  The output value is printed on the falling edge of the clock so that it prints the correct value.  In order to print the std_logic_vector the function converts the std_logic_vector to an integer and then separates each digit in the integer and converts it to a string.  Next it combines each string digit and uses the report command to print the string.  This is done with sequential logic in a process.

## Output
The output of the CPU simulation is a testbench file called "calc_tb.vhdl".  This testbench include many bench,arks to test our design. In order to run the testbench file use these two GHDL commands:
1. ghdl -e calc_tb
2. ghdl -r calc_tb "--vcd=calcWave.vcd"<br>
To view the waveform run: gtkwave calcWave.vcd
