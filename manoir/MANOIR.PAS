uses crt,graph,menus;
var graphdriver:integer;
    graphmode:integer;
    ch:char;
    x,y:integer;
    epee:boolean;
    textehasard:string;
    baguette:boolean;
    livre:boolean;
    bouclier:boolean;
    pompe:boolean;
    vue:boolean;
    hasard:integer;
    arrosage:boolean;
    feu:boolean;
    pain:boolean;
    codehasard:integer;
    morts:boolean;
    surprise:boolean;
    papier:boolean;

procedure plan;
forward;
procedure tout_false;
forward;
procedure grenier;
forward;
procedure load;
forward;
procedure save;
forward;
procedure final;
forward;
procedure sallemanger;
forward;
procedure salon;
forward;
procedure chambre;
forward;
procedure cuisine;
forward;
procedure lampe;
forward;
procedure fer;
forward;
procedure tonneau;
forward;
procedure bibliotheque;
forward;
procedure mort;
forward;
procedure jeu;
forward;
procedure passage;
forward;
procedure saladier;
forward;
procedure fleur;
forward;
procedure lampe2;
forward;
procedure aufeu;
forward;
procedure suite;
forward;
procedure tele;
forward;
procedure feuch;
forward;
procedure bilan;
forward;
procedure arbresa;
forward;
procedure lit;
forward;
procedure meuble;
forward;
procedure lampedanger;
forward;
procedure armoires_cuisine;
forward;
procedure table;
forward;

procedure plan;
begin
cache_souris;
Cleardevice;
setcolor(1);
setBKcolor(1);
{toit};
moveto(20,60);lineto(120,20);
lineto(240,60);lineto(20,60);
{reste de la maison};
lineto(20,140);
lineto(240,140);
lineto(240,60);
lineto(200,60);
lineto(200,100);
lineto(240,100);
lineto(20,100);
moveto(110,60);lineto(110,100);
lineto(80,100);
lineto(80,140);
{chemin‚e};
moveto(180,40);lineto(180,20);
lineto(200,20);
lineto(200,50);
{sauver .. charger}
setcolor(2);
moveto(0,180);lineto(0,199);
lineto(150,199);
lineto(150,180);
lineto(0,180);
moveto(170,180);lineto(170,199);
lineto(318,199);
lineto(318,180);
lineto(170,180);
outtextXY(0,185,'            SAUVER              CHARGER');
outtextXY(130,40,'1');
outtextXY(60,80,'2');
outtextXY(150,80,'3');
outtextXY(220,80,'4');
outtextXY(50,120,'5');
outtextXY(150,120,'6');
outtextXY(0,155,'Ou voulez-vous aller?');montre_souris;
end;

procedure mort;
var question:string;
begin
cleardevice;
morts:=true;
outtextXY(5,5,'Voici une triste fin ...');
outtextXY(0,100,'Voulez-vous rejouer ??');
repeat
readln(question);
if question='oui' then tout_false;
if question='non' then halt;
if question='bilan' then bilan;
until (question='oui') or (question='non') or (question='bilan');
end;

procedure suite;{du salon}
begin
outtextXY(0,185,'Pointez ce que vous voulez examiner ...');
montre_souris;
           repeat
    x:=Xsouris;
    y:=Ysouris;
              if bouton_gauche and
              (x>200) and (x<440) and (y in [70..140]) then feuch;
              if bouton_gauche and
              (x>40) and (x<120) and (y in [20..140]) then arbresa;
              if bouton_gauche and
              (x>260) and (x<380) and (y in [10..70]) then tele;
until bouton_droit;
end;

procedure fer;
begin
cache_souris;
cleardevice;
outtextXY(0,5,'Vous avez choisi le fer a repasser. Mais ');
outtextXY(0,20,'helas pour vous, vous n''y trouvez rien. ');
outtextXY(0,35,'Au moment ou vous allez vous relever, la');
outtextXY(0,50,'lampe vous tombe dessus vous voila');
{dessin du fer … repasser}
setcolor(2);
moveto(20,160);lineto(20,190);
lineto(160,190);
lineto(140,160);
lineto(20,160);
setcolor(3);
lineto(20,140);
lineto(120,140);
lineto(120,160);
lineto(100,160);
lineto(100,150);
lineto(40,150);
lineto(40,160);
lineto(20,160);
setcolor(1);
moveto(130,160);lineto(130,150);
lineto(140,150);
lineto(140,160);
setcolor(3);
if bouclier then
                begin
                       outtextXY(0,65,'sauve grace a votre bouclier...');ch:=readkey;montre_souris;
                       jeu;
                end
             else
                begin
                outtextXY(0,65,'aplati comme une crepe.');ch:=readkey;
                mort;
                end;
end;

procedure load;
var fichnom:file of boolean;
    i:integer;
    nom:string;
begin
cache_souris;
cleardevice;
repeat
outtextxy(0,5,'Nom du fichier');read(nom);
assign(fichnom,nom+'.dat');
{$I-}
reset(fichnom);
{$I+}
until IOResult=0;
read(fichnom,epee);
read(fichnom,pain);
read(fichnom,bouclier);
read(fichnom,livre);
read(fichnom,arrosage);
read(fichnom,surprise);
read(fichnom,feu);
read(fichnom,pompe);
read(fichnom,vue);
read(fichnom,baguette);
read(fichnom,papier);
close(fichnom);
cleardevice;
setcolor(1);
setBKcolor(1);
outtextXY(0,20,'Vous avez :');
if livre then outtextXY(0,95,'UN LIVRE');
if epee then outtextXY(160,95,'UNE EPEE');
if vue then outtextXY(0,110,'UNE LONGUE VUE');
if arrosage then outtextXY(160,110,'UN TUYAU D''ARROSAGE');
if pain then outtextXY(0,125,'UN MORCEAU DE PAIN');
if papier then outtextXY(160,125,'UN CODE ');
if surprise then outtextXY(0,140,'UNE BOITE A SURPRISE');
if pompe then outtextXY(160,140,'UNE POMPE');
if baguette then outtextXY(0,155,'UNE BAGUETTE MAGIQUE');
if bouclier then outtextXY(160,155,'UN BOUCLIER');
ch:=readkey;
jeu;
end;

procedure save;
var fichnom:file of boolean;
    i:integer;
    nom:string;
