#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <fstream>
using namespace std;

int main(int argc,char* argv[]){
	if (argc!=3){
		printf("[parameter error]\nusage: LSB2MSB.exe input_MSB_data output_LSB_data\n");
		return 0;
	}
	
	FILE* fin=fopen(argv[1],"rb");
	FILE* fout=fopen(argv[2],"wb");
	if (fin==NULL || fout==NULL){
		printf("file open error\n");
		return 0;
	}
	unsigned short x;
	
	while (fread(&x,sizeof(unsigned short),1,fin)){
		//for (int j=15;j>=0;j--) printf("%d",(x>>j)&1);printf("\n");
		x=x>>8 | (x<<8);
		fwrite(&x,sizeof(unsigned short),1,fout);
	}

}