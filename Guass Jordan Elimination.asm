.data
.align 2
varword: .word main , c1 , c2

wlcm: .asciiz "\n______________________________________________________________\n  ****Equation Solving By Guass Jordan Elimination****\n______________________________________________________________"

cases: .asciiz  "\n\n   1.  ax1 + bx2 = c\n   2.  ax1 + bx2 + cx3 = d"
msg: .asciiz "\n\n   Plz select correct code for equation solving : "
again: .asciiz "\n\n\n    Do you want to solve another equation ?\n\tEnter (1) for 'YES' & (0) for 'NO' : "
desh: .asciiz "\n______________________________________________________________\n"

#___________________________________________________________________________________________________________________________

myArray:  .space 96  
M11: .asciiz "\tEnter M11  --->  "
M12: .asciiz "\tEnter M12  --->  "
M13: .asciiz "\tEnter M13  --->  "
M21: .asciiz "\tEnter M21  --->  "
M22: .asciiz "\tEnter M22  --->  "
M23: .asciiz "\tEnter M23  --->  "
M31: .asciiz "\tEnter M31  --->  "
M32: .asciiz "\tEnter M32  --->  "
M33: .asciiz "\tEnter M33  --->  "
X1:  .asciiz "\tEnter  X1  --->  "
X2:  .asciiz "\tEnter  X2  --->  "
X3:  .asciiz "\tEnter  X3  --->  "

#___________________________________________________________________________________________________________________________
space: .asciiz "  "
newLine: .asciiz  "\n\t"
tab: "\t"
b: .asciiz  " | "
s: .asciiz "  "

formatm: .asciiz "\n\n\n Plz enter your input for the equation in following format:\n\tm11  m12  |  x1\n\tm21  m22  |  x2\n\nLet, start entering the entities.....\n"
format: .asciiz " Plz enter your input for the equation in following format:\n\tm11  m12  m13  |  x1\n\tm21  m22  m23  |  x2\n\tm31  m32  m33  |  x3\n\nLet, start entering the entities.....\n"

augmented: .asciiz "\n\n    The augmented form of matrix is :"

step_1:.asciiz "\n\n\t<---- Step : 1 ---->\nmaking  pivot of 1st  row - 1st  column\n"
step_2:.asciiz "\n\n\t<---- Step : 2 ---->\neliminating the elements below the pivot\n"
step_3:.asciiz "\n\n\t<---- Step : 3 ---->\n making  pivot  of  2nd  row - 2nd column\n"
step_4:.asciiz "\n\n\t<---- Step : 4 ---->\neliminating the elements below the pivot\n"
step_5:.asciiz "\n\n\t<---- Step : 5 ---->\n making  pivot  of  3rd row - 3rd element\n"
step_6:.asciiz "\n\n\t<---- Step : 6 ---->\n eliminating the elements below the pivot\n"



skip: .asciiz "As the pivot to be set is already 1, \NSo that we will skip this step and move to the next sstep"

solution_msg: .asciiz "\n\n\t\tSolution\n  The augmneted matrix says that :\n"
X1_sol: .asciiz "\n   1 -----> x1 = " 
X2_sol: .asciiz "\n   2 -----> x2 = "
X3_sol: .asciiz "\n   3 -----> x3 = "

no_sol: .asciiz 
infinite_sol: .asciiz 

#___________________________________________________________________________________________________________________________
thank: .asciiz "\n\n_______________________thankyou_________________________"

#___________________________________________________________________________________________________________________________

.text
main:
     la     $a0, wlcm
     li     $v0, 4     
     syscall

operation:
     la     $a0, cases
     li     $v0, 4     
     syscall

correct:
     la     $a0, msg
     li     $v0, 4     
     syscall

     li $v0 , 5
     syscall

     blt $v0 , 1 , correct
     bgt $v0 , 2 , correct

     la $a1 , varword
     sll $t0 , $v0 , 2

     add $t1, $a1 , $t0
     lw $t2 , 0($t1)
     jr $t2

#___________________________________________________________________________________________________________________________
#___________________________________________________________________________________________________________________________

