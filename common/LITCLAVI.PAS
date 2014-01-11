unit litclavier;

interface
uses crt,graph;
type enscar=set of char;
     chaine=string[30];
procedure litcar(var ch:char;ensvalid:enscar);
procedure litchainemin(var ch:chaine;m,n:integer;ensvalid:enscar;var echappe:boolean);
procedure litchaine(var ch:chaine;n:integer;ensvalid:enscar;var echappe:boolean);
(******************************************)
implementation
procedure litcar ;
begin
  repeat
  ch:=readkey;
  if (ch=#0)  then ch:=chr(ord(readkey)+128);
  ch:=upcase(ch);
  until ch in ensvalid;
end;
procedure litchainemin;
var l:integer;
    elt:char;
    xPC,yPc,largeur:integer;
    couleur:word;

    procedure effaceXY(x,y:integer); {effacement de 1 caractŠre}
    begin
    couleur:=getcolor;setcolor(getBkColor);
    outTextXY(X,Y,chr(219));
    setcolor(couleur);
    end;

begin
   largeur:=textwidth('a');
   ch:='';l:=0;
   echappe:=false;
   outText(chr(219));xPC:=getX-largeur;ypc:=getY;
   repeat
   litcar(elt,ensvalid+[#13,#8,#27]);
   if (elt=#8) and (l>0) then begin
                                effaceXY(xpc,ypc);
                                effaceXY(xpc-largeur,ypc);
                                xpc:=xpc-largeur;
                                outTextXY(Xpc,ypc,chr(219));
                                l:=l-1;
                                ch:=copy(ch,1,length(ch)-1);
                                end;
   if (elt in ensvalid) and (l<n) then begin
                          effaceXY(Xpc,Ypc);
                          outTextXY(xpc,ypc,elt+chr(219));
                          xpc:=xpc+largeur;
                          ch:=ch+elt;
                          l:=l+1;
                                       end;
   if elt=#27 then echappe:=true;
   until ((elt=#13) and (l>=m)) or (elt=#27);
end;

procedure litchaine;
begin
     litchainemin(ch,1,n,ensvalid,echappe)
end;
end.