unit menus;
interface
  uses
    crt,dos,graph,aspectCt,litclavier;

const ligne1=20;

type forme=array[0..15] of word;
var souris_est_la,souris_cachee,sortie:boolean;
    forme_curseur,masque:pointer;
    XSCreenMaxglb,XMaxGlb,YMaxGlb:word;
    maxXCurseur,minXCurseur,maxYCurseur,minYCurseur:integer;
    preserve:pointer; {sur la zone m‚moire de pr‚servation de l'image
                      recouverte par le curseur }
    pmask1,pcurseur1,pmask2,pcurseur2,pmask3,pcurseur3,pmask4,pcurseur4,
    pmask5,pcurseur5:pointer;

const {doigt}

      mask1:forme=($0FFC,$0FFE,$0FFF,$0FFF,$1FFF,$1FFF,$1FFF,$1FFF,$1FFF,$1FFF,$0FFF,
                   $01FF,$000F,$000F,$000F,$0006);
      curseur1:forme=($07F8,$07FC,$07FE,$07FE,$0006,$0DBE,$0DBE,$0D80,$0DB6,$0DB6,$0056,
                     $0006,$0006,$0006,$0006,$0000);

      mask2:forme=($0000,$0380,$0FE0,$3FE0,$3FE0,$3FE0,$3FF8,$3FF8,
                  $3FF8,$3FF8,$3FF8,$3FF8,$3FF8,$03C0,$03C0,$0000);
     curseur2:forme=($0000,$0000,$0100,$0540,$1540,$1540,$1540,$1FD0,
                    $1FF0,$1FF0,$1FF0,$1FF0,$0180,$0180,$0180,$0000);
      {fleche}

     mask3:forme=($0800,$1C00,$3E00,$7F00,$FF80,$7FC1,$3FE3,$1FF7,$0FFF,$07FF,$03FF,
                   $01FF,$00FF,$01FF,$03FF,$07FF);
      curseur3:forme=($0000,$0800,$1C00,$3E00,$7F00,$3F80,$1FC0,$0FE2,$07F6,$03FE,$01FE,
                     $00FE,$007E,$00FE,$01FE,$0000);
      {COIN SUP}

     mask4:forme=($FFFF,$FFFF,$FFFF,$FFFF,$F000,$F000,$F000,$F000,$F000,$F000,$F000,
                   $F000,$F000,$F000,$F000,$F000);
      curseur4:forme=($0000,$7FFE,$7FFE,$6000,$6000,$6000,$6000,$6000,$6000,$6000,$6000,
                     $6000,$6000,$6000,$6000,$0000);
     {COIN INF}
     mask5:forme=($000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,$000F,
                   $000F,$FFFF,$FFFF,$FFFF,$FFFF);
      curseur5:forme=($0000,$0006,$0006,$0006,$0006,$0006,$0006,$0006,$0006,$0006,$0006,
                     $0006,$0006,$7FFE,$7FFE,$0000);

procedure initgraphic(mode:integer);
procedure inverseWindow(x1,y1,x2,y2:word);
procedure vide_buffer;
procedure selectfenetreTotale;
procedure fenetre(x,y:integer;Texte:string;largeur,hauteur:integer;var p:pointer);
procedure ferme_fenetre(x,y,largeur,hauteur:integer;p:pointer);
procedure souris(no_fonc:integer;var ax,bx,cx,dx:integer);
function bouton_droit:boolean;
function bouton_gauche:boolean;
function souris_active:boolean;
function XSouris:word;
function YSouris:word;
procedure amplitude_X(minX,maxX:word);
procedure amplitude_Y(minY,maxY:word);
procedure cache_souris;
procedure montre_souris;
procedure deplace_curseur(souris_est_la:boolean;ensvalid:enscar;var x,y:integer;var ch:char);
procedure depcurseur(souris_est_la:boolean;ensvalid:enscar;var x,y:integer;var ch:char);
procedure met_souris(x,y:word);
procedure choixDansMenu(texte:string;ensvalid:enscar;item:string;x,y:integer; var reponse:char);
procedure choixDansMenuH(ensvalid:enscar;item:string;x,y:integer; var reponse:char);
procedure afficheDir(chemin,suffixe:string);
procedure restaure(x,y:integer);
procedure affiche_curseur(x,y:integer);


implementation
procedure selectfenetretotale;
begin
     setviewport(0,0,getmaxX,getmaxY,true);
end;


