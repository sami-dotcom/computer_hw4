# Initialize registers
    .data
prompt: .asciiz "Enter a positive integer: "
result: .asciiz "Prime numbers up to "
r: .asciiz " are: "
    .text
    .globl main
main:
    li $v0, 4           #
    la $a0, prompt        
    syscall             

    li $v0, 5           
    syscall             
    move $s0, $v0       

    li $v0, 4           
    la $a0, result        
    syscall             
    move $a0, $s0       
    li $v0, 1           
    syscall             

    li $v0, 4           
    la $a0, r        
    syscall             

    li $t0, 2           
    li $t1, 2           

loop:
    bge $t0, $s0, exit  
    move $a0, $t0       
    jal is_prime        
    beq $v0, 1, print   
    addi $t0, $t0, 1    
    j loop              

print:
    li $v0, 1           
    syscall             
    addi $t0, $t0, 1    
    j loop              

exit:
    li $v0, 10          
    syscall             

is_prime:
    li $v0, 0           
    li $t1, 2           
    ble $a0, 1, not_prime 
    beq $a0, 2, prime   
loop2:
    bge $t1, $a0, prime 
    div $a0, $t1        
    mfhi $t2            
    beq $t2, $zero, not_prime 
    addi $t1, $t1, 1    
    j loop2             
prime:
    li $v0, 1           
    jr $ra              
not_prime:
    li $v0, 0           
    jr $ra              
