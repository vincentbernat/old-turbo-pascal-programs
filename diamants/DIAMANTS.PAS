Uses Crt,Graph,Dos;

Const Poussiere : FillPatternType = ($A7,$1B,$9B,$1F,$1F,$9B,$1B,$A7);

Type Plat = Record
            L1    : String[20];
            L2    : String[20];
            L3    : String[20];
            L4    : String[20];
            L5    : String[20];
            L6    : String[20];
            L7    : String[20];
            L8    : String[20];
            L9    : String[20];
            L10   : String[20];
            L11   : String[20];
            L12   : String[20];
            NbDiam: Byte;
            End;

Var Pilote, Mode, Erreur : Integer;
    InfoFonteBase        : TextSettingsType;
    Ch                   : Char;
    Plateau              : Array[1..20] of Plat;
    EtatPlateau          : Array[1..20,1..12] of Char;
    Pous, Monstre1, Diam : Pointer;
    Roche, B1, B2        : Pointer;
    NiveauAff            : Byte;
    Diamants,Vies        : Byte;
    NivCour              : Byte;

Procedure Presentation;
Var i                : Integer;
    chaine, copyc    : String;
    ch1,ch2          : Char;
    l                : Integer;
Begin
SetColor(2);
SetTextJustify(1,1);
Chaine:='       LA MINE DE DIAMANTS       ';
OutTextXY(160,100,'LA MINE DE DIAMANTS');
i:=9;
l:=length(chaine);
Repeat
ClearDevice;
copyc:=copy(chaine,1,20);
OutTextXY(160,100,copyc);
chaine:=copy(chaine,2,l-2)+copy(chaine,1,1);
SetBKColor(i);
I:=I+1;
if i=16 then i:=9;
Until KeyPressed;
Ch:=Readkey;
end;

Procedure Jeu;
begin
SetTextStyle(2,0,4);
SetColor(3);
SetTextJustify(InfoFonteBase.Horiz,InfoFonteBase.Vert);
OutTextXY(2,178,'Vies :     Diamants :      Niveau :  ');
end;

