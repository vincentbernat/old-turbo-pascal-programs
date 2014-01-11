uses graph,crt,litclavier,menus,dos;

Var
   fichnom:file of integer;
   dirInfo:searchrec;
   fichnom2:file of string;
   fichnom3:file of real;
   mode,pilote:integer;
   dollar:integer;
   dollar2:string;
   balle:integer;
   droit:boolean;
   balle2:string;
   hasard:word;
   x,y:integer;
   i:integer;
   iS:string;
   longeur:integer;
   heureR:array[1..6] of integer;
   minuteR:array[1..6] of integer;
   secondeR:array[1..6] of integer;
   numeroRS:string;
   heureRS:string;
   minuteRS:string;
   secondeRS:string;
   nomR:array[1..6] of string;
   place:boolean;
   total:array[1..6] of real;
   nom:string;
   heureS,minuteS,secondeS:string;
   erreur:integer;
   valeur:string;
   valeurR:real;
   heure,minute,seconde,idiot:word;
   heure2,minute2,seconde2:word;
   ch:char;
   plus:word;
   xcu,ycu,xcurseur,ycurseur:integer;
   couleur:integer;
   soucoupe:integer;

procedure score;
forward;

procedure perdu;
begin
gettime(heure,minute,seconde,idiot);
restaure(Xcu,ycu);
settextStyle(1,0,6);
setcolor(0);
repeat
setcolor(couleur);
couleur:=couleur+1;if couleur=4 then couleur:=1;
outtextXY(10,35,'GAME OVER');
until keypressed;
ch:=readkey;
score;
end;

procedure score;
var fichnom:file of integer;
    fichnom2:file of string;
