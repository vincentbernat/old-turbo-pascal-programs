uses crt,graph,titre;
var graphdriver:integer;
    graphmode:integer;
    nom:string;
    ch:char;
    enter:string;
    solution:string;
    reponse:string;
    cHoIx7:string;

procedure chambre;
forward;
procedure salon;
forward;
procedure hall;
forward;
procedure couloir;
forward;
procedure cuisine;
forward;
procedure cave;
forward;
procedure caisse;
forward;
procedure tonneau;
forward;
procedure manette;
forward;
procedure vide;
forward;
procedure passsecret;
forward;
procedure obs;
forward;
procedure mort;
forward;
procedure triomphe;
forward;


procedure mort;
var serse:string;
begin
Cleardevice;
setbkcolor(1);
setcolor(1);
outtextxy(100,50,'Vous etes mort...');
outtextXY(100,100,'Voulez-vous rejouer?');
readln(serse);
if (serse='OUI') or (serse='oui') then hall;
if (serse='NON') or (serse='non') then
                  begin
                  outtextxy(120,170,'Au revoir');ch:=readkey;
                  Halt;
                  end;
end;

procedure triomphe;
var question:string;
begin
Cleardevice;
setcolor(1);
setBKcolor(1);
outtextXY(60,40,'BRAVO ! ! !');
outtextXY(0,70,'Voulez-vous rejouer ?');
readln(question);
if (question='OUI') or (question='oui') then hall;
if (question='NON') or (question='non') then
                                            begin
                                            outtextXY(100,100,'Au revoir ...');
                                            ch:=readkey;
                                            Halt;
                                            end;
end;

procedure canape;
var choix:char;
begin
Cleardevice;
setbkcolor(3);
outtextXY(0,5,'Tu t''asseois sur le canape et tu allumes');
outtextXY(0,20,'la television.Il est exactement l''heure des');
outtextXY(0,35,'infos. Ils font un reportage sur les fan-');
outtextXY(0,50,'tomes. Au moment ou ils allaient montrer');
outtextXY(0,65,'comment tuer les fantomes, un fantome ');
outtextXY(0,80,'surgit devant vous. Lance un de et si le');
outtextXY(0,95,'total est entre 1 et 3 tapez 1 sinon');
outtextXY(0,110,'tapez 2');
choix:=readkey;
if (choix='1') then
      begin
      outtextXY(0,125,'Ouf vous avez echappe a ce maudit fan-');
      outtextXY(0,140,'tome! Et quand vous vous etes remis de ');
      outtextXY(0,155,'vos frayeurs, vous decouvrez un vase en');
      outtextXY(0,170,'porcelaine. Maintenant vous vous dirigez');
      outtextXY(0,185,'vers la porte.');ch:=readkey;couloir;
      end;
if (choix='2') then
        begin
        outtextXY(0,125,'Le fantome vous etouffe');ch:=readkey;mort;
        end;
end;
procedure porte;
begin
cleardevice;
outtextXY(0,5,'Vous ouvrez la porte et ...');ch:=readkey;vide;
end;

procedure cuisine;
var cuisin:char;
begin
Cleardevice;
setbkcolor(2);setcolor(3);
moveto(320,0);lineto(320,150);
lineto(0,150);
lineto(0,0);
lineto(360,0);
moveto(0,50);lineto(260,50);lineto(260,0);
lineto(160,0);
lineto(160,50);
lineto(160,0);
lineto(60,0);
lineto(60,50);
lineto(60,0);
moveto(320,70);lineto(300,70);
lineto(300,110);
lineto(240,110);
lineto(240,150);
moveto(60,150);lineto(60,100);
lineto(40,100);
lineto(40,95);
lineto(200,95);
lineto(200,100);
lineto(180,100);
lineto(180,150);
lineto(160,150);
lineto(160,100);
lineto(80,100);
lineto(80,150);
moveto(200,20);lineto(180,20);
lineto(180,30);lineto(200,30);lineto(200,20);
moveto(110,20);lineto(80,20);
lineto(80,30);lineto(110,30);lineto(110,20);
moveto(20,20);lineto(0,20);
lineto(0,30);lineto(20,30);lineto(20,20);
outtextXY(0,100,'porte');
outtextXY(0,145,'Allez-vous 1)Sortir par la porte ');
outtextxy(0,160,'          2)Ouvrir les armoires   ');
outtextxy(0,175,'      3) Vous assoir sur la banquette?');
readln(cuisin);
if (cuisin='1') then obs;
if (cuisin='2') then
  begin
  cleardevice;
  outtextXY(0,5,'Vous ouvrez les armoire une a une, mais');
  outtextXY(0,20,'dedans il n''y avait rien. Vous allez a');
  outtextXY(0,35,'la porte ...');ch:=readkey;porte;
  end;
