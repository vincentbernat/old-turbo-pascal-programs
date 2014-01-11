procedure load;
var fichnom:file of boolean;
    i:integer;
    nom:string;
begin
cache_souris;
cleardevice;
repeat
outtextxy(0,5,'Nom du fichier');read(nom);
assign(fichnom,nom+'.dat');
{$I-}
reset(fichnom);
{$I+}
until IOResult=0;
read(fichnom,epee);
read(fichnom,pain);
read(fichnom,bouclier);
read(fichnom,livre);
read(fichnom,arrosage);
read(fichnom,surprise);
read(fichnom,feu);
read(fichnom,pompe);
read(fichnom,vue);
read(fichnom,baguette);
read(fichnom,papier);
close(fichnom);
cleardevice;
setcolor(1);
setBKcolor(1);
outtextXY(0,20,'Vous avez :');
if livre then outtextXY(0,95,'UN LIVRE');
if epee then outtextXY(160,95,'UNE EPEE');
if vue then outtextXY(0,110,'UNE LONGUE VUE');
if arrosage then outtextXY(160,110,'UN TUYAU D''ARROSAGE');
if pain then outtextXY(0,125,'UN MORCEAU DE PAIN');
if papier then outtextXY(160,125,'UN CODE ');
if surprise then outtextXY(0,140,'UNE BOITE A SURPRISE');
if pompe then outtextXY(160,140,'UNE POMPE');
if baguette then outtextXY(0,155,'UNE BAGUETTE MAGIQUE');
if bouclier then outtextXY(160,155,'UN BOUCLIER');
ch:=readkey;
jeu;
end;

procedure save;
var fichnom:file of boolean;
    i:integer;
    nom:string;
begin
cleardevice;
outtextXY(0,5,'Nom du fichier');read(nom);
assign(fichnom,nom+'.dat');
rewrite (fichnom);
   write(fichnom,epee);
   write(fichnom,pain);
   write(fichnom,bouclier);
   write(fichnom,livre);
   write(fichnom,arrosage);
   write(fichnom,surprise);
   write(fichnom,feu);
   write(fichnom,pompe);
   write(fichnom,vue);
   write(fichnom,baguette);
   write(fichnom,papier);
close(fichnom);
HALT;
end;
