UNIT utile;
INTERFACE
USES graph,piece,menu2,crt,Phall,Parmoire,Psalon,Pcuisine,Pcave,finish;

var p:pointer;

procedure entete(texte:string;fentre:boolean);
procedure fin(raison:string);
procedure affichemenu;
procedure fantome_est_la;
procedure sac;

IMPLEMENTATION

var ch:char;
    ord2:string;
    x,y:integer;

procedure entete(texte:string;fentre:boolean);
begin
if fentre then begin setviewport(1,1,getmaxX-1,13,true);clearviewport;end;
    outtextXY(3,3,texte);
    selectfenetretotale;
end;

procedure fin(raison:string);
const do1 : word = 98;
      re  : word = 110;
      mi  : word = 124;
      fa  : word = 131;
      so  : word = 147;
      la  : word = 165;
      si  : word = 185;

var w, c : integer;
    bout : string;
begin
settextstyle(4,0,4);
c:=random(3);
w:=0;
bout:='';
repeat
w:=w+1;
c:=c+1;
if c=4 then c:=1;
bout:=copy(raison,1,w);
setcolor(c);
outtextXY(5,90,bout);
setcolor(0);
outtextXY(7,90,bout);
sound(200);delay(100);Nosound;
until w=length(raison);
sound(re);delay(800);Nosound;delay(10);
sound(re);delay(800);Nosound;delay(10);
sound(re);delay(400);Nosound;delay(10);
sound(re);delay(1000);Nosound;delay(10);
sound(fa);delay(800);Nosound;delay(10);
sound(mi);delay(600);Nosound;delay(10);
sound(mi);delay(800);Nosound;delay(10);
sound(re);delay(800);Nosound;delay(10);
sound(re);delay(800);Nosound;delay(10);
sound(do1);delay(800);Nosound;delay(10);
sound(re);delay(800);Nosound;
Vide_buffer;
repeat
c:=c+1;
if c=6 then c:=0;
setBkcolor(c);
until keypressed;
ch:=readkey;
if ch='a' then begin sound(5000);delay(1000);Nosound;end;
rejoue;
end;

procedure affichemenu;
begin
setcolor(3);
setviewport(0,0,getmaxX,14,ClipOn);
Clearviewport;
rectangle(0,0,getmaxX,14);
entete(' Fichier  Action  Option',true);
setcolor(1);
entete(' F        A       O',false);
SelectFenetreTotale;
end;

procedure fantome_est_la;
const do1 : word = 980;
      re  : word = 1100;
      mi  : word = 1240;
      fa  : word = 1310;
      so  : word = 1470;
      la  : word = 1650;
      si  : word = 1850;

var deja:boolean;
    h:integer;