if (cuisin='3') then passsecret;
   begin
   end;
end;

procedure obs;
var proche:string;
begin
cleardevice;
setbkcolor(0);
setcolor(2);
outtextXY(0,5,'Voulez-vous aller au nord 1) au sud 2)');
outtextXY(0,20,'   A l''est 3) a l''ouest 4)');
readln(proche);
if (proche='2') then
            begin
            outtextXY(5,35,'un fantome vous etouffe');ch:=readkey;mort;
            end;
if (proche='4') then
           begin
           triomphe;
           end;
if (proche='3') then
              begin
              outtextXY(5,35,'un fantome vous etouffe');ch:=readkey;mort;
              end;
if (proche='1') then
           begin
           outtextXY(5,35,'un fantome vous etrangle');ch:=readkey;mort;
           end;
end;
procedure cave;
var frappe:string;
begin
cleardevice;
outtextXY(0,5,'Tout a coup l''echelle se brise.........');ch:=readkey;
cleardevice;
setbkcolor(1);
moveto(40,105); lineto(80,105);
lineto(80,120);
lineto(40,120);
lineto(40,105);
moveto(40,108);lineto(80,108);
lineto(80,110);
lineto(40,110);
moveto(160,105);lineto(130,105);
lineto(130,120);
lineto(160,120);
lineto(160,105);
moveto(200,105);lineto(200,120);
lineto(230,120);
lineto(230,105);
lineto(200,105);
setbkcolor(2);
moveto(205,10);
lineto(210,15);
lineto(240,10);
moveto(200,10);lineto(210,20);
lineto(240,15);
moveto(60,105);lineto(60,120);
moveto(130,105);lineto(140,100);
lineto(170,100);
lineto(170,120);
lineto(170,100);
lineto(160,105);
moveto(200,105);lineto(210,100);
lineto(240,100);
lineto(230,105);
moveto(190,10);
lineto(220,25);
lineto(240,20);
moveto(20,10);lineto(240,10);
lineto(240,120);
lineto(20,120);
lineto(20,10);
outtextxy(100,10,'porte');
outtextXY(0,120,'Allez-vous 1) fouiller les caisses');
outtextXY(0,135,'2) Boire le vin que le tonneau contient');
outtextXY(0,150,'           3) ou sortir par le porte?');
readln(frappe);
if (frappe='1') then caisse;
if (frappe='2') then tonneau;
if (frappe='3') then vide;
end;

procedure caisse;
var frappe:string;
    de:string;
begin
Cleardevice;
setBKcolor(3);
setcolor(1);
outtextXY(0,5,'Vous y trouvez des tas d''OBJETS en tout');
outtextXY(0,20,'genre comme une veille lampe, une epee');
outtextXY(0,35,'rouillee, une statuette, un drap.....');
outtextXY(0,50,'Minute, le drap bouge, c''etait un fanto-');
outtextXY(0,65,'me. Avez-vous un CHASSE-FANTOME? Si oui');
outtextXY(0,80,'tapez 3 sinon tirez les des si vous obte-');
outtextXY(0,95,'nez 6 ou moins tapez 1 sinon tapez 2');
readln(de);
if (de='1') then
     begin
     outtextXY(0,110,'Le fantome vous etrangle...............');ch:=readkey;mort;
     end;
if (de='2')or(de='3') then manette;
end;