begin
str(heure,heureS);
str(minute,minuteS);
str(seconde,secondeS);
settextstyle(1,0,2);
cleardevice;
outtextXY(5,10,'Votre temps est '+heureS+'h'+minuteS+'mn'+secondeS+'s.');
ch:=readkey;
{valeur:=heureS+minuteS+secondeS;
val(valeur,valeurR,erreur);
if erreur<>0 then outtextXY(5,5,'ERREUR');
settextstyle(0,0,0);
if valeurR>total[6] then
                     begin
                     Cleardevice;
                     outtextXY(5,190,'Entrez votre nom: ');
                     gotoXY(20,25);
                     read(nom);
                     if valeurR>total[1] then
                                         begin
                                         place:=true;
                           Total[6]:=Total[5];nomR[6]:=nomR[5];secondeR[6]:=secondeR[5];
                                         heureR[6]:=heureR[5];minuteR[6]:=minuteR[5];
                           total[5]:=total[4];nomR[5]:=nomR[4];secondeR[5]:=secondeR[4];
                                         heureR[5]:=heureR[4];minuteR[5]:=minuteR[4];
                           Total[4]:=Total[3];nomR[4]:=nomR[3];secondeR[4]:=secondeR[3];
                                         heureR[4]:=heureR[3];minuteR[4]:=minuteR[3];
                           total[3]:=total[2];nomR[3]:=nomR[2];secondeR[3]:=secondeR[2];
                                         heureR[3]:=heureR[2];minuteR[3]:=minuteR[2];
                           Total[2]:=Total[1];nomR[2]:=nomR[1];secondeR[2]:=secondeR[1];
                                         heureR[2]:=heureR[1];minuteR[2]:=minuteR[1];
                           total[1]:=valeurR;nomR[1]:=Nom;secondeR[1]:=seconde;
                                         heureR[1]:=heure;minuteR[1]:=minute;
                           end;
                     if (valeurR>total[2]) and (not(place)) then
                                         begin
                                         place:=true;
                           Total[6]:=Total[5];nomR[6]:=nomR[5];secondeR[6]:=secondeR[5];
                                         heureR[6]:=heureR[5];minuteR[6]:=minuteR[5];
                           total[5]:=total[4];nomR[5]:=nomR[4];secondeR[5]:=secondeR[4];
                                         heureR[5]:=heureR[4];minuteR[5]:=minuteR[4];
                           Total[4]:=Total[3];nomR[4]:=nomR[3];secondeR[4]:=secondeR[3];
                                         heureR[4]:=heureR[3];minuteR[4]:=minuteR[3];
                           total[3]:=total[2];nomR[3]:=nomR[2];secondeR[3]:=secondeR[2];
                                         heureR[3]:=heureR[2];minuteR[3]:=minuteR[2];
                           Total[2]:=valeurR;nomR[2]:=Nom;secondeR[2]:=seconde;
                                         heureR[2]:=heure;minuteR[2]:=minute;
                           end;
                     if (valeurR>total[3]) and (not(place)) then
                                         begin
                                         place:=true;
                           Total[6]:=Total[5];nomR[6]:=nomR[5];secondeR[6]:=secondeR[5];
                                         heureR[6]:=heureR[5];minuteR[6]:=minuteR[5];
                           total[5]:=total[4];nomR[5]:=nomR[4];secondeR[5]:=secondeR[4];
                                         heureR[5]:=heureR[4];minuteR[5]:=minuteR[4];
                           Total[4]:=Total[3];nomR[4]:=nomR[3];secondeR[4]:=secondeR[3];
                                         heureR[4]:=heureR[3];minuteR[4]:=minuteR[3];
                           Total[3]:=valeurR;nomR[3]:=Nom;secondeR[3]:=seconde;
                                         heureR[3]:=heure;minuteR[3]:=minute;
                           end;
                     if (valeurR>total[4]) and (not(place)) then
                                         begin
                                         place:=true;
                           Total[6]:=Total[5];nomR[6]:=nomR[5];secondeR[6]:=secondeR[5];
                                         heureR[6]:=heureR[5];minuteR[6]:=minuteR[5];
                           total[5]:=total[4];nomR[5]:=nomR[4];secondeR[5]:=secondeR[4];
                                         heureR[5]:=heureR[4];minuteR[5]:=minuteR[4];
                           Total[4]:=valeurR;nomR[4]:=Nom;secondeR[4]:=seconde;
                                         heureR[4]:=heure;minuteR[4]:=minute;
                           end;
                     if (valeurR>total[5]) and (not(place)) then
                                         begin
                                         place:=true;
                           Total[6]:=Total[5];nomR[6]:=nomR[5];secondeR[6]:=secondeR[5];
                                         heureR[6]:=heureR[5];minuteR[6]:=minuteR[5];
                           Total[5]:=valeurR;nomR[5]:=Nom;secondeR[5]:=seconde;
                                         heureR[5]:=heure;minuteR[5]:=minute;
                           end;
                     if (valeurR>total[6]) and (not(place)) then
                                       begin
                                         place:=true;
                           Total[6]:=valeurR;nomR[6]:=Nom;secondeR[6]:=seconde;
                                         heureR[6]:=heure;minuteR[6]:=minute;
                           end;
                     end;
Cleardevice;
i:=1;
repeat
str(heureR[i],heureRS);
str(minuteR[i],minuteRS);
str(secondeR[i],secondeRS);
str(i,iS);
if i=1 then couleur:=1;
if i=2 then couleur:=2;
if i=4 then couleur:=3;
setcolor(couleur);
outtextXY(5,i*10,iS+'. '+nomR[i]+'     '+heureRS+':'+minuteRS+':'+secondeRS);
i:=i+1;
until i=7;
settextstyle(2,0,4);
setcolor(2);
outtextXY(5,170,'SAUVEGARDE: VEUILLEZ INSERER UNE DISQUETTE DANS B:');
outtextXY(5,185,'PUIS APPUYEZ SUR UNE TOUCHE.');
ch:=readkey;
setverify(true);
assign(fichnom,'b:secret.dat');
rewrite(fichnom);
write(fichnom,heureR[1]);
write(fichnom,heureR[2]);
write(fichnom,heureR[3]);
write(fichnom,heureR[4]);
write(fichnom,heureR[5]);
write(fichnom,heureR[6]);
write(fichnom,minuteR[1]);
write(fichnom,minuteR[2]);
write(fichnom,minuteR[3]);
write(fichnom,minuteR[4]);
write(fichnom,minuteR[5]);
write(fichnom,minuteR[6]);
write(fichnom,secondeR[1]);
write(fichnom,secondeR[2]);
write(fichnom,secondeR[3]);
write(fichnom,secondeR[4]);
write(fichnom,secondeR[5]);
write(fichnom,secondeR[6]);
close(fichnom);
assign(fichnom2,'b:secret2.dat');
rewrite(fichnom2);
write(fichnom2,nomR[1]);
write(fichnom2,nomR[2]);
write(fichnom2,nomR[3]);
write(fichnom2,nomR[4]);
write(fichnom2,nomR[5]);
write(fichnom2,nomR[6]);
close(fichnom2);
assign(fichnom3,'b:secret3.dat');
rewrite(fichnom3);
write(fichnom3,total[1]);
write(fichnom3,total[2]);
write(fichnom3,total[3]);
write(fichnom3,total[4]);
write(fichnom3,total[5]);
write(fichnom3,total[6]);
close(fichnom3);}
halt(1);
end;

