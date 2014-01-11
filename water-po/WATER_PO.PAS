uses dos,graph,crt;

Var
   r:registers;
   CodeErreur:integer;
   pilote,mode:integer;
   x,y:array[1..5] of integer;
   a:array[1..4] of boolean;
   force:word;
   ch:char;
   p1,p2:integer;
   point1,point2:string;
   direction:string;
   direct_en:string;
   dir:string;
   truc,machin:boolean;
   i,duree:integer;
   min,sec:word;
   h,min2,sec2,cent:word;
   l8,l12:integer;

procedure vide_buffer;
forward;
procedure verify;
forward;
procedure depart;
forward;
procedure gagne;
forward;
procedure litcar(var ch:char);
forward;

procedure litcar(var ch:char);
begin
  ch:=readkey;
  if (ch=#0) then ch:=chr(ord(readkey)+128);
  ch:=upcase(ch);
end;

procedure gagne;
begin
                        settextstyle(1,0,2);
                        verify;
                        Cleardevice;
                        setcolor(3);
                        rectangle(40,20,280,180);
                        rectangle(300,85,310,115);
                        rectangle(10,85,20,115);
                        setfillstyle(1,3);
                        floodfill(300,20,3);
                        setfillstyle(1,1);
                        floodfill(305,100,3);
                        setfillstyle(1,2);
                        floodfill(15,100,3);
                        setcolor(1);
                        outtextXY(10,-2,'       WATER - POLO');
                        setcolor(2);
                        outtextXY(13,-1,'       WATER - POLO');
                        x[1]:=45;y[1]:=55;
                        x[2]:=45;y[2]:=145;
                        x[3]:=275;y[3]:=55;
                        x[4]:=275;y[4]:=145;
                        x[5]:=160;y[5]:=100;
                        direction:='-';
                        direct_en:='-';
                        dir:='-';
                        force:=0;
                        a[1]:=false;
                        a[2]:=false;
                        a[3]:=false;
                        a[4]:=false;
                        settextstyle(0,0,0);
                        verify;
end;

procedure vide_buffer;
begin
     r.ax:=$0c0B;
     intr($21,r)
end;

procedure verify;
begin
CodeErreur:=GraphResult;
if CodeErreur <> grOk then
                  begin
                  Closegraph;
                  Writeln('Erreur graphique : ');
                  Writeln(GraphErrorMsg(CodeErreur));
                  Writeln('Interruption imm‚diate du programme ...');
                  Halt(1);
                  end;
end;

procedure depart;
begin
setcolor(1);
str(p1,point1);
str(p2,point2);
outtextXY(130,190,''+point1+' - '+point2);
setcolor(2);
outtextXY(133,189,''+point1+' - '+point2);
setcolor(1);
moveto(x[3]+5,y[3]-5);lineto(x[3]-5,y[3]+5);
moveto(x[3]-5,y[3]-5);lineto(x[3]+5,y[3]+5);
moveto(x[4]+5,y[4]-5);lineto(x[4]-5,y[4]+5);
moveto(x[4]-5,y[4]-5);lineto(x[4]+5,y[4]+5);
setcolor(2);
moveto(x[1]+5,y[1]-5);lineto(x[1]-5,y[1]+5);
moveto(x[1]-5,y[1]-5);lineto(x[1]+5,y[1]+5);
moveto(x[2]+5,y[2]-5);lineto(x[2]-5,y[2]+5);
moveto(x[2]-5,y[2]-5);lineto(x[2]+5,y[2]+5);
setcolor(0);
moveto(x[1]+5,y[1]-5);lineto(x[1]-5,y[1]+5);
moveto(x[1]-5,y[1]-5);lineto(x[1]+5,y[1]+5);
moveto(x[3]+5,y[3]-5);lineto(x[3]-5,y[3]+5);
moveto(x[3]-5,y[3]-5);lineto(x[3]+5,y[3]+5);
setcolor(3);
circle(x[5],y[5],3);
circle(x[5],y[5],2);
circle(x[5],y[5],1);
putpixel(x[5],y[5],3);
delay(50);
if keypressed then
              begin
              litcar(ch);
              vide_buffer;
              if (ch=#200) and (y[1]>30)  then y[1]:=y[1]-5;
              if ch=#200 then direction:='N';
              if (ch=#208) and (y[1]<170) then y[1]:=y[1]+5;
              if ch=#208 then direction:='S';
              if (ch=#203) and (x[1]>50)  then x[1]:=x[1]-5;
              if ch=#203 then direction:='O';
              if (ch=#205) and (x[1]<270) then x[1]:=x[1]+5;
              if ch=#205 then direction:='E';
              if (ch=#199) and (x[1]>50)  then x[1]:=x[1]-5;
              if (ch=#199) and (y[1]>30)  then y[1]:=y[1]-5;
              if ch=#199 then direction:='NO';
              if (ch=#201) and (x[1]<270) then x[1]:=x[1]+5;
              if (ch=#201) and (y[1]>30)  then y[1]:=y[1]-5;
              if ch=#201 then direction:='NE';
              if (ch=#207) and (x[1]>50)  then x[1]:=x[1]-5;
              if (ch=#207) and (y[1]<170) then y[1]:=y[1]+5;
              if ch=#207  then direction:='SO';
              if (ch=#209) and (x[1]<270) then x[1]:=x[1]+5;
              if (ch=#209) and (y[1]<170) then y[1]:=y[1]+5;
              if ch=#209 then direction:='SE';
{*******************************************************************}
              machin:=false;
              if ch='P' then
                        begin
                        sec2:=sec;
                        min2:=min;
                        machin:=true;
                        repeat
                        i:=0;
                        ch:=readkey;
                        ch:=upcase(ch);
                        if ch='P' then i:=100;
                        settime(0,min2,sec2,0);
                        until i=100;
                        end;
              if machin then min:=min2;
              if machin then sec:=sec2;
{*******************************************************************}
              if (ch='T') and (y[3]>30)  then y[3]:=y[3]-5;
              if ch='T' then direct_en:='N';
              if (ch='B') and (y[3]<170) then y[3]:=y[3]+5;
              if ch='B' then direct_en:='S';
              if (ch='F') and (x[3]>50)  then x[3]:=x[3]-5;
              if ch='F' then direct_en:='O';
              if (ch='H') and (x[3]<270) then x[3]:=x[3]+5;
              if ch='H' then direct_en:='E';
              if (ch='R') and (x[3]>50)  then x[3]:=x[3]-5;
              if (ch='R') and (y[3]>30)  then y[3]:=y[3]-5;
              if ch='R' then direct_en:='NO';
              if (ch='Y') and (x[3]<270) then x[3]:=x[3]+5;
              if (ch='Y') and (y[3]>30)  then y[3]:=y[3]-5;
              if ch='Y' then direct_en:='NE';
              if (ch='V') and (x[3]>50)  then x[3]:=x[3]-5;
              if (ch='V') and (y[3]<170) then y[3]:=y[3]+5;
              if ch='V'  then direct_en:='SO';
              if (ch='N') and (x[3]<270) then x[3]:=x[3]+5;
              if (ch='N') and (y[3]<170) then y[3]:=y[3]+5;
              if ch='N' then direct_en:='SE';
              if a[1] then
                      begin
                      setcolor(0);
                      circle(x[5],y[5],3);
                      circle(x[5],y[5],2);
                      circle(x[5],y[5],1);
                      putpixel(x[5],y[5],0);
                      x[5]:=x[1];
                      y[5]:=y[1];
                      setcolor(3);
                      circle(x[5],y[5],3);
                      circle(x[5],y[5],2);
                      circle(x[5],y[5],1);
                      putpixel(x[5],y[5],3);
                      end;
              if (ch=chr(13)) and (not(a[1])) and (x[5]=x[1]) and (y[5]=y[1]) then
                                          begin
                                          a[1]:=true;
                                          force:=0;
                                          ch:='-';
                                          end;
              if (ch=chr(13)) and (a[1]) then
                              begin
                              force:=10;
                              a[1]:=false;
                              dir:=direction;
                              end;
              if a[3] then
                      begin
                      setcolor(0);
                      circle(x[5],y[5],3);
                      circle(x[5],y[5],2);
                      circle(x[5],y[5],1);
                      putpixel(x[5],y[5],0);
                      x[5]:=x[3];
                      y[5]:=y[3];
                      setcolor(3);
                      circle(x[5],y[5],3);
                      circle(x[5],y[5],2);
                      circle(x[5],y[5],1);
                      putpixel(x[5],y[5],3);
                      end;
              if (ch=' ') and (not(a[3])) and (x[5]=x[3]) and (y[5]=y[3]) then
                                          begin
                                          a[3]:=true;
                                          force:=0;
                                          ch:='-';
                                          end;
              if (ch=' ') and (a[3]) then
                              begin
                              force:=10;
                              a[3]:=false;
                              dir:=direct_en;
                              end;
              end;
setcolor(2);
moveto(x[1]+5,y[1]-5);lineto(x[1]-5,y[1]+5);
moveto(x[1]-5,y[1]-5);lineto(x[1]+5,y[1]+5);
setcolor(1);
moveto(x[3]+5,y[3]-5);lineto(x[3]-5,y[3]+5);
moveto(x[3]-5,y[3]-5);lineto(x[3]+5,y[3]+5);
if (force<>0) and (y[5]>30) and (y[5]<170) then
          begin
          force:=force-1;
          setcolor(0);
          circle(x[5],y[5],3);
          circle(x[5],y[5],2);
          circle(x[5],y[5],1);
          putpixel(x[5],y[5],0);
          if dir='N'  then y[5]:=y[5]-5;
          if dir='S'  then y[5]:=y[5]+5;
          if dir='O'  then x[5]:=x[5]-5;
          if dir='E'  then x[5]:=x[5]+5;
          if dir='NE' then
                      begin
                      x[5]:=x[5]+5;
                      y[5]:=y[5]-5;
                      end;
          if dir='NO' then
                      begin
                      x[5]:=x[5]-5;
                      y[5]:=y[5]-5;
                      end;
          if dir='SO' then
                      begin
                      x[5]:=x[5]-5;
                      y[5]:=y[5]+5;
                      end;
          if dir='SE' then
                      begin
                      x[5]:=x[5]+5;
                      y[5]:=y[5]+5;
                      end;
          setcolor(3);
          circle(x[5],y[5],3);
          circle(x[5],y[5],2);
          circle(x[5],y[5],1);
          putpixel(x[5],y[5],3);
          truc:=true;
          if (x[5]>300) and (x[5]<310) and (y[5]>85) and (y[5]<115) then
                        begin
                        p1:=p1+1;
                        gagne;
                        truc:=false;
                        end;
          if (x[5]>10) and (x[5]<20) and (y[5]>85) and (y[5]<115) then
                        begin
                        p2:=p2+1;
                        gagne;
                        truc:=false;
                        end;
          if (truc) and (force=0) and ((x[5]>278) or (x[5]<43)) then gagne;
          end;
setcolor(0);
moveto(x[2]+5,y[2]-5);lineto(x[2]-5,y[2]+5);
moveto(x[2]-5,y[2]-5);lineto(x[2]+5,y[2]+5);
if (x[5]>x[2]) and (random(100)<20) then x[2]:=x[2]+5;
if (x[5]<x[2]) and (random(100)<20) then x[2]:=x[2]-5;
if (y[5]<y[2]) and (random(100)<20) then y[2]:=y[2]-5;
if (y[5]>y[2]) and (random(100)<20) then y[2]:=y[2]+5;
if a[2] then
        begin
        if (random(100)>50) and (x[2]<270) then x[2]:=x[2]+5;
        if (random(100)>30) and (x[2]>250) then
                                           begin
                                           dir:='E';
                                           force:=10;
                                           a[2]:=false;
                                           end;
        end;
          setcolor(0);
          circle(x[5],y[5],3);
          circle(x[5],y[5],2);
          circle(x[5],y[5],1);
          putpixel(x[5],y[5],0);
if a[2] then x[5]:=x[2];
if a[2] then y[5]:=y[2];
          setcolor(3);
          circle(x[5],y[5],3);
          circle(x[5],y[5],2);
          circle(x[5],y[5],1);
          putpixel(x[5],y[5],3);
if (x[5]=x[2]) and (y[5]=y[2]) and not(a[1]) and (random(100)<50) then
                                       begin
                                       a[3]:=false;
                                       a[4]:=false;
                                       a[2]:=true;
                                       end;
if (a[2]) and (random(100)<63) then
                               begin
                               if y[1]>y[2] then dir:='S';
                               if y[1]<y[2] then dir:='N';
                               if x[1]<x[2] then dir:='O';
                               if x[1]>x[2] then dir:='E';
                               force:=10;
                               a[2]:=false;
                               end;
setcolor(0);
moveto(x[4]+5,y[4]-5);lineto(x[4]-5,y[4]+5);
moveto(x[4]-5,y[4]-5);lineto(x[4]+5,y[4]+5);
if (x[5]>x[4]) and (random(100)<20) then x[4]:=x[4]+5;
if (x[5]<x[4]) and (random(100)<20) then x[4]:=x[4]-5;
if (y[5]<y[4]) and (random(100)<20) then y[4]:=y[4]-5;
if (y[5]>y[4]) and (random(100)<20) then y[4]:=y[4]+5;
if a[4] then
        begin
        if (random(100)>50) and (x[4]>50) then x[4]:=x[4]-5;
        if (random(100)>30) and (x[4]<70) then
                                           begin
                                           dir:='E';
                                           force:=10;
                                           a[4]:=false;
                                           end;
        end;
          setcolor(0);
          circle(x[5],y[5],3);
          circle(x[5],y[5],2);
          circle(x[5],y[5],1);
          putpixel(x[5],y[5],0);
if a[4] then x[5]:=x[4];
if a[4] then y[5]:=y[4];
          setcolor(3);
          circle(x[5],y[5],3);
          circle(x[5],y[5],2);
          circle(x[5],y[5],1);
          putpixel(x[5],y[5],3);
if (x[5]=x[4]) and (y[5]=y[4]) and not(a[3]) and (random(100)<50) then
                                       begin
                                       a[1]:=false;
                                       a[2]:=false;
                                       a[4]:=true;
                                       end;
if (a[4]) and (random(100)<63) then
                               begin
                               if y[3]>y[4] then dir:='S';
                               if y[3]<y[4] then dir:='N';
                               if x[3]<x[4] then dir:='O';
                               if x[3]>x[4] then dir:='E';
                               force:=10;
                               a[4]:=false;
                               end;
end;

begin
randomize;
ch:='-';
x[1]:=45;y[1]:=55;
x[2]:=45;y[2]:=145;
x[3]:=275;y[3]:=55;
x[4]:=275;y[4]:=145;
x[5]:=160;y[5]:=100;
direction:='-';
direct_en:='-';
dir:='-';
force:=0;
p1:=0;
p2:=0;
a[1]:=false;
a[2]:=false;
a[3]:=false;
a[4]:=false;
write('Dur‚e du match ? ');readln(duree);
DetectGraph(pilote,mode);
if (pilote <> CGA) then
                   begin
                   Clrscr;
                   writeln('Jeu ne marchant qu''avec la carte CGA');
                   Halt(1);
                   end;
pilote:=cga;mode:=1;
initgraph(pilote,mode,'');
verify;
settextstyle(1,0,2);
verify;
setBKcolor(1);
setcolor(3);
rectangle(40,20,280,180);
rectangle(300,85,310,115);
rectangle(10,85,20,115);
setfillstyle(1,3);
floodfill(300,20,3);
setfillstyle(1,1);
floodfill(305,100,3);
setfillstyle(1,2);
floodfill(15,100,3);
setcolor(1);
outtextXY(10,-2,'       WATER - POLO');
setcolor(2);
outtextXY(13,-1,'       WATER - POLO');
settextstyle(0,0,0);
verify;
min:=0;
sec:=0;
min2:=min;
sec2:=sec;
settime(0,min,sec,0);
repeat
depart;
gettime(h,min2,sec2,cent);
if min2=duree then ch:=chr(27);
until ch=chr(27);
Cleardevice;
settextstyle(1,0,5);
str(p1,point1);
str(p2,point2);
setcolor(1);
OuttextXY(95,80,''+point1+' - '+point2);
setcolor(2);
OuttextXY(98,81,''+point1+' - '+point2);
settextstyle(1,0,2);
verify;
setcolor(1);
outtextXY(10,28,'       WATER - POLO');
setcolor(2);
outtextXY(13,29,'       WATER - POLO');
setcolor(3);
rectangle(10,10,310,180);
rectangle(11,11,309,179);
rectangle(12,12,308,178);
l8:=80;
l12:=120;
sound(440);
delay(l12);
Nosound;
sound(0);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(0);
delay(l12);
Nosound;
sound(466);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(466);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(466);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(0);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(370);
delay(l8);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(370);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(370);
delay(l12);
Nosound;
sound(440);
delay(l12);
Nosound;
sound(294);
delay(180);
Nosound;
closegraph;
restorecrtmode;
Clrscr;
end.