begin
cleardevice;
outtextXY(0,5,'Nom du fichier');read(nom);
assign(fichnom,nom+'.dat');
rewrite (fichnom);
   write(fichnom,epee);
   write(fichnom,pain);
   write(fichnom,bouclier);
   write(fichnom,livre);
   write(fichnom,arrosage);
   write(fichnom,surprise);
   write(fichnom,feu);
   write(fichnom,pompe);
   write(fichnom,vue);
   write(fichnom,baguette);
   write(fichnom,papier);
close(fichnom);
HALT;
end;

procedure bilan;
var questi:string;
begin
cleardevice;
setcolor(1);
setBKcolor(1);
outtextXY(0,20,'Vous avez eu :');
if livre then outtextXY(0,95,'UN LIVRE');
if epee then outtextXY(160,95,'UNE EPEE');
if vue then outtextXY(0,110,'UNE LONGUE VUE');
if arrosage then outtextXY(160,110,'UN TUYAU D''ARROSAGE');
if pain then outtextXY(0,125,'UN MORCEAU DE PAIN');
if papier then outtextXY(160,125,'UN CODE ');
if surprise then outtextXY(0,140,'UNE BOITE A SURPRISE');
if pompe then outtextXY(160,140,'UNE POMPE');
if baguette then outtextXY(0,155,'UNE BAGUETTE MAGIQUE');
if bouclier then outtextXY(160,155,'UN BOUCLIER');
setcolor(2);
outtextXY(0,170,'     Et vous etes sorti(e)s ');
if morts then outtextXY(0,185,'           vaincu') else outtextXY(0,185,'        vainqueur');
ch:=readkey;
cleardevice;
setcolor(3);
outtextXY(0,105,'Voulez-vous rejouer?');
repeat
readln(questi);
if questi='oui' then
        begin
        tout_false;
        end;
if questi='non' then halt;
if questi='bilan' then bilan;
until (questi='non') or (questi='oui') or (questi='bilan');
end;

procedure tele;
begin
cache_souris;
cleardevice;
setcolor(3);
setBKcolor(1);
outtextXY(0,5,'Allez-vous ');
moveto(20,40);lineto(40,40);
lineto(40,60);
lineto(20,60);
lineto(20,40);
outtextXY(50,50,'allumer la tele');
moveto(20,80);lineto(40,80);
lineto(40,100);
lineto(20,100);
lineto(20,80);
outtextXY(50,90,'examiner la tele');
montre_souris;
      repeat
   x:=Xsouris;
   y:=Ysouris;
                if bouton_gauche and
                (x>40) and (x<80) and (y in [40..60]) then
                       begin
                       cache_souris;
                       cleardevice;
                       outtextXY(0,5,'Vous allumez la tele et ... une formi-');
                       outtextXY(0,20,'dable explosion retentit. Vous entendez');
                       outtextXY(0,35,'un bruit tres bruyant vous disparaissez');
                       outtextXY(0,50,'sous le plancher. Vous etes dans une ');
                       delay(5000);
                       setBKcolor(0);
                       outtextXY(0,65,'piece obscure. Vous vous dirigez au ha-');
                       outtextXY(0,80,'sard et tout a coup tout s''ecroula ...');
                       outtextXY(0,95,'Vous sentez une echelle vous la montez');
                       outtextXY(0,110,'et vous vous retrouvez dans le salon !');
                       delay(5000);
                       setBKcolor(1);
                       outtextXY(0,125,'Dans le salon, rien ne semblait avoir');
                       outtextXY(0,140,'change. Tout est en bon etat. Vous ');
                       outtextXY(0,155,'trouvez juste une baguette magique ');
                       outtextXY(0,170,'a cote de la television ...');ch:=readkey;
                       baguette:=true;
                       jeu;
                       end;
                if bouton_gauche and
                (x>40) and (x<80) and (y in [80..100]) then
                        begin
                        cache_souris;
                        cleardevice;
                        outtextXY(0,5,'Vous examinez la tele et ... un ... ');
                        randomize;
                        hasard:=random(100);
                        if hasard >= 50 then
                                  begin
                                  outtextXY(0,20,'effroyable squelette ouvrit la porte.');
                                  if epee then
                                          begin
                                          outtextXY(0,35,'Mais vous le battez ...');
                                          ch:=readkey;
                                          jeu;
                                          end
                                      else
                                         begin
                                         outtextXY(0,35,'Il vous tue d''un coup d''epee ...');
                                         ch:=readkey;
                                         mort;
                                         end;
                                  end
                             else
                                 begin
                                 outtextXY(0,20,'... Non rien ne se passa.');
                                 outtextXY(0,35,'La tele est une simple tele.');
                                 ch:=readkey;jeu;
                                 end;
                        end;
until bouton_droit;
end;

procedure arbresa;
begin
cache_souris;
cleardevice;
outtextXY(0,5,'Vous voyez encore la morsure');
outtextXY(0,20,'du feu sinon il n''y a rien');
outtextXY(0,35,'d''autre sauf au pied de l''arbre, enterre');
outtextXY(0,50,'un bouclier ... ');ch:=readkey;
bouclier:=true;
jeu;
end;

procedure feuch;
begin
cache_souris;
cleardevice;
setcolor(1);
setBKcolor(0);
outtextXY(0,5,'Vous inspectez ');
moveto(20,60);lineto(40,60);
lineto(40,80);
lineto(20,80);
lineto(20,60);
outtextXY(55,70,'Le feu ');
moveto(20,120);lineto(40,120);
lineto(40,140);
lineto(20,140);
lineto(20,120);
outtextXY(55,130,'La cheminee ');
montre_souris;
            repeat
       x:=Xsouris;
       y:=Ysouris;
             if bouton_gauche and
             (x>40) and (x<80) and (y in [60..80]) then
                        begin
                        cache_souris;
                        cleardevice;
                        outtextXY(0,5,'Vous inspectez les flammes du feu mais');
                        outtextXY(0,20,'il n''y a rien d''interessant ...');ch:=readkey;
                        jeu;
                        end;
             if bouton_gauche and
             (x>40) and (x<80) and (y in [120..140]) then
                        begin
                        cache_souris;
                        cleardevice;
                        if arrosage then
                               begin
                               outtextXY(0,5,'Vous eteignez le feu avec votre tuyau');
                               outtextXY(0,20,'Mais par malchance votre tuyau brule.');
                               outtextXY(0,35,'Mais vous trouvez un superbe bouclier.');
                               arrosage:=false;
                               bouclier:=true;
                               ch:=readkey;
                               jeu;
                               end
                           else
                               begin
                               outtextXY(0,5,'Vous n''avez pas de tuyau. Vous brulez ...');ch:=readkey;
                               mort;
                               end;
                        end;