procedure eff_char3(x,y:integer);
begin
couleur:=getcolor;
setcolor(getBkcolor);
outtextXY(x,y,'€€€');
end;

begin
{mode:=0;
pilote:=cga;
initgraphic(0);
droit:=false;
settextstyle(2,0,4);
setcolor(2);
outtextXY(5,170,'LECTURE: VEUILLEZ INSERER UNE DISQUETTE DANS B:');
outtextXY(5,185,'PUIS APPUYEZ SUR UNE TOUCHE.');
ch:=readkey;
setverify(true);
findfirst('b:?secret*.*',archive,DirInfo);
if DosError=0 then
               begin
               assign(fichnom,'b:secret.dat');
               reset(fichnom);
               read(fichnom,heureR[1]);
               read(fichnom,heureR[2]);
               read(fichnom,heureR[3]);
               read(fichnom,heureR[4]);
               read(fichnom,heureR[5]);
               read(fichnom,heureR[6]);
               read(fichnom,minuteR[1]);
               read(fichnom,minuteR[2]);
               read(fichnom,minuteR[3]);
               read(fichnom,minuteR[4]);
               read(fichnom,minuteR[5]);
               read(fichnom,minuteR[6]);
               read(fichnom,secondeR[1]);
               read(fichnom,secondeR[2]);
               read(fichnom,secondeR[3]);
               read(fichnom,secondeR[4]);
               read(fichnom,secondeR[5]);
               read(fichnom,secondeR[6]);
               close(fichnom);
               assign(fichnom2,'b:secret2.dat');
               reset(fichnom2);
               read(fichnom2,nomR[1]);
               read(fichnom2,nomR[2]);
               read(fichnom2,nomR[3]);
               read(fichnom2,nomR[4]);
               read(fichnom2,nomR[5]);
               read(fichnom2,nomR[6]);
               close(fichnom2);
               assign(fichnom3,'b:secret3.dat');
               reset(fichnom3);
               read(fichnom3,total[1]);
               read(fichnom3,total[2]);
               read(fichnom3,total[3]);
               read(fichnom3,total[4]);
               read(fichnom3,total[5]);
               read(fichnom3,total[6]);
               close(fichnom3);
               end;}
