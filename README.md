# Assembly Maze
An assembly MIPS project that recursively solves a maze and also allows for user input through polling or interrupts.

## Table of Contents
* [General Info](#general-info)
* [Functions](#functions)
* [Polling](#polling)
* [Interrupts](#interrupts)
* [Demonstration](#demonstration)

## General info
This project was built using qtSPIM v.9.1.20 . It takes hard-coded the string input of "I"s and dots as the maze. The user can press ```w,a,s,d``` to move and also ```e``` to show the solution.
All the three assembly programs have the same functionality, except 
* the ```labyrinth.asm``` uses syscalls,
* the ```polling.asm``` uses polling and memory mapped I/O,
* and the ```interrupts.asm``` uses an interrupt handler defined in ```exceptions_labyrint_proj.s```.

## Functions
* ```printLabyrinth:``` prints the maze line-by-line.
* ```makeMove:``` recursive function to solve maze by pressing e.
* ```getReady:``` reprints the maze by changing user possition to the initial.
* ```move:``` simple function that checks the user's input, and moves the player.
* ```main:``` loops a menu and reads the input, calling the above functions accordingly.
 
## Polling
Thre extra functions are declared here to replace the functionality of syscalls.
* ```Write_ch:``` It loads an "1" to the bit#0 of the transmitter control (0xffff0008) to make the console ready for printing and then loads the byte of data to print in the address transmitter data (0xffff000c).
* ```Read_ch:``` Similarly, loads an "1" to the bit#0 of the reciever control (0xffff0000) and after the user inputs, it takes the byte from the address Receiver data (0xffff0004).
* ```Print_string:``` Just a loop where every time ```Write_ch:``` is called to print the characters of the string one-by-one.

## Interrupts
Enables interrupts for CPU and keyboard in the "exceptions.s" file and adds two global variables. The ```cdata``` which contains the users input (the exception handler takes the data from the "RecieverData" address and puts it in that variable). The ```cflag``` which is 0 and goes to 1 if a key is pressed.
So the handler is a loop where if ```cflag``` becomes 1, it breaks the loop makes ```cflag=0``` and puts the Reciever Data in the ```cdata``` register, then it reenters the loop.

## Demonstration
![demo gif](./demo.gif)
