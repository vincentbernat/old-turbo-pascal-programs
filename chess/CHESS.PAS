{$M 51200,0,655360}
Uses Crt,Dos,Graph,Menus,litclavier;

Const Roi      = 1;
      Dame     = 2;
      Tour     = 3;
      Fou      = 4;
      Cavalier = 5;
      Pion     = 6;
      Noir     = 0;
      Blanc    = 11;

Type Coordonnees = Record
                   X,Y:byte;
                   End;

Var ch,ch2,ch3       : Char;
    Entet            : boolean;
    Fen1             : pointer;
    larg,long        : integer;
    temp,pourC       : real;
    pourCent,reste   : string;
    i                : integer;
    piec1,NB         : byte;
    Ligne            : byte;
    caseEch          : Array[1..8,1..8] of byte;
    caseOcc          : Array[1..8,1..8] of boolean;
    erreur,rien      : boolean;
    NbPiece          : byte;
    NbPB,NbPN        : byte;
    PDern            : boolean;
    PB,PN            : byte;
    FB,FN,DB,DN,CB,
    CN,TN,TB         : byte;
    RN,RB            : byte;

Procedure Zone(x,y,long,larg : integer;Var p:pointer);
Begin
    GetMem(P,ImageSize(x,y,x+long,y+larg));
    GetImage(x,y,x+long,y+larg,P^);
End;

Procedure Entete(Texte:String;eff:boolean);
Begin
if eff then begin
            SetColor(0);
            SetFillstyle(1,0);
            Bar(0,0,GetMaxX,17);
            end;
SetColor(1);
if eff then outtextXY(6,6,Texte) else outtextXY(5,5,texte);
Rectangle(0,0,GetMaxX,17);
End;

Function CaseCoul(i,j:integer) : byte;
var m:integer;
begin
m:=i+j;
if (m MOD 2=0) then CaseCoul:=1 else CaseCoul:=0;
end;

Procedure Ecris(Texte:string;var error:boolean);
begin
setcolor(1);
ligne:=ligne+1;
error:=true;
if ligne=24 then
            begin
            sound(780);Delay(200);Nosound;delay(175);sound(1500);delay(175);Nosound;
            SetViewport(330,20,638,198,ClipOn);
            ch:=readkey;
            Clearviewport;
            setcolor(1);
            SelectFenetreTotale;
            Rectangle(330,20,638,198);
            ligne:=3;
            end;
outtextXY(340,8*ligne,texte);
end;

Function Securit : boolean;
begin
Entete('Etes-vous s–r ?',true);
ChoixDansMenu('Oui  ,Non',['O','N'],'ON',60,25,ch);
Securit:=(ch='O');
end;

Procedure Init;
Var i1,i2:integer;
Begin
Cleardevice;
i1:=0;
repeat
i2:=0;
i1:=i1+1;
repeat
i2:=i2+1;
caseOcc[i2,i1]:=false;
CaseEch[i2,i1]:=0;
until i2=8;
until i1=8;
Rectangle(0,20,320,198);
Rectangle(330,20,638,198);
i1:=5;
i2:=-30;
Entet:=True;
Ligne:=3;
repeat
i2:=i2+35;
i1:=i1+20;
Line(5,i1,285,i1);
Line(i2,25,i2,184);
until i1=185;
larg:=130;
long:=320;
i1:=9;
i2:=-56;
repeat
SetFillstyle(3,1);
i1:=i1+20;
i2:=-56;
repeat
i2:=i2+70;
Floodfill(i2+3,i1+3,1);
until i2>=224;
i1:=i1+20;
i2:=-21;
repeat
i2:=i2+70;
Floodfill(i2+3,i1+3,1);
until i2>=224;
until i1>=150;
SetColor(1);
Rectangle(5,25,285,185);
Rectangle(4,24,286,186);
OutTextXY(290,30,'1');OutTextXY(290,50,'2');OutTextXY(290,70,'3');
OutTextXY(290,90,'4');OutTextXY(290,110,'5');OutTextXY(290,130,'6');
OutTextXY(290,150,'7');OutTextXY(290,170,'8');
OutTextXY(25,189,'A   B   C   D    E   F   G   H');
{Fenetre de Presentation}
Fenetre(160,50,' ,   TOPIQUES Editions,  ,'+
                  ' , ,V‚rificateur d''‚chiquier,'+
                ' , , ,                 (c) 1991,  ,'+
                      '                V. Bernat',long,larg,Fen1);
