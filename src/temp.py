filename = "ram2.data"
fout = open('temp.txt','w')
fin = open(filename,'r')
i=0
for line in fin:
	fout.write('ram['+str(i)+'] <= 16\'b'+line.strip()+';\n')
	i=i+1
fin.close()
fout.close()