c1:
     addi $t0 , $zero , 0   #indexing
     la     $a0, formatm
     li     $v0, 4     
     syscall

     la $a0, M11
     li $v0, 4     
     syscall

     li $v0, 6
     syscall
     mfc1 $v0 , $f0
     swc1 $f0 , myArray($t0)

     la $a0, M12
     li $v0, 4     
     syscall

     addi $t0 , $t0 , 4
     li $v0, 6
     syscall
     mfc1 $v0 , $f0

     swc1 $f0 , myArray($t0)


     la $a0, X1
     li $v0, 4     
     syscall

     addi $t0 , $t0 , 4
     li $v0, 6
     syscall
     mfc1 $v0 , $f0

     swc1 $f0 , myArray($t0)

     la $a0, M21
     li $v0, 4     
     syscall

     addi $t0 , $t0 , 4
     li $v0, 6
     syscall
     mfc1 $v0 , $f0

     swc1 $f0 , myArray($t0)

     la $a0, M22
     li $v0, 4     
     syscall

     addi $t0 , $t0 , 4
     li $v0, 6
     syscall
     mfc1 $v0 , $f0

     swc1 $f0 , myArray($t0)

     la $a0, X2
     li $v0, 4     
     syscall

     addi $t0 , $t0 , 4
     li $v0, 6
     syscall
     mfc1 $v0 , $f0

     swc1 $f0 , myArray($t0)

     la  $a0, augmented
     li  $v0, 4     
     syscall

     addi $t9 , $zero , 0  #flag for step
     j printingm



step1m:

     la $a0, step_1
     li $v0,4
     syscall

     addi $t9 , $t9 , 1
     j guassian_pivotm


#___________________________________________________________________________________________________________________________

step2m:
     la $a0, step_2
     li $v0,4
     syscall

     addi $t3 , $zero , 0
     addi $t3 , $t3 , 12

     lwc1 $f1, myArray($t3)
     mov.s $f0 , $f1

     sub.s  $f1 , $f1 , $f1
     swc1 $f1 , myArray($t3)

     addi $t3 , $zero , 0
     addi $t3 , $t3 , 4

     lwc1 $f1, myArray($t3)
     mov.s $f2 , $f1

     addi $t3 , $zero , 0
     addi $t3 , $t3 , 8

     lwc1 $f1, myArray($t3)
     mov.s $f3 , $f1

     mul.s $f5 , $f2 , $f0
     mul.s $f6 , $f3 , $f0

     addi $t3 , $zero , 0
     addi $t3 , $t3 , 16

     lwc1 $f1, myArray($t3)
     sub.s  $f1 , $f1 , $f5
     swc1 $f1 , myArray($t3)

     addi $t3 , $zero , 0
     addi $t3 , $t3 , 20

     lwc1 $f1, myArray($t3)
     sub.s  $f1 , $f1 , $f6
     swc1 $f1 , myArray($t3)

     addi $t9 , $t9 , 1
     j printingm

#___________________________________________________________________________________________________________________________


step3m:

     la $a0, step_3
     li $v0,4
     syscall

     addi $t9 , $t9 , 1
     j guassian_pivotm


#___________________________________________________________________________________________________________________________
step4m:

     la $a0, step_4
     li $v0,4
     syscall

     addi $t3 , $zero , 0
     addi $t3 , $t3 , 4

     lwc1 $f1, myArray($t3)
     mov.s $f0 , $f1

     sub.s  $f1 , $f1 , $f1
     swc1 $f1 , myArray($t3)

     addi $t3 , $zero , 0
     addi $t3 , $t3 , 20

     lwc1 $f1, myArray($t3)
     mov.s $f2 , $f1

     mul.s $f5 , $f2 , $f0

     addi $t3 , $zero , 0
     addi $t3 , $t3 , 8

     lwc1 $f1, myArray($t3)
     sub.s  $f1 , $f1 , $f5
     swc1 $f1 , myArray($t3)

     addi $t9 , $t9 , 1
     j printingm


#___________________________________________________________________________________________________________________________

guassian_pivotm:
     beq $t9 , 1 , steponem
     beq $t9 , 3 , stepthreem


steponem:
     addi $t3 , $zero , 0
     j reductionm


stepthreem:
     addi $t3 , $zero , 0
     addi $t3 , $t3 , 16
     j reductionm