end;

Procedure AffichePiece(Piece:Byte;Entour:Boolean;X,Y:integer);
Begin
If Piece=1 then begin outtextXY(x+15,y+8,'R');outtextXY(x+16,y+9,'R'); end;
If Piece=2 then begin outtextXY(x+15,y+8,'D');outtextXY(x+16,y+9,'D'); end;
If Piece=3 then begin outtextXY(x+15,y+8,'T');outtextXY(x+16,y+9,'T'); end;
If Piece=4 then begin outtextXY(x+15,y+8,'F');outtextXY(x+16,y+9,'F'); end;
If Piece=5 then begin outtextXY(x+15,y+8,'C');outtextXY(x+16,y+9,'C'); end;
If Piece=6 then begin outtextXY(x+15,y+8,'P');outtextXY(x+16,y+9,'P'); end;
if entour then begin Rectangle(x+2,y+2,x+32,y+17);Rectangle(x+1,y+1,x+33,y+18); end;
End;

Procedure PlacePiece(VAR piece,NB:byte);
Var X,y:integer;
    w,z:integer;
    ws,zs,rep:string;
    erreur:integer;
    a,b:integer;
    sort:boolean;
begin
erreur:=0;
if souris_est_la then
                 BEGIN
                 Entete('Placez la piŠce...',true);
                 Montre_souris;
                 sort:=false;
                 repeat
                 repeat
                 X:=Xsouris;
                 Y:=Ysouris;
                 until (bouton_gauche) or (bouton_droit);
                 Cache_souris;
                 if (x>5) and (x<285) and (y>25) and (y<185) and (not(bouton_droit)) then sort:=true
                                          else if not(bouton_droit) then
                                                            begin
                                                            sound(780);
                                                            delay(400);
                                                            Nosound;
                                                            sort:=false;
                                                            Montre_souris;
                                                            end;
                 if bouton_droit then sort:=true;
                 until Sort;
                 if bouton_droit then erreur:=-1;
                 {recherche les coordonn‚es de la case sur l'‚chiquier}
                 w:=trunc(((x-5)/35)+1);
                 z:=trunc(((y-25)/20)+1);
                 END
               ELSE
                 BEGIN
                 Entete('Ecrivez les coordonn‚es de la piece … placer (lettre+chiffre) : ',true);
                 moveto(2+8*65,4);
                 litcar(ch,['A'..'H',#27]);
                 if ch=#27 then exit;
                 Outtext(ch);
                 ws:=ch;
                 Moveto(2+8*67,4);
                 litCar(ch,['1'..'8',#27]);
                 if ch=#27 then exit;
                 OutText(ch);
                 zs:=ch;
                 if ws='A' then w:=1;
                 if ws='B' then w:=2;
                 if ws='C' then w:=3;
                 if ws='D' then w:=4;
                 if ws='E' then w:=5;
                 if ws='F' then w:=6;
                 if ws='G' then w:=7;
                 if ws='H' then w:=8;
                 val(zs,z,erreur);
                 if erreur<>0 then Entete('Erreur !!!',false);
                 END;
if erreur<>0 then exit;
if caseOcc[w,z] then begin sound(780);delay(300);Nosound;Exit; end;
CaseOcc[w,z]:=true;
CaseEch[w,z]:=NB+piec1;
{recherche les coordonn‚es du coin sup‚rieur gauche de la case en graphique}
a:=((w-1)*35)+5;
b:=((z)*20)+5;
if NB=0 then affichePiece(piec1,false,a,b);
if NB=11 then affichePiece(piec1,true,a,b);
end;

Procedure ajoutPiece;
Var sortie:boolean;
begin
repeat
Entete('Choisisez la piece...',true);
ChoixDansMenu('Roi,Dame,Tour,Fou,Cavalier,Pion,<ESC>',['R','D','T','F','C','P',#27],
               'RDTFCP'+chr(27),60,25,ch);
sortie:=(ch=chr(27));
if not(sortie) then
               Begin
               ChoixDansMenu('Blanc,Noir,<ESC>',['B','N',#27],'BN'+chr(27),60,25,ch2);
               case ch of
                    'R' : begin piec1:=1;if ch2='N' then NB:=0 else NB:=11; end;
                    'D' : begin piec1:=2;if ch2='N' then NB:=0 else NB:=11; end;
                    'T' : begin piec1:=3;if ch2='N' then NB:=0 else NB:=11; end;
                    'F' : begin piec1:=4;if ch2='N' then NB:=0 else NB:=11; end;
                    'C' : begin piec1:=5;if ch2='N' then NB:=0 else NB:=11; end;
                    'P' : begin piec1:=6;if ch2='N' then NB:=0 else NB:=11; end;
                    end;
               if not(ch2=#27) then PlacePiece(piec1,NB) else sortie:=true;
               end;
until sortie;
end;

procedure sousPiece;
Var X,Y:integer;
    w,z:integer;
    ws,zs:string;
    rep:string;
    erreur:integer;
    a,b:integer;
    sort,CaVa:boolean;
Begin
erreur:=0;
if souris_est_la then
                 BEGIN
                 Entete('Pointez la piŠce … enlever...',true);
                 montre_souris;
                 sort:=false;
                 repeat
                 repeat
                 X:=Xsouris;
                 Y:=Ysouris;
                 until (bouton_gauche) or (bouton_droit);
                 Cache_souris;
                 if (x>5) and (x<285) and (y>25) and (y<185) and (not(bouton_droit)) then sort:=true
                                      else if not(bouton_droit) then
                                                           begin
                                                           sound(780);
                                                           delay(400);
                                                           NoSound;
                                                           sort:=false;
                                                           end;
                 if bouton_droit then sort:=true;
                 until Sort;
                 if bouton_droit then erreur:=-1;
                 {recherche les coordonn‚es de la case sur l'‚chiquier}
                 w:=trunc(((x-5)/35)+1);
                 z:=trunc(((y-25)/20)+1);
                 END
              ELSE
                 BEGIN
                 Entete('Ecrivez les coordonn‚es de la piece … enlever (lettre+chiffre) : ',true);
                 moveto(2+8*65,4);
                 litcar(ch,['A'..'H',#27]);
                 if ch=#27 then exit;
                 Outtext(ch);
                 ws:=ch;
                 Moveto(2+8*67,4);
                 litCar(ch,['1'..'8',#27]);
                 if ch=#27 then exit;
                 OutText(ch);
                 zs:=ch;
                 if ws='A' then w:=1;
                 if ws='B' then w:=2;
                 if ws='C' then w:=3;
                 if ws='D' then w:=4;
                 if ws='E' then w:=5;
                 if ws='F' then w:=6;
                 if ws='G' then w:=7;
                 if ws='H' then w:=8;
                 val(zs,z,erreur);
                 if erreur<>0 then Entete('Erreur !!!',false);
                 END;
if (erreur<>0) then EXIT;
CaseOcc[w,z]:=false;
CaseEch[w,z]:=0;
{recherche les coordonn‚es du coin sup‚rieur gauche de la case en graphique}
a:=((w-1)*35)+5;
b:=((z)*20)+5;
if CaseCoul(w,z)=0 then SetFillStyle(1,0) else setfillstyle(3,1);
Bar(a,b,a+35,b+20);
setcolor(1);
Rectangle(a,b,a+35,b+20);
end;

Procedure Setup;
Var Sortie:Boolean;
    Sec:boolean;
Begin
repeat
Entete('SETUP',true);
ChoixDansMenu('Placer une piece,Enlever une piece,Nouveau,<ESC>',
              ['P','E','N',#27],'PEN'+chr(27),60,25,ch);
sortie:=(ch=#27);
  Case ch of
       'P' : ajoutPiece;
       'E' : sousPiece;
       'N' : begin sec:=securit;if not(sec) then exit;init;sortie:=true end;
       End;
until sortie;
end;

procedure Verify(VAR error:boolean);
Var i1,i2:integer;
begin
NbPiece:=0;PDern:=false;
RN:=0;NbPB:=0;PN:=0;
PB:=0;FB:=0;FN:=0;DB:=0;
DN:=0;CN:=0;CB:=0;TN:=0;
RB:=0;NbPN:=0;TB:=0;
error:=false;
i1:=0;
repeat
i2:=0;
i1:=i1+1;
repeat
i2:=i2+1;
if caseOcc[i2,i1] then NbPiece:=NbPiece+1;
if caseEch[i2,i1]=1 then RN:=RN+1;
if caseEch[i2,i1]=12 then RB:=RB+1;
if caseEch[i2,i1]>=12 then NbPB:=NbPB+1;
if (caseEch[i2,i1]<12) and (caseEch[i2,i1]<>0) then NbPN:=NbPN+1;
if (caseEch[i2,i1]=2) and (DN=0) then DN:=1 else if caseEch[i2,i1]=2 then PN:=PN+1;
if (caseEch[i2,i1]=13) and (DB=0) then DB:=1 else if caseEch[i2,i1]=13 then PB:=PB+1;
if (caseEch[i2,i1]=15) and (FB<2) then FB:=FB+1 else if caseEch[i2,i1]=15 then PB:=PB+1;
if (caseEch[i2,i1]=4) and (FN<2) then FN:=FN+1 else if caseEch[i2,i1]=4 then PN:=PN+1;
if (caseEch[i2,i1]=16) and (CB<2) then CB:=CB+1 else if caseEch[i2,i1]=16 then PB:=PB+1;
if (caseEch[i2,i1]=5) and (CN<2) then CN:=CN+1 else if caseEch[i2,i1]=5 then PN:=PN+1;
if (caseEch[i2,i1]=14) and (TB<2) then TB:=TB+1 else if caseEch[i2,i1]=14 then PB:=PB+1;
if (caseEch[i2,i1]=3) and (TN<2) then TN:=TN+1 else if caseEch[i2,i1]=3 then PN:=PN+1;
if caseEch[i2,i1]=6 then PN:=PN+1;
if caseEch[i2,i1]=17 then PB:=PB+1;
if ((i1=1) or (i1=8)) and ((caseEch[i2,I1]=6) or (caseEch[i2,i1]=17)) then Pdern:=true;
until i2=8;
until i1=8;
if NbPiece>32 then Ecris('L''‚chiquier comporte trop de pieces.',error);
if NbPiece<2 then Ecris('L''‚chiquier n''a pas assez de pieces.',error);
if (NbPiece=2) and (RB=1) and (RN=1) then Ecris('La partie est interminable...',error);
if RB=0 then Ecris('Il manque le roi blanc.',error);
if RN=0 then Ecris('Il manque le roi noir.',error);
if RB>1 then Ecris('Il y a trop de rois blancs.',error);
if RN>1 then Ecris('Il y a trop de rois noirs.',error);
if NbPN>16 then Ecris('Il y a trop de piŠces noires.',error);
if NbPB>16 then Ecris('Il y a trop de piŠces blanches.',error);
if PB>8 then Ecris('Il y a trop de pions blancs.',error);
if PN>8 then Ecris('Il y a trop de pions noirs.',error);
if Pdern then begin Ecris('Les pions ne doivent pas se trouver...',error);
                    Ecris('sur la premiŠre ou derniŠre ligne...',rien);
                    Ecris('de l''‚chiquier.',rien); end;
if not(error) then Ecris('Verification complŠte et sans erreur.',rien);
Ecris('-------------------------------------',rien)
end;

procedure resolu;
Var sortie:boolean;
begin
sortie:=false;
entete('RESOLUTION',true);
ChoixDansMenu('Verification de l''‚chiquier         ,<ESC>',
               ['V',#27],'V'+chr(27),60,25,ch3);
sortie:=false;
sortie:=(ch3=#27);
if not(sortie) then Verify(erreur);
end;

Begin
NoSound;
temp:=memavail;
SetTextStyle(0,0,0);
i:=0;
Cleardevice;
Souris_est_la:=Souris_active;
Init;
repeat
erreur:=false;
pourC:=(Memavail/Temp)*100;
str(PourC:6:2,PourCent);
str(MemAvail:6,Reste);
Entete('Setup Resolution Quitter              '+reste+'           '+PourCent+' %',true);
Entete('S     R ',false);
ChoixDansMenuH(['S','R','Q',#173],'SRQ'+#173,2,2,ch);
if entet then begin entet:=false;Ferme_fenetre(160,50,long,larg,Fen1); end;
if ((ch=#173) or (ch='Q')) and (securit) then Begin
               SetColor(0);
               i:=0;
               repeat
               rectangle(0+i,0+i,640-i,200-i);
               i:=i+1;
               until i=101;
               CloseGraph;
               RestoreCrtMode;
               Halt;
               End;
If ch='S' then Setup;
If Ch='R' then Resolu;
until false;
End.
