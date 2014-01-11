Uses Crt;

Var Couleur:array[1..4] of byte;
    c:integer;
    i:integer;
    ch1,ch,ch2:char;
    chI1,chI2:integer;
    mulS1,mulS2,c1,c2,c3:string;
    mul1,mul2,result,pres,m:longint;
    erreur:integer;
    reussi,echec:integer;
    pass,pass2,faute:boolean;

Procedure Centrer(x,y:integer;texte:string);
begin
GotoXY(x-round(length(texte)/2),y);Write(Texte);
end;

Procedure Vertical(x,y:integer;Texte:string);
var i:integer;
begin
i:=-1;
repeat
i:=i+1;
GotoXY(x,y+i);Write(copy(texte,i+1,1));
until i=length(texte);
end;

Begin
reussi:=0;
echec:=0;
repeat
Randomize;
Clrscr;
Centrer(40,1,'Tu dois trouver la valeur de la resistance ci-dessous :');
GotoXY(1,5);
TextColor(white);
Writeln('       ÚÄÄÄÄÂÄÄÂÄÄÄÂÄÄÂÄÄÄÂÄÄÂÄÄÄÄÄÄÄÂÄÄÂÄÄÄÄ¿');
Writeln('       ³    ³  ³   ³  ³   ³  ³       ³  ³    ³');
Writeln('       ³    ³  ³   ³  ³   ³  ³       ³  ³    ³   ');
Writeln('       ³    ³  ³   ³  ³   ³  ³       ³  ³    ³      ');
Writeln('       ³    ³  ³   ³  ³   ³  ³       ³  ³    ³         ');
Writeln('       ÀÄÄÄÄÁÄÄÁÄÄÄÁÄÄÁÄÄÄÁÄÄÁÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÙ            ');
couleur[1]:=random(10);
couleur[2]:=random(10);
couleur[3]:=random(7);
couleur[4]:=random(3);
c:=couleur[1];
if couleur[1]=1 then c:=6;
if couleur[1]=2 then c:=12;
if couleur[1]=3 then c:=4;
if couleur[1]=4 then c:=14;
if couleur[1]=5 then c:=10;
if couleur[1]=6 then c:=9;
if couleur[1]=7 then c:=5;
if couleur[1]=8 then c:=7;
if couleur[1]=9 then c:=15;
For i:=6 to 9 do
    begin
    TextColor(c);
    GotoXY(14,i);
    write('ÛÛ');
    end;
if couleur[1]=0 then textColor(White);
case couleur[1] of
     0 : Vertical(14,11,chr(24)+'NOIR');
     1 : Vertical(14,11,chr(24)+'MARRON');
     2 : Vertical(14,11,chr(24)+'ROUGE');
     3 : Vertical(14,11,chr(24)+'ORANGE');
     4 : Vertical(14,11,chr(24)+'JAUNE');
     5 : Vertical(14,11,chr(24)+'VERT');
     6 : Vertical(14,11,chr(24)+'BLEU');
     7 : Vertical(14,11,chr(24)+'VIOLET');
     8 : Vertical(14,11,chr(24)+'GRIS');
     9 : Vertical(14,11,chr(24)+'BLANC');
     end;
c:=couleur[2];
if couleur[2]=1 then c:=6;
if couleur[2]=2 then c:=12;
if couleur[2]=3 then c:=4;
if couleur[2]=4 then c:=14;
if couleur[2]=5 then c:=10;
if couleur[2]=6 then c:=9;
if couleur[2]=7 then c:=5;
if couleur[2]=8 then c:=7;
if couleur[2]=9 then c:=15;
For i:=6 to 9 do
    begin
    TextColor(c);
    GotoXY(21,i);
    write('ÛÛ');
    end;
if couleur[2]=0 then textColor(White);
case couleur[2] of
     0 : Vertical(21,11,chr(24)+'NOIR');
     1 : Vertical(21,11,chr(24)+'MARRON');
     2 : Vertical(21,11,chr(24)+'ROUGE');
     3 : Vertical(21,11,chr(24)+'ORANGE');
     4 : Vertical(21,11,chr(24)+'JAUNE');
     5 : Vertical(21,11,chr(24)+'VERT');
     6 : Vertical(21,11,chr(24)+'BLEU');
     7 : Vertical(21,11,chr(24)+'VIOLET');
     8 : Vertical(21,11,chr(24)+'GRIS');
     9 : Vertical(21,11,chr(24)+'BLANC');
     end;