reductionm:
     lwc1 $f1, myArray($t3)
     mov.s $f0 , $f1

     div.s $f1 , $f1 , $f1
     swc1 $f1 , myArray($t3)

     addi $t3,$t3,4
     lwc1 $f1, myArray($t3)

     div.s $f1 , $f1 , $f0
     swc1 $f1 , myArray($t3)

     beq  $t9 , 3 , printing

     addi $t3,$t3,4
     lwc1 $f1, myArray($t3)

     div.s $f1 , $f1 , $f0
     swc1 $f1 , myArray($t3)

     beq $t9 , 1 , printingm


printingm:
     addi $t1 , $zero , 0   #loop counter
     addi $t0 , $zero , 0   #indexing
     addi $t2 , $zero , 5  #upper bound for 3*3 matrix

     la $a0, newLine
     li $v0,4
     syscall


print_loopm:
     bgt $t1 , $t2 , next_stepm

     lwc1 $f13, myArray($t0)
     li $v0,2
     mov.s $f12,$f13
     syscall

     la $a0, s
     li $v0,4
     syscall

     addi $t1, $t1, 1
     addi $t0, $t0, 4
   
     beq $t1,3,new_linem

     beq $t1,2,blockerm
     beq $t1,5,blockerm

     j print_loopm


new_linem:
     la $a0, newLine
     li $v0,4
     syscall
     j print_loopm


blockerm:
     la $a0 , b
     li $v0,4
     syscall
     j print_loopm


next_stepm:
     beq $t9,0,step1m
     beq $t9,1,step2m
     beq $t9,2,step3m
     beq $t9,3,step4m
     beq $t9,6,solutionm



solutionm:
     la $a0, desh
     li $v0,4
     syscall

     la $a0, solution_msg
     li $v0,4
     syscall

     la $a0, X1_sol
     li $v0,4
     syscall

     addi $s0,$s0,8


     lwc1 $f13, myArray($s0)
     li $v0,2
     mov.s $f12,$f13
     syscall

     la $a0, X2_sol
     li $v0,4
     syscall
 
     addi $s0,$s0,12

     lwc1 $f13, myArray($s0)
     li $v0,2
     mov.s $f12,$f13
     syscall

     la     $a0, desh
     li     $v0, 4     
     syscall

     j again_perform



c2:
la     $a0, desh
li     $v0, 4     
syscall

addi $t0 , $zero , 0   #indexing

la $a0, M11
li $v0, 4     
syscall

li $v0, 6
syscall
mfc1 $v0 , $f0
swc1 $f0 , myArray($t0)


la $a0, M12
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)


la $a0, M13
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)

la $a0, X1
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)

la $a0, M21
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)

la $a0, M22
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)


la $a0, M23
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)


la $a0, X2
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)


la $a0, M31
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)


la $a0, M32
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)


la $a0, M33
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)


la $a0, X3
li $v0, 4     
syscall

addi $t0 , $t0 , 4
li $v0, 6
syscall
mfc1 $v0 , $f0

swc1 $f0 , myArray($t0)


la  $a0, augmented
li  $v0, 4     
syscall


addi $t9 , $t9 , 0 #flag for step
j printing


#___________________________________________________________________________________________________________________
step1:
     la $a0, step_1
     li $v0,4
     syscall

     addi $t9 , $t9 , 1
     j guassian_pivot


#___________________________________________________________________________________________________________________________

step2:
     la $a0, step_2
     li $v0,4
     syscall

     addi $t9 , $t9 , 1

step2_1st:
     addi $t8 , $zero , 0
     addi $t8 , $t8 , 1 #flag for elimating

     addi $t3 , $zero , 0
     addi $t3 , $t3 ,  16

     addi $t4 , $zero , 0
     addi $t4 , $t4 ,  4

     addi $t5 , $zero , 0
     addi $t5 , $t5 ,  20

     j elimination

step2_2nd:
     addi $t8 , $t8 , 1 #flag for elimating

     addi $t3 , $zero , 0
     addi $t3 , $t3 ,  32

     addi $t4 , $zero , 0
     addi $t4 , $t4 ,  4

     addi $t5 , $zero , 0
     addi $t5 , $t5 ,  36

     j elimination

#___________________________________________________________________________________________________________________________
step3:
     la $a0, step_3
     li $v0,4
     syscall

     addi $t9 , $t9 , 1
     j guassian_pivot


