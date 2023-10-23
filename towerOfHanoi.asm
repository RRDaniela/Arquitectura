#Daniela Isabel Rodríguez Robles
#Claudio Heredia Luna
.text
	addi s0, zero, 3 #Número de discos, n = ?
	addi s3, zero, 1 #Para la comparación del if
	addi t3, zero, 0 #Cero temporal
	lui a2, 0x10010      #Apuntador a origen
	lui a3, 0x10010	 #Apuntador a auxiliar
	lui a4, 0x10010	 #Apuntador a destino 
	lui a5, 0x10010 	#Apuntador inicial
	addi a3, a3, 0x0c
	addi a4, a4, 0x18
main: 
	#int main()
	#{
	#	int n = 4; // Number of disks
	#	towerOfHanoi(n, 'A', 'C', 'B'); // A, B and C are names of rods
	#	return 0;
	#}
	addi s6, s0, 1 #n = n + 1
	addi t0, zero, 1 #int i = 1
for:
	beq t0, s6, towerOfHanoi #for(int i = 0; i<n; i++);
	sw t0, 0(a5) #Guarda i en t2 + 4
	addi t0, t0, 1 #Incrementa t0 en 1
	addi a5, a5, 4
	jal zero, for

towerOfHanoi: nop
	#void towerOfHanoi(int n, char from_rod, char to_rod, char aux_rod)
	#    if (n == 1)
	bne s0, s3, else
	# printf("\n Move disk 1 from rod %c to rod %c ORIGEN, DESTINO);
	lw s5, 0(a2) #Mover a s5 lo que hay en el origen
	sw t3, 0(a2) #Mover un 0 a la dirección de origen
	sw s5, 0(a4) #Mover a DESTINO lo que hay en s5
	jalr ra
else:
	# push -> n, ori, aux, dest
	addi sp, sp, -20
	sw a2, 16(sp) #Apuntador a ORIGEN
	sw a3, 12(sp) #Apuntador a AUX
	sw a4, 8(sp)  #Apuntador a DEST
	sw ra, 4(sp)
	sw s0, 0(sp)
	# modify args
	addi a2, a2, -4
	addi a4, a4, +4
	addi s0, s0, -1
	jal towerOfHanoi
	# pop
	lw s0, 0(sp)
	lw ra, 4(sp)
	lw a4, 8(sp)
	lw a3, 12(sp)
	lw a2,16(sp)
	addi sp, sp, +20
	# recursive call towerOfHanoi(n-1, ori, aux, dest);
	#    towerOfHanoi(n-1, aux, dest, origen);
	# push -> n, ori, aux, dest
	addi sp, sp, -20
	sw a3, 16(sp) #Apuntador a AUX
	sw a4, 12(sp)  #Apuntador a DEST
	sw a2, 8(sp) #Apuntador a ORIGEN
	sw ra, 4(sp)
	sw s0, 0(sp)
	# modify args
	addi a2, a2, -4
	addi a4, a4, +4
	addi s0, s0, -1
	jal towerOfHanoi
	# pop
	lw s0, 0(sp)
	lw ra, 4(sp)
	lw a2,8(sp)
	lw a4, 12(sp)
	lw a3, 16(sp)
	addi sp, sp, +20


#{
#    if (n == 1)
#    {
#        printf("\n Move disk 1 from rod %c to rod %c", from_rod, to_rod);
#        return;
#    }else{
#    towerOfHanoi(n-1, from_rod, aux_rod, to_rod);
#    printf("\n Move disk %d from rod %c to rod %c", n, from_rod, to_rod);
#    towerOfHanoi(n-1, aux_rod, to_rod, from_rod);
#}}

end: nop
