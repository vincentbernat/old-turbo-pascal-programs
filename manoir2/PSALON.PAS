UNIT Psalon;
INTERFACE
USES graph,piece;

procedure salon;

IMPLEMENTATION

var couleur,bord:integer;

procedure salon;
begin
Cleardevice;
endroit:='SALON';
setcolor(3);
RECTANGLE(15,16,304,177);
{pot}
RECTANGLE(29,49,43,65);
setfillstyle(1,3);
floodfill(30,50,3);
{canap�}
RECTANGLE(97,58,188,64);
RECTANGLE(185,64,101,74);
LINE(188,58,201,44);
LINE(189,65,204,49);
LINE(186,75,200,62);
LINE(200,62,203,59);
LINE(203,59,203,51);
LINE(186,76,184,75);
RECTANGLE(202,44,107,19);
LINE(107,45,97,58);
ELLIPSE(121,32,0,360,1,2);
ELLIPSE(183,33,0,360,0,2);
LINE(205,23,203,19);
LINE(205,50,205,23);
setfillstyle(1,1);
floodfill(98,59,3);
floodfill(184,65,3);
floodfill(200,30,3);
floodfill(199,70,3);
floodfill(170,55,3);
setfillpattern(fill1,1);
floodfill(204,30,3);
floodfill(186,67,3);
{mouchoir}
if not(mouchoir) then
            begin
            LINE(215,60,210,69);
            LINE(210,69,204,74);
            LINE(204,74,209,70);
            LINE(204,75,220,82);
            LINE(220,82,222,76);
            LINE(223,76,230,70);
            LINE(230,70,215,62);
            LINE(203,76,202,73);
            LINE(202,73,207,69);
            LINE(207,69,211,61);
            LINE(211,61,213,62);
            LINE(211,61,214,59);
            LINE(214,59,232,68);
            LINE(232,68,230,70);
            LINE(214,65,214,68);
            LINE(214,68,216,66);
            LINE(218,67,216,69);
            setfillstyle(1,2);
            floodfill(220,74,3);
            end;
{bouteille}
if not(bouteille) then
   begin
   LINE(135,100,135,118);
   LINE(135,118,140,121);
   LINE(140,121,143,121);
   LINE(143,121,147,118);
   LINE(147,118,147,100);
   LINE(147,100,136,101);
   LINE(135,101,139,96);
   LINE(139,96,140,92);
   LINE(147,100,144,95);
   LINE(144,95,144,92);
   LINE(144,92,141,92);
   LINE(136,103,147,102);
   LINE(140,95,143,95);
   end
 else line(159,104,130,104);
{table}
RECTANGLE(117,126,120,158);
RECTANGLE(165,157,168,127);
RECTANGLE(129,127,132,139);
RECTANGLE(152,128,155,140);
setfillstyle(1,3);
floodfill(118,127,3);
floodfill(166,155,3);
floodfill(130,128,3);
floodfill(153,129,3);
LINE(117,126,129,105);
LINE(169,127,159,104);
LINE(159,104,148,104);
LINE(135,104,130,104);
LINE(130,105,134,105);
LINE(121,127,166,127);
LINE(121,129,165,129);
setfillstyle(9,3);
floodfill(132,126,3);
{tiroir}
LINE(36,100,33,129);
LINE(33,129,55,136);
LINE(55,136,59,103);
LINE(59,104,37,100);
LINE(36,100,48,95);
LINE(58,103,68,99);
LINE(68,99,49,95);
LINE(68,100,64,131);
LINE(64,131,56,135);
LINE(36,109,58,112);
LINE(34,119,56,123);
ELLIPSE(48,106,0,360,1,1);
ELLIPSE(46,117,0,360,1,0);
ELLIPSE(45,127,0,360,0,0);
{decor du fond}
LINE(0,199,35,130);
LINE(50,95,86,39);
LINE(319,198,226,40);
RECTANGLE(28,66,49,68);
RECTANGLE(49,68,28,66);
LINE(86,39,86,6);
LINE(86,6,227,6);
LINE(227,6,227,42);
LINE(227,42,205,42);
LINE(86,40,107,40);
LINE(86,6,0,0);
LINE(227,6,319,0);
LINE(256,90,256,37);
LINE(256,37,280,69);
LINE(279,69,279,129);
LINE(260,81,263,85);
setfillpattern(tapis,1);
floodfill(200,100,3);
setfillstyle(11,2);
floodfill(17,17,3);
floodfill(300,17,3);
floodfill(160,17,3);
{support du pot}
RECTANGLE(166,19,140,9);
{plante}
setcolor(1);
LINE(31,49,27,36);
LINE(39,49,45,39);
LINE(43,43,38,32);
LINE(40,35,44,24);
LINE(41,39,30,31);
LINE(28,40,33,37);
LINE(27,39,24,35);
LINE(33,34,37,26);
LINE(35,49,31,34);
LINE(33,39,35,27);
LINE(34,41,37,44);
LINE(35,41,38,40);
putpixel(102,77,2);
setcolor(3);
end;

begin
couleur:=3;
bord:=3;
end.