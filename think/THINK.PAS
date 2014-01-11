Uses Dos,Crt,Graph;

Type LigneNiv                              = String[13];
     Horloge                               = Record
                                               Heure,
                                               Minute,
                                               Sec : Word;
                                             End;
     Position                              = Record
                                               x,
                                               y : Integer;
                                             End;

Var Pilote,Mode,Erreur                     : Integer;
    i                                      : word;
    Cube                                   : Array[1..9] of pointer;
    Contour,Fond,Obstacle,Eau              : Pointer;
    Ch                                     : Char;
    Niveau                                 : Array [1..100,1..12] of LigneNiv;
    TempsNiveau                            : String[2];
    Temp                                   : integer;
    temps,Level,Points                     : String;
    Pts                                    : Integer;
    HDep,HArr,HAct                         : Horloge;
    NiveauCourant                          : Byte;
    x,y                                    : Integer;
    a,b                                    : Integer;
    CubeSelect                             : boolean;
    SelectCube                             : Position;
    c                                      : integer;

Procedure Titre;
Begin
i:=i+1;
if i=16 then i:=1;
SetColor(i);
OutTextXY(GetMaxX DIV 2,170,'THINK WAY');
SetColor(i+1);
OutTextXY((GetMaxX DIV 2)-2,172,'THINK WAY');
SetColor(i-1);
OutTextXY((GetMaxX DIV 2)-4,174,'THINK WAY');
End;

Procedure PrepareTitre;
begin
x:=0;
y:=0;
Repeat
repeat
PutImage(x,y,Contour^,NormalPut);
x:=x+16;
until x>=GetMaxX-1;
x:=0;
y:=y+16;
until y>=GetMaxY-1;
SetFillStyle(1,0);
end;

Procedure Vide_Buffer;
Var r:Registers;
Begin
r.ax:=$0C0B;
Intr($21,r);
End;

Procedure PreparePointer;
Var w : Integer;
    s : String[1];
Begin
SetTextStyle(1,0,1);
SetTextJustify(1,1);
w:=1;
Repeat
ClearDevice;
SetColor(LightCyan);
Rectangle(0,0,32,25);
Rectangle(1,1,31,24);
PutPIxel(0,0,0);
PutPIxel(32,25,0);
PutPIxel(0,25,0);
PutPIxel(32,0,0);
SetFillStyle(1,Cyan);
FloodFill(4,4,LightCyan);
SetColor(Black);
if w<>9 then str(w,s) else s:='?';
OutTextXY(16,10,s);
SetColor(White);
OutTextXY(17,11,s);
GetMem(cube[w],imageSize(0,0,32,25));
GetImage(0,0,32,25,cube[w]^);
w:=w+2;
Until w=11;
w:=2;
Repeat
ClearDevice;
SetColor(LightMagenta);
Rectangle(0,0,32,25);
Rectangle(1,1,31,24);
PutPIxel(0,0,0);
PutPIxel(32,25,0);
PutPIxel(0,25,0);
PutPIxel(32,0,0);
SetFillStyle(1,Magenta);
FloodFill(4,4,LightMagenta);
SetColor(Black);
Str(w,s);
OutTextXY(16,10,s);
SetColor(White);
OutTextXY(17,11,s);
GetMem(cube[w],imageSize(0,0,32,25));
GetImage(0,0,32,25,cube[w]^);
w:=w+2;
Until w=12;
ClearDevice;
w:=0;
Repeat
SetColor(Yellow);
Rectangle(w,w,32-w,25-w);
SetColor(Brown);
Rectangle(w+1,w+1,32-(w+1),25-(w+1));
GetMem(Obstacle,ImageSize(0,0,32,25));
GetImage(0,0,32,25,Obstacle^);
w:=w+2;
Until w=18;
ClearDevice;
SetColor(Cyan);
SetFillStyle(1,Cyan);
Bar(0,0,32,25);
SetColor(LightBlue);
Line(0,0,32,25);
Line(0,1,31,25);
PutPixel(0,0,0);
PutPixel(32,25,0);
PutPixel(0,25,0);
PutPixel(32,0,0);
SetColor(LightCyan);
Line(1,0,32,24);
SetColor(LightBlue);
SetFillStyle(1,LightBlue);
Bar(4,21,6,19);
Bar(28,4,26,6);
SetColor(LightCyan);
SetFillStyle(1,LightCyan);
Bar(3,22,5,20);
Bar(29,3,27,5);
GetMem(Contour,ImageSize(0,0,32,25));
GetImage(0,0,32,25,Contour^);
ClearDevice;
SetColor(LightBlue);
SetFillStyle(1,Blue);
Bar(0,0,15,25);
Bar(17,0,32,25);
SetColor(LightCyan);
Line(15,0,0,0);
Line(0,0,0,25);
Line(32,0,17,0);
Line(17,0,17,25);
GetMem(Fond,imageSize(0,0,32,25));
GetImage(0,0,32,25,Fond^);
ClearDevice;
SetColor(LightBlue);
SetFillStyle(1,LightBlue);
Moveto(0,7);Lineto(0,25);Lineto(32,25);Lineto(32,7);
w:=0;
Repeat
ellipse(w+2,7,0,180,2,1);
ellipse(w+6,7,180,360,2,1);
w:=w+8;
Until w=32;
FloodFill(4,20,LightBlue);
SetColor(LightCyan);
Line(14,14,18,14);
Line(8,20,12,20);
Line(2,9,6,9);
Line(18,16,22,16);
Line(21,24,25,24);
Line(27,11,31,11);
GetMem(Eau,ImageSize(0,0,32,25));
GetImage(0,0,32,25,eau^);
end;

