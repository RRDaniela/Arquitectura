#Daniela Isabel Rodríguez Robles
#Claudio Heredia Luna
.text
	addi s0, zero, 3 #Número de discos, n = ?
	lui s1, 0x10010 #Apuntador a A
main: 
	#int main()
	#{
	#	int n = 4; // Number of disks
	#	towerOfHanoi(n, 'A', 'C', 'B'); // A, B and C are names of rods
	#	return 0;
	#}
	addi t0, zero, 0 #int i = 0
	add t1, zero, s0 #int n = número de discos
	sw t0, 0(s1)
	addi t0, t0, 1 #Incrementa t0 en 1
for:
	bge t0, t1, end #for(int i = 0; i<n; i++);
	nop
	sw t0, 4(s1)
	addi t0, t0, 1 #Incrementa t0 en 1
	jal zero, for
	jal towerOfHanoi
	jal end

towerOfHanoi:
	#void towerOfHanoi(int n, char from_rod, char to_rod, char aux_rod)
#{
#    if (n == 1)
#    {
#        printf("\n Move disk 1 from rod %c to rod %c", from_rod, to_rod);
#        return;
#    }
#    towerOfHanoi(n-1, from_rod, aux_rod, to_rod);
#    printf("\n Move disk %d from rod %c to rod %c", n, from_rod, to_rod);
#    towerOfHanoi(n-1, aux_rod, to_rod, from_rod);
#}

end: nop