#___________________________________________________________________________________________________________________________
step4:
     la $a0, step_4
     li $v0,4
     syscall

addi $t9 , $t9 , 1
addi $t8 , $zero , 0

step4_1st:
     addi $t8 , $t8 , 1
     addi $t3 , $zero , 0
     addi $t3 , $t3 ,  4

     addi $t4 , $zero , 0
     addi $t4 , $t4 ,  24

     addi $t5 , $zero , 0
     addi $t5 , $t5 ,  8

     j elimination

step4_2nd:
     addi $t8 , $t8 , 1 #flag for elimating

     addi $t8 , $t8 , 1
     addi $t3 , $zero , 0
     addi $t3 , $t3 ,  36

     addi $t4 , $zero , 0
     addi $t4 , $t4 ,  24

     addi $t5 , $zero , 0
     addi $t5 , $t5 ,  40

     j elimination

#___________________________________________________________________________________________________________________________
step5:
     la $a0, step_5
     li $v0,4
     syscall

     addi $t9 , $t9 , 1
     j guassian_pivot

#___________________________________________________________________________________________________________________________

step6:
     la $a0, step_6
     li $v0,4
     syscall

     addi $t9 , $t9 , 1
     addi $t8 , $zero , 0

step6_1st:
     addi $t8 , $t8 , 1

     addi $t3 , $zero , 0
     addi $t3 , $t3 ,  8

     addi $t4 , $zero , 0
     addi $t4 , $t4 ,  44

     addi $t5 , $zero , 0
     addi $t5 , $t5 ,  12

     j elimination
     

step6_2nd:
     addi $t8 , $t8 , 1

     addi $t3 , $zero , 0
     addi $t3 , $t3 ,  24

     addi $t4 , $zero , 0
     addi $t4 , $t4 ,  44

     addi $t5 , $zero , 0
     addi $t5 , $t5 ,  28


j elimination

#___________________________________________________________________________________________________________________________
guassian_pivot:
     beq $t9 , 1 , stepone
     beq $t9 , 3 , stepthree
     beq $t9 , 5 , stepfive

stepone:
addi $t3 , $zero , 0
j reduction


stepthree:
     addi $t3 , $zero , 0
     addi $t3 , $t3 , 20
     j reduction

stepfive:
     addi $t3 , $zero , 0
     addi $t3 , $t3 , 40
     j reduction


reduction:
lwc1 $f1, myArray($t3)
mov.s $f0 , $f1

div.s $f1 , $f1 , $f1
swc1 $f1 , myArray($t3)


addi $t3,$t3,4
lwc1 $f1, myArray($t3)

div.s $f1 , $f1 , $f0
swc1 $f1 , myArray($t3)

beq  $t9 , 5 , printing


addi $t3,$t3,4
lwc1 $f1, myArray($t3)

div.s $f1 , $f1 , $f0
swc1 $f1 , myArray($t3)

beq  $t9 , 3 , printing


addi $t3,$t3,4
lwc1 $f1, myArray($t3)

div.s $f1 , $f1 , $f0
swc1 $f1 , myArray($t3)

beq $t9 , 1 , printing



elimination:
     beq $t9 , 2 , eliminating1
     beq $t9 , 4 , eliminating2
     beq $t9 , 6 , eliminating3


eliminating1:

     lwc1 $f1, myArray($t3)
     mov.s $f0 , $f1

     sub.s  $f1 , $f1 , $f1
     swc1 $f1 , myArray($t3)

     lwc1 $f1, myArray($t4)
     mov.s $f2 , $f1

     addi $t4 , $t4 , 4

     lwc1 $f1, myArray($t4)
     mov.s $f3 , $f1

     addi $t4 , $t4 , 4

     lwc1 $f1, myArray($t4)
     mov.s $f4 , $f1


     mul.s $f5 , $f2 , $f0
     mul.s $f6 , $f3 , $f0
     mul.s $f7 , $f4 , $f0


     lwc1 $f1, myArray($t5)
     sub.s  $f1 , $f1 , $f5
     swc1 $f1 , myArray($t5)

     addi $t5 , $t5 , 4

     lwc1 $f1, myArray($t5)
     sub.s  $f1 , $f1 , $f6
     swc1 $f1 , myArray($t5)

     addi $t5 , $t5 , 4

     lwc1 $f1, myArray($t5)
     sub.s  $f1 , $f1 , $f7
     swc1 $f1 , myArray($t5)

     beq  $t8 , 1 , step2_2nd
     beq  $t8 , 2 , printing



