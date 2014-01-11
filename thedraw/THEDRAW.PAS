{$M 65500,0,65535}

Uses Crt,Graph,Menus,Dos,LitClavier;

{Type fich=File of char;
     Tab=Array[0..1024] of Char;}

Var GrPilote, GrMode : Integer;
    Erreur           : Integer;
    ch               : char;
    p,z              : pointer;
    MenuAffiche      : boolean;
    Couleur          : Byte;
    Taille           : Byte;
   GrafBase : Word;

Procedure Entete(Texte:string);
begin
Setcolor(GetMaxColor);
SetFillStyle(1,0);
Bar(1,1,GetmaxX-1,15);
Rectangle(1,1,getmaxX-1,15);
OutTextXY(5,4,Texte);
end;


Procedure SetcolorInv(Color:integer);
begin
setcolor(GetMaxColor-Color);
end;

procedure ampli;
begin
amplitude_X(0,getmaxX);
amplitude_y(16,getmaxy);
end;

Procedure Cercle(x,y,r1,r2:integer);
var t:real;
Begin
  t:=0;
  repeat
    line(round(r1*cos(t)+x),round(r2*sin(t)+y),round(r1*cos(t+0.1)+x),round(r2*sin(t+0.1)+y));
    t:=t+0.1;
  until t>2*pi;
end;

Procedure Zone(x,y,largeur,hauteur:integer;Var p:pointer);
Begin
GetMem(p,imageSize(x,y,x+largeur,y+hauteur));
GetImage(x,y,x+largeur,y+hauteur,p^);
end;

Procedure FermeZone(x,y,largeur,hauteur:integer;mode:Byte;var p:pointer);
Begin
PutImage(x,y,p^,0);
{freemem(p,imageSize(x,y,x+largeur,y+hauteur));}
dispose(p);
end;

{Procedure LireBloc(Var f:fich;Var Buf:Tab);
Var b:Longint;
    Car:char;
begin
b:=-1;
Repeat
b:=b+1;
Read(f,Car);
Buf[b]:=Car;
Until Car=^Z;
end;}

Procedure ConfirmNouveau;
Begin
Zone(0,0,GetmaxX,15,p);
Entete('Veuillez confirmer l''effacement de l''‚cran');
ch:=' ';
ChoixDansMenu('Non,Oui',['N','O'],'NO'+chr(27),12,17,ch);
FermeZone(0,0,getmaxX,16,0,p);
Case ch of
        'O' : begin ClearDevice; end;
     end;
ch:=' ';
SetTextStyle(0,0,0);
end;

Function Quitter : Boolean;
Begin
Entete('Quitter');
ChoixDansMenu('Non,Oui',['N','O'],'NO',12,17,ch);
If ch='O' then Quitter:=true else quitter:=false;
if ch='O' then Exit;
SetFillStyle(1,0);
Bar(0,0,GetMaxX,15);
Montre_souris;
end;

Procedure TT;
Var Click:Boolean;
    DejaClick:Boolean;
    X,y,x2,y2:integer;
    Color:Byte;
Begin
montre_souris;
ampli;
DejaClick:=False;
Click:=false;
Repeat
if (PressBouton=1) and (not(DejaClick)) then
                                        begin
                                        DejaClick:=True;
                                        SetWriteMode(1);
                                        x:=Xsouris+1;Y:=ysouris+1;
                                        Cache_souris;
                                        end;
if (DejaClick) and (PressBouton=1) then
                                   Begin
                                   setcolor(Couleur);
                                   x2:=xsouris-2;y2:=ysouris-2;
                                   Line(x,y,X2,Y2);
                                   delay(10);
                                   Line(x,y,x2,y2);
                                   end;
Until (DejaClick) and (PressBouton=0);
SetWriteMode(0);
setcolor(couleur);
Line(x,y,x2,y2);
end;

