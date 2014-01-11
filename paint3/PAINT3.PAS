uses dos,graph,menus,printer,crt;

VAR x,y,w,j,j3:integer;
    j2:word;
    modeCour:integer;
    Ycentre,Xcentre,Xrayon,Yrayon,deb,fin:integer;
    SYcentre,SXcentre,SXrayon,SYrayon,Sdeb,Sfin,ins:string;
    ligne_du_bas:boolean;
    accept,acc,oub:boolean;
    bord:integer;
    INST:ARRAY[1..1600] OF STRING [35];
    gomme,trait,point,cercle,arc_de_cercle,carre,paint:boolean;
    f_tra,f_poi,f_cer,f_arc,f_car,f_pai:boolean;
    ch:char;
    ajout:string;
    p,p2:pointer;
    xs,ys:string;
    effacer:string;
    confirm:boolean;


procedure aff_ligne_du_bas(ecran:boolean);
var i:integer;
begin
cache_souris;
if (not(ecran)) and (not(ligne_du_bas)) then fenetre(0,getmaxY-40,'',getmaxX,40,p);
ligne_du_bas:=true;                 {******************_-^-_******************}
                                    {met en m‚moire la partie qui sera        }
setcolor(bord);                        {recouverte par la bande si la elle n'est }
{contour}                           {pas d‚j… mise.}
setviewport(0,getmaxY-40,getmaxX,getmaxY,true);
clearviewport;
selectfenetretotale;
rectangle(0,0,getmaxX,getmaxY-40);
rectangle(0,getmaxY-40,getmaxX,getmaxY);
{ligne du bas}
rectangle(40,getmaxY-30,70,getmaxY-10);
rectangle(80,getmaxY-30,110,getmaxY-10);
rectangle(120,getmaxY-30,150,getmaxY-10);
rectangle(160,getmaxY-30,190,getmaxY-10);
rectangle(200,getmaxY-30,230,getmaxY-10);
setcolor(1);
rectangle(240,getmaxY-30,270,getmaxY-10);
setcolor(bord);
rectangle(241,getmaxY-31,271,getmaxY-9);
rectangle(280,getmaxY-30,290,getmaxY-10);
{symboles}
circle(55,getmaxY-20,5);
rectangle(83,getmaxY-27,107,getmaxY-13);
line(123,getmaxY-13,147,getmaxY-27);
i:=0;
repeat
i:=i+1;
putpixel(160+random(30),getmaxY-30+random(20),bord);
until i=10;
ellipse(215,getmaxY-20,0,180,5,5);
if modeCour<>-1 then setfillstyle(1,3) else setfillstyle(1,1);floodfill(250,getmaxY-20,1);
outtextXY(282,175,'G');
{remplissage de l'ecran et de la bande}
if (modeCour<>-1) and (ecran) then floodfill(100,40,3);
if (modeCour=-1) and (ecran) then floodfill(100,40,1);
setfillstyle(9,1);
if modeCour<>-1 then floodfill(2,getmaxY-1,3) else floodfill(2,getmaxY-1,1);
montre_souris;
end;

{procedure erreur(doserreur:integer);
begin
clearviewport;
setcolor(1);rectangle(0,0,280,60);
setcolor(2);
if doserreur=101 then outtextXY(1,1,'DISQUE PLEIN');
if doserreur=150 then outtextXY(1,1,'DISQUE PROTEGE EN ECRITURE');
if doserreur=151 then outtextXY(1,1,'UNITE NON RECONNUE PAR SYS.');
if doserreur=152 then outtextXY(1,1,'UNITE NON PRETE');
if doserreur=155 then outtextXY(1,1,'COMMUNIC.-DISQUE ERRONEE');
if doserreur=156 then outtextXY(1,1,'POSITION. DES TETES INC.');
if doserreur=157 then outtextXY(1,1,'SUP. MAGNETIQUE INCONNU');
if doserreur=158 then outtextXY(1,1,'SECTEUR NON TROUVE');
if doserreur=159 then outtextXY(1,1,'PLUS DE PAPIER');
if doserreur=160 then outtextXY(1,1,'ERREUR D''ECRITURE');
if doserreur=162 then outtextXY(1,1,'ERREUR LIEE AU MATERIEL');
if doserreur=003 then outtextXY(1,1,'CHEMIN D''ACCES INTROUVABLE');
if doserreur=005 then outtextXY(1,1,'ACCES INTERDIT');
if doserreur=015 then outtextXY(1,1,'UNITE NON VALIDE');
ch:=readkey;
confirm:=false;
end;}

procedure oublier;
begin
if oub then
       begin
       fenetre(0,0,'',getmaxX,getmaxY,p2);
       setviewport(20,20,300,80,true);
       clearviewport;
       setcolor(1);rectangle(0,0,280,60);
       setcolor(2);
       outtextXY(5,5,'Oublier');
       outtextXY(5,35,'Etes vous sur(e)?');
       repeat
       ch:=readkey;
       until (ch='O') or (ch='o') or (ch='N') or (ch='n');
       selectFenetreTotale;
       ferme_fenetre(0,0,getmaxX,getmaxY,p2);
       dispose(p2);release(p2);
       if (ch='o') or (ch='O') then oub:=true else oub:=false;
       end;
if oub then
   begin
   j:=0;
   repeat
   j:=j+1;
   inst[j]:='NON PRIS';
   until j=1600;
   j:=0;
   end;
end;

procedure sauver;
var f:text;
    mot:string;
    info:searchrec;
begin
fenetre(0,0,'',getmaxX,getmaxY,p2);
setviewport(20,20,300,80,true);
repeat
repeat
oub:=false;
confirm:=true;
clearviewport;
setcolor(1);rectangle(0,0,280,60);
if modeCour<>-1 then setcolor(2);
outtextXY(5,5,'   UNITE (A-Z) ?');
ch:=readkey;
outtextXY(5,35,'NOM DU FICHIER ?');
gotoXY(20,7);read(mot);
if mot='' then mot:='NONAME';
until confirm;
confirm:=true;
mot:=ch+':'+mot;
if pos('.',mot)=0 then mot:=mot+'.PAS';
{findfirst(ch+':*.*',archive,info);
repeat
      if info.name=mot then
                       begin
                       clearviewport;
                       setcolor(1);
                       rectangle(0,0,280,60);if modecour<>-1 then setcolor(2);
                       outtextXY(5,20,'EXISTE DEJA');
                       oub:=false;
                       confirm:=false;
                       end
                      else
                       begin
                       confirm:=true;
                       findnext(info);
                       end;
until doserror<>0;}
until confirm;
{$i-}
assign(f,mot);
rewrite(f);
{if doserror<>0 then erreur(doserror);
if IOresult<>0 then erreur(IOresult);}
j:=1;
repeat
repeat
      writeln(f,inst[j]);
      confirm:=true;
      j:=j+1;
until (j=j3) or (inst[j]='NON PRIS');
{if doserror<>0 then confirm:=false;
if IOresult<>0 then confirm:=false;erreur(IOresult);}
until confirm;
close(f);
{$i+}
selectFenetreTotale;
ferme_fenetre(0,0,getmaxX,getmaxY,p2);
dispose(p2);release(p2);
oublier;
end;

procedure imprimer;
begin
j:=0;
{$i-}
oub:=false;
repeat
repeat
      j:=j+1;
      writeln(lst,inst[j]);
      confirm:=true;
until (j=j3) or (inst[j+1]='NON PRIS');
{if (doserror<>0) or (IOresult<>0) then confirm:=false}
{               begin

               fenetre(0,0,'',getmaxX,getmaxY,p2);
               setviewport(20,20,300,80,true);
               if IOresult<>0 then erreur(IOresult);
               if doserror<>0 then erreur(doserror);
               ferme_fenetre(0,0,getmaxX,getmaxY,p2);
               dispose(p2);release(p2);
               end;}
until confirm;
{$i+}
oublier;
end;

procedure initialiser(mode:integer);
begin
gomme:=false;
j:=0;
repeat
j:=j+1;
inst[j]:='NON PRIS';
until j=1600;
j:=0;
ligne_du_bas:=true;
ch:=' ';
trait:=false;point:=false;cercle:=false;arc_de_cercle:=false;carre:=false;paint:=false;
f_tra:=false;f_poi:=false;f_cer:=false;f_arc:=false;f_car:=false;f_pai:=false;
initgraphic(mode);
cleardevice;
if mode<>-1 then bord:=3 else bord:=1;
if mode<>-1 then setfillstyle(1,3) else setfillstyle(1,1);
floodfill(2,2,2);
fenetre(0,getmaxY-40,'',getmaxX,40,p);
Cleardevice;
settextstyle(0,0,0);
if graphResult<>grOk then
                     begin
                     restorecrtmode;
                     repeat
                     clrscr;
                     writeln('Erreur graphique pour la fonte de caractŠre.');
                     writeln('A>bandonner   R>‚‚ssayer');
                     ch:=readkey;ch:=upcase(ch);if ch='A' then halt(1);
                     if ch='R' then settextstyle(0,0,0);
                     until graphResult=grOk;
                     end;
souris_est_la:=souris_active;
aff_ligne_du_bas(true);
montre_souris;
end;

begin
modeCour:=-1;
acc:=false;
initialiser(modeCour);
repeat
      x:=Xsouris;y:=Ysouris;
      if modeCour<>-1 then x:=x DIV 2;
  if bouton_gauche and (ligne_du_bas) and (x>40) and (x<70) and (y in [170..190]) and (not(cercle)) then
                                               begin
                                               cache_souris;
                                               cercle:=true;
                                               if trait then effacer:='trait';
                                               if carre then effacer:='carre';
                                               if paint then effacer:='paint';
                                               if point then effacer:='point';
                                               if arc_de_cercle then effacer:='arc_de_cercle';
                                               if modeCour<>-1 then setfillstyle(1,2) else setfillstyle(2,1);
                                               if modeCour<>-1 then floodfill(42,getmaxY-28,3)
                                                  else floodfill(42,getmaxY-28,1);
                                               if modeCour<>-1 then floodfill(55,getmaxY-20,3)
                                                  else floodfill(55,getmaxY-20,1);
                                               montre_souris;
                                               end;
  if bouton_gauche and (ligne_du_bas) and (x>80) and (x<110) and (y in [getmaxY-30..getmaxY-10]) and (not(carre)) then
                                               begin
                                               cache_souris;
                                               if trait then effacer:='trait';
                                               if cercle then effacer:='cercle';
                                               if paint then effacer:='paint';
                                               if point then effacer:='point';
                                               if arc_de_cercle then effacer:='arc_de_cercle';
                                               carre:=true;
                                               if modeCour<>-1 then setfillstyle(1,2) else setfillstyle(2,1);
                                               floodfill(82,getmaxY-28,bord);
                                               floodfill(90,getmaxY-20,bord);
                                               montre_souris;
                                               end;
  if (bouton_gauche) and (ligne_du_bas) and (x>120) and (x<150) and (y in [getmaxY-30..getmaxY-10]) and (not(trait)) then
                                               begin
                                               cache_souris;
                                               trait:=true;
                                               if carre then effacer:='carre';
                                               if cercle then effacer:='cercle';
                                               if paint then effacer:='paint';
                                               if point then effacer:='point';
                                               if arc_de_cercle then effacer:='arc_de_cercle';
                                               if modeCour<>-1 then setfillstyle(1,2) else setfillstyle(2,1);
                                               floodfill(122,getmaxY-28,bord);
                                               montre_souris;
                                               end;
  if (bouton_gauche) and (ligne_du_bas) and (x>160) and (x<190) and (y in [getmaxY-30..getmaxY-10]) and (not(point)) then
                                               begin
                                               cache_souris;
                                              if carre then effacer:='carre';
                                               if cercle then effacer:='cercle';
                                               if paint then effacer:='paint';
                                               if trait then effacer:='trait';
                                               if arc_de_cercle then effacer:='arc_de_cercle';
                                               point:=true;
                                               if modeCour<>-1 then setfillstyle(1,2) else setfillstyle(2,1);
                                               floodfill(162,getmaxY-28,bord);
                                               montre_souris;
                                               end;
  if (bouton_gauche) and (ligne_du_bas) and (x>200) and (x<230) and (y in [getmaxY-30..getmaxY-10])
                                        and (not(arc_de_cercle)) then
                                               begin
                                               cache_souris;
                                               if carre then effacer:='carre';
                                               if cercle then effacer:='cercle';
                                               if paint then effacer:='paint';
                                               if trait then effacer:='trait';
                                               if point then effacer:='point';
                                               arc_de_cercle:=true;
                                               if modeCour<>-1 then setfillstyle(1,2) else setfillstyle(2,1);
                                               floodfill(202,getmaxY-28,bord);
                                               montre_souris;
                                               end;
  if (bouton_gauche) and (ligne_du_bas) and (x>240) and (x<270) and (y in [getmaxY-30..getmaxY-10]) and (not(paint)) then
                                               begin
                                               cache_souris;
                                               paint:=true;
                                               if carre then effacer:='carre';
                                               if cercle then effacer:='cercle';
                                               if arc_de_cercle then effacer:='arc_de_cercle';
                                               if trait then effacer:='trait';
                                               if point then effacer:='point';
                                               if modeCour<>-1 then setfillstyle(1,2) else setfillstyle(2,1);
                                               floodfill(242,getmaxY-28,1);
                                               montre_souris;
                                               end;
  if (bouton_gauche) and (ligne_du_bas) and (x>280) and (x<290) and (y in [getmaxY-30..getmaxY-10]) and (not(gomme)) then
                                               begin
                                               cache_souris;
                                               gomme:=true;
                                               if modeCour<>-1 then setfillstyle(1,2) else setfillstyle(2,1);
                                               floodfill(282,getmaxY-28,bord);
                                               montre_souris;
                                               end;
  if (bouton_gauche) and (ligne_du_bas) and (x>280) and (x<290) and (y in [getmaxY-30..getmaxY-10]) and (gomme) then
                                               begin
                                               cache_souris;
                                               gomme:=false;
                                               setfillstyle(1,0);
                                               if modeCour<>-1 then floodfill(282,getmaxY-28,bord)
                                                  else bar(280,getmaxY-30,290,getmaxY-10);
                                               montre_souris;
                                               end;
if effacer='cercle' then
                    begin
                    setfillstyle(1,0);
                    floodfill(42,getmaxY-28,bord);
                    floodfill(55,getmaxY-20,bord);
                    cercle:=false;
                    end;
if effacer='carre' then
                   begin
                   setfillstyle(1,0);
                   floodfill(82,getmaxY-29,bord);
                   floodfill(90,getmaxY-25,bord);
                   carre:=false;
                   end;
if effacer='trait' then
                   begin
                   setfillstyle(1,0);
                   floodfill(122,getmaxY-28,bord);
                   trait:=false;
                   end;
if effacer='paint' then
                   begin
                   setfillstyle(1,0);
                   floodfill(242,getmaxY-28,1);
                   paint:=false;
                   end;
if effacer='arc_de_cercle' then
                   begin
                   setfillstyle(1,0);
                   floodfill(202,getmaxY-28,bord);
                   arc_de_cercle:=false;
                   end;
if effacer='point' then
                   begin
                   setfillstyle(1,0);
                   floodfill(162,getmaxY-28,bord);
                   point:=false;
                   end;
if keypressed then ch:=readkey;
if ch=chr(82) then aff_ligne_du_bas(false);
if ch=chr(83) then begin cache_souris;ligne_du_bas:=false;ferme_fenetre(0,getmaxY-40,getmaxX,40,p);montre_souris; end;
if ch=chr(45) then HALT;
if ch=chr(59) then imprimer;
if ch=chr(60) then sauver;
if ch=chr(61) then oublier;
if ch=chr(63) then begin modeCour:=modeCour+1;if modeCour>6 then modeCour:=0;initialiser(modeCour); end;
if ch=chr(62) then
                   begin
                   cache_souris;
                   fenetre(0,0,'',getmaxX,getmaxY,p2);
                   setviewport(20,20,300,80,true);
                   setcolor(1);
                   rectangle(0,0,280,60);if modecour<>-1 then setcolor(2);
                   outtextXY(1,1,'Ajouter :');
                   gotoXY(16,7);readln(ajout);
                   j:=j+1;inst[j]:=ajout;
                   SelectFenetreTotale;
                   ferme_fenetre(0,0,getmaxX,getmaxY,p2);
                   montre_souris;
                   end;
if ch=chr(27) then
                   begin
                   cache_souris;
              if (f_cer) or (f_poi) or (f_tra) or (f_car) or (f_pai) or (f_arc) then ferme_fenetre(0,0,getmaxX,getmaxY,p2);
                   if cercle then f_cer:=false;
                   if point then f_poi:=false;
                   if trait then f_tra:=false;
                   if carre then f_car:=false;
                   if paint then f_pai:=false;
                   if arc_de_cercle then f_arc:=false;
              if (f_cer) or (f_poi) or (f_tra) or (f_car) or (f_pai) or (f_arc) then  begin dispose(p2);release(p2);end;
                   montre_souris;
                   end;
if bouton_gauche and (acc) and ((not(ligne_du_bas)) or (y<getmaxY-40)) then
                                          begin
                                          ferme_fenetre(0,0,getmaxX,getmaxY,p2);
                                          dispose(p2);release(p2);
                                          accept:=false;
                                          acc:=false;
                                          end;
accept:=false;
if bouton_gauche  and (not(acc)) and ((not(ligne_du_bas)) or (y<getmaxY-40)) then begin accept:=true;acc:=true; end;
if (accept) and (cercle) then f_cer:=true;
if (accept) and (trait) then f_tra:=true;
if (accept) and (carre) then f_car:=true;
if (accept) and (paint) then acc:=false;
if (accept) and (paint) then accept:=false;
if (accept) and (arc_de_cercle) then f_arc:=true;
if (accept) and (point) then begin accept:=false;acc:=false; end;
if (accept) and (acc) then
          begin
          cache_souris;
          Xcentre:=x;
          Ycentre:=y;
          Xrayon:=0;
          Yrayon:=0;
          deb:=0;
          fin:=180;
          w:=0;
          fenetre(0,0,'',getmaxX,getmaxY,p2);
          montre_souris;
          end;
cache_souris;
if f_cer then
         begin
         w:=w+1;
         Xrayon:=abs(x-xCentre);
         Yrayon:=abs(y-ycentre);
         setcolor(0);
         ellipse(Xcentre,Ycentre,0,360,Xrayon,Yrayon);
         delay(100);
         setcolor(bord);
         ellipse(Xcentre,Ycentre,0,360,Xrayon,Yrayon);
         end;
if f_car then
         begin
         w:=w+1;
         Xrayon:=x-xCentre;
         Yrayon:=y-ycentre;
         setcolor(0);
         rectangle(Xcentre,Ycentre,Xcentre+Xrayon,Ycentre+Yrayon);
         delay(100);
         setcolor(bord);
         rectangle(Xcentre,Ycentre,Xcentre+Xrayon,Ycentre+Yrayon);
         end;
if f_tra then
         begin
         w:=w+1;
         Xrayon:=x-xCentre;
         Yrayon:=y-ycentre;
         setcolor(0);
         line(Xcentre,Ycentre,Xcentre+Xrayon,Ycentre+Yrayon);
         delay(100);
         setcolor(bord);
         line(Xcentre,Ycentre,Xcentre+Xrayon,Ycentre+Yrayon);
         end;
if f_arc then
         begin
         w:=w+1;
         if (ch=chr(104)) and (deb<360) then deb:=deb+1;
         if (ch=chr(105)) and (deb>0) then deb:=deb-1;
         if (ch=chr(106)) and (fin<360) then fin:=fin+1;
         if (ch=chr(107)) and (fin>0) then fin:=fin-1;
         if (ch=chr(94)) and (deb<355) then deb:=deb+5;
         if (ch=chr(95)) and (deb>5) then deb:=deb-5;
         if (ch=chr(96)) and (fin<355) then fin:=fin+5;
         if (ch=chr(97)) and (fin>5) then fin:=fin-5;
         if (ch=chr(84)) and (deb<340) then deb:=deb+20;
         if (ch=chr(85)) and (deb>20) then deb:=deb-20;
         if (ch=chr(86)) and (fin<340) then fin:=fin+20;
         if (ch=chr(87)) and (fin>20) then fin:=fin-20;
         Xrayon:=abs(x-xCentre);
         Yrayon:=abs(y-ycentre);
         setcolor(0);
         ellipse(Xcentre,Ycentre,deb,fin,Xrayon,Yrayon);
         delay(100);
         setcolor(bord);
         ellipse(Xcentre,Ycentre,deb,fin,Xrayon,Yrayon);
         end;
{if f_poi then
         begin
         w:=w+1;
         setcolor(0);
         putpixel(Xcentre,Ycentre,0);
         delay(100);
         setcolor(3);
         putpixel(Xcentre,Ycentre,3);
         end;}
if bouton_droit and (f_cer) then
                            begin
                            j:=j+1;
                            acc:=false;
                            ferme_fenetre(0,0,getmaxX,getmaxY,p2);
                            dispose(p2);release(p2);
                            if gomme then setcolor(bord) else setcolor(0);
                            ellipse(Xcentre,Ycentre,0,360,Xrayon,Yrayon);
                            str(Xcentre,SXcentre);str(Ycentre,SYcentre);
                            str(Xrayon,SXrayon);str(Yrayon,SYrayon);
                            if gomme then inst[j]:='*ELLIPSE('+SXcentre+','+SYcentre+',0,360,'+SXrayon+','+SYrayon+');'
                                     else inst[j]:='ELLIPSE('+SXcentre+','+SYcentre+',0,360,'+SXrayon+','+SYrayon+');';
                            setcolor(0);
                            f_cer:=false;
                            end;
if bouton_droit and (f_car) then
                            begin
                            acc:=false;
                            j:=j+1;
                            ferme_fenetre(0,0,getmaxX,getmaxY,p2);
                            dispose(p2);release(p2);
                            if gomme then setcolor(bord) else setcolor(0);
                            rectangle(Xcentre,Ycentre,Xcentre+Xrayon,Ycentre+Yrayon);
                            str(Xcentre,SXcentre);str(Ycentre,SYcentre);
                            Xrayon:=Xcentre+Xrayon;
                            Yrayon:=Ycentre+Yrayon;
                            str(Xrayon,SXrayon);str(Yrayon,SYrayon);
                            if gomme then inst[j]:='*RECTANGLE('+SXcentre+','+SYcentre+','+SXrayon+','+SYrayon+');'
                                     else inst[j]:='RECTANGLE('+SXcentre+','+SYcentre+','+SXrayon+','+SYrayon+');';
                            f_car:=false;
                            end;
if bouton_droit and (f_tra) then
                            begin
                            acc:=false;
                            j:=j+1;
                            ferme_fenetre(0,0,getmaxX,getmaxY,p2);
                            dispose(p2);release(p2);
                            if gomme then setcolor(bord) else setcolor(0);
                            line(Xcentre,Ycentre,Xcentre+Xrayon,Ycentre+Yrayon);
                            str(Xcentre,SXcentre);str(Ycentre,SYcentre);
                            Xrayon:=Xcentre+Xrayon;
                            Yrayon:=Ycentre+Yrayon;
                            str(Xrayon,SXrayon);str(Yrayon,SYrayon);
                            if gomme then inst[j]:='*LINE('+SXcentre+','+SYcentre+','+SXrayon+','+SYrayon+');'
                                     else inst[j]:='LINE('+SXcentre+','+SYcentre+','+SXrayon+','+SYrayon+');';
                            f_tra:=false;
                            end;
if bouton_gauche and ((not(ligne_du_bas)) or (y<getmaxY-40)) and (point) then
                            begin
                            cache_souris;
                            Xcentre:=x;Ycentre:=y;
                            j:=j+1;
                            str(Xcentre,SXcentre);str(Ycentre,SYcentre);
                            if gomme then inst[j]:='*PUTPIXEL('+SXcentre+','+SYcentre+',Gomme);'
                                     else inst[j]:='PUTPIXEL('+SXcentre+','+SYcentre+',Couleur);';
                            j2:=getpixel(xcentre,ycentre);
                            if (gomme) and (j2=3) then
                                                  begin
                                                  inst[j]:='        ';
                                                  j:=j-1;
                                                  end;
                            if (not(gomme)) and (j2=0) then
                                                  begin
                                                  inst[j]:='        ';
                                                  j:=j-1;
                                                  end;
                            if gomme then putpixel(Xcentre,Ycentre,bord) else putpixel(Xcentre,Ycentre,0);
                            montre_souris;
                            end;
if bouton_gauche and ((not(ligne_du_bas)) or (y<getmaxY-40)) and (paint) then
                            begin
                            cache_souris;
                            Xcentre:=x;Ycentre:=y;
                            j:=j+1;
                            if modeCour<>-1 then putpixel(Xcentre,Ycentre,2) else putpixel(Xcentre,Ycentre,0);
                            str(Xcentre,SXcentre);str(Ycentre,SYcentre);
                            inst[j]:='FLOODFILL('+SXcentre+','+SYcentre+',Bord);';
                            montre_souris;
                            end;
if bouton_droit and (f_arc) then
                            begin
                            acc:=false;
                            j:=j+1;
                            ferme_fenetre(0,0,getmaxX,getmaxY,p2);
                            dispose(p2);release(p2);
                            if gomme then setcolor(bord) else setcolor(0);
                            ellipse(Xcentre,Ycentre,deb,fin,Xrayon,Yrayon);
                            str(Xcentre,SXcentre);str(Ycentre,SYcentre);
                            str(Xrayon,SXrayon);str(Yrayon,SYrayon);
                            str(deb,Sdeb);str(fin,Sfin);
                            if gomme then inst[j]:='*ELLIPSE('+SXcentre+','+SYcentre+','+Sdeb+','+Sfin+
                                                             ','+SXrayon+','+SYrayon+');'
                                     else inst[j]:='ELLIPSE('+SXcentre+','+SYcentre+
                                                             ','+Sdeb+','+Sfin+','+SXrayon+','+SYrayon+');';
                            setcolor(0);
                            f_arc:=false;
                            end;
if w=20 then
        begin
        cache_souris;
        ferme_fenetre(0,0,getmaxX,getmaxY,p2);
        release(p2);
        dispose(p2);
        fenetre(0,0,'',getmaxX,getmaxY,p2);
        montre_souris;
        w:=0;
        end;
ch:=' ';
if j=1599 then
       begin
       fenetre(0,0,'',getmaxX,getmaxY,p2);
       setviewport(20,20,300,80,true);
       CLearviewport;
       setcolor(1);
       rectangle(0,0,280,60);
       outtextXY(1,5,'PLUS ASSEZ DE MEMOIRE POUR LES');
       outtextXY(1,17,'DONNES');
       outtextXY(5,35,'Sauvegarder, Imprimer ou Oublier');
       repeat
       ch:=readkey;
       ch:=upcase(ch);
       until (ch='S') or (ch='I') or (ch='O');
       selectfenetretotale;
       ferme_fenetre(0,0,getmaxX,getmaxY,p2);
       dispose(p2);release(p2);
       j3:=j;
       j:=0;
       if ch='S' then sauver;
       if ch='I' then imprimer;
       if ch='O' then oub:=true;
       if ch='O' then oublier;
       selectfenetretotale;
       end;
montre_souris;
vide_buffer;
until false;
end.