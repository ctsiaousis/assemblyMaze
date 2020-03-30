.data
.align 2 				#stoixisi mnimis
labyrinth:       .asciiz "Labyrinth:\n"
win:        .asciiz "winner,winner,chicken,dinner\n"
menu:       .asciiz "press w,a,s,d to move.\npress e to show solution.\npress c to close.\n"
W:               .word   21
H:               .word   11
startX:          .word   1
TotalElements:   .word   231
newLine:         .asciiz "\n"

map:             .ascii  "I.IIIIIIIIIIIIIIIIIIII....I....I.......I.IIII.IIIII.I.I.III.I.II.I.....I..I..I.....II.I.III.II...II.I.IIII...I...III.I...I...IIIIII.IIIII.III.III.II.............I.I...IIIIIIIIIIIIIIII.I.III@...............I..IIIIIIIIIIIIIIIIIIIIIII"
#map:             .asciiz  "I.IIIIIIIIIIIIIIIIIII@....I....I.......I.I\n"
.align 2
temp:            .space 100
.align 2
buff:            .space 100
playerPos:       .word 1



                  
.text
.globl main
main:
		lw $t0,startX
		sw $t0,playerPos
        jal printLabyrinth
        

		la $a1,newLine
		jal Print_String
	
		
		li $t0,0
startMenu:
        beq $t0,99,endMenu
		lw $t1,playerPos
		lb $t2,map($t1)
		bne $t2,64, notSolved
		
		
		
		
		la $a1,win
		jal Print_String
		
		
		
		li $v0, 10 			                     #R2 =10 gia termatismo
        syscall
notSolved:



		la $a1,menu
		jal Print_String
        
		
		jal Read_ch
		add $t0,$v0,$0
		
	    bne $t0,101,notHint
		jal getReady
		lw $a0,startX
		jal makeMove
		
notHint:
        beq $t0,99,endMenu
		add $a0,$t0,$0
		jal Move
		j startMenu
endMenu:
        jal getReady
		lw $a0,startX
		jal makeMove
        jal printLabyrinth
	li $v0, 10 			                     #R2 =10 gia termatismo
    syscall
#end main
	
	
#==============================================
	
	printLabyrinth:
		la $a1,newLine
        add $sp,$sp,-4
		sw $ra,0($sp)
        jal Print_String
        lw $ra,0($sp)
	    add $sp,$sp,4
	    li $t0,0
		li $t7,0
		li $t3,20000
usleep:
		beqz $t3,end_usleep
     	sub $t3,$t3,1
		b usleep
end_usleep:


forLbl1:
	    
		lw $t3,H
		slt $t4,$t0,$t3
		beq $t4,0,afterFor1
		bge $t0,$t3,afterFor1        		#if(! (t0<H))goto afterFor1;
		li $t1,0  
forLbl2:
            lw $t4,W
			bge $t1,$t4,afterFor2         	#if (!( t1<W))
			lw  $t6,playerPos
			bne $t7,$t6,  afterIf
		    li $t4,80
			sb $t4,temp($t1)
			j afterElse
			
afterIf:
			
			lb  $t5,map($t7)
			sb $t5,temp($t1)
afterElse:
			addi $t7,$t7,1
			addi $t1,$t1,1
			j forLbl2
afterFor2:
        addi $t2,$t1,1
		li $t4,10
		sb $t4,temp($t2)
		
		
		la $a1,temp
		
		addi $sp, $sp, -4
		sw $ra,0($sp)
	    jal Print_String
	    lw $ra,0($sp)
		addi $sp, $sp, 4
		
		
		la $a1,newLine
		addi $sp, $sp, -4
		sw $ra,0($sp)
        jal Print_String
        lw $ra,0($sp)
		addi $sp, $sp, 4
		addi $t0,$t0,1
		j forLbl1
afterFor1:

			
 jr $ra
	
	
#=====================================================
getReady:
		addi $sp,$sp,-8
		sw $s0,0($sp)
		li $s0,0
		li $t1,231
		addi $t1,$t1,1
forReady:
		bge $s0,$t1, endReady
		   lb $t0,map($s0)
		   
		    bne $t0,35, afterIfReady1   #35=#
	        li $t2,46     #46=.
	        sb $t2,map($s0)
			 #sw $ra,4($sp)
	        # jal printLabyrinth
	        # lw $ra,4($sp)
afterIfReady1:	
			 bne $t0,42, afterIfReady2  #42=*
	        li $t2,46     #46=.
	        sb $t2,map($s0)
			#sw $ra,4($sp)
			#jal printLabyrinth
			#lw $ra,4($sp)
afterIfReady2:
			 bne $t0,37, afterIfReady3  #37=%
	        li $t2,64     				#64=@
	        sb $t2,map($s0)
			# sw $ra,4($sp)
			#jal printLabyrinth
			#lw $ra,4($sp)
afterIfReady3:
		 
	
		 
		addi $s0,$s0,1
	j forReady
endReady:
lw $s0,0($sp)
add $sp,$sp,8
jr $ra

	
#=======================================================
	

Move:
add $t0,$a0,$0
li $t1,73  								#73=I
lw $t2,playerPos
li $t3,42  								#42=*
lw $t4,W

	bne $t0,119, afterW                 #119=w
		sub $t5,$t2,$t4
		lb  $t6,map($t5)
		beq $t6,$t1,afterW
		sb $t3,map($t2)
		sw $t5,playerPos