eliminating2:
     lwc1 $f1, myArray($t3)
     mov.s $f0 , $f1

     sub.s  $f1 , $f1 , $f1
     swc1 $f1 , myArray($t3)

     lwc1 $f1, myArray($t4)
     mov.s $f2 , $f1

     addi $t4 , $t4 , 4

     lwc1 $f1, myArray($t4)
     mov.s $f3 , $f1

     mul.s $f5 , $f2 , $f0
     mul.s $f6 , $f3 , $f0

     lwc1 $f1, myArray($t5)
     sub.s  $f1 , $f1 , $f5
     swc1 $f1 , myArray($t5)

     addi $t5 , $t5 , 4

     lwc1 $f1, myArray($t5)
     sub.s  $f1 , $f1 , $f6
     swc1 $f1 , myArray($t5)

     beq  $t8 , 1 , step4_2nd
     beq  $t8 , 2 , printing



eliminating3:
     lwc1 $f1, myArray($t3)
     mov.s $f0 , $f1

     sub.s  $f1 , $f1 , $f1
     swc1 $f1 , myArray($t3)

     lwc1 $f1, myArray($t4)
     mov.s $f2 , $f1

     mul.s $f5 , $f2 , $f0

     lwc1 $f1, myArray($t5)
     sub.s  $f1 , $f1 , $f5
     swc1 $f1 , myArray($t5)

     beq  $t8 , 1 , step6_2nd
     beq  $t8 , 2 , printing


skipping:
     la     $a0, skip
     li     $v0, 4     
     syscall

     addi $t9 , $t9 , 1

     beq $t9,1,step2
     beq $t9,3,step4
     beq $t9,5,step6


printing:
     addi $t1 , $zero , 0   #loop counter
     addi $t0 , $zero , 0   #indexing
     addi $t2 , $zero , 11  #upper bound for 3*3 matrix

     la $a0, newLine
     li $v0,4
     syscall


print_loop:
     bgt $t1 , $t2 , next_step

     lwc1 $f13, myArray($t0)
     li $v0,2
     mov.s $f12,$f13
     syscall

     la $a0, s
     li $v0,4
     syscall

     addi $t1, $t1, 1
     addi $t0, $t0, 4

     beq $t1,4,new_line
     beq $t1,8,new_line

     beq $t1,3,blocker
     beq $t1,7,blocker
     beq $t1,11,blocker

     j print_loop


new_line:
     la $a0, newLine
     li $v0,4
     syscall
     j print_loop


blocker:
     la $a0 , b
     li $v0,4
     syscall
     j print_loop


next_step:
     beq $t9,0,step1
     beq $t9,1,step2
     beq $t9,2,step3
     beq $t9,3,step4
     beq $t9,4,step5
     beq $t9,5,step6
     beq $t9,6,solution


#___________________________________________________________________________________________________________________________
solution:
     la $a0, solution_msg
     li $v0,4
     syscall

     la $a0, X1_sol
     li $v0,4
     syscall

     addi $s0,$s0,12


     lwc1 $f13, myArray($s0)
     li $v0,2
     mov.s $f12,$f13
     syscall

     la $a0, X2_sol
     li $v0,4
     syscall
 
     addi $s0,$s0,16

     lwc1 $f13, myArray($s0)
     li $v0,2
     mov.s $f12,$f13
     syscall

     la $a0, X3_sol
     li $v0,4
     syscall

     addi $s0,$s0,16

     lwc1 $f13, myArray($s0)
     li $v0,2
     mov.s $f12,$f13
     syscall

     j again_perform


again_perform:
     la     $a0, again
     li     $v0, 4     
     syscall

     li $v0 , 5
     syscall
     move $t7 , $v0
     beqz $t7 , exit
     beq $t7 , 1 , operation

     bgt $t7 , 1 , again_perform
     blt $t7 , 0 , again_perform


#__________________________________________________________________________________________________________________________
exit:
     la $a0, thank
     li $v0,4
     syscall

     li $v0 , 10
     syscall
#___________________________________________________________________________________________________________________________