randomize;
mode:=0;
pilote:=cga;
initgraphic(0);
settextstyle(0,0,0);
Cleardevice;
rectangle(40,155,80,199);
rectangle(40,155,120,185);
rectangle(40,170,120,199);
plus:=15;
balle:=0;
place:=false;
setfillstyle(1,1);
repeat
setcolor(3);
hasard:=random(20);
plus:=hasard+plus+10;
line(hasard+(plus-10),40,hasard+(plus-10),30);
line(hasard+plus,40,hasard+plus,30);
setcolor(3);
circle(hasard+(plus-5),12,20);
floodfill(hasard+(plus-5),12,3);
setcolor(1);
circle(hasard+(plus-5),12,20);
until plus>270;
setfillstyle(1,3);
floodfill(50,157,3);floodfill(100,157,3);
floodfill(50,172,3);floodfill(100,172,3);
floodfill(50,187,3);floodfill(100,187,3);
setcolor(0);
rectangle(40,155,80,199);
rectangle(40,155,120,185);
rectangle(40,170,120,199);
heure:=0;
heure2:=0;
minute:=0;
minute2:=0;
seconde:=0;
seconde2:=0;
setcolor(1);
outtextXY(0,190,'≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥');
outtextXY(4,190,'≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥≥');
masque:=pmask6;
forme_curseur:=pcurseur6;
soucoupe:=0;
dollar:=20;

  deplace_curseur(souris_est_la,[#27,#172],xcurseur,ycurseur,ch);
{  xcurseur:=xsouris;ycurseur:=ysouris;}
  affiche_curseur(xcurseur,ycurseur);
  xcu:=xcurseur;ycu:=ycurseur;
  setcolor(0);
outtextXY(20,5,'€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€');
setcolor(3);   {N O M B R E DE C A R A C T E R E S}
outtextXY(20,5,' Balle(s):    Dollar(s):         ');
repeat
  deplace_curseur(souris_est_la,[#63,#27,#68,#59,#172],xcurseur,ycurseur,ch);
  if keypressed then ch:=readkey;
  if (xcurseur<>xcu) or (ycurseur<>ycu)
  then begin
    restaure(xcu,ycu);{xcurseur:=xsouris;ycurseur:=ysouris;}
              if xcu<5 then xcu:=298;
              if xcu>300 then xcu:=7;
    affiche_curseur(xcurseur,ycurseur);
    xcu:=xcurseur;ycu:=ycurseur;
      end;
  if balle>4 then
             begin
             dollar:=dollar+6;
             balle:=balle-4;
             setcolor(0);
             str(balle,balle2);
             str(dollar,dollar2);
             outtextXY(20,5,'           €             €€€€€€€€');
             setcolor(3);
             outtextXY(20,5,'           '+balle2+'             '+dollar2);
             end;
  if (soucoupe=0) and (ch=#63){ and (balle=0)} then
                               begin
                               restaure(xcu,ycu);
                               setcolor(0);
                               circle(x,y,5);circle(x,y,4);circle(x,y,3);circle(x,y,2);
                               circle(x,y,1);putpixel(x,y,0);
                               affiche_curseur(xcu,ycu);
                               dollar:=dollar-1;
                               if dollar<0 then perdu;
                               setcolor(3);
                               line(40,155,40,140);
                               setcolor(2);
                               outtextXY(41,140,'€€€');
                               met_souris(250,160);
                               delay(500);
                               settime(heure2,minute2,seconde2,0);
                               soucoupe:=1;
                               x:=30;y:=150;
                               eff_char3(41,140);
                               setcolor(0);
                               line(40,155,40,140);
                               balle:=balle+2;
                               dollar:=dollar-4;
                               setcolor(0);
                               str(balle,balle2);
                               str(dollar,dollar2);
                               outtextXY(20,5,'           €             €€€€€€€€');
                               setcolor(3);
                               outtextXY(20,5,'           '+balle2+'             '+dollar2);
                               if dollar<0 then perdu;
                               end;
 if (soucoupe=1) and (ch=#13) and (balle<>0) then
                              begin
                              balle:=balle-1;
                              if dollar<0 then perdu;
                              setcolor(0);
                              str(balle,balle2);
                              str(dollar,dollar2);
                              outtextXY(20,5,'           €             €€€€€€€€');
                              setcolor(3);
                              outtextXY(20,5,'           '+balle2+'             '+dollar2);
                              setcolor(2);
                              if balle=0 then
                                         begin
                                         soucoupe:=0;
                                         gettime(heure2,minute2,seconde2,idiot);
                                         end;
                              delay(350);
if (getpixel(xcurseur+8,ycurseur+8)=2)or(getpixel(xcurseur+9,ycurseur+9)=2)or(getpixel(xcurseur+7,ycurseur+7)=2) then
                                                               begin
                                                               dollar:=dollar+5;
                                                               setcolor(0);
                                                               str(balle,balle2);
                                                               str(dollar,dollar2);
                                                               outtextXY(20,5,'           €             €€€€€€€€');
                                                               setcolor(3);
                                                               outtextXY(20,5,'           '+balle2+'             '+dollar2);
                                                               sound(36);
                                                               delay(100);
                                                               sound(42);delay(100);
                                                               sound(27);delay(400);
                                                               sound(31);delay(90);
                                                               gettime(heure2,minute2,seconde2,idiot);
                                                               Nosound;
                                                               soucoupe:=0;
                                                               restaure(xcu,ycu);
                                                               setcolor(0);
                                                               circle(x,y,5);circle(x,y,4);circle(x,y,3);circle(x,y,2);
                                                               circle(x,y,1);putpixel(x,y,0);
                                                               affiche_curseur(xcu,ycu);
                                                               end;
                              end;
if soucoupe=1 then
              begin
              restaure(xcu,ycu);
              setcolor(0);
              circle(x,y,5);circle(x,y,4);circle(x,y,3);
              circle(x,y,2);circle(x,y,1);putpixel(x,y,0);
              affiche_curseur(xcu,ycu);
              if longeur<1 then
              begin
              hasard:=random(50000);
              longeur:=30;
              end;
              if hasard>25000 then x:=x+5;
              if hasard<25000 then x:=x-5;
              y:=y-3;
              if x<5 then x:=298;
              if x>300 then x:=7;
              longeur:=longeur-1;
              setcolor(2);
              circle(x,y,5);circle(x,y,4);circle(x,y,3);circle(x,y,2);
              circle(x,y,1);putpixel(x,y,2);
              if y<33 then
                 begin
                 soucoupe:=0;
              restaure(xcu,ycu);
              setcolor(0);
              circle(x,y,5);circle(x,y,4);circle(x,y,3);circle(x,y,2);
              circle(x,y,1);putpixel(x,y,0);
              affiche_curseur(xcu,ycu);
              gettime(heure2,minute2,seconde2,idiot);
                 end;
              end;
until ((ch=#172) or (ch=#27));
restaure(xcu,ycu);
end.