afterW:


	bne $t0,115, afterS               	#115=s
		add $t5,$t2,$t4
		lb  $t6,map($t5)
		beq $t6,$t1,afterS
		sb $t3,map($t2)
		sw $t5,playerPos
afterS:
  
  
  
	bne $t0,97,afterA              		#97=a
        addi $t5,$t2,-1
		lb  $t6,map($t5)
		beq $t6,$t1,afterA
		sb $t3,map($t2)
		sw $t5,playerPos
afterA:


	bne $t0,100, afterD              	#100=d
		addi $t5,$t2,1
		lb  $t6,map($t5)
		beq $t6,$t1,afterD
		sb $t3,map($t2)
		sw $t5,playerPos
afterD:
	
    addi $sp,$sp,-4
	sw $ra,0($sp)
	jal printLabyrinth
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
#====================================================
makeMove:
		addi $sp,$sp,-8
		sw $s0,0($sp)
		add $s0,$a0,$0
		
        slti $t1,$s0,0
		 beq $t1 ,1, after_if_1
		 lw $t2 ,TotalElements
		 slt $t1,$s0,$t2
		 beq $t1,1,after_if_2
after_if_1:
        add $v0,$0,$0
        lw $s0,0($sp)
	    addi $sp,$sp,8
	    jr $ra
after_if_2:
		lb $t0,map($a0)
		bne $t0,46,else_if_1
		addi $t0,$0,42
		sb $t0,map($s0)
		sw $ra,4($sp)
        jal printLabyrinth
	    lw $ra,4($sp)
		
		addi $a0,$s0,1
		sw $ra,4($sp)
	    jal makeMove
	    lw $ra,4($sp)
		bne $v0,1,if_1
		addi $t2,$0,35
		sb $t2,map($s0)
		sw $ra,4($sp)
	    jal printLabyrinth
	    lw $ra,4($sp)
		li $v0,1
		lw $s0,0($sp)
	    addi $sp,$sp,8
	    jr $ra

if_1:
        lw $t2,W
		add $a0,$s0,$t2
		sw $ra,4($sp)
	    jal makeMove
	    lw $ra,4($sp)
		bne $v0,1,if_2
		
		addi $t2,$0,35
		sb $t2,map($s0)
		sw $ra,4($sp)
	    jal printLabyrinth
	    lw $ra,4($sp)
		li $v0,1
		lw $s0,0($sp)
	    addi $sp,$sp,8
	    jr $ra
if_2:  
		addi $a0,$s0,-1
		sw $ra,4($sp)
	    jal makeMove
	    lw $ra,4($sp)
		bne $v0,1,if_3
		addi $t2,$0,35
		sb $t2,map($s0)
		sw $ra,4($sp)
	    jal printLabyrinth
	    lw $ra,4($sp)
		li $v0,1
		lw $s0,0($sp)
	    addi $sp,$sp,8
	    jr $ra
if_3:
		 lw $t2,W
		sub $a0,$s0,$t2
		sw $ra,4($sp)
	    jal makeMove
	    lw $ra,4($sp)
		bne $v0,1,if_4
		addi $t2,$0,35
		sb $t2,map($s0)
		sw $ra,4($sp)
	    jal printLabyrinth
	    lw $ra,4($sp)
		li $v0,1
		lw $s0,0($sp)
	    addi $sp,$sp,8
	    jr $ra
if_4:
else_if_1:
        lb $t1,map($s0)
		bne $t1,64,exit_if
		li $t9,37
		la $t2,map
		add $t2,$t2,$s0	
        li $t9,37
		sb $t9,($t2)
	    sw $ra,4($sp)
	    jal printLabyrinth
	    lw $ra,4($sp)
		li $v0,1
		lw $s0,0($sp)
	    addi $sp,$sp,8
	    jr $ra
exit_if:
        lw $s0,0($sp)
	    addi $sp,$sp,8
	    jr $ra

		
#===============================================


Print_String:
		addi $sp,$sp,-16	
		sw  $ra,0($sp)
		sw  $s1,4($sp)	
		sw  $s2,8($sp)	
		sw  $s3,12($sp)		
		move $s2,$a1
		li $s1,0

PS_Loop:
		add $s3,$s1,$s2
		lb $a1,0($s3)
		
		jal Write_ch
		beq $a1,0,Return
		#beq $a1,10,Return		
		addi $s1,$s1,1
		j PS_Loop

Return:
		lw $ra,0($sp)
		lw  $s1,4($sp)	
		lw  $s2,8($sp)	
		lw  $s3,12($sp)	
		addi $sp,$sp,16
		jr $ra
	
#===============================================


Write_ch:
       
		lw $a2,0xffff0008	# Transmitter control
		and $a2,$a2,1		
		beq $a2,0,Write_ch
		sw $a1,0xffff000c 	# Transmitter data
		jr $ra
		
#===============================================

Read_string:
		addi $sp,$sp,-4			
		sw $ra, 0($sp)			
		add $t5, $0 , $0 
	
RS_Loop:
		jal Read_ch	
		sb $v0, buff($t5) 			
		beq $v0,0, Return2		
		#beq $v0,10, Return2
		addi $t5, $t5,1			
		move $a0, $v0	
		jal Write_ch			
		j RS_Loop

Return2:
		lw $ra, 0($sp)			
		addi $sp, $sp, 4	
		jr $ra		
		
#===============================================

Read_ch:
		lb $t0,0xffff0000	# Receiver control 
		and $t0,$t0,1		
		beq $t0,0,Read_ch
		lb $v0,0xffff0004	# Receiver data
		jr $ra
		
#===============================================