Procedure MauvaisNiveaux(Taille,nombre:boolean);
Begin
CloseGraph;
Clrscr;
TextColor(LightBlue);
if taille then Writeln('Les fichiers .NIV n''ont pas une entˆte r‚glementaire ...');
if nombre then writeln('Les fichiers .NIV ne sont pas au nombre de 100...');
Writeln('Arrˆt du programme...');
Halt;
End;

Procedure AssigneNiveau(Niv:Byte);
Var Directory : SearchRec;
    w,Erreur   : Integer;
    Erreur1,
    Erreur2   : Boolean;
    f         : Text;
    s         : String;
Begin
w:=0;
Erreur1:=False;
Erreur2:=False;
FindFirst('*.NIV',Archive,Directory);
While DosError=0 do
      Begin
      w:=w+1;
      if Directory.Size<>158 then Erreur1:=true;
      FindNext(Directory);
      End;
if w<>1 then erreur2:=true;
If erreur1 or erreur2 then MauvaisNiveaux(erreur1,erreur2);
{$i-}
Case Niv of
         1 : Assign(f,'NIV1.NIV');
         End;
{$i+}
Erreur:=IOResult;
if IOResult<>0 then
               Begin
               str(Niv,s);
               CloseGraph;
               Clrscr;
               TextColor(LightBlue);
               Writeln('Le fichier NIV'+s+' n''est pas trouv‚...');
               Writeln('Arrˆt du programme...');
               End;
Reset(f);
Read(f,Niveau[Niv,1]);
Read(f,Niveau[Niv,2]);
Read(f,Niveau[Niv,3]);
Read(f,Niveau[Niv,4]);
Read(f,Niveau[Niv,5]);
Read(f,Niveau[Niv,6]);
Read(f,Niveau[Niv,7]);
Read(f,Niveau[Niv,8]);
Read(f,Niveau[Niv,9]);
Read(f,Niveau[Niv,10]);
Read(f,Niveau[Niv,11]);
Read(f,Niveau[Niv,12]);
Read(f,TempsNiveau);
End;

Procedure AfficheNiveau(Niv:Byte);
Var W,Z     : Integer;
    element : String[1];