begin
deja:=false;
h:=0;
h:=random(20);
sound(la);delay(420 DIV 4);Nosound;delay(50);
sound(la);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;delay(50);
sound(233);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;
sound(233);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;
sound(233);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;delay(50);
sound(la);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;
sound(185);delay(320 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;
sound(185);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;
sound(185);delay(420 DIV 4);Nosound;
sound(la);delay(420 DIV 4);Nosound;
if lave then deja:=true;
if lave then lave:=false;
if  (bombe)      and (h<18) then begin bombe:=false;deja:=true; end;
if  (marteau)    and (h<18) and (not(deja)) then begin marteau:=false;    deja:=true; end;
if  (mouchoir)   and (h<18) and (not(deja)) then begin mouchoir:=false;    deja:=true; end;
if  (tableau)    and (h<18) and (not(deja)) then begin tableau:=false;    deja:=true; end;
if  (epee)       and (h<18) and (not(deja)) then begin epee:=false;       deja:=true; end;
if  (essuie)     and (h<18) and (not(deja)) then begin essuie:=false;     deja:=true; end;
if  (huile)      and (h<18) and (not(deja)) then begin huile:=false;      deja:=true; end;
if  (boulon)     and (h<18) and (not(deja)) then begin boulon:=false;     deja:=true; end;
if  (torchon)    and (h<18) and (not(deja)) then begin torchon:=false;    deja:=true; end;
if  (tuyau)      and (h<18) and (not(deja)) then begin tuyau:=false;      deja:=true; end;
if  (collier)    and (h<18) and (not(deja)) then begin collier:=false;    deja:=true; end;
if  (colle)      and (h<18) and (not(deja)) then begin colle:=false;      deja:=true; end;
if  (rustine)    and (h<18) and (not(deja)) then begin rustine:=false;    deja:=true; end;
if  (contact)    and (h<18) and (not(deja)) then begin contact:=false;    deja:=true; end;
if  (lampe)      and (h<18) and (not(deja)) then begin lampe:=false;      deja:=true; end;
if  (vaiselle)   and (h<18) and (not(deja)) then begin vaiselle:=false;   deja:=true; end;
if  (clef)       and (h<18) and (not(deja)) then begin clef:=false;       deja:=true; end;
if  (bouteille)  and (h<18) and (not(deja)) then begin bouteille:=false;  deja:=true; end;
end;

procedure sac;
var       liste : string;
          liste2: string;
          ord2  : string;
begin
repeat
liste:='';
liste2:='';
if tableau   then liste:=liste+'Tableau,'      else liste:=liste+'***********,';
if epee      then liste:=liste+'Epee,'         else liste:=liste+'***********,';
if essuie    then liste:=liste+'eSsuie-tout,'  else liste:=liste+'***********,';
if lave      then liste:=liste+'Lave-glace,'   else liste:=liste+'***********,';
if bombe     then liste:=liste+'Bombe,'        else liste:=liste+'***********,';
if mouchoir  then liste:=liste+'Mouchoir,'     else liste:=liste+'***********,';
if bouteille then liste:=liste+'boUteille,'    else liste:=liste+'***********,';
if clef      then liste:=liste+'Clef,'         else liste:=liste+'***********,';
if vaiselle  then liste:=liste+'Vaiselle,'     else liste:=liste+'***********,';
if lampe     then liste:=liste+'lAmpe,'        else liste:=liste+'***********,';
if collier   then liste:=liste+'Collier,'      else liste:=liste+'***********,';
if colle     then liste:=liste+'cOlle,'        else liste:=liste+'***********,';
if contact   then liste:=liste+'cleF de c.,'   else liste:=liste+'***********,';
if marteau   then liste2:=liste2+'Marteau,'      else liste2:=liste2+'***********,';
if parchemin then liste2:=liste2+'Parchemin,'    else liste2:=liste2+'***********,';
if huile     then liste2:=liste2+'Huile,'        else liste2:=liste2+'***********,';
if boulon    then liste2:=liste2+'Boulon,'       else liste2:=liste2+'***********,';
if torchon   then liste2:=liste2+'Torchon,'      else liste2:=liste2+'***********,';
if rustine   then liste2:=liste2+'Rustine,'      else liste2:=liste2+'***********,';
if tuyau     then liste2:=liste2+'tUyau,'        else liste2:=liste2+'***********,';
if bougeoir  then liste2:=liste2+'bOugeoir,'     else liste2:=liste2+'***********,';
if tresor    then liste2:=liste2+'trEsor,'       else liste2:=liste2+'***********,';
choixdansmenu(liste+'* SUITE,<ESC>',['T','E','S','L','B','M','U','C','V','A','C','O','F','*',#27],
'TESLBMOCVACOF*'+chr(27),30,25,ch);
case ch of
     'T' : ord2:=' TABLEAU';
     'E' : ord2:=' EPEE';
     'S' : ord2:=' ESSUIE-TOUT';
     'L' : ord2:=' LAVE-GLACE';
     'B' : ord2:=' BOMBE';
     'M' : ord2:=' MOUCHOIR';
     'U' : ord2:=' BOUTEILLE';
     'C' : ord2:=' CLEF';
     'V' : ord2:=' VAISELLE';
     'A' : ord2:=' LAMPE';
     'C' : ord2:=' COLLIER';
     'O' : ord2:=' COLLE';
     'F' : ord2:=' CLEF C.';
     end;
                 if ord2=' TABLEAU' then begin tableau:=false;if endroit='HALL' then d_hall; end;
                 if ord2=' EPEE' then begin epee:=false;if endroit='HALL' then d_hall; end;
                 if ord2=' ESSUIE-TOUT' then begin essuie:=false;if endroit='ARMOIRE' then armoire; end;
                 if ord2=' LAVE-GLACE' then begin lave:=false;if endroit='ARMOIRE' then armoire; end;
                 if ord2=' BOMBE' then bombe:=false;
                 if ord2=' MOUCHOIR' then begin mouchoir:=false;if endroit='SALON' then salon; end;
                 if ord2=' BOUTEILLE' then begin bouteille:=false;if endroit='SALON' then salon; end;
                 if ord2=' CLEF' then clef:=false;
                 if ord2=' LAMPE' then LAMPE:=false;
                 if ord2=' VAISELLE' then begin vaiselle:=false;if endroit='CUISINE' then cuisine; end;
                 if ord2=' COLLIER' then begin collier:=false;if endroit='CAVE' then cave; end;
                 if ord2=' COLLE' then colle:=false;
                 if ord2=' CLEF C.' then contact:=false;
                 if ord2=' MARTEAU' then marteau:=false;
if ch='*' then
          begin
          choixdansmenu(liste2+'<ESC>',['M','P','H','B','T','R','U','O','E',#27],
          'P'+chr(27),30,25,ch);
          case ch of
               'P' : parchemin:=false;
               'M' : marteau:=false;
               'H' : huile:=false;
               'B' : boulon:=false;
               'T' : torchon:=false;
               'R' : rustine:=false;
               'U' : tuyau:=false;
               'B' : bougeoir:=false;
               'T' : tresor:=false;
               end;
          end;
{if (ordre='LANCER') and (fantome) then
                  begin
                 if (ord2=' TABLEAU') and (tableau) then begin tableau:=false;if endroit='HALL' then d_hall; end;
                 if (ord2=' EPEE') and (epee) then begin epee:=false;if endroit='HALL' then d_hall; end;
                 if (ord2=' ESSUIE-TOUT') and (essuie) then begin essuie:=false;if endroit='ARMOIRE' then armoire; end;
                 if (ord2=' LAVE-GLACE') and (lave) then begin lave:=false;if endroit='ARMOIRE' then armoire; end;
                 if (ord2=' BOMBE') and (bombe) then bombe:=true;
                 if (ord2=' MOUCHOIR') and (mouchoir) then begin mouchoir:=false;if endroit='SALON' then salon; end;
                 if (ord2=' BOUTEILLE') and (bouteille) then begin bouteille:=true;if endroit='SALON' then salon; end;
                 end;}
until (ch=chr(27)) or (bouton_droit);
end;

{procedure formatage;
var rep:chaine;
    erreur,mode:integer;
    ch:char;
    caVa:boolean;
begin
    entete('Etes-vous s–r(e) ?',true);
    moveto(2+8*24,4);
      litchaine(rep,1,['O','N'],sortie);
      if (sortie) or (rep='N') then EXIT;
    entete('Lecteur        (A a Z): ',true);
    repeat
    moveto(2+8*24,4);
      litchaine(rep,1,['A'..'Z'],sortie);
      if sortie then EXIT;
      caVa:=true;
      if Doserror<>0 then
      begin
        entete('Erreur                     <ESC>',true);
        litcar(ch,[#27]);
        entete('Lecteur        (A a Z): ',true);
        caVa:=false;
     end;
     until caVa;
end;}

begin
end.