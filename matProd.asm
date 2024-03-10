#criação de um programa para a multiplicação de 2 matrizes 4x4
#Faremos para o teste a multiplicação da matriz 
# a = {{1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16}}
#pela matriz
# b = {{1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16}}
# O resultado deve ser a matriz
# c = {{90,100,110,120},{202,228,254,280},{314,356,398,440},{426,484,542,600}}

#OBS: a posição [i][j] de uma matriz é encontrado somando ao endereço
#da matriz o valor 4 * (4*i + j)

.globl main

main:
	#Alocação de memória da matriz A
	addi $sp, $sp, -64
	add $s0, $sp, $0		# s0 := &a
	
	#Alocação de memória da matriz b
	addi $sp, $sp, -64
	add $s1, $sp, $0		# s1 := &b
	
	#Alocação de memória da matriz c
	addi $sp, $sp, -64
	add $s2, $sp, $0		# s2 := &c
	
	#Inicialização de a e b
	li $s3, 0
	initial_loop:
		li $t0, 16
		beq $s3, $t0, end_initial_loop
		
		add $t0, $s3, $0
		addi $t0, $t0, 1
		li $t1, 4
		mul $t1, $t1, $s3
		add $t2, $t1, $s0
		add $t3, $t1, $s1
		sw $t0, 0($t2)
		sw $t0, 0($t3)
		
		addi $s3, $s3, 1
		j initial_loop
	end_initial_loop:
	
	#Entraremos para os loops principais do programa
	
	####LOOP I
	li $s3, 0		#s3 := i (0)
	i_loop:
		li $t0, 4
		beq $s3, $t0, end_i_loop
		
		####LOOP J
		li $s4, 0		#s4 := j (0)
		j_loop:
			li $t0, 4
			beq $s4, $t0, end_j_loop
			
			li $s6, 0		#sum = 0
			####LOOP K
			li $s5, 0		#s5 := k (0)
			k_loop:
				li $t0, 4
				beq $s5, $t0, end_k_loop
		
				#Encontrando o valor de a[i][k]
				add $t0, $s3, $0
				li $t1, 4
				mul $t0, $t0, $t1
				add $t0, $t0, $s5
				mul $t0, $t0, $t1
				add $t0, $t0, $s0		#t0 := &a[i][k]
				lw $s7, 0($t0)			#s7 := a[i][k]
				
				#Encontrando o valor de b[k][j]
				add $t0, $s5, $0
				li $t1, 4
				mul $t0, $t0, $t1
				add $t0, $t0, $s4
				mul $t0, $t0, $t1
				add $t0, $t0, $s1		#t0 := &b[k][j]
				lw $t0, 0($t0)			#t0 := b[k][j]
				
				mul $t0, $t0, $s7
				add $s6, $s6, $t0
		
				addi $s5, $s5, 1
				j k_loop
			end_k_loop:
			
			#Encontrando o valor de c[i][j]
			add $t0, $s3, $0
			li $t1, 4
			mul $t0, $t0, $t1
			add $t0, $t0, $s4
			mul $t0, $t0, $t1
			add $t0, $t0, $s2		#t0 := &a[i][j]
			
			sw $s6, 0($t0)			#c[i][j] = sum
		
			addi $s4, $s4, 1
			j j_loop
		end_j_loop:
		
		addi $s3, $s3, 1
		j i_loop
	end_i_loop:
	
	add $sp, $sp, 192
	li $v0, 10
	syscall