procedure affiche_curseur;
begin
  if ((x<0) or (x>XScreenMaxGlb-17) or (y<0) or (y>YMaxGlb-17)) then EXIT;

    getimage(x,y,x+15,y+15,preserve^);
    putimage(x,y,masque^,OrPut);
    putimage(x,y,forme_curseur^,XOrPut);

end;

procedure restaure;
var i:integer;
    ad:word;
begin
   if ((x<0) or (x>XScreenMaxGlb-17) or (y<0) or (y>YMaxGlb-17)) then EXIT;
   putimage(x,y,preserve^,0)
end;


procedure fenetre;
var i,j,n,l:integer;
   tableChoix : array[1..15] of string[80];
begin
  j:=1;
  n:=1;
{  largeur:=0;hauteur:=0;
  repeat
      tableChoix[j]:='';
      hauteur:=hauteur+10;l:=0;
      repeat
       tableChoix[j]:=tableChoix[j]+texte[n];
       n:=n+1;l:=l+8;
     until (texte[n]=',') or (n>length(texte));
     if l>largeur then largeur:=l;
      j:=j+1;n:=n+1;
   until n>length(texte);
 }
  getmem(p,imagesize(x,y,x+largeur,y+hauteur));
  getimage(x,y,x+largeur,y+hauteur,p^);
 { setviewport(x,y,x+largeur,y+hauteur,false);
  clearviewport;
  rectangle(0,0,largeur,hauteur);}
  i:=0;
  {repeat
    outTextXY(4,i*10,tableChoix[i+1]);
    i:=i+1;
  until i=(hauteur div 10);
  setviewport(0,0,getmaxX,getmaxY,true);}
end;

procedure ferme_fenetre;
begin
  putimage(x,y,p^,0);
{  freemem(p,imagesize(x,y,x+largeur,y+hauteur));}
dispose(p);
end;

procedure afficheDir;
var Srec:searchRec;
    posPoint,i,col,lig,maxlig,maxcol:integer;
    nom:string;
    ch:char;