c:=couleur[3];
if couleur[3]=1 then c:=6;
if couleur[3]=2 then c:=12;
if couleur[3]=3 then c:=4;
if couleur[3]=4 then c:=14;
if couleur[3]=5 then c:=10;
if couleur[3]=6 then c:=9;
For i:=6 to 9 do
    begin
    TextColor(c);
    GotoXY(28,i);
    write('ÛÛ');
    end;
if couleur[3]=0 then textColor(White);
case couleur[3] of
     0 : Vertical(28,11,chr(24)+'NOIR');
     1 : Vertical(28,11,chr(24)+'MARRON');
     2 : Vertical(28,11,chr(24)+'ROUGE');
     3 : Vertical(28,11,chr(24)+'ORANGE');
     4 : Vertical(28,11,chr(24)+'JAUNE');
     5 : Vertical(28,11,chr(24)+'VERT');
     6 : Vertical(28,11,chr(24)+'BLEU');
     end;
if couleur[4]=0 then c:=14;
if couleur[4]=1 then c:=7;
if couleur[4]=2 then c:=0;
For i:=6 to 9 do
    begin
    TextColor(c);
    if c=0 then GotoXY(38,i) else gotoXY(39,i);
    if c=0 then write('ÛÛÛÛ') else write('ÛÛ');
    end;
if couleur[4]=2 then textColor(White);
case couleur[4] of
     0 : Vertical(39,11,chr(24)+'OR');
     1 : Vertical(39,11,chr(24)+'ARGENT');
     2 : Vertical(39,11,chr(24)+'Pas d''anneau');
     end;
repeat
GotoXY(18,24);Write('      *            =             ê … ñ    %');
pass:=false;
repeat
GotoXY(19,24);
ch1:=readkey;
until (ord(ch1) in [48..57]);
repeat
GotoXY(19,24);Write(ch1);
ch2:=readkey;
until (ord(ch2) in [48..57]);
GotoXY(20,24);Write(ch2);
mulS1:=concat(ch1,ch2);
Val(mulS1,mul1,erreur);
if erreur<>0 then Halt;
pass:=false;
repeat
GotoXY(26,24);
{$I-}
Read(mul2);
{$I+}
if IOResult<>0 then pass:=false else pass:=true;
until pass;
pass:=false;
repeat
GotoXY(40,24);
{$I-}
Read(result);
{$I+}
if IOResult<>0 then pass:=false else pass:=true;
until pass;
pass:=false;
repeat
GotoXY(57,24);
{$I-}
Read(pres);
{$I+}
if IOResult<>0 then pass:=false else pass:=true;
until pass;
faute:=false;
Val(ch1,chI1,erreur);
if erreur<>0 then Halt;
Val(ch2,chI2,erreur);
if erreur<>0 then Halt;
if couleur[1]<>chI1 then faute:=true;
if couleur[2]<>chI2 then faute:=true;
case Couleur[3] of
     0 : m:=1;
     1 : m:=10;
     2 : m:=100;
     3 : m:=1000;
     4 : m:=10000;
     5 : m:=100000;
     6 : m:=1000000;
     end;
if mul2<>m then faute:=true;
if mul1*mul2<>result then faute:=true;
if pres>20 then faute:=true;
if pres<5 then faute:=true;
if (couleur[4]=0) and (pres<>5) then faute:=true;
if (couleur[4]=1) and (pres<>10) then faute:=true;
if (couleur[4]=2) and (pres<>20) then faute:=true;
if (pres<>5) xor (pres<>10) xor (pres<>20) then faute:=true;
str(couleur[1],c1);
str(couleur[2],c2);
c3:=concat(c1,c2);
Val(c3,c,erreur);
if erreur<>0 then Halt;
if (c*m)<>Result then faute:=true;
if faute then
         begin
         sound(100);
         delay(500);
         Nosound;
         echec:=echec+1;
         pass2:=false;
         end;
if not(faute) then begin pass2:=true;reussi:=reussi+1; end;
until pass2;
ch:=readkey;
until ch=chr(27);
Clrscr;
if reussi>1 then Writeln('Tu as r‚ussi a trouver la valeur de ',reussi,' resistances sur ',echec+reussi);
if reussi<2 then Writeln('Tu as r‚ussi a trouver la valeur de ',reussi,' resistance sur ',echec+reussi);
End.