procedure passsecret;
var hfddgfhd:string;
begin
Cleardevice;
outtextXY(0,5,'Tout a coup le mur bouge, se deplace et');
outtextXY(0,20,'laisse place a un passage. Vous vous');
outtextXY(0,35,'faufilez dans le passage et continuez');
outtextXY(0,50,'tout droit. Tout a coup un fantome');
outtextXY(0,65,'surgit devant vous. Vous etes pris au');
outtextXY(0,80,'piege. Mais au lieu de vous faire quel-');
outtextXY(0,95,'que chose il vous pose une question dans');
outtextXY(0,110,'un hurlement:"Certain(e) tissent leur');
outtextXY(0,125,'toile dans la maison". Avez vous un ');
outtextXY(0,140,'message? si oui tapez 1 sinon dite votre');
outtextXY(0,155,'reponse..........');
readln(hfddgfhd);
if (hfddgfhd='1') then
    begin
    cleardevice;
    outtextXY(0,5,'Tout a coup le message tombe de votre');
    outtextXY(0,20,'poche. Le fantome prend le message et');
    outtextXY(0,35,'le lit. Apres ceci il vous laisse passer');
    outtextXY(0,50,'Vous continuez tout droit. Tout a coup ');
    outtextXY(0,65,'une echelle apparait.Vous montez l''echel-');
    outtextXY(0,80,'le et vous vus trouvez dans le couloir');ch:=readkey;couloir
    end;
if (hfddgfhd='araign‚e') or (hfddgfhd='ARAIGNEE') or (hfddgfhd='araignee')then
    begin
    cleardevice;
    outtextXY(0,5,'Vous dites la reponse il vous laisse');
    outtextXY(0,35,'passer. Vous montez une echelle et');
    outtextXY(0,50,'vous vous retrouvez dans le couloir...');ch:=readkey;couloir;
    end;
if (hfddgfhd<>'araign‚e') or (hfddgfhd<>'ARAIGNEE') or (hfddgfhd<>'araignee') then mort;
end;

procedure vide;
var epee:string;
begin
Cleardevice;
setBKcolor(1);
setcolor(1);
outtextXY(0,5,'Vous ouvrez la porte et entrez dans une');
outtextXY(0,20,'piece obscure.Avez-vous une epee bleue?');
outtextXY(0,35,'Si oui tapez 1 sinon tapez 2');
readln(epee);
if (epee='1') then
   begin
   outtextXY(0,50,'Votre epee bleue scintille tellement');
   outtextXY(0,65,'que vous voyez bien que la piece est');
   outtextXY(0,80,'vide.Tout a coup la porte se ferme ');
   outtextXY(0,95,'toute seule. Maintenant vous etes');
   outtextXY(0,110,'prisonnier a jamais.................');ch:=readkey;mort;
   end;
if (epee='2') then
   begin
   outtextXY(0,50,'Vous ne vous attardez pas a vous');
   outtextXY(0,65,'apercevoir que vous etes prisonnier....');ch:=readkey;mort;
   end;
end;

procedure tonneau;
begin
Cleardevice;
setcolor(2);
setBKcolor(2);
outtextXY(0,5,'Vous vous avancez vers les tonneaux vous');
outtextXY(0,20,'les ouvrez, mais au lieu de trouver du ');
outtextXY(0,35,'vin vous trouvez une manette. Vous tirez');
outtextXY(0,50,'dessus mais il ne se passe rien. Tout a');
outtextXY(0,65,'coup,vous vous trouvez devant les ');
outtextXY(0,80,'caisses');ch:=readkey;caisse;
end;

procedure manette;
var direct:string;
begin
Cleardevice;
setBKcolor(1);
outtextXY(0,5,'Au fond de la caisse vous y trouvez une');
outtextXY(0,20,'manette. Allez-vous 1) Tirer sur la');
outtextXY(0,35,'  "      2) ou aller jusqu''au tonneau');
outtextXY(0,50,'      3) ou vous dirigez vers la porte?');
readln(direct);
if (direct='1') then passsecret;
if (direct='2') then tonneau;
if (direct='3') then vide;
end;



procedure couloir;
var manger:string;
    tape:string;
begin
cleardevice;
line(0,100,180,0);
line(60,140,280,0);
outtextXY(0,130,'Le couloir n''a rien de particulier');
outtextXY(0,145,'mais vous pouvez 1) Mieux chercher');
outtextXY(0,160,'               2) Continuer jusqu''une');
outtextXY(0,175,'                       porte.');
readln (manger);
if (manger='2') then
   begin
   Cleardevice;
   outtextXY(0,5,'Vous n''y trouvez point de porte. Si vous');
   outtextXY(0,20,'possedez l''epee bleue tapez 1 sinon 2.');
   readln (tape);
   if (tape='1') then
      begin
      outtextXY(0,35,'Tout a coup un fantome le plus cruel');
      setbkcolor(2);
      outtextXY(0,50,'de tous apparait. Grace a votre epee ');
      outtextXY(0,65,'bleue il disparait aussitot.Tout a coup');
      outtextXY(0,80,'vous apercevez une porte. Vous vous');
      outtextXY(0,95,'dirigez vers elle.');ch:=readkey;cuisine;
      end;
   if (tape='2') then
      begin
      outtextXY(0,35,'Tout a coup un fantome le plus cruel');
      setBKcolor(2);
      outtextXY(0,50,'de tous apparait et vous etrangle......');ch:=readkey;mort;
      end;
   end;
