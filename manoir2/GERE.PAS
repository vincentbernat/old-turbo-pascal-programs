UNIT gere;
INTERFACE
USES piece,dos,crt,graph,finish,Phall,Parmoire,Psalon,Pcuisine,Pescalier,Pcave,Pgarage;

procedure charge;
procedure sauve;

IMPLEMENTATION

procedure charge;
var fichnom:file of boolean;
    fichnom2:text;
    i:integer;
    nom:string[8];begin
cleardevice;
repeat
outtextxy(0,5,'Nom du fichier');read(nom);
assign(fichnom,nom+'.DAT');
{$I-}
reset(fichnom);
{$I+}
until IOResult=0;
   read(fichnom,epee);
   read(fichnom,tableau);
   read(fichnom,essuie);
   read(fichnom,lave);
   read(fichnom,bombe);
   read(fichnom,mouchoir);
   read(fichnom,bouteille);
   read(fichnom,clef);
   read(fichnom,vaiselle);
   read(fichnom,lampe);
   read(fichnom,collier);
   read(fichnom,P_hall);
   read(fichnom,P_salon);
   read(fichnom,cave_ecl);
   read(fichnom,P_cave);
   read(fichnom,tresor);
   read(fichnom,parchemin);
   read(fichnom,colle);
   read(fichnom,contact);
   read(fichnom,marteau);
   read(fichnom,gara);
   read(fichnom,boulon);
   read(fichnom,boulon_mis);
   read(fichnom,tuyau);
   read(fichnom,torchon);
   read(fichnom,rustine);
   read(fichnom,huile);
   read(fichnom,bougeoir);
close(fichnom);
repeat
assign(fichnom2,nom+'.END');
{$I-}
reset(fichnom2);
until IOResult=0;
{$I+}
   readln(fichnom2,endroit);
close(fichnom2);
cleardevice;
setcolor(3);
setBKcolor(0);
bilan;
if endroit='HALL' then D_HALL;
if endroit='ARMOIRE' then armoire;
if endroit='SALON' then salon;
if endroit='CUISINE' then cuisine;
if endroit='ESCALIER' then escalier;
if endroit='CAVE' then cave;
if endroit='GARAGE' then garage;
end;

procedure sauve;
var fichnom:file of boolean;
    fichnom2:text;
    i:integer;
    nom:string[8];
begin
cleardevice;
settextstyle(3,0,5);
rectangle(20,20,300,180);
outtextXY(60,90,'Nom du fichier ? (8 car.)');
gotoXY(15,20);read(nom);
assign(fichnom,nom+'.DAT');
rewrite (fichnom);
   write(fichnom,epee);
   write(fichnom,tableau);
   write(fichnom,essuie);
   write(fichnom,lave);
   write(fichnom,bombe);
   write(fichnom,mouchoir);
   write(fichnom,bouteille);
   write(fichnom,clef);
   write(fichnom,vaiselle);
   write(fichnom,lampe);
   write(fichnom,collier);
   write(fichnom,P_hall);
   write(fichnom,P_salon);
   write(fichnom,cave_ecl);
   write(fichnom,P_cave);
   write(fichnom,tresor);
   write(fichnom,parchemin);
   write(fichnom,colle);
   write(fichnom,contact);
   write(fichnom,marteau);
   write(fichnom,gara);
   write(fichnom,boulon);
   write(fichnom,boulon_mis);
   write(fichnom,tuyau);
   write(fichnom,torchon);
   write(fichnom,rustine);
   write(fichnom,huile);
   write(fichnom,bougeoir);
close(fichnom);
assign(fichnom2,nom+'.END');
rewrite(fichnom2);
   writeln(fichnom2,endroit);
close(fichnom2);
TextMode(BW80);
Clrscr;
HALT;
end;

begin
end.