Procedure AssignePlateau;
Begin
{ composition d'un niveau : }
{ 1 = Depart
  2 = Rocher
  3 = Diamant
  4 = Monstre
  5 = Monstre2
  6 = Vide
  7 = Sortie
  0 = Poussiäre}
{Un niveau est de taille 19*11}
Plateau[1].L1 :='1200003002200020002';
Plateau[1].L2 :='0200000022000200020';
Plateau[1].L3 :='0200030020000000200';
Plateau[1].L4 :='0020664600020002300';
Plateau[1].L5 :='0000000200030002002';
Plateau[1].L6 :='0020000300020002200';
Plateau[1].L7 :='0002003000020002000';
Plateau[1].L8 :='0000000003000000000';
Plateau[1].L9 :='0000000000000000000';
Plateau[1].L10:='0020220000020002300';
Plateau[1].L11:='0000700000000200003';
Plateau[1].NbDiam:=9;
End;

{x=0 et y=0 au coin supÇrieur gauche du rectangle sans compter le trait.}

Procedure Affichebonhomme(x,y:integer;genre:byte);
begin
if genre=1 then
	begin
	Setcolor(1); {la casquette}
	Line(x+3,y,x+6,y);
	Line(x+3,y+1,x+8,y+1);
	Setcolor(2);{la tàte}
	line(x+3,y+3,x+7,y+3);
	Line(x+3,y+4,x+5,y+4);
	Putpixel(x+7,y+4,2);
	Line(x+3,y+5,x+7,y+5);
	Line(x+4,y+6,x+6,y+6);
	Setcolor(3);{le pull}
	Line(x+4,y+7,x+6,y+7);
	Line(x+3,y+8,x+3,y+10);
	Line(x+4,y+9,x+4,y+10);
	PutPixel(x+5,y+11,3);
	Rectangle(x+6,y+8,x+7,y+9);
	Putpixel(x+5,y+8,3);
	Setcolor(2){la main};
	Line(x+8,y+10,x+8,y+11);
	Setcolor(1){le manche de la pioche};
	Line(x+9,y+10,x+11,y+4);
	Setcolor(3);{la pioche}
	Line(x+10,y+3,x+12,y+3);
	Putpixel(x+9,y+4,3);
	PutPixel(x+13,y+4,3);
	Setcolor(1);{le pantalon}
	Rectangle(x+3,y+11,x+4,y+14);
	Rectangle(x+6,y+11,x+7,y+14);
	PutPixel(x+5,y+11,1);
	setcolor(3);{les chaussures}
	Line(x+3,y+15,x+8,y+15);
	end;
if genre=2 then
	begin
        x:=x+15;
	Setcolor(1); {la casquette}
	Line(x-3,y,x-6,y);
	Line(x-3,y+1,x-8,y+1);
	Setcolor(2);{la tàte}
	line(x-3,y+3,x-7,y+3);
	Line(x-3,y+4,x-5,y+4);
	Putpixel(x-7,y+4,2);
	Line(x-3,y+5,x-7,y+5);
	Line(x-4,y+6,x-6,y+6);
	Setcolor(3);{le pull}
	Line(x-4,y+7,x-6,y+7);
	Line(x-3,y+8,x-3,y+10);
	Line(x-4,y+9,x-4,y+10);
	PutPixel(x-5,y+11,3);
	Rectangle(x-6,y+8,x-7,y+9);
	Putpixel(x-5,y+8,3);
	Setcolor(2){la main};
	Line(x-8,y+10,x-8,y+11);
	Setcolor(1){le manche de la pioche};
	Line(x-9,y+10,x-11,y+4);
	Setcolor(3);{la pioche}
	Line(x-10,y+3,x-12,y+3);
	Putpixel(x-9,y+4,3);
	PutPixel(x-13,y+4,3);
	Setcolor(1);{le pantalon}
	Rectangle(x-3,y+11,x-4,y+14);
	Rectangle(x-6,y+11,x-7,y+14);
	PutPixel(x-5,y+11,1);
	setcolor(3);{les chaussures}
	Line(x-3,y+15,x-8,y+15);
	end;
end;

Procedure PrepareCaractere;
Var i:integer;
Begin
SetBkColor(0);
ClearDevice;
SetFillPattern(Poussiere,1);
Bar(1,1,17,17);
GetMem(Pous,imageSize(1,1,17,17));
GetImage(1,1,17,17,pous^);
Cleardevice;
i:=16;
repeat
setcolor(2);
Rectangle(1+(16-i),1+(16-i),i+1,i+1);
setcolor(3);
Rectangle(1+(16-i)+1,1+(16-i)+1,i,i);
i:=i-2;
until i=-2;
GetMem(monstre1,imageSize(0,0,16,16));
GetImage(0,0,16,16,Monstre1^);
Cleardevice;
Setcolor(3);
Moveto(4,8);Lineto(8,4);
Lineto(12,8);Lineto(8,12);Lineto(4,8);
SetfillStyle(1,3);
Floodfill(8,8,3);
GetMem(Diam,imageSize(1,1,17,17));
GetImage(1,1,17,17,Diam^);
Setcolor(3);
Setfillstyle(9,3);
FillEllipse(9,9,7,7);
GetMem(Roche,imageSize(1,1,17,17));
GetImage(1,1,17,17,roche^);
ClearDevice;
AfficheBonhomme(1,1,1);
GetMem(B1,imageSize(1,1,17,17));
GetImage(1,1,17,17,B1^);
ClearDevice;
AfficheBonhomme(1,1,2);
GetMem(B2,imageSize(1,1,17,17));
GetImage(1,1,17,17,B2^);
Cleardevice;
end;

Procedure AfficheNiveau(Niv:Byte);
Var a,b:Byte;
    Aff:String;
Begin
NiveauAff:=niv;
{ composition d'un niveau : }
{ 1 = Depart
  2 = Rocher
  3 = Diamant
  4 = Monstre
  5 = Monstre2
  6 = Vide
  7 = Sortie
  0 = Poussiäre}
{Un niveau est de taille 19*11}
a:=1;b:=1;
Repeat
Repeat
Case b of
       1  : Aff:=Copy(Plateau[niv].L1,a,1);
       2  : Aff:=Copy(Plateau[niv].L2,a,1);
       3  : Aff:=Copy(Plateau[niv].L3,a,1);
       4  : Aff:=Copy(Plateau[niv].L4,a,1);
       5  : Aff:=Copy(Plateau[niv].L5,a,1);
       6  : Aff:=Copy(Plateau[niv].L6,a,1);
       7  : Aff:=Copy(Plateau[niv].L7,a,1);
       8  : Aff:=Copy(Plateau[niv].L8,a,1);
       9  : Aff:=Copy(Plateau[niv].L9,a,1);
       10 : Aff:=Copy(Plateau[niv].L10,a,1);
       11 : Aff:=Copy(Plateau[niv].L11,a,1);
       12 : Aff:=Copy(Plateau[niv].L12,a,1);
       end;
if aff=  '1' then PutImage((a-1)*16,(b-1)*16,B1^,XorPut);
if aff=  '2' then PutImage((a-1)*16,(b-1)*16,Roche^,XorPut);
if aff=  '3' then PutImage((a-1)*16,(b-1)*16,Diam^,XorPut);
if aff=  '4' then PutImage((a-1)*16,(b-1)*16,Monstre1^,XorPut);
if aff=  '7' then PutImage((a-1)*16,(b-1)*16,Monstre1^,4);
if aff=  '0' then PutImage((a-1)*16,(b-1)*16,Pous^,XorPut);
a:=a+1;
Until a=20;
a:=1;
b:=b+1;
Until b=12;
SetBkColor(0);
end;

Begin
DetectGraph(Pilote,Mode);
If Pilote=HercMono then
                   Begin
                   Writeln('Ce jeu ne fonctionne qu''avec les cartes IBM');
                   Halt;
                   end;
If Lo(DosVersion)<3 then
                   Begin
                   TextColor(LightRed);
                   Writeln('Ce jeu ne fonctionne qu''avec les versions 3.00 ou ultÇrieures');
                   Halt;
                   end;
Pilote:=Cga;
Mode:=CGAC1;
InitGraph(Pilote,Mode,'');
Erreur:=GraphResult;
If Erreur<>GrOk then
                Begin
                TextColor(LightMagenta);
                Writeln('Erreur lors de l''initialisation graphique : '+GraphErrorMsg(Erreur));
                Halt;
                end;
SetTextStyle(TriplexFont,0,5);
GetTextSettings(InfoFonteBase);
Presentation;
AssignePlateau;
PrepareCaractere;
NivCour:=1;
Vies:=4;
Diamants:=0;
AfficheNiveau(1);
Jeu;
Release(Monstre1);Release(Roche);Release(Diam);Release(pous);
Dispose(Monstre1);Dispose(Roche);Dispose(Diam);Dispose(pous);
Release(B1);Dispose(B2);
End.