uses crt,menu2,graph,litclavier,piece,Phall,Pcuisine,Parmoire,Psalon,Pescalier,Pcave,
     Pgarage,T_tres,utile,finish,gere;

var mode,pilote,couleur       : integer;
    fantome                   : boolean;
    ch                        : char;
    quitte                    : boolean;
    ordre                     : string;
    x, y, w                   : integer;

procedure Chmode;
forward;
procedure pointe;
forward;

procedure fichier;
begin
repeat
setcolor(3);
entete('Fichier',true);
rectangle(0,0,getmaxX,14);
ChoixDansMenu('Sauver,Charger,Quitter,<ESC>',['S','C','Q',#27],'SCQ'+chr(27),30,25,ch);
case ch of
        'Q' : quitte:=true;
        'S' : sauve;
        'C' : charge;
        end;
until (ch=#27) or (ch='Q') or (bouton_droit);
end;

procedure action;
begin
repeat
setcolor(3);
entete('Action',true);rectangle(0,0,getmaxX,14);ChoixDansMenu('Prendre,pOser,Aller,feRmer,Detruire     ,oUvrir,'+
'Monter (dans),‚Clairer la piЉce  ,Baisser,eXaminer,deScendre l escalier,prEndre la porte de d. ,<ESC>',
['P','O','A','R','D','F','U','M','C','B','X','S','E',#27],'POARDUMCBXSE'+chr(27),30,25,ch);
  case ch of
        'P' : begin entete('Pointez l''objet … prendre.',true);ordre:='PRENDRE';pointe; end;
        'D' : begin entete('Pointez l''objet … d‚truire.',true);ordre:='DETRUIRE';pointe; end;
        'U' : begin entete('Pointez la ® chose Ї … ouvrir.',true);ordre:='OUVRIR';pointe; end;
        'B' : begin entete('Pointez le Va et Vient … baisser.',true);ordre:='BAISSER';pointe; end;
        'X' : begin entete('Pointez l''objet … examiner.',true);ordre:='EXAMINER';pointe; end;
        'A' : begin entete('Pointez votre ® destination Ї.',true);ordre:='ALLER';pointe; end;
        'R' : begin entete('Pointez la ® chose Ї … fermer.',true);ordre:='FERMER';pointe; end;
        'O' : begin entete('Choisissez l''objet … poser.',true);ordre:='POSER';sac; end;
        'M' : begin entete('Pointez dans quoi vous voulez monter.',true);ordre:='MONTER';pointe; end;
        'E' : begin
              if endroit='SALON' then begin d_hall;if random(20)<3 then fantome_est_la; end;
              if endroit='CUISINE' then begin salon;;if random(20)<3 then fantome_est_la;end;
              if endroit='CAVE' then setBKcolor(0);
              if (endroit='CAVE') or (endroit='DANS LE NOIR') then begin salon;if random(20)<3 then fantome_est_la;end;
              if endroit='GARAGE' then begin cave;if random(20)<3 then fantome_est_la;end;
              end;
        'S' : begin
              if (endroit='ESCALIER') and (clef) then begin cave;if random(20)<3 then fantome_est_la;end else
                                                 begin
                                                 if (endroit='ESCALIER') then
                                                    begin
                                                    setcolor(0);outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                    setcolor(2);outtextXY(10,180,'Vous arrivez devant une porte mais');
                                                    outtextXY(5,190,'celle-ci est ferm‚e. Remontez au salon');Vide_buffer;
                                                    ch:=readkey;setcolor(0);
                                                    outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                    outtextXY(5,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');setcolor(3);
                                                    salon;if random(20)<3 then fantome_est_la;
                                                    end;
                                                 end;
              end;
        'C' : begin
              if (endroit='DANS LE NOIR') and (lampe) then cave_ecl:=true;
              if (endroit='DANS LE NOIR') and (not(lampe)) then fin('Vous cherchez une lampe et...');
              cave;if random(20)<3 then fantome_est_la;
              end;
  end;
until (ch=#27) or (bouton_droit);
end;

procedure option;
begin
repeat
setcolor(3);
entete('Option',true);
  rectangle(0,0,getmaxX,14);
  ChoixDansMenu('Changer le mode graphique  ,Video Inverse,bIlan,<ESC>',
  ['C','V','I',#27],'CVI'+chr(27),10,25,ch);
   case ch of
     'V' : InverseWindow(0,0,getmaxX,getmaxY);
     'C' : chmode;
     'I' : begin bilan;if endroit='ARMOIRE' then armoire; if endroit='HALL' then d_hall;
                       if endroit='SALON' then salon;if endroit='CUISINE' then cuisine;
                       if endroit='ESCALIER' then escalier;if endroit='CAVE' then cave;
                       if endroit='GARAGE' then garage;
           end;
     end;
until (ch=#27) or (bouton_droit);
end;

procedure surprise;
begin
setcolor(0);
         outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                           setcolor(2);
                                            outtextXY(10,180,'Surprise ! Il y a des inscriptions');
                                            outtextXY(10,190,'bizarres au dos du tableau !      ');
                                            setcolor(1);
                                            Vide_buffer;
                                            outtextXY(10,200,'Appuyez sur une touche ...');
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,200,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'® Examiner l''evier, vous y trou');
                                            outtextXY(10,190,'verez sans doute quelque chose en  Ї');
                                            setcolor(1);
                                            Vide_buffer;
                                            outtextXY(10,200,'Appuyez sur une touche ...');
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,200,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'® nettoyant avec un mou..... ou ');
                                            outtextXY(10,190,'... ..... ... ... ...... ... Ї');
                                            setcolor(1);
                                            Vide_buffer;
                                            outtextXY(10,200,'Appuyez sur une touche ...');
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,200,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
end;

procedure pass;
begin
Cleardevice;
RECTANGLE(115,49,227,113);
LINE(115,49,11,14);
LINE(227,49,319,4);
LINE(115,113,0,177);
LINE(227,113,319,168);
LINE(36,157,0,177);
setfillpattern(tapis,1);
floodfill(237,75,3);
floodfill(103,79,3);
setcolor(2);
outtextXY(10,180,'Vous avancez dans ce passage quand');
outtextXY(10,190,'tout … coup un bruit r‚sonna : ...');
setcolor(1);
Vide_buffer;
ch:=readkey;
setcolor(0);
outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
setcolor(2);
outtextXY(10,180,'... un mur venait de remplacez la');
outtextXY(10,190,'grille. Et vous voil… prisonnier !');
Vide_buffer;
ch:=readkey;
setcolor(0);
outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
setcolor(3);
RECTANGLE(156,71,185,95);
ELLIPSE(171,86,0,180,14,8);
LINE(157,86,155,104);
LINE(185,83,188,105);
LINE(155,105,160,117);
LINE(160,117,166,105);
LINE(166,105,174,116);
LINE(174,116,178,115);
LINE(178,115,183,102);
LINE(183,102,191,102);
LINE(96,125,122,131);
LINE(122,131,148,131);
LINE(148,131,190,129);
LINE(190,129,227,116);
LINE(228,116,231,116);
setfillstyle(1,1);
floodfill(171,84,3);
floodfill(164,121,3);
floodfill(173,104,3);
floodfill(160,114,3);
floodfill(175,114,3);
setcolor(2);
outtextXY(10,180,'Une vanne s''ouvrit en laissant');
outtextXY(10,190,'passer de l''eau  ...    ');
fin('L''eau ‚tait mortelle...');
end;

procedure grille_d;
begin
    entete('Possedez vous une bombe ?',true);
    moveto(2+8*24,4);
    litcar(ch,['O','N']);
    if (ch='O') and (not(bombe)) then fin('Mentir est un Defaut...');
    if (ch='N') and (bombe) then entete('Non ? Mais si ...',true);
if bombe then
         begin
         grille:=false;
         sound(36);
         delay(1000);
         Nosound;
         d_hall;;if random(20)<3 then fantome_est_la;
         end;
end;

procedure chMode;
var rep:chaine;
    erreur,mode:integer;
    ch:char;
    caVa:boolean;
begin
    entete('Mode graphique (0 a 5): ',true);
    repeat
    moveto(2+8*24,4);
      litchaine(rep,1,['0'..'5'],sortie);
      if sortie then EXIT;
      val(rep,mode,erreur);
      setgraphmode(mode);
      caVa:=true;
      if graphresult=-10 then
      begin
        entete('mode invalide              <ESC>',true);
        litcar(ch,[#27]);
        entete('Mode graphique (0 a 5): ',true);
        caVa:=false;
     end;
     until caVa;
     closegraph;initgraphic(mode);
     if endroit='HALL' then begin d_hall;;if random(20)<3 then fantome_est_la; end;
     if endroit='ARMOIRE' then begin armoire;if random(20)<3 then fantome_est_la; end;
     if endroit='SALON' then begin salon;if random(20)<3 then fantome_est_la;end;
     if endroit='CUISINE' then begin cuisine;if random(20)<3 then fantome_est_la;end;
     if endroit='ESCALIER' then begin escalier;if random(20)<3 then fantome_est_la;end;
     if endroit='CAVE' then begin cave;if random(20)<3 then fantome_est_la;end;
     if endroit='DANS LE NOIR' then begin obs;if random(20)<3 then fantome_est_la;end;
     if endroit='GARAGE' then begin garage;if random(20)<3 then fantome_est_la;end;
end;

procedure pointe;
var ord2:string;
    bord:byte;
begin
souris_est_la:=souris_active;
montre_souris;
ord2:='';
met_souris(15,16);
        repeat
        x:=Xsouris;
        y:=Ysouris;
        x:=x DIV 2;
        until bouton_gauche;
        ch:=#27;
        cache_souris;
        if endroit='HALL' then
                          begin
                          if (x>33) and (x<51) and (y in [110..145]) and (not(tableau)) then ord2:=' TABLEAU';
                          if (x>187) and (x<196) and (y in [41..53]) and (not(epee)) then ord2:=' EPEE';
                          if (x>237) and (x<265) and (y in [34..87]) and (grille) then ord2:=' GRILLE';
                          if (x>67) and (x<98) and (y in [69..173]) then ord2:=' ARMOIRE';
                          if (x>237) and (x<265) and (y in [34..87]) and (not(grille)) then ord2:=' PASSAGE';
                          if (x>153) and (x<174) and (y in [34..68]) then ord2:=' PORTE';
                          end;
        if endroit='ARMOIRE' then
                          begin
                          if (x>119) and (x<152) and (y in [72..178]) then ord2:=' BALAI';
                          if (x>161) and (x<173) and (y in [31..58]) then ord2:=' LAVE-GLACE';
                          if (x>130) and (x<158) and (y in [48..58]) then ord2:=' ESSUIE-TOUT';
                          if (x>193) and (x<228) and (y in [43..59]) then ord2:=' LIVRE';
                          if (x>15) and (x<30) and (y in [15..30]) then ord2:=' ARMOIRE';
                          end;
        if endroit='SALON' then
                          begin
                          if (x>97) and (x<205) and (y in [19..76]) then ord2:=' CANAPE';
                          if (x>202) and (x<232) and (y in [60..82]) then ord2:=' MOUCHOIR';
                          if (x>34) and (x<68) and (y in [99..136]) then ord2:=' TIROIRS';
                          if (x>117) and (x<168) and (y in [104..158]) then ord2:=' TABLE';
                          if (x>135) and (x<147) and (y in [92..121]) then ord2:=' BOUTEILLE';
                          if (x>256) and (x<279) and (y in [37..129]) then ord2:=' PORTE';
                          end;
        if endroit='CUISINE' then
                          begin
                          if (x>174) and (x<248) and (y in [49..69]) then ord2:=' VAISELLE';
                          if (x<251) and (x>170) and (y in [79..106]) then ord2:=' 1er PLACARD';
                          if (x>246) and (x<278) and (y in [88..161]) then ord2:=' 2eme PLACARD';
                          if (x<226) and (x>143) and (y in [113..162]) then ord2:=' TABLE';
                          if (x<97) and (x>66) and (y in [111..143]) then ord2:=' FOUR';
                          if (x<126) and (x>69) and (y in [91..109]) then ord2:=' EVIER';
                          if (x<150) and (x>135) and (y in [60..108]) then ord2:=' FRIGO';
                          end;
        if endroit='ESCALIER' then
                          if (x>15) and (x<304) and (y in [16..177]) then ord2:=' ESCALIER';
        if endroit='CAVE' then
                          begin
                          if (x>228) and (x<241) and (y in [109..122]) then ord2:=' COLLIER';
                          if (x>237) and (x<244) and (y in [41..49]) then ord2:=' VA ET VIENT Nш1';
                          if (x>253) and (x<263) and (y in [41..50]) then ord2:=' VA ET VIENT Nш2';
                          if (x>238) and (x<245) and (y in [57..67]) then ord2:=' VA ET VIENT Nш3';
                          if (x>252) and (x<259) and (y in [59..69]) then ord2:=' VA ET VIENT Nш4';
                          if (x>182) and (x<227) and (y in [136..172]) then ord2:=' CAISSE';
                          if (x>110) and (x<163) and (y in [106..162]) then ord2:=' TONNEAU';
                          if (x>155) and (x<183) and (y in [39..73]) then ord2:=' PORTE';
                          end;
        if endroit='GARAGE' then
                          begin
                          if (x>97) and (x<250) and (y in [76..160]) then ord2:=' VOITURE';
                          if (x>125) and (x<231) and (y in [39..68]) then ord2:=' ETAGERES';
                          if (x>26) and (x<90) and (y in [30..110]) then ord2:=' PORTE';
                          if (x>100) and (x<109) and (y in [58..68]) then ord2:=' INTERRUPTEURS';
                          end;
ordre:=ordre+ord2;
setcolor(0);
outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
setcolor(3);
outtextXY(15,185,ordre);

{*****************************************************************************}

if endroit='HALL' then
                  begin
                  if ordre='PRENDRE EPEE' then begin epee:=true;d_hall;;if random(20)<3 then fantome_est_la; end;
                  if ordre='PRENDRE TABLEAU' then begin tableau:=true;d_hall;;if random(20)<3 then fantome_est_la; end;
                  if ordre='DETRUIRE GRILLE' then grille_d;
                  if ordre='OUVRIR ARMOIRE' then armoire;
                  if ordre='EXAMINER TABLEAU' then surprise;
                  if ordre='OUVRIR PORTE' then begin p_hall:=true;outtextXY(155,42,'O'); end;
                  if ordre='FERMER PORTE' then begin p_hall:=false;setcolor(0);outtextXY(155,42,'Ы');setcolor(3); end;
                  if ordre='ALLER PASSAGE' then pass;
                  if (ordre='ALLER PORTE') and (p_hall) then begin salon;if random(20)<3 then fantome_est_la;end;
                  end;
if endroit='ARMOIRE' then
                  begin
                  if ordre='FERMER ARMOIRE' then begin d_hall;;if random(20)<3 then fantome_est_la;end;
                  if (ordre='EXAMINER LIVRE') and (random(10)<9) then
                                            begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Ouf ! Heureusement que vous n''avez');
                                            outtextXY(10,190,'pas pris le livre car il est reli‚');
                                            setcolor(1);
                                            Vide_buffer;
                                            outtextXY(10,200,'Appuyez sur une touche ...');
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,200,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'… une bombe !!!');
                                            setcolor(1);
                                            Vide_buffer;
                                            outtextXY(10,200,'Appuyez sur une touche ...');
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,200,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            end;
                  if ordre='PRENDRE LIVRE' then fin('Le livre ‚tait pi‚g‚ ... ');
                  if ordre='PRENDRE ESSUIE-TOUT' then begin essuie:=true;armoire;if random(20)<3 then fantome_est_la; end;
                  if ordre='PRENDRE LAVE-GLACE' then begin lave:=true;armoire;if random(20)<3 then fantome_est_la; end;
                  if ordre='PRENDRE BALAI' then
                                           begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Tiens, tiens ! le balai est attach‚.');
                                            outtextXY(10,190,'Pas moyen de le prendre ...       ');
                                            setcolor(1);
                                            Vide_buffer;
                                            outtextXY(10,200,'Appuyez sur une touche ...');
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,200,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            if (epee) and (random(10)>=5) then
                                                      begin
                                                      setcolor(2);
                                                      outtextXY(10,180,'Soudain votre ‚p‚e s''‚chappa de');
                                                      outtextXY(10,190,'de votre main et revint … sa place !');
                                                      epee:=false;
                                                      setcolor(1);
                                                      Vide_buffer;
                                                      outtextXY(10,200,'Appuyez sur une touche ...');
                                                      ch:=readkey;
                                                      setcolor(0);
                                                      outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                      outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                      outtextXY(10,200,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                      end;
                                            setcolor(3);
                                            end;
                  end;
if endroit='SALON' then
                  begin
                  if ordre='PRENDRE MOUCHOIR' then begin;mouchoir:=true;salon;if random(20)<3 then fantome_est_la;end;
                  if ordre='PRENDRE BOUTEILLE' then begin;bouteille:=true;salon;if random(20)<3 then fantome_est_la;end;
                  if ordre='EXAMINER MOUCHOIR' then
                                               begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Le mouchoir est un mouchoir comme les');
                                            outtextXY(10,190,'autres. Ses initiales sont ® V I Ї.');
                                            setcolor(1);
                                            Vide_buffer;
                                            outtextXY(10,200,'Appuyez sur une touche ...');
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,200,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                               end;
                  if ordre='OUVRIR TIROIRS' then
                                   begin
                                   randomize;
                                   if random(20)<16 then
                                             begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Vous y d‚couvrez une mini-bombe ...  ');
                                            outtextXY(10,190,'Voulez-vous la prendre ? (O/N)    ');
                                            Vide_buffer;
                                            litcar(ch,['O','N']);
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            if ch='O' then bombe:=true else bombe:=false;
                                             end
                                          else
                                            begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Vous n''y trouvez que de la poussiЉre.');
                                            Vide_buffer;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            end;
                                   end;
                  if ordre='OUVRIR PORTE' then begin outtextXY(88,10,'O');P_salon:=true;end;
                  if ordre='FERMER PORTE' then begin setcolor(0);outtextXY(88,10,'Ы');P_salon:=false;end;
                  if (ordre='ALLER PORTE') and (p_salon) then begin cuisine;if random(20)<3 then fantome_est_la;end;
                  if ordre='EXAMINER CANAPE' then
                                            begin
                                   if random(20)>10 then
                                            begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Tiens, tiens ! Les boutons du canape ');
                                            outtextXY(10,190,'peuvent tourner...Essayez-vous ?(O/N)');
                                            Vide_buffer;
                                            litcar(ch,['O','N']);
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            if ch='O' then
                                                      begin
                                                      setcolor(1);
                                                      outtextXY(10,180,'Le canap‚ se pousse et laisse place un   ');
                                                      outtextXY(10,190,'escalier qui mЉne sans doute … la cave.');
                                                      ch:=readkey;
                                                      setcolor(0);
                                                      outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                      outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                      setcolor(3);
                                                      escalier;if random(20)<3 then fantome_est_la;
                                                      end;
                                           end
                                          else
                                            begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Vous ne remarquez rien de sp‚cial ...');
                                            Vide_buffer;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            end;
                                            end;
                  setcolor(3);
                  end;
if endroit='CUISINE' then
                  begin
                  if ordre='OUVRIR FOUR' then fin('Du four sortit un gaz mort');
                  if ordre='PRENDRE VAISELLE' then begin vaiselle:=true;cuisine;if random(20)<3 then fantome_est_la; end;
                  if (ordre='EXAMINER EVIER') and (mouchoir) then
                                            begin
                                            bord:=3;
                                            setviewport(277,21,213,87,ClipOn);
                                            Clearviewport;
                                            SelectFenetreTotale;
                                            setcolor(3);
                                            RECTANGLE(277,21,213,87);
                                            ELLIPSE(244,37,0,360,10,11);
                                            ELLIPSE(244,37,0,360,13,14);
                                            LINE(243,52,243,82);
                                            LINE(246,51,246,85);
                                            LINE(246,85,236,85);
                                            LINE(236,85,236,82);
                                            LINE(236,82,242,82);
                                            RECTANGLE(242,75,237,79);
                                            {en rouge}
                                            setfillstyle(1,2);
                                            FLOODFILL(225,60,Bord);
                                            FLOODFILL(244,37,Bord);
                                            {en jaune}
                                            setfillstyle(1,3);
                                            FLOODFILL(245,60,3);
                                            FLOODFILL(240,77,3);
                                            mouchoir:=false;
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Enlevant les salet‚es avec votre mou-');
                                            outtextXY(10,190,'choir vous d‚couvrez une clef...     ');
                                            Vide_buffer;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Voulez-vous la prendre ?? (O/N) ');
                                            Vide_buffer;
                                            litcar(ch,['O','N']);
                                            if ch='O' then clef:=true;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            cuisine;if random(20)<3 then fantome_est_la;
                                            end;
                  if (ordre='EXAMINER TABLE') and ((tableau) xor (epee)) then
                                              fin('Imposible d''y r‚sister!...');
                  if ordre='PRENDRE TABLE' then
                                              fin('Quelle idee... Quelle idee...');
                  if ordre='OUVRIR 1er PLACARD' then
                                            if random(20)>10 then
                                            begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Vous n''y trouvez qu''une carte...   ');
                                            outtextXY(10,190,'apprenant qu''il y a un esaclier sous');
                                            Vide_buffer;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            outtextXY(10,180,'le canape ....     Recommencez cette');
                                            outtextXY(10,190,'aventure ... Un squelette vous donna...');
                                            Vide_buffer;
                                            fin('le repos ETERNEL ...');
                                            end
                                         else fin('Victime d''un meurtre...');
                  if (ordre='OUVRIR 2eme PLACARD') and (random(20)<15) then
                                         begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Quelle chance ! Vous trouvez le bou-');
                                            outtextXY(10,190,'geoir mais il ‚tait allum‚ et un de');
                                            Vide_buffer;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(1);
                                            outtextXY(10,180,'vos objets risque de br–ler. Tentez  ');
                                            outtextXY(10,190,'votre chance...          ');
                                            if tableau then tableau:=false;
                                            if mouchoir then mouchoir:=false;
                                            if epee then fin('Votre ‚p‚e chauffa trop...');
                                            bougeoir:=true;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            Vide_buffer;
                                            setcolor(3);
                                            end;
                  if ordre='OUVRIR FRIGO' then
                                          begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Vous ouvrez le frigo et regardez ce ');
                                            outtextXY(10,190,'qu''il y a … l''int‚rieur. A part du');
                                            Vide_buffer;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(1);
                                            outtextXY(10,180,'lait, vous trouvez une lampe de poche');
                                            outtextXY(10,190,'que vous prenez...       ');
                                            lampe:=true;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            Vide_buffer;
                                            setcolor(3);
                                          end;
                  end;
if (endroit='ESCALIER') and (ordre='EXAMINER ESCALIER') then
                                            begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'A part quelques fissures, qui pour- ');
                                            outtextXY(10,190,'ait faire craquer la marche, l''es-');
                                            Vide_buffer;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(1);
                                            outtextXY(10,180,'calier paraЊt tout a fait normal...');
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            Vide_buffer;
                                            setcolor(3);
                                            end;
if endroit='CAVE' then
                  begin
                  if ordre='PRENDRE COLLIER' then begin collier:=true;cave;if random(20)<3 then fantome_est_la; end;
                  if ordre='FERMER PORTE' then p_cave:=false;
                  if ordre='OUVRIR PORTE' then
                                            begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Bizarre, la porte ne s''ouvre pas...');
                                            Vide_buffer;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            end;
                  if ordre='EXAMINER CAISSE' then
                                             begin
                                             entete('Prenez ce qui vous int‚resse.',true);
                                             repeat
                                       choixdansmenu('Colle,Peinture,cLef de contact  ,ThermomЉtre,Marteau,pArchemin,<ESC>',
                                             ['C','P','L','T','M','A',#27],'CPLTMA'+chr(27),30,25,ch);
                                             case ch of
                                                  'C' : colle:=true;
                                                  'P' : fin('Elle explosa avec vous...');
                                                  'L' : contact:=true;
                                                  'M' : marteau:=true;
                                                  'A' : parchemin:=true;
                                                  'T' : fin('Il indiquait 2000 degres');
                                                  end;
                                             until ch=chr(27);
                                             end;
                  if ordre='BAISSER VA ET VIENT Nш1' then
                                            begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Vous baissez se va et vient et la   ');
                                            outtextXY(10,190,'lumiЉre s''‚teignit...             ');
                                            Vide_buffer;
                                            ch:=readkey;
                                            setcolor(0);
                                            cave_ecl:=false;
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            cave;if random(20)<3 then fantome_est_la;
                                            end;
                  if ordre='BAISSER VA ET VIENT Nш2' then
                                            begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Vous le baissez et la porte s''ouvrit.');
                                            outtextXY(10,190,'Mais vous perdez votre lampe... ');
                                            Vide_buffer;
                                            p_cave:=true;
                                            ch:=readkey;
                                            setcolor(0);
                                            if lampe then lampe:=false;
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            end;
                  if ordre='BAISSER VA ET VIENT Nш3' then
                                            begin
                                            setcolor(0);
                                            outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(2);
                                            outtextXY(10,180,'Une voix se fit entendre:®Pour trouver');
                                            outtextXY(5,190,'le tr‚sor,d‚marrez sans ouvrir la porte.');
                                            Vide_buffer;
                                            ch:=readkey;
                                            setcolor(0);
                                            outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            outtextXY(5,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                            setcolor(3);
                                            end;
                  if ordre='BAISSER VA ET VIENT Nш4' then fin('La trappe s''ouvrit !..');
                  if ordre='EXAMINER TONNEAU' then
                                              begin
                                              setcolor(0);
                                              outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              setcolor(2);
                                              outtextXY(10,180,'Vous l''examiner quand un ®€treЇ vous ');
                                              outtextXY(10,190,'ordonna:® Donnez moi … boire ! Ї ');
                                              Vide_buffer;
                                              ch:=readkey;
                                              setcolor(0);
                                              outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              setcolor(2);
                                              outtextXY(10,180,'Si vous avez une bouteille, consentez');
                                              outtextXY(10,190,'vous … lui donner ?? (O/N)  ');
                                              Vide_buffer;
                                              litcar(ch,['O','N']);
                                              setcolor(0);
                                              outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              setcolor(3);
                                              if (ch='O') and (not(bouteille)) then fin('Mentir est un d‚faut...');
                                              if ch='O' then
                                                        begin
                                                        bouteille:=false;
                                                        setcolor(2);
                                                        outtextXY(10,180,'®Fais se que(HIPS)je te dis: prends');
                                                        outtextXY(10,190,'la voi(HIPS)ture et fonce dans la porte.');
                                                        Vide_buffer;
                                                        ch:=readkey;
                                                        setcolor(0);
                                                        outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                        outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                        end;
                                              if (ch='N') and (bouteille) then fin('Soyez plus g‚n‚reux...');
                                              end;
                  if (ordre='ALLER PORTE') and (p_cave) then begin garage;if random(20)<3 then fantome_est_la;end;
                  end;
if endroit='GARAGE' then
                  begin
                  if ordre='OUVRIR PORTE' then
                                          begin
                                          setcolor(0);
                                          outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                          setcolor(2);
                                          outtextXY(10,180,'Elle est ‚lectrique. Il faudrait ');
                                          outtextXY(10,190,'appuyer sur l''interrupteur pour l''ouvrir.');
                                          Vide_buffer;
                                          ch:=readkey;
                                          setcolor(0);
                                          outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                          outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                          end;
                  if ordre='EXAMINER INTERRUPTEURS' then
                                          begin
                                          setviewport(230,20,300,90,ClipOn);
                                          Clearviewport;
                                          SelectFenetreTotale;
                                          setcolor(3);
                                          rectangle(230,20,300,90);
                                          rectangle(240,30,260,80);
                                          rectangle(270,30,290,80);
                                          setfillstyle(9,1);
                                          floodfill(232,22,3);
                                          setfillstyle(1,2);
                                          floodfill(242,32,3);
                                          floodfill(272,32,3);
                                          montre_souris;
                                          entete('Pointez l''interrupteur … activer.',true);
                                          repeat
                                          x:=Xsouris;
                                          y:=Ysouris;
                                          x:=x DIV 2;
                                          until bouton_gauche;
                                          cache_souris;
                                          if (x>240) and (x<260) and (y in [30..80]) then gara:=false;
                                          if (x>270) and (x<290) and (y in [30..80]) then gara:=true;
                                          garage;if random(20)<3 then fantome_est_la;
                                          end;
                  if ordre='EXAMINER ETAGERES' then
                                               begin
                                               entete('Prenez ce qui vous int‚resse.',true);
                                               repeat
                                               choixdansmenu('Huile,Boulon,Torchon (legerement rape),'+
                                                             'Rustine,tUyau d''arossage tres tres vieux,<ESC>',
                                               ['H','B','T','R','U',#27],'HBTRU'+chr(27),30,25,ch);
                                               case ch of
                                                  'H' : huile:=true;
                                                  'B' : boulon:=true;
                                                  'T' : torchon:=true;
                                                  'R' : rustine:=true;
                                                  'U' : tuyau:=true;
                                                  end;
                                               until ch=chr(27);
                                               end;
                  if ordre='EXAMINER VOITURE' then
                                              begin
                                              setcolor(0);
                                              outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              setcolor(2);
                                              outtextXY(10,180,'Vous examiniez attentivement la voiture');
                                              outtextXY(10,190,'quand tu remarquas qu''un boulon man-');
                                              Vide_buffer;
                                              ch:=readkey;
                                              setcolor(0);
                                              outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              setcolor(2);
                                              outtextXY(10,180,'quait … la roue avant.');
                                              if boulon then outtextXY(2,190,'Vous le remplacez par votre boulon.') else
                                                             outtextXY(2,190,'Mais vous n''avez pas un seul boulon.');
                                              if boulon then begin boulon:=false;boulon_mis:=true; end;
                                              Vide_buffer;
                                              ch:=readkey;
                                              setcolor(0);
                                              outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              outtextXY(2,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              setcolor(3);
                                              end;
                  if ordre='MONTER VOITURE' then
                                              begin
                                              setcolor(0);
                                              outtextXY(15,185,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              setcolor(2);
                                              outtextXY(10,180,'Vous montez dans la voiture et vous vous');
                                              outtextXY(10,190,'asseyez au volant ... ');
                                              Vide_buffer;
                                              ch:=readkey;
                                              setcolor(0);
                                              outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              outtextXY(10,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              setcolor(2);
                                              if contact then
                                                 begin
                                                 outtextXY(10,180,'Voulez-vous d‚marrez ?');
                                                 litcar(ch,['O','N']);
                                                 if (ch='O') and (not(boulon_mis)) then fin('Une roue se d‚tacha et ...');
                                                 if (ch='O') and (not(gara)) then
                                                     begin
                                                     outtextXY(10,190,'Vous d‚marrez et rentrez dans la porte.');
                                                     tresor_t;
                                                     Vide_buffer;
                                                     ch:=readkey;
                                                     setcolor(0);
                                                     tresor:=true;
                                                     outtextXY(10,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                     outtextXY(2,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                                     setcolor(1);
                                                     outtextXY(10,180,'Fantastique ! Vous percez la premiЉre paroi');
                                                     outtextXY(2,190,'de la porte et le tresor en sort !...');
                                                     Vide_buffer;
                                                     ch:=readkey;
                                                     garage;if random(20)<3 then fantome_est_la;
                                                     setcolor(1);
                                                     outtextXY(10,180,'      APPUYEZ SUR UNE TOUCHE');
                                                     end;
                                                 if (ch='O') and (gara) then
                                                     begin
                                                     if (tresor) and (parchemin) and (bougeoir) and (clef) then gagne
                                                        else
                                              outtextXY(10,190,'Vous ne poss‚dez pas tous les preuves utiles');
                                                     end;
                                                 end
                                              else outtextXY(0,180,'Pas de clef de C,vous ne pouvez pas partir.');
                                              Vide_buffer;
                                              ch:=readkey;
                                              setcolor(0);
                                              outtextXY(0,180,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              outtextXY(2,190,'ЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫЫ');
                                              setcolor(3);
                                              end;
                  end;
end;

begin
randomize;
Textmode(BW80);
textcolor(lightgreen);
if not(souris_active) then
                      begin
                      write('Ce jeu n‚cessite l''emploi de la souris. ');
                      textColor(LightMagenta+blink);
                      writeln('Verifiez ci celle-ci est bien');
                      writeln('branch‚e ou charg‚e sinon consultez le mode d''emploi...');
                      writeln;
                      textcolor(white);
                      Halt(1);
                      end;
fantome:=false;ordre:='';initgraphic(0);cleardevice;x:=0;y:=0;settextStyle(0,0,0);
d_hall;
fantome_est_la;
repeat
affichemenu;quitte:=false;
ChoixDansMenuH(['F','A','O'],'FAO',0,0,ch);
case ch of
     'F' : Fichier;
     'A' : Action;
     'O' : Option;
     end;
until quitte;
end.