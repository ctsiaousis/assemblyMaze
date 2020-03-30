/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: user
 *
 * Created on 4 Δεκεμβρίου 2018, 9:00 μμ
 */

#include <stdio.h>
#include <stdlib.h>
#define  Max_width 100

long long R0=0,v0,a1,a2,a3,a0,t0,t1,t2,t3,t4,t5,t6,t7,s0,s1,s2,ra;

int W = 21;
int H = 11;
int startX = 1;
int TotalElements = 231;
char map[232] = "I.IIIIIIIIIIIIIIIIIII"
                "I....I....I.......I.I"
                "III.IIIII.I.I.III.I.I"
                "I.I.....I..I..I.....I"
                "I.I.III.II...II.I.III"
                "I...I...III.I...I...I"
                "IIIII.IIIII.III.III.I"
                "I.............I.I...I"
                "IIIIIIIIIIIIIII.I.III"
                "@...............I..II"
                "IIIIIIIIIIIIIIIIIIIII";


char temp[Max_width]; //Global

int playerPos;



void printLabyrinth (void){
   t0=0;  //int i
   t7=0;//k
 usleep(200000);
 printf("Labyrinth:\n");
 
 forLbl1:
  if(! (t0<H))goto afterFor1;
              
 t1=0; //j
 forLbl2:
    if(!( t1<W)) goto afterFor2;
               if (!(t7==playerPos)) goto afterIf;
                 temp[t1]='P';
                 goto afterElse;
                 afterIf:
                 temp[t1]=map[t7];
                 afterElse:
                 t7++;
                 t1++;
     goto forLbl2;
     afterFor2:
                            
  t2=t1+1;
  temp[t2]='\0';
  
  printf("%s\n", temp);
  t0++;
  goto forLbl1;
afterFor1:

  t0=0;
 }

void getReady(){
    int temps[2];
    temps[0]=s0;
    s0=0; //i
    t1=TotalElements+1;
    forReady:
   if(!(s0<t1))goto endReady;
        if(!(map[s0]=='#')) goto afterIfReady1;
            map[s0]='.';
           // printLabyrinth();
    
         afterIfReady1:
    
         if(!(map[s0]=='*'))goto afterIfReady2;
            map[s0]='.';
        // printLabyrinth();
          afterIfReady2:
    
    
         if(!(map[s0]=='%')) goto afterIfReady3;
            map[s0]='@';
           // printLabyrinth();
            afterIfReady3:
         s0++;
        goto forReady;
         endReady:
        s0=temps[0];
}

void makeMove(void){
    int tmp[2];
    tmp[0]=s0; // backup s0
    s0=a0; // index 

    if(a0<0) goto after_if_1; //index<0
    if(a0<231) goto after_if_2;//index<totalelements
    after_if_1:
    v0=0;      // return 0
    s0=tmp[0];
    return;
    after_if_2:
    t0 = (int)map[a0]; 

    if(t0 != (int)'.') goto else_if_1;
    t0 = (int)'*';
    map[s0]=(char)t0;
    printLabyrinth();

    a0 = s0 + 1;
    tmp[1] = ra;
    makeMove();
    ra = tmp[1];
    if (v0 != 1) goto if_1;
    map[s0] = '#';
    printLabyrinth();
    v0 = 1;
    s0 = tmp[0];
    return;

if_1:
    a0 = s0 + 21;
    tmp[1] = ra;
    makeMove();
    ra = tmp[1];
    if (v0 != 1) goto if_2;
    map[s0] = '#';
    printLabyrinth();
    v0 = 1;
    s0 = tmp[0];
 return;

if_2:
    a0 = s0 - 1;
    tmp[1] = ra;
    makeMove();
    ra = tmp[1];
    if (v0 != 1) goto if_3;
    map[s0] = '#';
    printLabyrinth();
    v0 = 1;
    s0 = tmp[0];
 return;

if_3:
    a0 = s0 - 21;
    tmp[1] = ra;
    makeMove();
    ra = tmp[1];
    if (v0 != 1) goto if_4;
    map[s0] = '#';
    printLabyrinth();
    v0 = 1;
    s0 = tmp[0];
 return;

if_4:
else_if_1:
    t1 = (int)map[a0];
    if(t1 != (int)'@') goto exit_if;
    map[s0] = '%';
    printLabyrinth();
    v0 = 1;
    s0=tmp[0];
 return;

exit_if:
    s0=tmp[0];
    v0=0;
 return;
}

void Move(){
    t0=a0;
    t1=(int)'I';
    t2=playerPos;
    t3=(int)'*';
    if(!(t0=='w'))goto afterW;
        if (!(map[t2-W]!=t1)) goto afterW;
         map[t2]=t3;
         t2=t2-W;
         playerPos=t2;
    afterW:
    
     if(!(t0=='s'))goto afterS;
        if (!(map[t2+W]!=t1)) goto afterS;
         map[t2]=t3;
         t2=t2+W;
         playerPos=t2;
    afterS:
    
     
      if(!(t0=='a'))goto afterA;
         if (!(map[t2-1]!=t1)) goto afterA;
         map[t2]=t3;
         t2=t2-1;
         playerPos=t2;
    
    
    afterA:
      
      
       if(!(t0=='d'))goto afterD;
           if (!(map[t2+1]!=t1)) goto afterD;
         map[t2]=t3;
         t2=t2+1;
         playerPos=t2;
    
    
    afterD:
    
       printLabyrinth();
    
    
    
    
}


int main(int argc, char** argv) {
    playerPos=startX;
    printLabyrinth();
    startmenu:
    if(!(t0!=(int)'c')) goto endmenu;
    t1=playerPos;
    if (!(map[t1]=='@')) goto notSolved;
     printf("winner,winner,chicken,dinner");
        return (EXIT_SUCCESS);
    notSolved:
     printf("press w,a,s,d to move.\n");
     printf("press e to show solution.\n");
     printf("press c to close.\n");
     scanf("%s",&t0); 
     
     if(!(t0=='e'))goto notHint;
     getReady();
     a0=startX;
     makeMove();
     notHint:
    
     if (!(t0!='c'))goto endmenu;
     a0=t0;
     Move();
     
    goto startmenu;
    endmenu:
    getReady();
    a0=startX;
    makeMove();
    return (EXIT_SUCCESS);
}






