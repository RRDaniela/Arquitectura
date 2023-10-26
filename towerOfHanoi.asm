.text
	addi s0, zero, 15 #Número de discos n = 3
	addi s1, zero, 1 #int i = 0
	addi s3, s0, 1 #n += 1
	lui s2, 0x10010 #Apuntador a memoria
	lui s4, 0x10010 #Apuntador a torre 1
	lui s5, 0x10010 #Apuntador a torre 2
	lui s6, 0x10010 #Apuntador a torre 3
	addi s7, zero, 0 #Valor a sumar a cada apuntador dependiendo de n	
	addi s8, zero, 0 #Valor a comparar en if

for: 
	bge s1, s3, main	#Si es mayor o igual n = 1 ir a main
	sw s1, 0(s2)	#Guardar en memoria s1
	addi t5, t5, 4 	#Incrementar el valor a sumar.
	addi s2, s2, 4	#Incrementar el apuntador
	addi s1, s1, 1	#i++
	jal zero, for

main:	nop
	
	add s5, s5, t5	#Mover el apuntador de la torre 2 
	add s6, s6, t5	#Mover el apuntador de la torre 3
	add s6, s6, t5	#Mover el apuntador de la torre 3
	jal towerOfHanoi
	jal end
	
towerOfHanoi: nop
#    if (n > 0)
	blt s8, s0, else
	jalr ra
else:	nop
	#TH(num - 1, x, z, y);
	#push
	addi sp, sp, -20 
	sw s4, 16(sp) #Apuntador a origen
	sw s5, 12(sp) #Apuntador a auxiliar
	sw s6, 8(sp)  #Apuntador a destino
	sw ra, 4(sp)  #Guardar ra
	sw s0, 0(sp)  #Guardar n
	#modify args
	addi s0, s0, -1 #Guardar n-1
	lw s6, 12(sp)
	lw s5, 8(sp)
	#recursive call
	jal towerOfHanoi
	#pop
	lw s0, 0(sp)
	lw ra, 4(sp)
	lw s6, 8(sp)
	lw s5, 12(sp)
	lw s4,16(sp)
	addi sp, sp, +20
#towerOfHanoi(n-1, aux_rod, to_rod, from_rod);
	addi t6, s0, -1 #Restar 1
	slli t1, t6, 2  #Multiplicar n * 4
	add t2, s4, t1  #Auxiliar de origen
	add t3, s6, t1  #Auxiliar de destino
	lw t0, 0(t2)    #Traer el valor
	sw zero, 0(t2)  #Mover un cero al valor actualizado
	sw t0, 0(t3)    #Mover al auxiliar de destino el valor
	#push
	addi sp, sp, -20 
	sw s4, 16(sp) #Apuntador a origen
	sw s5, 12(sp) #Apuntador a auxiliar
	sw s6, 8(sp)  #Apuntador a destino
	sw ra, 4(sp)  #Guardar ra
	sw s0, 0(sp)  #Guardar n
	#modify args
	#TH(num - 1, y, x, z);
	addi s0, s0, -1 #Guardar n-1
	lw s4, 12(sp)
	lw s5, 16(sp)
	#recursive call
	jal towerOfHanoi
	#pop
	lw s0, 0(sp)
	lw ra, 4(sp)
	lw s6, 8(sp)
	lw s5, 12(sp)
	lw s4,16(sp)
	addi sp, sp, +20
	jalr ra
		
end: nop

