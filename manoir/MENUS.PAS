unit menus;
interface
  uses
    crt,dos;

type forme=array[0..15] of word;
var souris_est_la,sortie:boolean;
    forme_curseur,masque:forme;
    maxXCurseur,minXCurseur,maxYCurseur,minYCurseur:integer;
    preserve:array[0..15] of longint;
const {doigt}
      mask1:forme=($0FFC,$0FFE,$0FFF,$0FFF,$1FFF,$1FFF,$1FFF,$1FFF,$1FFF,$1FFF,$0FFF,
                   $01FF,$000F,$000F,$000F,$0006);
      curseur1:forme=($07F8,$07FC,$07FE,$07FE,$0006,$0DBE,$0DBE,$0D80,$0DB6,$0DB6,$0056,
                     $0006,$0006,$0006,$0006,$0000);
      {main}
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


procedure vide_buffer;
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
procedure met_souris(x,y:word);


implementation



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
end;

procedure montre_souris;
var ax,bx,cx,dx:integer;
begin
   souris(1,ax,bx,cx,dx);
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

end.