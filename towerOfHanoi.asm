.text
	addi s0, zero, 1 #Número de discos n = 3
	addi s1, zero, 1 #int i = 0
	addi s3, s0, 1 #n += 1
	lui s2, 0x10010 #Apuntador a memoria
	lui s4, 0x10010 #Apuntador a torre 1
	lui s5, 0x10010 #Apuntador a torre 2
	lui s6, 0x10010 #Apuntador a torre 3
	addi s7, zero, 0 #Valor a sumar a cada apuntador dependiendo de n	
	addi s8, zero, 1 #Valor a comparar en if
for: 
	bge s1, s3, main	#Si es mayor o igual n = 1 ir a main
	sw s1, 0(s2)	#Guardar en memoria s1
	addi s2, s2, 4	#Incrementar el apuntador
	addi s1, s1, 1	#i++
	jal zero, for

main:	nop
	addi s5, s5, 0x0c #Mover el apuntador a 0x1001000C
	addi s6, s6, 0x18 #Mover el apuntador a 0x10010018

towerOfHanoi: nop
#    if (n == 1)
	bne s0, s8, else	
	jal zero, moveDisk
else:	nop
	#towerOfHanoi(n-1, from_rod, aux_rod, to_rod);
	#push
	addi sp, sp, -20 
	sw s4, 16(sp) #Apuntador a origen
	sw s5, 12(sp) #Apuntador a auxiliar
	sw s6, 8(sp)  #Apuntador a destino
	sw ra, 4(sp)  #Guardar ra
	sw s0, 0(sp)  #Guardar n
	#modify args
	addi s0, s0, -1 #Guardar n-1
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
	#push
	addi sp, sp, -20 
	sw s5, 16(sp) #Apuntador a origen
	sw s6, 12(sp)  #Apuntador a destino
	sw s4, 8(sp) #Apuntador a auxiliar	
	sw ra, 4(sp)  #Guardar ra
	sw s0, 0(sp)  #Guardar n
	#modify args
	addi s0, s0, -1 #Guardar n-1
	#recursive call
	jal towerOfHanoi
	#pop
	lw s0, 0(sp)
	lw ra, 4(sp)
	lw s4, 8(sp)
	lw s6, 12(sp)
	lw s5,16(sp)
	addi sp, sp, +20
	jalr ra
		

moveDisk: nop
	#printf("\n Move disk n from rod ORI to rod DEST");
	sw s0, 0(s6)
	sw zero, 0(s4)
		
end: nop