until bouton_droit;
end;

procedure aufeu;
begin
feu:=true;
{dessin du feu sur l'arbre}
setcolor(2);
circle(60,40,5);
setfillstyle(1,2);
floodfill(60,40,2);
ch:=readkey;
cleardevice;
outtextXY(5,5,'Tiens, ca sent le roussi ...');
outtextXY(0,20,'Mais c''est l''arbre qui brule!');
if arrosage then
            begin
            outtextXY(0,35,'Grace a votre tuyau, vous eteignez le');
            outtextXY(0,50,'feu ...');ch:=readkey;salon;
            end
        else
            begin
            outtextXY(0,35,'Vous brulez vif ...');
            ch:=readkey;
            mort;
            end;
end;

procedure lampe2;
begin
cache_souris;
cleardevice;
setBKcolor(1);
setcolor(3);
outtextXY(0,5,'Vous avez choisi la lampe.');
outtextXY(0,20,'Vous montez sur la chaise et regardez ');
outtextXY(0,35,'la lampe.');
randomize;
hasard:=random(10);
If hasard>5 then
             begin
             outtextXY(0,50,'La lampe est une lampe comme les autres.');
             outtextXY(0,65,'Subitement un squelette ouvrit la porte.');
             if epee then
                   begin
                   outtextXY(0,80,'Vous vous battez et gagnez.');ch:=readkey;
                   jeu;
                   end
                else
                   begin
                   outtextXY(0,80,'Le squelette vous tue ...');ch:=readkey;
                   mort;
                   end
             end
         else
              begin
              outtextXY(0,50,'La lampe est une lampe comme les autres.');
              ch:=readkey;
              jeu;
              end
end;

procedure fleur;
begin
cache_souris;
cleardevice;
setBKcolor(2);
setcolor(1);
outtextXY(0,5,'Vous avez choisi la fleurs. C''est une');
outtextXY(0,20,'fleur comme les autres. Mais soudain,');
outtextXY(0,35,'un fantome apparut.');
if pompe then
         begin
         outtextXY(0,50,'Vous l''aspirez avec votre pompe.');
         outtextXY(0,65,'Vous voyez que la tige de la fleur etait');
         outtextXY(0,80,'une epee ...');epee:=true;
         ch:=readkey;
         jeu;
         end
     else
         begin
         outtextXY(0,50,'Il vous etouffe ...');
         ch:=readkey;
         mort;
         end;
end;

procedure bibliotheque;
begin
cache_souris;
cleardevice;
setcolor(3);
moveto(20,20);lineto(20,80);
lineto(60,80);
lineto(60,20);
lineto(20,20);
lineto(100,20);
lineto(100,80);
lineto(60,80);
lineto(60,180);
lineto(140,180);
lineto(140,20);
lineto(100,20);
lineto(100,80);
lineto(140,80);
lineto(140,130);
lineto(20,130);
lineto(20,80);
lineto(20,180);
lineto(100,180);
lineto(100,20);
outtextXY(145,5,'Pointez le livre que');
outtextXY(145,20,'vous voulez prendre.');
montre_souris;
              repeat
    x:=Xsouris;
    y:=Ysouris;
         if bouton_gauche and
         (x>40) and (x<280) and (y in [20..80]) then
                     begin
                     outtextXY(0,185,'Il n''est pas interessant.                       ');
                     ch:=readkey;bibliotheque;
                     end;
         if bouton_gauche and
         (x>40) and (x<200) and (y in [80..130]) then
                    begin
                     outtextXY(0,185,'Il n''est pas interessant.                       ');
                     ch:=readkey;bibliotheque;
                     end;
         if bouton_gauche and
         (x>200) and (x<280) and (y in [80..130]) then
                     begin
                     outtextXY(0,185,'Vous possedez maintenant un livre ...            ');
                     livre:=true;
                     ch:=readkey;jeu;
                     end;
         if bouton_gauche and
         (x>40) and (X<280) and (y in [130..180]) then
                     begin
                     outtextXY(0,185,'Il n''est pas interessant.                       ');
                     ch:=readkey;bibliotheque;
                     end;
until bouton_droit;
end;

procedure tonneau;
begin
cache_souris;
cleardevice;
setcolor(2);
setbkcolor(1);
outtextXY(0,5,'Vous avez choisi le tonneau. Vous y trou-');
outtextXY(0,20,'vez juste une longue vue et une pompe.');ch:=readkey;
vue:=true;
pompe:=true;
jeu;
end;

procedure jeu;
begin
plan;montre_souris;
repeat
      x:=Xsouris;
      y:=Ysouris;
    if bouton_gauche and
    (x>40) and (x<480) and (Y in [20..60]) then grenier;
    if bouton_gauche and
    (x>40) and (x<240) and (Y in [60..100]) then cuisine;
    if bouton_gauche and
    (x>220) and (x<400) and (Y in [60..100]) then chambre;
    if bouton_gauche and
    (x>400) and (x<480) and (Y in [60..100]) then final;
    if bouton_gauche and
    (x>40) and (x<160) and (Y in [100..140]) then salon;
    if bouton_gauche and
    (x>160) and (x<480) and (Y in [100..140]) then sallemanger;
    if bouton_gauche and
    (x>0) and (x<300) and (Y in [180..200]) then save;
    if bouton_gauche and
    (x>340) and (x<640) and (Y in [180..200]) then load;
until bouton_droit;
end;

procedure cuisine;
begin
cache_souris;
cleardevice;
{dessin des armoires}
setcolor(1);
moveto(40,0);lineto(300,0);
lineto(300,40);
lineto(40,40);
lineto(40,0);
lineto(100,0);
lineto(100,40);
lineto(160,40);
lineto(160,0);
lineto(200,0);
lineto(200,40);
lineto(240,40);
lineto(240,0);
lineto(240,20);
lineto(40,20);
circle(270,20,1);
circle(220,10,1);
circle(180,10,1);
circle(120,10,1);
circle(70,10,1);
circle(220,30,1);
circle(220,30,1);
circle(180,30,1);
circle(120,30,1);
circle(70,30,1);
setfillstyle(11,3);
floodfill(260,20,1);
floodfill(210,10,1);
floodfill(170,10,1);
floodfill(110,10,1);
floodfill(90,10,1);
floodfill(210,30,1);
floodfill(170,30,1);
floodfill(110,30,1);
floodfill(90,30,1);
{lampe}
setcolor(3);
moveto(20,0);lineto(20,60);
circle(20,70,10);
setfillstyle(1,3);
floodfill(20,71,3);
{table}
setcolor(2);
moveto(100,180);lineto(100,120);
lineto(80,120);
lineto(80,110);
lineto(240,110);
lineto(240,120);
lineto(220,120);
lineto(220,180);
lineto(210,180);
lineto(210,120);
lineto(110,120);
lineto(110,180);
lineto(100,180);
setfillstyle(1,3);
floodfill(105,160,2);
{dessin de la chaise}
setcolor(1);
moveto(230,180);lineto(230,130);
lineto(240,130);
lineto(240,180);
lineto(240,130);
lineto(280,130);
lineto(280,80);
lineto(290,80);
lineto(290,180);
lineto(280,180);
lineto(280,140);
lineto(240,140);
moveto(0,180);lineto(320,180);
setfillstyle(1,1);
floodfill(235,179,1);
floodfill(285,179,1);
{souris}
outtextXY(0,185,'Pointez ce que vous voulez examiner ...');
montre_souris;
    repeat
          x:=XSouris;
          y:=Ysouris;
                       if bouton_gauche and
                       (x>20) and (x<60) and (y in [0..80]) then lampedanger;
                       if bouton_gauche and
                       (x>80) and (x<600) and (y in [0..40]) then armoires_cuisine;
                       if bouton_gauche and
                       (x>160) and (x<480) and (y in [110..180]) then table;
    until bouton_droit;
end;

procedure chambre;
begin
cache_souris;
cleardevice;
setcolor(blue);
setbkcolor(red);
moveto(30,180);lineto(30,120);
lineto(40,120);
lineto(40,180);
lineto(40,160);
lineto(160,160);
lineto(160,180);
lineto(170,180);
lineto(170,140);
lineto(160,140);
lineto(160,160);
lineto(40,130);
setfillstyle(1,blue);
floodfill(60,150,blue);
setcolor(3);
moveto(140,0);lineto(140,50);
circle(140,60,10);
setfillstyle(1,3);
floodfill(140,60,3);
setcolor(2);
moveto(200,120);lineto(200,180);
lineto(250,180);
lineto(250,120);
lineto(200,120);
moveto(210,130);lineto(240,130);
lineto(240,140);
lineto(210,140);
lineto(210,130);
putpixel(225,135,1);
moveto(210,150);lineto(210,160);
lineto(240,160);
lineto(240,150);
lineto(210,150);
putpixel(225,155,1);
setfillstyle(11,2);
floodfill(220,170,2);
outtextxy(0,5,'Pointez ce que vous voulez examiner ... ');
montre_souris;
             repeat
               x:=XSouris;
               y:=YSouris;
                     if bouton_gauche and
                     (x>60) and (x<340) and (y in [120..180]) then lit;
                     if bouton_gauche and
                     (x>400) and (x<500) and (y in[120..180]) then meuble;
until bouton_droit;
end;

procedure lampe;
begin
cache_souris;
cleardevice;
outtextXY(0,5,'Vous avez choisi la lampe. Vous montez');
outtextXY(0,20,'sur la table a repasser et vous tombez');sound (220);
delay (2000);
Nosound;
outtextXY(0,35,'sur la bibliotheque. Vous decouvrez un');
outtextXY(0,50,'livre interessant que vous prenez. ');
outtextXY(0,65,'Vous decouvrez un passage derriere la ');
outtextXY(0,80,'bibliotheque.  ');
outtextXY(0,95,'   VOULEZ-VOUS PRENDRE CE PASSAGE ?');
setcolor(3);
livre:=true;
moveto(5,115);lineto(5,130);
lineto(20,130);
lineto(20,115);
lineto(5,115);
moveto(240,115);lineto(255,115);
lineto(255,130);
lineto(240,130);
lineto(240,115);
outtextXY(0,145,'OUI');
outtextXY(235,145,'NON');
montre_souris;
    repeat
        x:=Xsouris;
        y:=Ysouris;
                if bouton_gauche and
                (x>10) and (x<40) and (y in [115..130]) then passage;
                if bouton_gauche and
                (x>480) and (x<500) and (y in [115..130]) then jeu;
    until bouton_droit;
end;

procedure saladier;
var hasard:integer;
begin
cache_souris;
Cleardevice;
setcolor(1);
setBKcolor(1);
OuttextXY(0,5,'Vous avez choisi le saladier. Vous ');
outtextXY(0,20,'ne voyez que de la salade.');
randomize;
hasard:=random(100);
if hasard>50 then
       begin
       outtextXY(0,35,'Vous remarquez de bizarres ecritures');
       if livre then
             begin
             outtextXY(0,50,'Grace a votre livre vous dechiffrez:');
             outtextXY(0,65,'passage.... derriere.... bibliotheque');
             ch:=readkey;jeu;
             end
           else
             begin
             outtextXY(0,50,'Vous n''arrivez pas a les dechiffrer.');
             ch:=readkey;jeu;
             end
       end
     else
       begin
       outtextXY(0,35,'A part ca il n''y a rien d''autre.');
       ch:=readkey;jeu;
       end;
end;

procedure final;
var quest:string;
    code:string;
    der:string;
    chouette:string;
begin
cache_souris;
cleardevice;
setBKcolor(0);
setcolor(1);
outtextXY(0,5,'La piece est obscure. ');
outtextXY(0,20,'Ou voulez vous aller ?');
{petits carres directionnel}
moveto(40,80);lineto(40,100);
lineto(60,100);
lineto(60,80);
lineto(40,80);
moveto(100,80);lineto(100,100);
lineto(120,100);
lineto(120,80);
lineto(100,80);
moveto(160,80);lineto(160,100);
lineto(180,100);
lineto(180,80);
lineto(160,80);
moveto(220,80);lineto(220,100);
lineto(240,100);
lineto(240,80);
lineto(220,80);
outtextXY(0,60,'    Nord    sud     est    ouest');
montre_souris;
             repeat
                x:=Xsouris;
                y:=YSouris;
                   if bouton_gauche and
                   (x>320) and (x<360) and (y in [80..100]) then
                          begin
                          cache_souris;
                          cleardevice;
                          setcolor(3);
                          setBKcolor(2);
                          outtextXY(0,5,'Tiens, il y a un drap,c''est un fantome!');
                          if surprise then
                               begin
                               outtextXY(0,20,'Vous ouvrez votre boite a surprise et ');
                               outtextXY(0,35,'le fantome la detruit d''un seul coup.');
                               outtextXY(0,50,'mais il disparu ...');
                               surprise:=false;
                               ch:=readkey;
                               jeu;
                               end
                            else
                               begin
                               outtextXY(0,20,'Le fantome se precipite sur vous !! ');
                               if pain then
                                   begin
                                   outtextXY(0,35,'Le fantome dit ®Abracadabradrill ...¯');
                                   outtextXY(0,50,'Malheur, tout vos objet sont retournes');
                                   outtextXY(0,65,'a leur place ! ! ! ! ! ! ! !');
                                   tout_false;
                                   end
                                 else
                                   begin
                                   outtextXY(0,35,'Il vous attrape et vous pose une ques-');
                                   outtextXY(0,50,'tion :');
                                   outtextXY(0,65,'® Qu''est que c''est q''un rhinoceros ??');
                                   outtextXY(0,80,'€a commence par un C ...¯');
                                   gotoXY(1,150);
                                   readln(quest);
                                   if quest='coleoptere' then
                                            begin
                                            outtextXY(0,95,'® Tres bien vous pouvez passez.');
                                            outtextXY(0,110,'Attendez quel est le code ? ¯');
                                            readln(code);
                                            if code=textehasard then
                                               begin
                                               outtextXY(0,125,'® Toutes mes felicitations !! ');
                                               outtextXY(0,140,'Vous avez gagne !!! ¯');
                                               ch:=readkey;
                                               cleardevice;
                                               outtextXY(0,5,'Voulez-vous rejouer ?');
                                               gotoXY(1,150);
                                               read(der);
                                               if der='oui' then
                                                       begin
                                                       tout_false;
                                                       end;
                                               if der='bilan' then bilan;
                                               if der='non' then
                                                       begin
                                                       outtextXY(0,35,'  Dommage, Au revoir ...');
                                                       end;

                                            end
                                         else
                                            begin
                                            outtextXY(0,125,'Le fantome vous etouffe ...');
                                            ch:=readkey;
                                            mort;
                                            end;
                                   end
                                 else
                                  begin
                                  outtextXY(0,95,' Le fantome vous etouffe ...');
                                  ch:=readkey;mort;
                                  end;
                              end;
                          end;
                     end;
                   if bouton_gauche and
                   (x>440) and (x<480) and (y in [80..100]) then
                         begin
                         cache_souris;
                         cleardevice;
                         setcolor(1);
                         setBKcolor(1);
                         outtextXY(0,5,'Vous avancez. Subitement, MILLE SIX ');
                         outtextXY(0,20,'CENTS SEIZE vampires apparurent ... ');
                         randomize;
                         hasard:=random(50);
                         if (hasard>25) and (baguette) then
                            begin
                            outtextXY(0,35,'Votre baguette magique tombe de votre ');
                            outtextXY(0,50,'poche. Aussi soudainement qu''ils ');
                            outtextXY(0,65,'etaient venus, les 1616 vampires dis-');
                            outtextXY(0,80,'parurent ... sans doute a cause de la ');
                            outtextXY(0,95,'baguette magique ... ');
                            ch:=readkey;
                            jeu;
                            end
                           else
                            begin
                            outtextXY(0,35,'Ils vous tuent ... ... ... ');
                            ch:=readkey;mort;
                            end;
                         end;
                   if bouton_gauche and
                   (x>200) and (x<240) and (y in [80..100]) then
                         begin
                         cache_souris;
                         cleardevice;
                         setcolor(1);
                         setBKcolor(1);
                         outtextXY(0,5,'Trois vampires surgirent ...');
                         randomize;
                         hasard:=random(50);
                         if hasard>25 then
                            begin
                            if epee then
                                    begin
                                    outtextXY(0,20,'Vous en tuez deux le troisieme s''echap-');
                                    outtextXY(0,35,'pe avec votre epee que vous avez essaye ');
                                    outtextXY(0,50,'de lui planter dans la tete ...');
                                    ch:=readkey;
                                    epee:=false;
                                    jeu;
                                    end
                                  else
                                    begin
                                    outtextXY(0,20,'Sans epee comment combattre les vampi-');
                                    outtextXY(0,35,'res ... ');
                                    ch:=readkey;mort;
                                    end;
                            end
                          else
                            begin
                            outtextXY(0,20,'Vous vous battez et en tuez deux, ');
                            outtextXY(0,35,'le troisieme s''en va chercher de ');
                            outtextXY(0,50,'l''aide. L''armee de vampire vous ');
                            outtextXY(0,65,'attaque et vous tue ... ');
                            mort;
                            end;
                         end;
                   if bouton_gauche and
                   (x>80) and (x<120) and (y in [80..100]) then
                          begin
                          cache_souris;
                          cleardevice;
                          setcolor(2);
                          setBKcolor(2);
                          outtextXY(0,5,'Un fantome vous arrete et vous pose une ');
                          outtextXY(0,20,'question :');
                          outtextXY(0,50,'® Que mange la chouette ?¯ (Mettez la re-');
                          outtextXY(0,65,'ponse au singulier et sans article SVP.)');
                          gotoXY(1,1);
                          readln(chouette);
                          if(chouette='campagnol')or(chouette='souris')or(chouette='rongeur')then
                            begin
                            outtextXY(0,80,'®Bien,prenez cette porte la.¯ Vous pre-');
                            outtextXY(0,95,'nez la porte indiquez et ... il vous ');
                            outtextXY(0,110,'etouffe ...');
                            ch:=readkey;mort;
                            end
                          else
                            begin
                            outtextXY(0,80,'®Toute mes felicitations vous avez gagne');
                            outtextXY(0,95,'20 coups de baton ! !¯. Et il vous donna');
                            outtextXY(0,110,'21 coups de baton ...');ch:=readkey;mort;
                            end;
                          end;
until bouton_droit;
end;

procedure passage;
begin
cache_souris;
cleardevice;
setBKcolor(1);
setcolor(3);
outtextXY(0,5,'Vous trouvez, au bout du passage, un ');
outtextXY(0,20,'tuyau d''arrosage.');arrosage:=true;
ch:=readkey;jeu;
end;

procedure salon;
begin
montre_souris;
cache_souris;
cleardevice;
{pot de l'arbre en jaune}
setcolor(3);
moveto(60,140);lineto(60,100);
lineto(20,100);
lineto(20,140);
lineto(60,140);
setfillstyle(1,3);
floodfill(40,120,3);
{arbre en vert}
setcolor(1);
moveto(40,100);lineto(40,57);
circle(40,40,20);
setfillstyle(9,1);
floodfill(40,40,1);
{dessin du feu}
setcolor(2);
moveto(100,140);lineto(100,80);
lineto(220,80);
lineto(220,140);
lineto(100,140);
moveto(110,140);lineto(120,120);
lineto(130,130);
lineto(140,100);
lineto(150,120);
lineto(160,90);
lineto(170,120);
lineto(180,90);
lineto(190,130);
lineto(200,120);
lineto(210,130);
lineto(220,100);
setfillstyle(1,2);
floodfill(160,130,2);
moveto(100,80);lineto(100,70);
lineto(220,70);
lineto(220,80);
{dessin de la t‚l‚ en vert}
setcolor(1);
moveto(140,70);lineto(140,60);
lineto(130,60);
lineto(130,10);
lineto(190,10);
lineto(190,60);
lineto(140,60);
lineto(180,60);
lineto(180,70);
lineto(180,10);
moveto(140,20);lineto(170,20);
lineto(170,50);
lineto(140,50);
lineto(140,20);
setfillstyle(1,1);
floodfill(175,40,1);
putpixel(185,20,3);
putpixel(185,30,3);
putpixel(185,40,3);
{dessin de la lampe}
setcolor(3);
moveto(260,0);lineto(260,40);
circle(260,50,10);
setfillstyle(1,3);
floodfill(260,50,3);
if feu then suite else aufeu;
end;

procedure lampedanger;
begin
cache_souris;
cleardevice;
randomize;
hasard:=random(20);
if hasard>10 then
         begin
         outtext('La lampe explose. Vous etes mort ');
         ch:=readkey;mort;
         end
     else
         begin
         outtextXY(0,75,'La lampe explose. Vous vous sauvez par');
         outtextXY(0,90,'             la porte ');
         ch:=readkey;
         jeu;
         end;
end;

procedure armoires_cuisine;
begin
cache_souris;
cleardevice;
{dessin des armoires}
setcolor(1);
moveto(40,0);lineto(300,0);
lineto(300,40);
lineto(40,40);
lineto(40,0);
lineto(100,0);
lineto(100,40);
lineto(160,40);
lineto(160,0);
lineto(200,0);
lineto(200,40);
lineto(240,40);
lineto(240,0);
lineto(240,20);
lineto(40,20);
circle(270,20,1);
circle(220,10,1);
circle(180,10,1);
circle(120,10,1);
circle(70,10,1);
circle(220,30,1);
circle(220,30,1);
circle(180,30,1);
circle(120,30,1);
circle(70,30,1);
setfillstyle(11,3);
floodfill(260,20,1);
floodfill(210,10,1);
floodfill(170,10,1);
floodfill(110,10,1);
floodfill(90,10,1);
floodfill(210,30,1);
floodfill(170,30,1);
floodfill(110,30,1);
floodfill(90,30,1);
outtextXY(0,80,'Pointez le placard que vous voulez exa-');
outtextXY(0,95,'miner ...');
montre_souris;
   repeat
         x:=XSouris;
         y:=YSouris;
             if bouton_gauche and
             (x>480) and (x<600) and (y in [0..40]) then
                     begin
                     outtextXY(0,110,'Bien entendu on prend le plus gros en');
                     outtextXY(0,125,'pensant que ce sera le plus interresant.');
                     outtextXY(0,140,'Vous y trouvez une boite a surprise.');
                     outtextXY(0,155,'Je ne sais pas si c''est interresant pour');
                     outtextXY(0,170,'vous mais ce ne l''est pas pour moi ...');
                     surprise:=true;
                     ch:=readkey;
                     jeu;
                     end;
             if (bouton_gauche and
             (x>80) and (x<200) and (y in [0..40])) or
             (bouton_gauche and
             (x>320) and (x<400) and (y in [0..20])) then
                     begin
                     outtextXY(0,110,'Huuumm, ce placard a l''air vide.');
                     randomize;
                     hasard:=random(50);
                     if (hasard>30) and (vue) then
                              begin
                              outtextXY(0,125,'Tiens,il y a une feuille ou il y a ecrit ');
                              setcolor(2);
                              randomize;
                              codehasard:=random(32000);
                              str(codehasard,textehasard);
                              outtextXY(0,140,'   CODE: '+ textehasard);
                              setcolor(1);
                              outtextXY(0,155,'Vous gardez ce papier au cas ou ...');
                              papier:=true;
                              ch:=readkey;
                              jeu
                              end
                         else
                              begin
                              outtextXY(0,125,'Et il est vide !! ');
                              ch:=readkey;
                              jeu
                              end;
                     end;
             if (bouton_gauche and
             (x>200) and (x<320) and (y in [0..40])) or
             (bouton_gauche and
             (x>320) and (x<400) and (y in [20..40])) then
                     begin
                     outtextXY(0,110,'Vous n''y trouvez qu''une boite a sur-');
                     outtextXY(0,125,'prise. Vous l''ouvrez, un fantome sort');
                     outtextXY(0,140,'de la boite et vous envoie une poudre ');
                     outtextXY(0,155,'mortelle ... ... ... ... ... ... ... .');
                     ch:=readkey;mort;
                     end;
             if bouton_gauche and
             (x>400) and (x<480) and (y in [0..40]) then
                     begin
                     outtextXY(0,110,'Tiens, tiens ! Il y a quelque chose. ');
                     randomize;
                     hasard:=random(20);
                     if hasard<=5 then
                        begin
                        outtextXY(0,125,'Un espece de fusil qui contient un');
                        outtextXY(0,140,'liquide gluant. Dessus (sur le fusil');
                        outtextXY(0,155,'pas sur le liquide), il y a de droles');
                        outtextXY(0,170,'ecritures: Chasse fantome. ');
                        outtextXY(0,185,'Ps: Il n''est pas charge. Il faut le ');
                        ch:=readkey;
                        cache_souris;
                        cleardevice;
                        outtextXY(0,5,'charger avec de la boue avec 3 arbres ');
                        outtextXY(0,20,'maches par une fourmi et ....... ');
                        outtextXY(0,35,'Vous n''allez quand meme pas le prendre');
                        outtextXY(0,50,'ce fusil. De plus en plus petites let-');
                        outtextXY(0,65,'tres il y a: Si ce fusil n''est pas ');
                        outtextXY(0,80,'charge il vous portera malchance !! ');
                        ch:=readkey;
                        jeu;
                        end
                     else
                        begin
                        outtextXY(0,125,'Non, il n''y a que de la poussiere ...');
                        ch:=readkey;
                        jeu;
                        end;
                     end;
until bouton_droit;
end;

procedure table;
begin
cache_souris;
cleardevice;
setcolor(1);
setBKcolor(1);
outtextXY(0,5,'Vous avez choisi la table. ');
randomize;
hasard:=random(50);
if hasard>25 then
              begin
              setcolor(2);
              outtextXY(0,20,'Vous remarquez un petit tiroir. Mais ');
              outtextXY(0,35,'vous n''arrivez pas a l''ouvrir. Au  ');
              outtextXY(0,50,'bout d''un moment il commence a ceder');
              outtextXY(0,65,'et il s''ouvrit brusquement. Il n''y ');
              outtextXY(0,80,'a qu''une boite a surprise que vous  ');
              outtextXY(0,95,'prenez en faisant la grimace ...');
              surprise:=true;
              ch:=readkey;
              jeu;
              end
          else
              begin
              setcolor(2);
              setBKcolor(red);
              outtextXY(0,20,'Vous remarquez un petit tiroir qui  ');
              outtextXY(0,35,'s''ouvrit et qui laissa echapper une');
              outtextXY(0,50,'epece fumee rouge. Cette fumee etait');
              outtextXY(0,65,'une poudre mortelle ...');
              ch:=readkey;mort;
              end;
end;

procedure sallemanger;
begin
cache_souris;
cleardevice;
setfillstyle(1,1);
setBKcolor(3);
setcolor(2);
{dessin de la table}
moveto(40,180);lineto(40,90);
lineto(220,90);
lineto(220,180);
lineto(200,180);
lineto(200,100);
lineto(60,100);
lineto(60,180);
lineto(40,180);
{remplissage en jaune de la table}
setfillstyle(1,3);
floodfill(50,150,2);
{dessin de la chaise en vert}
setcolor(1);
moveto(230,180);lineto(230,130);
lineto(240,130);
lineto(240,180);
lineto(240,130);
lineto(280,130);
lineto(280,80);
lineto(290,80);
lineto(290,180);
lineto(280,180);
lineto(280,140);
lineto(240,140);
{dessin de la lampe}
moveto(240,0);lineto(240,50);
setcolor(2);
circle(240,60,10);
floodfill(240,60,2);
{saladier en rouge coloriage vert}
moveto(40,60);lineto(50,90);
lineto(100,90);
lineto(110,60);
lineto(40,60);
setfillstyle(1,1);
floodfill(80,80,2);
{vase}
setcolor(1);
moveto(120,90);lineto(120,70);
lineto(140,70);
lineto(140,90);
lineto(120,90);
{fleur}
moveto(130,70);lineto(130,60);
lineto(120,40);
setcolor(2);
circle(120,30,10);
floodfill(120,30,2);
outtextXY(0,185,'Pointez ce que vous voulez examiner');
montre_souris;
 repeat
      x:=Xsouris;
      y:=Ysouris;
          if bouton_gauche and
          (x>80) and (x<220) and (y in [60..90]) then saladier;
          if bouton_gauche and
          (x>200) and (x<280) and (y in [20..90]) then fleur;
          if bouton_gauche and
          (x>460) and (x<500) and (y in [0..70]) then lampe2;
 until bouton_droit;
end;

procedure lit;
begin
cache_souris;
cleardevice;
outtextxy(0,5,'Sur lui, il y a 3 ou 4 couvertures mais');
outtextXY(0,20,'rien d''interessant. Vous examinez le ');
outtextxy(0,35,'lit sous toutes ses coutures mais rien');
outtextXY(0,50,'d''interessant. Vous regardez sous le ');
outtextxy(0,65,'lit puis sous les couvertures. ');
randomize;
hasard:=random(50);
if hasard>20 then
                 begin
                 outtextXY(0,80,'Vous n''y trouvez qu''un morceau de pain.');
                 pain:=true;
                 ch:=readkey;
                 jeu;
                 end
          else
                 begin
                 outtextXY(0,80,'Un enorme vampire surgit.  Vous n''avez ');
                 outtextXY(0,95,'pas le temps de reagir. Il vous mord et');
                 outtextXY(0,110,'vous tombez au sol ... ');
                 ch:=readkey;mort;
                 end;
end;

procedure meuble;
begin
cache_souris;
cleardevice;
setcolor(1);
setBKcolor(2);
{contour du meuble}
moveto(100,0);lineto(240,0);
lineto(240,180);
lineto(100,180);
lineto(100,0);
{premier tiroir}
moveto(120,30);lineto(220,30);
lineto(220,70);
lineto(120,70);
lineto(120,30);
circle(170,50,5);
{deuxieme}
moveto(120,110);lineto(220,110);
lineto(220,150);
lineto(120,150);
lineto(120,110);
circle(170,130,5);
{remplissages}
setfillstyle(11,1);
floodfill(150,100,1);
setfillstyle(1,2);
floodfill(170,50,1);
floodfill(170,130,1);
outtextXY(0,185,'Pointez un des tiroirs.');
montre_souris;
       repeat
          x:=Xsouris;
          y:=Ysouris;
              if bouton_gauche and
              (x>240) and (x<440) and (y in [30..70]) then
                       begin
                       cache_souris;
                       cleardevice;
                       setBKcolor(1);
                       outtextXY(0,5,'Huum, ce tiroir a l''air vide, mais vous');
                       outtextXY(0,20,'regardez quand meme l''interieur. ');
                       sound(80);
                       outtextXY(0,35,'Catastrophe, le plafond s''effondre ...');
                       ch:=readkey;
                       delay(10);
                       Nosound;
                       mort;
                       end;
              if bouton_gauche and
              (x>240) and (x<440) and (y in [110..150]) then
                       begin
                       cache_souris;
                       cleardevice;
                       setBKcolor(1);
                       outtextXY(0,5,'Tiens, tiens ! Il y a des papier. ');
                       outtextXY(0,20,'Des papiers d''identite. Vous ');
                       outtextXY(0,35,'observez longuement et vous vous');
                       outtextXY(0,50,'apercevez que ces papiers appar-');
                       outtextXY(0,65,'tiennent a un vampire. J''ai bien');
                       outtextXY(0,80,'dit a un VAMPIRE !!!!!!!!!!!!!!!');
                       outtextXY(0,95,'Vous entendez soudain un bruit ');
                       sound(20);
                       outtextXY(0,110,'de mitraillette. MALHEUR !!!!!');
                       outtextXY(0,125,'Un vampire surgit, puis deux, ');
                       outtextXY(0,145,'puis quatre, puis ... une armee');
                       outtextXY(0,160,'entiere !!!!!!!!!!!!!!!!!!!!!!!');
                       outtextXY(0,175,'L''armee de vampires se precipita');
                       ch:=readkey;
                       cleardevice;
                       outtextXY(0,5,'sur vous. Une balle vous trans- ');
                       outtextXY(0,20,'persa le coeur. Vous etes mort ...');
                       ch:=readkey;
                       Nosound;
                       mort;
                       end;
until bouton_droit;
end;

procedure tout_false;
begin
epee:=false; {true}
baguette:=false;
livre:=false;
bouclier:=false;
pompe:=false;
arrosage:=false;
vue:=false;
papier:=false;
feu:=false;
morts:=false;
pain:=false;
surprise:=false;
ch:=readkey;
jeu;
end;

procedure grenier;
begin
cache_souris;
Cleardevice;
setBKcolor(1);
{contour de la piŠce}
setcolor(1);
moveto(140,0);lineto(20,40);
lineto(20,140);
lineto(300,140);
lineto(300,40);
lineto(200,0);
{la bibliothŠque et les livres}
setcolor(2);
moveto(260,140);lineto(260,60);
lineto(300,60);
lineto(290,60);
lineto(290,120);
lineto(280,120);
lineto(280,60);
moveto(270,80);lineto(270,120);
lineto(300,120);
lineto(260,120);
lineto(260,100);
lineto(300,100);
lineto(300,80);
lineto(260,80);
moveto(300,140);lineto(300,60)
{couleurs des livres};
floodfill(265,110,2);
floodfill(275,110,2);
floodfill(285,110,2);
floodfill(295,110,2);
floodfill(265,90,2);
floodfill(275,90,2);
floodfill(285,90,2);
floodfill(295,90,2);
floodfill(285,70,2);
floodfill(295,70,2);
{lampe}
setcolor(3);
moveto(170,0);lineto(170,40);
setcolor(2);
circle(170,50,10);
{tonneau}
setcolor(3);
moveto(60,140);lineto(20,140);
lineto(20,100);
lineto(60,100);
lineto(60,130);
lineto(70,130);
lineto(70,135);
lineto(65,135);
lineto(65,133);
lineto(60,133);
lineto(60,140);
lineto(60,130);
lineto(20,130);
lineto(20,120);
lineto(60,120);
lineto(60,110);
lineto(20,110);
{table … repasser}
setcolor(1);
moveto(20,100);lineto(80,100);
lineto(110,140);
lineto(120,140);
lineto(90,100);
lineto(120,100);
lineto(120,90);
lineto(20,90);
lineto(20,100);
{fer … repasser}
setcolor(2);
moveto(110,70);lineto(120,70);
lineto(120,90);
lineto(100,90);
lineto(100,80);
setcolor(1);
lineto(100,75);
lineto(110,75);
lineto(110,80);
setcolor(2);
lineto(100,80);
lineto(120,80);
SetColor(3);
outtextXY(0,155,'Pointez ce que vous voulez examiner.');
montre_souris;
   repeat
x:=Xsouris;
y:=Ysouris;
   if bouton_gauche and
   (x>320) and (x<360) and (Y in [0..60]) then lampe;
   if bouton_gauche and
   (x>520) and (x<600) and (Y in [60..140]) then bibliotheque;
   if bouton_gauche and
   (x>40) and (x<240) and (Y in [60..100]) then fer;
   if bouton_gauche and
   (x>40) and (x<120) and (Y in [100..140]) then tonneau;
   until bouton_droit;
end;

begin
ClrScr;
epee:=false; {true}
baguette:=false;
livre:=false;
bouclier:=false;
morts:=false;
pompe:=false;
arrosage:=false;
vue:=false;
papier:=false;
feu:=false;
pain:=false;
surprise:=false;
randomize;
codehasard:=random(3200);
if not(souris_active) then   begin
                              repeat
                              textcolor(red+blink);
                              textbackground(white);
                              highvideo;
                              gotoXY(1,1);
                              write('Attention, la SOURIS est mal branch‚e ou mal activ‚e ... ');
                              until keypressed;
                              exit;
                             end;
  textcolor(2);
  highvideo;
  textbackground(red);
  writeln('Ce jeu est … peu prŠs celui de la maison hant‚e. Sauf que c''est dans un ');
  writeln('manoir. Contrairement … la maison hant‚e, vous n''aurez pas … vous battre ');
  writeln('contre avec les d‚s. Ex: Un fantome vous attaque. (disons que vous avez une');
  writeln('‚p‚e magique) Mais grace a votre epee magique, vous le tuez. (Vous avez sans');
  writeln('doute remarqu‚ qu''il n''y a pas d''ACCENTS.)');
  textbackground(0);
  textcolor(brown);
  writeln('');
  writeln('PS : A la fin, que vous ayez gagne ou non, vous pouvez demandez votre bilan ');
  writeln('     quand l''ordinateur vous demande si vous voulez rejouer. Pour cela, ');
  writeln('     tapez bilan ... ');ch:=readkey;

  graphdriver:=cga;
  initgraph(graphdriver,graphmode,'');
  seTtextStyle(3,0,1);
  setgraphmode(0);
  amplitude_x(0,getmaxx*2-2);amplitude_y(0,getmaxy);
  jeu;
  CloseGraph;
  end.
