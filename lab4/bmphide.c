#include<stdio.h>
#include <stdlib.h>
int sizem = 100;

void hidemsg(char b,char c,unsigned char* data);
char readmsg(char b,unsigned char* data);
void * readBMP(char* filename)

{	
  char msg[sizem];
	unsigned char head[54];
    FILE* f = fopen(filename, "rb");
    fread(head, 1, 54, f);
    
	  int width = *(int*)&head[18];
    int height = *(int*)&head[22];
    int bytes = *(int*)&head[28]/8;
    int byte = 8;
    int t=1;
    char sign;
    int size = bytes * width * height;
    unsigned char *data;
    data = (unsigned char*)malloc(sizeof(unsigned char)* size);
 
     scanf("%s", msg);
    fread(data, sizeof(unsigned char), size, f); 


    for (int i =0 ; msg[i]!=0;  i++){

      hidemsg(bytes-1,msg[i],data+(bytes*i*byte));
    }
  
    //   for (int i =2; i<200;  i=i+3){
    //   printf("%d  ",data[i]);
    // }

    while(t==1){

      sign= readmsg(bytes-1,data);
      printf("%c",sign);
      if(sign == 0){
        t=0;
        }
    }



 

}
int main(int argc, char* argv[]) {

  readBMP("o.bmp");

  // char num1[100];
  // char num2[100];
  // scanf("%s", num1);
  // scanf("%s", num2);
  // char* string = addParts(num1, num2);
  // display(string);

  return 0;
}