if (manger='1') then
   begin
   cleardevice;
   outtextXY(0,5,'Vous examinez mieux le couloir, il est');
   outtextXY(0,20,'fait de marbre. Tout a coup vous butez');
   outtextXY(0,35,'contre quelque chose: c''est un message.');
   outtextXY(0,50,'Tout … coup vous butez contre quelque ');
   outtextXY(0,65,'chose d''autre,cette fois c''est un anneau');
   outtextXY(0,80,'de trappe vous tirez dessus et tout a ');
   outtextXY(0,95,'coup la trappe s''ouvre vous descendez.');ch:=readkey;cave;
   end;
end;

procedure salon;
begin
Cleardevice;
outtext('salon');
Cleardevice;
setcolor(1);
moveto(142,40);lineto(70,40);
lineto(70,60);
lineto(142,60);
lineto(142,40);
lineto(142,70);
lineto(130,80);
lineto(120,80);
lineto(120,66);
lineto(128,60);
moveto(138,60);lineto(128,68);
lineto(120,66);
moveto(128,66);lineto(128,80);
moveto(120,76);lineto(80,76);
lineto(70,80);
lineto(70,64);
lineto(79,60);
lineto(70,60);
lineto(60,64);
lineto(60,80);
moveto(60,66);lineto(70,66);
moveto(70,68);lineto(120,68);
moveto(60,80);lineto(70,80);
setcolor(3);
moveto(80,100);lineto(80,140);
lineto(120,140);
lineto(120,100);
lineto(80,100);
lineto(100,100);
lineto(110,90);
lineto(100,100);
lineto(90,90);
moveto(90,110);lineto(90,130);
lineto(110,130);
lineto(110,110);
lineto(90,110);
outtextXY(70,5,'porte');
moveto(150,0);lineto(150,150);
lineto(0,150);
outtextXY(155,5,'Vas-tu:1) t''asseoir');
outtextXY(155,20,'sur le canape');
outtextXY(155,35,'ou 2) sortir par');
outtextXY(155,50,'la porte?');
readln(reponse);
if(reponse='1')then canape;
if(reponse='2')then couloir;
end;

procedure armoire;
var direction:string;
begin
Cleardevice;
setbkcolor(2);
outtext('Vous y trouvez une epee bleue.');
outtextXY(11,50,'Allez vous jusqu''a 1)la porte du nord');
outtextXY(11,70,'               2)La porte de l''est');
readln(direction);
if (direction='1') then chambre;
if (direction='2') then salon;
end;

procedure chambre;
var choix2:string;
var choix7:string;
begin
Cleardevice;
outtext('chambre');
cleardevice;
setbkcolor(1);
setcolor(2);
moveto(10,80);lineto(10,100);
lineto(20,100);
lineto(20,80);
lineto(130,80);
lineto(130,70);
lineto(10,70);
lineto(10,80);
lineto(120,80);
lineto(120,100);
lineto(130,100);
lineto(130,70);
lineto(20,60);
lineto(20,70);
lineto(20,50);
lineto(10,50);
lineto(10,80);
setcolor(1);
moveto(150,60);lineto(190,60);
lineto(190,100);
lineto(180,100);
lineto(180,70);
lineto(160,70);
lineto(160,100);
lineto(150,100);
lineto(150,60);
lineto(150,70);
lineto(190,70);
setcolor(3);
moveto(180,60);lineto(180,30);
lineto(140,30);
lineto(140,46);
lineto(150,46);
lineto(150,40);
lineto(170,40);
lineto(170,60);
moveto(142,46);lineto(142,52);
lineto(148,52);lineto(148,46);
outtextXY(0,125,'Vas-tu: 1) Allumer la lampe.');
outtextXY(0,140,'     2) Te coucher sur le lit.');
outtextXY(0,155,'  3) Aller en direction de la porte.');
outtextXY(255,60,'  porte');
outtextXY(0,170,'4) Fouiller la table de nuit.');
readln(choix2);
if(choix2='1') then
      begin
      Cleardevice;
      outtextXY(0,5,'Tu allumes la lampe et t''apercoit que');
      outtextXY(0,20,'la couverture qui etait sur le lit etait');
      outtextXY(0,35,'un fantome. En fouillant le tiroir de');
      outtextXY(0,50,'la table de nuit tu y trouves un CHASSE');
      outtextXY(0,65,'FANTOME! Tu te diriges vers la porte');ch:=readkey;couloir;
      end;