Begin
w:=0;
repeat
PutImage(159,w,Contour^,Orput);
PutImage(607,w,Contour^,Orput);
PutImage(0,w,Contour^,Orput);
w:=w+25;
until w>=350;
w:=0;
Repeat
PutImage(w,0,Contour^,Orput);
PutImage(w,325,Contour^,Orput);
w:=w+32;
Until w>=640;
w:=25;
repeat
PutImage(32,w,Fond^,Orput);
PutImage(64,w,Fond^,Orput);
PutImage(96,w,Fond^,Orput);
PutImage(128,w,Fond^,Orput);
w:=w+25;
until w>=325;
PutImage(40,31,cube[1]^,NormalPut);
PutImage(40,62,cube[2]^,NormalPut);
PutImage(40,93,cube[3]^,NormalPut);
PutImage(40,124,cube[4]^,NormalPut);
PutImage(40,155,cube[5]^,NormalPut);
PutImage(40,186,cube[6]^,NormalPut);
PutImage(40,217,cube[7]^,NormalPut);
PutImage(40,248,cube[8]^,NormalPut);
SetColor(Black);
SetTextJustify(1,1);
SetTextStyle(1,0,2);
OutTextXY(99,43,'- 3');
OutTextXY(99,74,'- 3');
OutTextXY(99,105,'- 3');
OutTextXY(99,136,'- 3');
OutTextXY(99,167,'- 3');
OutTextXY(99,198,'- 3');
OutTextXY(99,229,'- 3');
OutTextXY(99,260,'- 3');
OutTextXY(98,43,'- 3');
OutTextXY(98,74,'- 3');
OutTextXY(98,105,'- 3');
OutTextXY(98,136,'- 3');
OutTextXY(98,167,'- 3');
OutTextXY(98,198,'- 3');
OutTextXY(98,229,'- 3');
OutTextXY(98,260,'- 3');
SetColor(White);
OutTextXY(96,40,'- 3');
OutTextXY(96,71,'- 3');
OutTextXY(96,102,'- 3');
OutTextXY(96,133,'- 3');
OutTextXY(96,164,'- 3');
OutTextXY(96,195,'- 3');
OutTextXY(96,226,'- 3');
OutTextXY(96,257,'- 3');
SetColor(Black);
SetTextStyle(1,0,1);
SetTextJustify(0,1);
Str(Pts,points);
if length(points)=1 then points:='000000'+points;
if length(points)=2 then points:='00000'+points;
if length(points)=3 then points:='0000'+points;
if length(points)=4 then points:='000'+points;
if length(points)=5 then points:='00'+points;
if length(points)=6 then points:='0'+points;
OutTextXY(20,12,points+' Pts');
SetTextStyle(1,0,4);
Temps:=TempsNiveau;
Temps:=temps+'''00';
SetFillStyle(1,0);
Bar(260,1,280+TextWidth('00''00')+20,25);
SetColor(LightRed);
Rectangle(260,0,280+TextWidth('00''00')+20,25);
SetColor(Black);
OutTextXY(280,7,temps);
SetTextStyle(1,0,1);
Str(Niv,Level);
if length(level)=1 then level:='00'+level;
if length(level)=2 then level:='0'+level;
OutTextXY(500,12,'Niveau '+level);
SetColor(White);
SetTextStyle(1,0,1);
SetTextJustify(0,1);
OutTextXY(22,14,points+' Pts');
SetTextStyle(1,0,4);
OutTextXY(282,9,temps);
SetTextStyle(1,0,1);
OutTextXY(502,14,'Niveau '+level);
w:=0;
z:=0;
element:=' ';
repeat
Repeat
element:=Copy(Niveau[Niv,z+1],w+1,1);
if element='A' then PutImage((w*32)+191,(z*25)+24,Obstacle^,OrPut);
if element='B' then PutImage((w*32)+191,(z*25)+24,Eau^,OrPut);
w:=w+1;
Until w=13;
w:=0;
z:=z+1;
until z=12;
w:=0;
z:=0;
element:=' ';
repeat
Repeat
element:=Copy(Niveau[Niv,z+1],w+1,1);
if element='1' then PutImage((w*32)+191,(z*25)+24,Cube[1]^,XorPut);
if element='2' then PutImage((w*32)+191,(z*25)+24,Cube[2]^,XorPut);
if element='3' then PutImage((w*32)+191,(z*25)+24,Cube[3]^,XorPut);
if element='4' then PutImage((w*32)+191,(z*25)+24,Cube[4]^,XorPut);
if element='5' then PutImage((w*32)+191,(z*25)+24,Cube[5]^,XorPut);
if element='6' then PutImage((w*32)+191,(z*25)+24,Cube[6]^,XorPut);
if element='7' then PutImage((w*32)+191,(z*25)+24,Cube[7]^,XorPut);
if element='8' then PutImage((w*32)+191,(z*25)+24,Cube[8]^,XorPut);
if element='9' then PutImage((w*32)+191,(z*25)+24,Cube[9]^,XorPut);
w:=w+1;
Until w=13;
w:=0;
z:=z+1;
until z=12;
End;

Procedure PressTouche;
Var CS:String[1];
    CarS:Char;
    vide:string;
Begin
ch:=readKey;
vide:='0';
if (ch=chr(72)) and (not(CubeSelect)) and (y<>24) then
                    Begin
                    SetColor(White);
                    Rectangle(x,y,x+32,y+25);
                    y:=y-25;
                    Rectangle(x,y,x+32,y+25);
                    End;
if (ch=chr(75)) and (not(CubeSelect)) and (x<>191) then
                    Begin
                    SetColor(White);
                    Rectangle(x,y,x+32,y+25);
                    x:=x-32;
                    Rectangle(x,y,x+32,y+25);
                    End;
if (ch=chr(77)) and (not(CubeSelect)) and (x<>575) then
                    Begin
                    SetColor(White);
                    Rectangle(x,y,x+32,y+25);
                    x:=x+32;
                    Rectangle(x,y,x+32,y+25);
                    End;
if (ch=chr(80)) and (not(CubeSelect)) and (y<>299) then
                    Begin
                    SetColor(White);
                    Rectangle(x,y,x+32,y+25);
                    y:=y+25;
                    Rectangle(x,y,x+32,y+25);
                    End;
if (ch=chr(13)) and (not(CubeSelect)) then
                    Begin
                    SelectCube.x:=(round((x-191) DIV 32))+1;
                    SelectCube.y:=(round((y-24) DIV 25))+1;
                    CS:=copy(niveau[niveauCourant,SelectCube.y],SelectCube.x,1);
                    CarS:=CS[1];
                    if (ord(Cars)>48) and (ord(cars)<58) then cubeselect:=true;
                    if cubeSelect then Rectangle(x,y,x+32,y+25);
                    if cubeSelect then Delete(niveau[niveauCourant,SelectCube.y],selectCube.x,1);
                    if CubeSelect then Insert(vide,niveau[niveauCourant,SelectCube.y],selectCube.x);
                    End;
if CarS='1' then c:=1;
if CarS='2' then c:=2;
if CarS='3' then c:=3;
if CarS='4' then c:=4;
if CarS='5' then c:=5;
if CarS='6' then c:=6;
if CarS='7' then c:=7;
if CarS='8' then c:=8;
if CarS='9' then c:=9;
if (ch=chr(72)) and (CubeSelect) and (y<>24) then
                    Begin
                    PutImage(x,y,cube[c]^,XorPut);
                    y:=y-25;
                    b:=b-1;
                    PutImage(x,y,cube[c]^,XorPut);
                    End;
if (ch=chr(75)) and (CubeSelect) and (x<>191) then
                    Begin
                    PutImage(x,y,cube[c]^,XorPut);
                    x:=x-32;
                    a:=a-1;
                    PutImage(x,y,cube[c]^,XorPut);
                    End;
if (ch=chr(77)) and (CubeSelect) and (x<>575) then
                    Begin
                    PutImage(x,y,cube[c]^,XorPut);
                    x:=x+32;
                    a:=a+1;
                    PutImage(x,y,cube[c]^,XorPut);
                    End;
if (ch=chr(80)) and (CubeSelect) and (y<>299) then
                    Begin
                    PutImage(x,y,cube[c]^,XorPut);
                    y:=y+25;
                    b:=b+1;
                    PutImage(x,y,cube[c]^,XorPut);
                    End;
end;

Procedure GameOver;
begin
end;

Procedure VerifyChrono;
Var heure,min,sec:string[2];
    h,m,s:integer;
    hh,mm,ss:word;
Begin
SetWriteMode(0);
SetTextStyle(1,0,4);
SetFillStyle(1,0);
SetColor(Black);
h:=Hact.Heure;
m:=Hact.Minute;
s:=Hact.Sec;
s:=s-HDep.Sec;
if s<0 then begin s:=60+s;m:=m-1;end;
m:=m-HDep.Minute;
if m<0 then begin m:=60+m;h:=h-1;end;
if h<>HDep.Heure then GAMEOVER;
if m>=Temp then GameOver;
s:=0-s;
if s<0 then s:=60+s;
if s=0 then m:=Temp-m else m:=(Temp-m)-1;
Str(s,Sec);
Str(m,min);
if length(min)=1 then min:='0'+min;
if length(sec)=1 then sec:='0'+sec;
OutTextXY(280,7,min+''''+sec);
Bar(261,1,279+TextWidth('00''00')+20,24);
setcolor(White);
GetTime(hh,mm,ss,i);
h:=hh;s:=ss;m:=mm;
s:=s-HDep.Sec;
if s<0 then begin s:=60+s;m:=m-1;end;
m:=m-HDep.Minute;
if m<0 then begin m:=60+m;h:=h-1;end;
s:=0-s;
if s<0 then s:=60+s;
if s=0 then m:=Temp-m else m:=(Temp-m)-1;
Str(s,Sec);
Str(m,min);
if length(min)=1 then min:='0'+min;
if length(sec)=1 then sec:='0'+sec;
OutTextXY(280,7,min+''''+sec);
SetWriteMode(1);
End;

Procedure Joue(Niv : Byte);
Begin
x:=191;y:=24;
a:=1;b:=1;
CubeSelect:=false;
SetWriteMode(XorPut);
SetColor(White);
Rectangle(x,y,x+32,y+25);
NiveauCourant:=Niv;
GetTime(HDep.Heure,HDep.Minute,HDep.Sec,i);
HArr.Sec:=HDep.Sec;
Val(tempsNiveau,temp,Erreur);
Harr.Minute:=HDep.Minute+Temp;
If HArr.Minute>59 then
                  Begin
                  HArr.Heure:=1;
                  HArr.Minute:=Harr.Minute-60;
                  end;
HArr.Heure:=HDep.Heure+HArr.Heure;
if HArr.Heure>23 then HArr.Heure:=HArr.Heure-24;
HAct.Heure:=HDep.Heure;HAct.Minute:=HDep.Minute;Hact.Sec:=HDep.Sec;
Repeat
VerifyChrono;
If Keypressed then PressTouche;
Vide_Buffer;
Until ch=chr(27);
end;

Procedure DisPosePointer;
Begin
i:=1;
repeat
release(cube[i]);dispose(cube[i]);
i:=i+1;
until i=10;
release(contour);dispose(contour);
release(obstacle);Dispose(Obstacle);
Release(fond);dispose(fond);
Release(eau);Dispose(eau);
End;

Begin
DetectGraph(Pilote,Mode);
Clrscr;
If Pilote=-2 then
             Begin
             TextColor(LightRed+Blink);
             Writeln('     ERREUR FATALE !');
             TextColor(LightBlue);
             Writeln('Le pilote graphique n''est pas d‚tect‚...');
             Writeln('R‚f‚rez-vous au manuel de r‚f‚rence de votre ordinateur...');
             Writeln('Arrˆt du programme...');
             Halt(1);
             End;
If Pilote<>VGA then
               Begin
               TextColor(LightBlue);
               Writeln('Cette version ne supporte pas les cartes graphiques en dehors de la');
               Writeln('carte VGA...');
               Writeln('Arrˆt du programme...');
               Halt;
               End;
Pilote:=VGA;
Mode:=VGAMed;
InitGraph(Pilote,Mode,'');
Erreur:=GraphResult;
If Erreur<>GrOk then
             Begin
             TextColor(LightRed+Blink);
             Write('ERREUR : ');
             TExtColor(LightBlue);
             Writeln(GraphErrorMsg(Erreur));
             Writeln('Arrˆt du programme...');
             End;
SetVisualPage(1);
SetActivePage(1);
ClearDevice;
SetActivePage(0);
Cleardevice;
PreparePointer;
SetVisualPage(1);
ClearDevice;
SetActivePage(0);
ClearDevice;
SetTextStyle(4,0,8);
SetTextJustify(1,1);
SetColor(Blue);
PrepareTitre;
SetVisualPage(0);
Repeat Titre; Until keypressed;
SetVisualPage(1);
SetActivePage(1);
ClearDevice;
SetActivePage(0);
Cleardevice;
i:=1;
SetBKColor(0);
Ch:=ReadKey;
AssigneNiveau(1);
Pts:=0;
ClearDevice;
AfficheNiveau(1);
SetVisualPage(0);
Joue(1);
DisPosePointer;
End.