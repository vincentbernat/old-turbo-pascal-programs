UNIT Pescalier;
INTERFACE
USES graph,piece;

procedure escalier;

IMPLEMENTATION

var couleur,bord:integer;

procedure escalier;
var bord:integer;
begin
bord:=3;
setcolor(3);
endroit:='ESCALIER';
Cleardevice;
RECTANGLE(15,16,304,177);
LINE(38,164,50,130);
LINE(50,130,284,134);
LINE(39,164,290,169);
LINE(290,169,285,135);
LINE(60,130,74,101);
LINE(74,101,258,104);
LINE(275,134,259,104);
LINE(83,101,99,70);
LINE(248,104,237,71);
LINE(237,71,99,70);
LINE(111,70,126,34);
LINE(230,71,219,41);
LINE(220,41,124,39);
LINE(138,40,150,12);
LINE(210,41,196,13);
LINE(196,13,150,12);
LINE(143,87,170,90);
LINE(191,90,227,86);
LINE(100,97,130,96);
LINE(105,79,126,83);
LINE(38,164,38,48);
LINE(38,48,84,0);
LINE(98,70,83,99);
LINE(290,169,290,64);
LINE(290,64,290,168);
LINE(290,63,233,0);
{en tapis vert}
setfillpattern(tapis,1);
FLOODFILL(84,69,Bord);
FLOODFILL(264,73,Bord);
{en jaune fill1}
setfillpattern(fill1,3);
FLOODFILL(201,146,Bord);
FLOODFILL(193,117,Bord);
FLOODFILL(188,83,Bord);
FLOODFILL(187,49,Bord);
FLOODFILL(185,27,Bord);
{ecris en noir}
setcolor(0);
LINE(105,79,126,83);
LINE(143,87,170,90);
LINE(100,97,130,96);
LINE(191,91,227,86);
LINE(191,90,227,86);
setcolor(3);
end;

begin
couleur:=3;
bord:=3;
end.