if(choix2='2')then
     begin
     cleardevice;
     outtext('La couverture etait un fantome qui');
     outtextXY(160,100,'t''etrangle');ch:=readkey;mort;
     end;
if(choix2='3') then couloir;
if(choix2='4') then
     begin
     cleardevice;
     setbkcolor(1);
     outtextXY(0,5,'Tu commences a fouiller la table');
     outtextXY(0,20,'quand un fantome surgit du lit');
     outtextXY(0,35,'et te laisse juste le temps de tirer le');
     outtextXY(0,50,'de. Si tu fais de 1 a 4 tape 1 sinon 2.');
     readln(cHoIx7);
     if(choix7='1')  then
          begin
          outtextXY(0,75,'Le fantome t''etrangle...................');ch:=readkey;mort;
          end;
     if(choix7='2') then
          begin
          Cleardevice;
          outtextXY(0,5,'Le fantome se met en boule dans le tiroir');
          outtextXY(0,15,'Maintenant tu sors par la porte');ch:=readkey;couloir;
          end;
     end;
end;

procedure hall;
  begin
    outtext('hall');
    cleardevice;
    setcolor(1);
    moveto(60,10);lineto(220,10);
    lineto(220,120);
    lineto(60,120);
    lineto(60,10);
    setcolor(3);
    moveto(60,20); lineto(80,20);
    lineto(80,100);
    lineto(60,100);
    setcolor(2);
    line(70,100,70,120);
    outtextXY(140,15,'porte');
    outtextXY(175,60,'porte');
    outtextXY(5,125,'prenez-vous: 1) La porte du nord');
    outtextXY(5,140,'             2) La porte de l''est');
    outtextXY(5,155,'             3) Ouvrir l''armoire');
    readln(solution);
    if (solution='1') then chambre;
    if (solution='2') then salon;
    if (solution='3') then armoire;
 end;
begin
 debut;
  graphdriver:=detect;

  clrscr;
  gotoXY(1,1);
  write ('Comment t''appelles-tu?');
  readln(nom);
  textcolor(2);
  writeln ('Bonjour ', nom);
  writeln ('Tu vas bient“t entrer dans la MAISON HANTEE');
  writeln ('Je te poserai des questions au-dessus tu r‚pondras par 1,2 ou 3');
  writeln ('Prends bien soin de noter les objets que tu as, car quand nous te');
  writeln ('les demanderons tu devras r‚pondre par oui si tu l''as ou non dans');
  writeln ('le cas contraire.');
  writeln ('Les piŠces ont toujours le nord en haut.Votre mission est de d‚bar-');
  writeln ('rasser les fant“mes de la maison(Pour combattre les fant“mes il');
  writeln ('vous faut 1 d‚.). PS: n''essayez pas de vous diriger avec le nord');
  writeln ('sud,est,ouest: vous vous embrouilleriez.');
  ch:=readkey;
  graphdriver:=1;graphmode:=0;
  initgraph(graphdriver,graphmode,'');
  Cleardevice;
  setcolor(2);
  moveto(70,10);lineto(220,10);
  lineto(250,40);
  lineto(50,40);
  lineto(70,10);
  setcolor(15);
  moveto(60,40); lineto(60,120);
  lineto(240,120);
  lineto(240,40);
  setcolor(1);
  moveto(220,80);lineto(220,60);
  lineto(200,60);
  lineto(200,80);
  lineto(220,80);
  moveto(100,80);lineto (100,60);
  lineto(80,60);
  lineto(80,80);
  lineto(100,80);
  setcolor(2);
  moveto(140,120);lineto(140,80);
  lineto(160,80);
  lineto(160,120);
  setTextstyle(gothicfont,0,1);
  outtextXY(10,130, 'Veux-tu entrer dans la maison?');
  readln(enter);
  outtextXY(1,1,enter);
  if ( enter = 'oui') then hall else outtext('au revoir');
  ch:=readkey;
  closegraph;
end.