begin
  maxlig:=(XScreenMaxglb+1) div 80;
  maxcol:=(YMaxGlb + 1) div 10 -2;
  setviewport(0,20,getmaxX,getmaxY,true);
  clearviewport;
  i:=0;
  findfirst(chemin+suffixe,AnyFile,Srec);
  while DosError=0 do
    begin
      nom:=Srec.name;
      posPoint:=pos('.',nom);
      delete(nom,posPoint,1+length(Nom)-posPoint);
      col:= (i mod maxlig)*80+1;lig:=(i div maxlig);
      lig:=(lig mod maxcol);
      outtextXY(col,lig*10,nom);
      i:=i+1;
      findNext(Srec);
    end;
  setviewport(0,0,getmaxX,getmaxY,true);
{  litcar(ch,[#27]);}
end;

procedure souris;
var r:registers;
begin
      r.ax:=no_fonc;
      r.bx:=bx;
      r.cx:=cx;
      r.dx:=dx;
      intr(51,r);
      ax:=r.ax;
      bx:=r.bx;
      cx:=r.cx;
      dx:=r.dx
end;

function bouton_droit;
var ax,bx,cx,dx:integer;
   val:boolean;
 begin
   souris(3,ax,bx,cx,dx);
   val:=((bx and 2)=2);
   bouton_droit:=val;
 end;

function bouton_gauche;
var ax,bx,cx,dx:integer;
   val:boolean;
 begin
   souris(3,ax,bx,cx,dx);
   val:=((bx and 1)=1);
   bouton_gauche:=val;
 end;

function souris_active;
var ax,bx,cx,dx:integer;
begin
   souris(0,ax,bx,cx,dx);
   souris_active:=(ax<>0)
end;

function XSouris;
var ax,bx,cx,dx:integer;
begin
   souris(3,ax,bx,cx,dx);
   XSouris:=cx
end;

function YSouris;
var ax,bx,cx,dx:integer;
begin
   souris(3,ax,bx,cx,dx);
   YSouris:=dx
end;

procedure amplitude_X;
var ax,bx,cx,dx:integer;
begin
    cx:=minX;
    dx:=maxX;
    souris(7,ax,bx,cx,dx);
end;

procedure amplitude_Y;
var ax,bx,cx,dx:integer;
begin
    cx:=minY;
    dx:=maxY;
    souris(8,ax,bx,cx,dx);
end;

procedure cache_souris;
var ax,bx,cx,dx:integer;
begin
   souris(2,ax,bx,cx,dx);
   souris_cachee:=true;
end;

procedure montre_souris;
var ax,bx,cx,dx:integer;
begin
   souris(1,ax,bx,cx,dx);
   souris_cachee:=false;
end;

procedure met_souris;
var ax,bx,cx,dx:integer;
begin
   cx:=x;dx:=y;
   souris(4,ax,bx,cx,dx);
end;

procedure vide_buffer;
var r:registers;
begin
  r.ax:=$0C0B;
  intr($21,r)
 end;

procedure depcurseur;
  {(souris:boolean;ensvalid:enscar;var x,y:integer;var ch:char);}
var  touche:char;
begin
    ch:=#0;
    if (not souris_est_la) then
       begin
         litcar(ch,[#203,#205,#200,#208,#13,#172]+ensvalid);
         case ch of
           #203:begin x:=x-4; if x<minXcurseur then x:=minXCurseur end;
           #205:begin x:=x+4;if x>maxXCurseur then x:=maxXCurseur end;
           #200:begin y:=y-4;if y<minYCurseur then y:=minYCurseur end;
           #208:begin y:=y+4;if y>maxYCurseur then y:=maxYCurseur end;
         end;
         {if  ((ch in [#203,#205,#200,#208]) and keypressed) then
            repeat litcar(touche,[#0..#255])
            until ((not keypressed) or (not (touche in [#203,#205,#200,#208])));
         if touche in ensvalid+[#13,#172] then ch:=touche;}
       end
                        else
       begin
            if keypressed then
                  begin
                     litcar(touche,[#0..#255]);
                     if touche in ensvalid+[#13,#172] then ch:=touche;
                  end;
            x:=Xsouris;Y:=Ysouris;
            if bouton_gauche then ch:=#13;
            if bouton_droit then ch:=#172;
        end;
end;

procedure deplace_curseur;
begin
     if (not souris_est_la) then vide_buffer;
     depcurseur(souris_est_la,ensvalid,x,y,ch);
end;

procedure inverseWindow(x1,y1,x2,y2:word);
var p:pointer;
    taille:word;
begin
  taille:=imagesize(x1,y1,x2,y2);
  getmem(p,taille);
  getimage(x1,y1,x2,y2,p^);
  putimage(x1,y1,p^,NotPut);
  freemem(p,taille);
end;

procedure choixDansMenu;
var ligne,ancLigne:integer;
    ch:char;
    sortons:boolean;
    ptr:pointer;
    largeur,hauteur:integer;
procedure inverse(ligne:integer);
  begin
{    defineTextWindow(9,x,y+ligne-1,x+largeur,y+ligne-1,0);
    selectwindow(9);}
    inverseWindow(x+3,y+ligne*10-6,x+largeur+4,y+ligne*10+2);
  end;
begin
   fenetre(x,y,texte,largeur,hauteur,ptr);
   if souris_est_la then begin
                          repeat until (not bouton_gauche);
                          amplitude_X(1,2);
                          amplitude_Y(10,hauteur);
                          met_souris(1,8)
                         end;
   ligne:=1;
   sortons:=false;
   inverse(ligne);
   while (not sortons) do
   begin
   ancLigne:=ligne;
   if keypressed then
       begin
         litcar(ch,[#0..#255]);
         if ch in ensvalid then
                    begin
                       reponse:=ch;
                       sortons:=true
                     end;
         if ch=#13 then begin reponse:=item[ligne];sortons:=true end;
         if ch=#200 then begin dec(ligne);if ligne<1 then ligne:=1 end;
         if ch=#208 then begin inc(ligne);if ligne>(hauteur div 10)
          then ligne:=(hauteur div 10) end;
       end;
    if souris_est_la then
        begin
          if bouton_gauche then begin reponse:=item[ligne];sortons:=true end;
          ligne:=(YSouris div 10)
        end;
    if ligne<> ancLIgne then
      begin
        inverse(ancLigne);
        inverse(ligne);
      end;
   end;
   if souris_est_la then begin
                          amplitude_X(minXCurseur,maxXCurseur);
                          amplitude_Y(minYCurseur,maxYCurseur);
                          repeat until (not bouton_gauche)
                         end;
   vide_buffer;
   ferme_fenetre(x,y,largeur,hauteur,ptr);
   selectFenetreTotale;
end;

procedure choixDansMenuH;
var ligne,ancLigne:integer;
    ch:char;
    sortons:boolean;
procedure inverse(ligne:integer);
var debut,fin:integer;
  begin
  if ligne<1 then ligne:=1;
  if ligne>6 then ligne:=6;
  case ligne of
  1:begin debut:=1;fin:=45 end;
  2:begin debut:=47;fin:=99 end;
  3:begin debut:=103;fin:=147 end;
  4:begin debut:=151;fin:=211 end;
  5:begin debut:=215;fin:=275 end;
  6:begin debut:=279;fin:=339;
          if XSCreenMaxGlb<330 then fin:=XSCreenMaxGlb end;
  end;
    inverseWindow(x+debut,y+2,x+fin,y+12);
  end;
begin
   if souris_est_la then begin
                          repeat until (not bouton_gauche);
                          amplitude_X(16,6*16+15);
                          amplitude_Y(1,2);
                          met_souris(16,1)
                         end;
   ligne:=1;
   sortons:=false;
   inverse(ligne);
   while (not sortons) do
   begin
   ancLigne:=ligne;
   if keypressed then
       begin
         litcar(ch,[#0..#255]);
         if ch in ensvalid then
                    begin
                       reponse:=ch;
                       sortons:=true
                     end;
         if ch=#13 then begin reponse:=item[ligne];sortons:=true end;
         if ch=#203 then begin dec(ligne);if ligne<1 then ligne:=1 end;
         if ch=#205 then begin inc(ligne);if ligne>6 then ligne:=6 end;
       end;
    if souris_est_la then
        begin
          if bouton_gauche then begin reponse:=item[ligne];sortons:=true end;
          ligne:=(XSouris div 16)
        end;
    if ligne<> ancLIgne then
      begin
        inverse(ancLigne);
        inverse(ligne);
      end;
   end;
   if souris_est_la then begin
                          amplitude_X(minXCurseur,maxXCurseur);
                          amplitude_Y(minYCurseur,maxYCurseur)
                         end;
 selectfenetreTotale;
end;

procedure prepare(tablo:forme;var ptablo:pointer);
type bitstype=array[0..15] of word;
const bits:bitstype =(32768,16384,8192,4096,2048,1024,512,256,128,64,32,16,8,4,2,1);
var i,j:integer;
begin
    setviewport(0,0,15,15,true);clearviewport;
    for i:=0 to 15 do
    for j:=0 to 15 do
    begin
        if (tablo[i] and bits[j])<>0 then putpixel(j,i,15);
    end;
    getmem(ptablo,imagesize(0,0,15,15));
    getimage(0,0,15,15,ptablo^);
end;

procedure initgraphic;
var grpilote,grmode,codeErreur:integer;
    ch:char;
    fichier:text;
begin
  repeat
   {$I-}
     assign(fichier,'GR.CST');
     reset(fichier);
     readln(fichier,grpilote);
     close(fichier);
     codeerreur:=IOresult;
   {$I+}
   if codeerreur<>0 then
   begin closegraph;write('fichier GR.CST non trouve ou defectueux');HALT(1) end;
   grmode:=0;
     initgraph(grpilote,grmode,'');
     codeErreur:=graphresult;
     if codeerreur <> GrOk then
     begin
       clrscr;
       writeln('Graphique non initialis‚');
       writeln('R>‚essayer');writeln('A>bandonner');
       litcar(ch,['A','R']);
       if ch='A' then HALT;
     end;
    until codeerreur=grOk;
    if mode>=0 then setgraphmode(mode);
    souris_est_la:=souris_active;
    minXCurseur:=0;minYCurseur:=0;
    XScreenMaxGlb:=getMaxX;YMaxglb:=getmaxY;
    XMaxGlb:=(XScreenMaxGlb-7) div 8;
    maxXCurseur:=XScreenMaxGlb-17;maxYCurseur:=YMaxGlb-17;
    if souris_est_la then
    begin
          amplitude_X(minXCurseur,maxXCurseur);
          amplitude_Y(minYCurseur,maxYCurseur);
          cache_souris;
    end;
    getmem(preserve,imagesize(0,0,15,15));
    getimage(0,0,15,15,preserve^);
    prepare(mask1,pmask1);
    prepare(curseur1,pcurseur1);
    prepare(mask2,pmask2);
    prepare(curseur2,pcurseur2);
    prepare(mask3,pmask3);
    prepare(curseur3,pcurseur3);
    prepare(mask4,pmask4);
    prepare(curseur4,pcurseur4);
    prepare(mask5,pmask5);
    prepare(curseur5,pcurseur5);
    setviewport(0,0,getmaxX,getmaxY,true);clearviewport;
end;

begin
     initgraphic(-1);
     souris_cachee:=true;
end.