Procedure TR;
Var Click:Boolean;
    DejaClick:Boolean;
    X,y,x2,y2:integer;
    Color:Byte;
Begin
montre_souris;
ampli;
DejaClick:=False;
Click:=false;
Repeat
if (PressBouton=1) and (not(DejaClick)) then
                                        begin
                                        DejaClick:=True;
                                        SetWriteMode(1);
                                        x:=Xsouris+1;Y:=ysouris+1;
                                        Cache_souris;
                                        end;
if (DejaClick) and (PressBouton=1) then
                                   Begin
                                   setcolor(Couleur);
                                   x2:=xsouris-2;y2:=ysouris-2;
                                   rectangle(x,y,x2,Y2);
                                   delay(10);
                                   rectangle(x,y,x2,y2);
                                   end;
Until (DejaClick) and (PressBouton=0);
SetWriteMode(0);
setcolor(couleur);
rectangle(x,y,x2,y2);
end;

Procedure TC;
Var Click:Boolean;
    DejaClick:Boolean;
    X,y,x2,y2:integer;
    Color:Byte;
Begin
montre_souris;
ampli;
DejaClick:=False;
Click:=false;
Repeat
if (PressBouton=1) and (not(DejaClick)) then
                                        begin
                                        DejaClick:=True;
                                        SetWriteMode(1);
                                        x:=Xsouris+1;Y:=ysouris+1;
                                        Cache_souris;
                                        end;
if (DejaClick) and (PressBouton=1) then
                                   Begin
                                   setcolor(Couleur);
                                   x2:=xsouris-2;y2:=ysouris-2;
                                   cercle(x,y,x2-x,Y2-y);
                                   delay(10);
                                   cercle(x,y,x2-x,y2-y);
                                   end;
Until (DejaClick) and (PressBouton=0);
SetWriteMode(0);
setcolor(couleur);
cercle(x,y,x2-x,y2-y);
end;

Procedure TA;
Var x,y:integer;
Begin
Montre_souris;
ampli;
Repeat
if Bouton_gauche then
                 begin
                 Cache_souris;
                 X:=Xsouris;y:=ysouris;
                 Putpixel(x,y,Couleur);
                 Montre_souris;
                 end;
until Bouton_droit;
Cache_souris;
end;

Procedure Ecrit;
var p3:pointer;
    x,y:integer;
    XXX:Chaine;
    Info:LineSettingsType;
Begin
GetLineSettings(Info);
SetLineStyle(0,0,0);
Entete('Exemple du caractŠre A (<ESC> pour quitter)');
case ch of
     'N' : SetTextStyle(0,0,Taille);
     'T' : SetTextStyle(1,0,Taille);
     'G' : SetTextStyle(4,0,Taille);
     'P' : SetTextStyle(2,0,Taille);
     'B' : SetTextStyle(3,0,Taille);
     end;
Zone(0,16,TextWidth(' Aa ')+2,TextHeight(' Aa ')+15,p3);
Setcolor(GetMaxColor);
SetFillStyle(1,0);
Bar(1,16,TextWidth(' Aa ')+1,TextHeight(' Aa ')+26+5);
Rectangle(1,16,TextWidth(' Aa ')+1,TextHeight(' Aa ')+26+5);
OutTextXY(1,20,' Aa ');
ch:=readkey;
FermeZone(0,16,TextWidth(' Aa '),TextHeight(' Aa ')+15,0,p3);
if ch=chr(27) then Exit;
Montre_Souris;
SetTextJustify(0,0);
repeat
If Bouton_Gauche then
                 Begin
                 Cache_souris;
                 Setcolor(Couleur);
                 x:=xSouris;y:=ysouris;
                 repeat
                 ch:=readkey;
                 if ch<>chr(13) then OutTextXY(x,y,ch);
                 x:=x+TextWidth(ch);
                 until ch=chr(13);
                 montre_souris;
                 end;
until Bouton_droit;
SetTextJustify(0,2);
SetLineStyle(Info.LineStyle,Info.Pattern,Info.ThickNess);
Cache_souris;
end;

Procedure EE;
begin
Entete('Choix du Texte');
ch:=' ';
ChoixDansmenu('Normal,Triplex,Gothique,Petit,Bƒton,<ESC>',['N','T','G','P','B',#27],
              'NTGPB'+chr(27),12,17,ch);
if ch<>chr(27) then Ecrit;
Ch:=' ';
end;

Procedure PP;
Var BordS:chaine;
    Bord:integer;
    erreur:integer;
    x,y:integer;
begin
Entete('Style :');
ChoixDansMenu('couleur Unie,trame Horizontale,trame Droite(/),trame droite Epaisse,trame gauche ‚Paisse,'+
              'trame Gauche,Trame,trame Oblique,trame Serr‚e,points espAc‚s,'+
              'points Rapproch‚s',['U','H','D','E','P','G','T','O','S','A','R'],'UHDEPGTOSAR',
              12,17,ch);
Entete('Remplir jusqu''… la couleur :');
Moveto(240,4);
LitChaineMin(BordS,1,2,['0'..'9'],sortie);
if sortie then Exit;
repeat
bord:=-1;
Montre_souris;
Case ch Of
        'U' : SetFillStyle(1,Couleur);
        'H' : SetFillStyle(2,Couleur);
        'D' : SetFillStyle(3,Couleur);
        'E' : SetfillStyle(4,Couleur);
        'P' : SetFillStyle(5,Couleur);
        'G' : SetFillStyle(6,Couleur);
        'T' : SetFillStyle(7,Couleur);
        'O' : SetfillStyle(8,Couleur);
        'S' : SetFillStyle(9,Couleur);
        'A' : SetFillStyle(10,Couleur);
        'R' : SetFillStyle(11,Couleur);
        end;
If Bouton_gauche then
                 begin
                 Cache_souris;
                 x:=Xsouris;Y:=Ysouris;
                 Val(bords,bord,erreur);
                 FloodFill(x,y,bord);
                 end;
Until bord<>-1;
end;

Procedure Pinceau;
Begin
Entete('Pinceaux');
ch:=' ';
ChoixDansMenu('Trait,Cercle,Rectangle,tExte,crAyon,Peinture,<ESC>',
              ['T','C','R','E','A','P',#27],'TCREAP'+chr(27),12,17,ch);
Case ch of
        'T' : TT;
        'R' : TR;
        'C' : TC;
        'A' : TA;
        'E' : EE;
        'P' : PP;
     end;
ch:=' ';
SetTextStyle(0,0,0);
End;

Procedure Couleurs;
var i:integer;
begin
Entete('Choix de la couleur');
ch:=' ';
ChoixDansMenu('0,1,2,3,4,5,6,7,9,10,11,12,13,14,15',
             ['0','1','2','3','4','5','6','7','9','A','B','Z','D','E','F'],
             '012345679ABCDEF',12,17,ch);
Val(ch,couleur,i);
if ch='A' then couleur:=10;
if ch='B' then couleur:=11;
if ch='C' then couleur:=12;
if ch='D' then couleur:=13;
if ch='E' then couleur:=14;
if ch='F' then couleur:=15;
Setcolor(couleur);
ch:=' ';
end;

Procedure CTaille;
var i:integer;
begin
Entete('Choix de la taille du Texte');
ch:=' ';
ChoixDansMenu('0,1,2,3,4,5,6,7,8,9',['0','1','2','3','4','5','6','7','8','9'],
              '0123456789',12,17,ch);
Val(ch,Taille,i);
ch:=' ';
end;

Procedure StyleT;
Var S,E:integer;
    Info:LineSettingsType;
Begin
Entete('Choix du style de tra‡age des Lignes');
ch:=' ';
ChoixDansMenu('Trait plein,trait Pointill‚,trait Mixte,trait tIret‚,epaisseur Normale,'+
              'epaisseur tRiple',['T','P','M','I','N','R'],'TPMINR',12,17,ch);
GetLineSettings(Info);
S:=Info.LineStyle;
E:=Info.ThickNess;
Case ch of
        'T' : S:=0;
        'P' : S:=1;
        'M' : s:=2;
        'I' : s:=3;
        'N' : e:=1;
        'R' : e:=3;
        end;
SetLineStyle(S,$0000,E);
end;

{*********************************************************}

Procedure SaveImage;
Var Fen:Pointer;
    NomFich:chaine;
    DirInfo:SearchRec;
    w,s:word;
    f:file of Char;
    ch2:char;
Begin
Repeat
Entete('Nom du fichier :');
Moveto(140,3);
LitChainemin(Nomfich,1,60,['0'..'9','A'..'Z',':','\','.',' '],sortie);
if sortie then exit;
if nomFich='' then Exit;
if pos('.',Nomfich)=0 then NomFich:=Nomfich+'.TDR';
FindFirst(Nomfich,Archive,DirInfo);
sortie:=True;
If DosError<>18 then Sortie:=False;
If DosError=0 then Begin assign(f,nomfich);Sortie:=true;Erase(f); end;
SetFillStyle(1,0);Bar(0,0,Getmaxx,15);
until sortie;
w:=0;
s:=0;
Assign(f,NomFich);
{$i-} Rewrite(f); {$i+}
if IOResult<>0 then Entete('Erreur lors de la cr‚ation du fichier...');
If IOResult<>0 then Exit;
Repeat
Repeat
Case GetPixel(w,s) of
                   0  : begin ch2:='0';write(f,ch2); end;
                   1  : begin ch2:='1';write(f,ch2); end;
                   2  : begin ch2:='2';write(f,ch2); end;
                   3  : begin ch2:='3';write(f,ch2); end;
                   4  : begin ch2:='4';write(f,ch2); end;
                   5  : begin ch2:='5';write(f,ch2); end;
                   6  : begin ch2:='6';write(f,ch2); end;
                   7  : begin ch2:='7';write(f,ch2); end;
                   8  : begin ch2:='8';write(f,ch2); end;
                   9  : begin ch2:='9';write(f,ch2); end;
                   10 : begin ch2:='A';write(f,ch2); end;
                   11 : begin ch2:='B';write(f,ch2); end;
                   12 : begin ch2:='C';write(f,ch2); end;
                   13 : begin ch2:='D';write(f,ch2); end;
                   14 : begin ch2:='E';write(f,ch2); end;
                   15 : begin ch2:='F';write(f,ch2); end;
                   end;
w:=w+1;
Until w=GetMaxX;
s:=s+1;
w:=0;
Until s=GetMaxY;
Ch2:='Z';
Write(f,ch2);
Close(f);
Entete('Fichier '+NomFich+' sauvegard‚');
ch:=readkey;
End;

Procedure LoadImage;
Var Fen:Pointer;
    NomFich:Chaine;
    DirInfo:SearchRec;
    w,s:word;
    f:File of Char;
    Buf:Array[0..60000] of char;
    ch2:char;
    PL:Longint;
Begin
Repeat
Entete('Nom du fichier :');
Moveto(140,3);
LitChainemin(Nomfich,1,60,['0'..'9','A'..'Z',':','\','.',' '],sortie);
if sortie then Exit;
if pos('.',Nomfich)=0 then NomFich:=Nomfich+'.TDR';
FindFirst(Nomfich,Archive,DirInfo);
sortie:=True;
If DosError<>0 then Sortie:=False;
SetFillStyle(1,0);Bar(0,0,GetMaxX,15);
until sortie;
w:=0;
s:=0;
Assign(f,NomFich);
{$i-} ReSet(f); {$i+}
if IOResult<>0 then Entete('Erreur lors de l''ouverture du fichier...');
If IOResult<>0 then Exit;
PL:=0;
Repeat
Read(f,Buf[PL]);
PL:=PL+1;
Until PL=60001;
PL:=0;
Repeat
repeat
if PL=60001 then
            Begin
            PL:=0;
            Repeat
            Read(f,Buf[PL]);
            if Buf[PL]='Z' then PL:=60001;
            PL:=PL+1;
            Until PL>=60001;
            PL:=0;
            end;
Case Buf[PL] of
         '1' : PutPixel(w,s,1);
         '2' : PutPixel(w,s,2);
         '3' : PutPixel(w,s,3);
         '4' : PutPixel(w,s,4);
         '5' : PutPixel(w,s,5);
         '6' : PutPixel(w,s,6);
         '7' : PutPixel(w,s,7);
         '8' : PutPixel(w,s,8);
         '9' : PutPixel(w,s,9);
         'A' : PutPixel(w,s,10);
         'B' : PutPixel(w,s,11);
         'C' : PutPixel(w,s,12);
         'D' : PutPixel(w,s,13);
         'E' : PutPixel(w,s,14);
         'F' : PutPixel(w,s,15);
         end;
w:=w+1;
PL:=PL+1;
until (w=getmaxX) or (BUF[PL]='Z');
s:=s+1;
w:=0;
Until (s=GetMaxY) or (Buf[PL]='Z');
Entete('Fichier '+NomFich+' charg‚');
ch:=readkey;
Close(f);
End;

{***************************************************************************}

Procedure Fichier;
Begin
Entete('Fichier');
ch:=' ';
ChoixDansMenu('Nouveau,Charger,Sauver,Quitter,<ESC>',
              ['N','C','S','Q',#27],'NCSQ'+chr(27),12,17,ch);
Case ch of
        'Q' : begin if Quitter then begin closegraph;Halt; end; Cache_souris; end;
        'N' : ConfirmNouveau;
        'S' : SaveImage;
        'C' : LoadImage;
     end;
ch:=' ';
SetTextStyle(0,0,0);
End;

Procedure affichemenu;
begin
Cache_souris;
SetFillstyle(1,0);
Bar(0,0,GetMaxX,15);
repeat
Entete('Fichier Pinceaux Couleurs Style Taille');
MenuAffiche:=true;
ChoixDansMenuH(['F','P','C','S','T',#27],'FPCST'+chr(27),1,1,ch);
Case Ch of
          'F' : Fichier;
          'P' : Pinceau;
          'C' : Couleurs;
          'T' : CTaille;
          'S' : StyleT;
          end;
until ch=chr(27);
SetFillStyle(1,0);
Bar(0,0,GetMaxX,15);
Vide_Buffer;
Montre_souris;
end;

Procedure PrepareEcran;
Begin
Cleardevice;
{SetFillStyle(1,GetMaxColor);
Floodfill(1,1,GetMaxColor);
}End;

Procedure GereProg;
Begin
repeat
If ((PressBouton=4) or (PressBouton=3)) and (not(menuAffiche)) then AfficheMenu;
if MenuAffiche then Vide_buffer;
If menuaffiche then menuaffiche:=false;
if keypressed then ch:=readkey;
until (PressBouton=7) or (ch=chr(27));
if p=nil then begin
              sound(2500);delay(200);Nosound;delay(50);Sound(100);Delay(200);Nosound;
              end;
end;

Procedure TestMode;
Var Inf,Sup:integer;
    i:byte;
    n:string;
    nbColor:string;
    Color,nb:integer;
begin
InitGraphic(-1);
GetModeRange(GrPilote,Inf,Sup);
Sound(2000);delay(500);Nosound;
i:=inf;
repeat
str(i,n);
str(Color,nbColor);
OuttextXY(5,i*15,'['+n+'] : '+GetModeName(i));
i:=i+1;
until i=sup+1;
repeat
repeat
ch:=readkey;
Val(ch,nb,erreur);
if erreur<>0 then Begin
                  Sound(200);Delay(200);Nosound;
                  end;
until erreur=0;
if (nb<inf) or (nb>sup) then
                        Begin
                        Sound(200);Delay(200);Nosound;
                        end;
until (nb>=Inf) and (nb<=Sup);
GrMode:=nb;
end;

Function TestPilote : Boolean;
Var codeErreur : Integer;
    fichier : text;
    Pilote : String;
    Ch:Char;
Begin
Clrscr;
 {$I-}
   Assign(fichier,'GR.CST');
   Reset(Fichier);
   readln(fichier,grpilote);
   close(fichier);
   CodeErreur:=IOResult;
 {$I+}
If CodeErreur<> 0 then
                  Begin
                  CloseGraph;Writeln('Fichier GR.CST non trouv‚ ou d‚fectueux');
                  Halt(1);
                  End;
If GrPilote=0 then GrPilote:=CGA;
Case GrPilote of
     1  : Pilote:='CGA';
     2  : Pilote:='MCGA';
     3  : Pilote:='EGA';
     4  : Pilote:='EGA64';
     5  : Pilote:='EGAMono';
     6  : Pilote:='IBM8514';
     7  : Pilote:='HercMono';
     8  : Pilote:='ATT400';
     9  : Pilote:='VGA';
     10 : Pilote:='PC3270';
  End;
Writeln('Le pilote graphique contenu dans le fichier GR.CST est : '+Pilote+'.');
Writeln('V‚rifiez que votre ordinateur peut supporter ce pilote.');
Writeln('Sinon, quittez TheDraw et modifiez le fichier GR.CST.');
Write('Voulez-vous continuez ?');
Ch:=Readkey;
Ch:=Upcase(ch);
TestPilote:=(ch='O');
end;

Procedure Verify_police_present;
Var DirInfo:SearchRec;
    NbPoliceF:Byte;
begin
NbPoliceF:=0;
FindFirst('*.CHR',Archive,DirInfo);
While DosError = 0 Do
      Begin
      if DirInfo.Name = 'TRIP.CHR' then NbPoliceF:=NbPoliCeF+1;
      if DirInfo.Name = 'GOTH.CHR' then NbPoliceF:=NbPoliCeF+1;
      if DirInfo.Name = 'SANS.CHR' then NbPoliceF:=NbPoliCeF+1;
      if DirInfo.Name = 'LITT.CHR' then NbPoliceF:=NbPoliCeF+1;
      FindNext(DirInfo);
      end;
If NbPoliceF<4 then
               Begin
               Clrscr;
               if NbPoliceF<3 then Writeln('Attention polices introuv‚es !')
                              else Writeln('Attention police introuv‚e !');
               Writeln('V‚rifiez si les polices GOTH.CHR, TRIP.CHR, LITT.CHR et SANS.CHR sont');
               Writeln('pr‚sentes...');
               ch:=readkey;
               Clrscr;
               Halt;
               end;
end;

Begin
if not(Souris_active) then
                      Begin
                      Writeln('Ce logiciel demande l''utilisation de la souris.');
                      Writeln('Le systŠme n''en d‚tecte pas.');
                      Writeln('Arrˆt du programme...');
                      Halt;
                      end;
Souris_est_la:=souris_active;
Verify_Police_present;
if not(TestPilote) then Halt else begin sound(200);delay(100);nosound end;
TestMode;
InitGraphic(GrMode);
SetTextStyle(0,0,0);
SetTextJustify(0,2);
Setcolor(GetmaxColor);
PrepareEcran;
MenuAffiche:=false;
Taille:=0;
Souris_est_la:=souris_active;
Repeat
Montre_Souris;
GereProg;
Cache_souris;
until Quitter;
CloseGraph;
Halt;
End.