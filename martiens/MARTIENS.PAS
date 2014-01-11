uses graph,crt;

const
  { The names of the various device drivers supported }
  DriverNames : array[0..10] of string[8] =
  ('Detect', 'CGA', 'MCGA', 'EGA', 'EGA64', 'EGAMono',
   'RESERVED', 'HercMono', 'ATT400', 'VGA', 'PC3270');

  { The five fonts available }
  Fonts : array[0..4] of string[13] =
  ('DefaultFont', 'TriplexFont', 'SmallFont', 'SansSerifFont', 'GothicFont');

  { The five predefined line styles supported }
  LineStyles : array[0..4] of string[9] =
  ('SolidLn', 'DottedLn', 'CenterLn', 'DashedLn', 'UserBitLn');

  { The twelve predefined fill styles supported }
  FillStyles : array[0..11] of string[14] =
  ('EmptyFill', 'SolidFill', 'LineFill', 'LtSlashFill', 'SlashFill',
   'BkSlashFill', 'LtBkSlashFill', 'HatchFill', 'XHatchFill',
   'InterleaveFill', 'WideDotFill', 'CloseDotFill');

  { The two text directions available }
  TextDirect : array[0..1] of string[8] = ('HorizDir', 'VertDir');

  { The Horizontal text justifications available }
  HorizJust  : array[0..2] of string[10] = ('LeftText', 'CenterText', 'RightText');

  { The vertical text justifications available }
  VertJust   : array[0..2] of string[10] = ('BottomText', 'CenterText', 'TopText');


var mode,pilote    : integer;
    startX,startY  : integer;
    r,w            : integer;
    couleur        : byte;
    curport        : viewportType;
    pause          : word;
    initpause      : word;
    saucer         : pointer;
    X, Y           : integer;
    ulx, uly       : word;
    lrx, lry       : word;
    Size           : word;
    I              : word;
    ch             : char;
    xo, yo, angle  : integer;
    x2, y2, xx, yy : integer;
    angle2         : integer;
    pre, pri       : boolean;
    compte         : byte;
    touche         : word;
    toucheS        : string[100];

procedure MoveSaucer(var X,Y:integer;Width,Height : integer);
var Step:integer;
begin
Step:=random(2*r);
if not(odd(step)) then
   step:=-step;
x:=x+step;
step:=random(r+2);
if not(odd(step)) then step:=-step;
y:=y+step;
{with Curport do
     begin
       if (x1+X+width-1>x2) then x:=x2-x1-width+1
     else
       if (x<0) then x:=10;
       if (y1+y+height-1>y2) then y:=y2-y1-height+1
     else
       if (y<0) then y:=10;
     end;}
if X>640 then x:=635;
if X<0 then x:=5;
if Y<0 then y:=5;
y:=y+3;
x:=x-3;
end;

function int2str(l:longint) :string;
var s:string;
begin
str(l,s);
int2str:=s;
end;

procedure GetDriverAndMode(var DriveStr, ModeStr : string);
{ Return strings describing the current device driver and graphics mode
  for display status report }
begin
  DriveStr := DriverNames[pilote];
  mode := GetGraphMode;
  case pilote of
    CGA        : case mode of
                   CGAC0 : ModeStr := 'CGAC0';
                   CGAC1 : ModeStr := 'CGAC1';
                   CGAC2 : ModeStr := 'CGAC2';
                   CGAC3 : ModeStr := 'CGAC3';
                   CGAHi : ModeStr := 'CGAHi';
                 end; { case }
    MCGA       : case mode of
                   MCGAC0  : ModeStr := 'MCGAC0';
                   MCGAC1  : ModeStr := 'MCGAC1';
                   MCGAC2  : ModeStr := 'MCGAC2';
                   MCGAC3  : ModeStr := 'MCGAC3';
                   MCGAMed : ModeStr := 'MCGAMed';
                   MCGAHi  : ModeStr := 'MCGAHi';
                 end; { case }
    EGA         : case mode of
                    EGALo : ModeStr := 'EGALo';
                    EGAHi : ModeStr := 'EGAHi';
                  end;
    EGA64       : case mode of
                    EGA64Lo :  ModeStr := 'EGA64Lo';
                    EGA64Hi :  ModeStr := 'EGA64Hi';
                  end; { case }
     HercMono   : ModeStr := 'HercMonoHi';
     EGAMono    : ModeStr := 'EGAMonoHi';
     PC3270     : ModeStr := 'PC3270Hi';
     ATT400     : case mode of
                    ATT400C0  : ModeStr := 'ATT400C0';
                    ATT400C1  : ModeStr := 'ATT400C1';
                    ATT400C2  : ModeStr := 'ATT400C2';
                    ATT400C3  : ModeStr := 'ATT400C3';
                    ATT400Med : ModeStr := 'ATT400Med';
                    ATT400Hi  : ModeStr := 'ATT400Hi';
                  end; { case }
     VGA         : case mode of
                     VGALo  : ModeStr := 'VGALo';
                     VGAMed : ModeStr := 'VGAMed';
                     VGAHi  : ModeStr := 'VGAHi';
                   end; { case }
  end; { case }
end; { GetDriverAndMode }


procedure ReportStatus;
{ Display the status of all query functions after InitGraph }
const
  X = 10;
var
  ViewInfo   : ViewPortType;     { Parameters for inquiry procedures }
  LineInfo   : LineSettingsType;
  FillInfo   : FillSettingsType;
  TextInfo   : TextSettingsType;
  Palette    : PaletteType;
  DriverStr  : string;           { Driver and mode strings }
  ModeStr    : string;
  Y          : word;

procedure WriteOut(S : string);
{ Write out a string and increment to next line }
begin
  OutTextXY(X, Y, S);
  Inc(Y, TextHeight('M')+2);
end; { WriteOut }

begin { ReportStatus }
  cleardevice;
  GetDriverAndMode(DriverStr, ModeStr);   { Get current settings }
  GetViewSettings(ViewInfo);
  GetLineSettings(LineInfo);
  GetFillSettings(FillInfo);
  GetTextSettings(TextInfo);
  GetPalette(Palette);

  Y := 4;
  SetTextJustify(LeftText, TopText);
  WriteOut('Graphics device    : '+DriverStr);
  WriteOut('Graphics mode      : '+ModeStr);
  WriteOut('Screen resolution  : (0, 0, '+Int2Str(GetMaxX)+', '+Int2Str(GetMaxY)+')');
  with ViewInfo do
  begin
    WriteOut('Current view port  : ('+Int2Str(x1)+', '+Int2Str(y1)+', '+Int2Str(x2)+', '+Int2Str(y2)+')');
    if ClipOn then
      WriteOut('Clipping           : ON')
    else
      WriteOut('Clipping           : OFF');
  end;
  WriteOut('Current position   : ('+Int2Str(GetX)+', '+Int2Str(GetY)+')');
  WriteOut('Palette entries    : '+Int2Str(Palette.Size));
  WriteOut('GetMaxColor        : '+Int2Str(GetMaxColor));
  WriteOut('Current color      : '+Int2Str(GetColor));
  with LineInfo do
  begin
    WriteOut('Line style         : '+LineStyles[LineStyle]);
    WriteOut('Line thickness     : '+Int2Str(Thickness));
  end;
  with FillInfo do
  begin
    WriteOut('Current fill style : '+FillStyles[Pattern]);
    WriteOut('Current fill color : '+Int2Str(Color));
  end;
  with TextInfo do
  begin
    WriteOut('Current font       : '+Fonts[Font]);
    WriteOut('Text direction     : '+TextDirect[Direction]);
    WriteOut('Character size     : '+Int2Str(CharSize));
    WriteOut('Horizontal justify : '+HorizJust[Horiz]);
    WriteOut('Vertical justify   : '+VertJust[Vert]);
  end;
repeat until keypressed;
ch:=readkey;
end; { ReportStatus }


begin
randomize;
startX:=200;
touche:=0;
startY:=100;
pri:=false;
r:=20;
angle:=20;
pause:=200;
initpause:=200;
pre:=false;
pilote:=detect;
initgraph(pilote,mode,'');
cleardevice;
{if w=0 then w:=1 else w:=0;
putpixel(startX,startY,i);
putpixel(startX-r,startY-(r DIV 3)-2,i);
putpixel(startX-r,startY+(r DIV 3)+2,i);
putpixel(startX+r,startY+(r DIV 3)+2,i);
putpixel(startX+r,startY-(r DIV 3)-2,i);}
Ellipse(startX,startY,0,360,r,(r DIV 3)+2);
Ellipse(startX,startY-4,190,357,r,r DIV 3);
Line(StartX+7,startY-6,startX+10,startY-12);
circle(startX+10,StartY-12,2);
Line(StartX-7,startY-6,startX-10,startY-12);
circle(startX-10,StartY-12,2);
setfillstyle(solidfill,1);
floodfill(startX+1,startY+4,getcolor);
X:=500;
Y:=50;
ulx:=startX-(r+1);
uly:=startY-14;
lrx:=startX+(r+1);
lry:=startY+(r DIV 3)+3;
Size:=imagesize(ulx,uly,lrx,lry);
getmem(saucer,size);
getimage(ulx,uly,lrx,lry,saucer^);
putimage(ulx,uly,saucer^,Xorput);
{decor};
cleardevice;
for i:=1 to 1000 do
    putpixel(random(getmaxX),random(getmaxY),1);
RECTANGLE(0,158,183,199);
RECTANGLE(14,167,84,173);
RECTANGLE(102,167,165,173);
LINE(0,158,57,139);
LINE(182,158,225,142);
LINE(224,142,224,187);
LINE(223,187,182,199);
LINE(58,139,231,139);
LINE(224,143,230,140);
LINE(230,140,230,184);
LINE(230,184,223,187);
ELLIPSE(128,146,0,180,38,17);
LINE(89,146,166,146);
setcolor(0);
LINE(98,139,158,139);
setcolor(1);
LINE(230,187,639,187);
{LINE(127,138,179,122);}
{setfillstyle(1,1);
FLOODFILL(117,138,1);
setfillstyle(9,1);
FLOODFILL(288,189,1);}
{le 1er flood sera plein}
{le 2eme sera tram‚}
{deplacement de la soucoupe}
ch:=' ';
angle:=-angle;
repeat
      if keypressed then ch:=readkey;
      if (ch=chr(75)) and (angle>-180) and (not(pri)) then
                    begin
                    setcolor(0);
                    if pre then line(127,138,xo,yo);
                    if pre then line(127,139,xo,yo);
                    if pre then line(127,137,xo,yo);
                    pre:=true;
                    angle:=angle-1;
                    xo:=round(127+54.405882*cos(angle/180*pi));
                    yo:=round(138+54.405882*sin(angle/180*pi));
                    setcolor(1);
                    line(127,138,xo,yo);
                    line(127,139,xo,yo);
                    line(127,137,xo,yo);
                    ELLIPSE(128,146,0,180,38,17);
                    end;
      if (ch=chr(77)) and (angle<0) and (not(pri)) then
                    begin
                    setcolor(0);
                    if pre then line(127,138,xo,yo);
                    if pre then line(127,139,xo,yo);
                    if pre then line(127,137,xo,yo);
                    pre:=true;
                    angle:=angle+1;
                    xo:=round(127+54.405882*cos(angle/180*pi));
                    yo:=round(138+54.405882*sin(angle/180*pi));
                    setcolor(1);
                    line(127,138,xo,yo);
                    line(127,139,xo,yo);
                    line(127,137,xo,yo);
                    ELLIPSE(128,146,0,180,38,17);
                    end;
      if pri then ch:=' ';
      for compte:=1 to 2 do
      if (ch=' ') and (pre) then
                    begin
                    sound(50);
                    delay(10);
                    Nosound;
                    if not(pri) then angle2:=angle;
                    if not(pri) then begin x2:=xo;y2:=yo;end;
                    setcolor(0);
                    if pri then line(x2,y2,xx,yy);
                    if pri then begin x2:=xx;y2:=yy;end;
                    xx:=round(x2+20*cos(angle2/180*pi));
                    yy:=round(y2+20*sin(angle2/180*pi));
                    pri:=true;
                    setcolor(1);
                    line(x2,y2,xx,yy);
                    if (xx>X) and (yy>Y) and (xx<X+r+r+2) and (yy<Y+(r DIV 3)+17) then
                                  begin
                                  ch:='&';
                                  setcolor(0);
                                  line(x2,y2,xx,yy);
                                  setcolor(1);
                                  sound(50);delay(1000);NoSound;
                                  X:=500;Y:=50;
                                  pri:=false;
                                  touche:=touche+1;
                                  end;
                    if (xx<0) or (xx>640) or (yy<0) or (yy>200) then
                                             begin
                                             ch:='&';
                                             sound(50);delay(70);Nosound;
                                             setcolor(0);
                                             line(x2,y2,xx,yy);
                                             setcolor(1);
                                             pri:=false;
                                             end;
                    end;
      if ch=chr(27) then
                    begin
                    str(touche,toucheS);
                    Cleardevice;
                    putimage(170,90,saucer^,NormalPut);
                    if touche<2 then outtextXY(220,100,'Tu as touch‚ '+toucheS+' soucoupe.');
                    if touche>1 then outtextXY(220,100,'Tu as touch‚ '+toucheS+' soucoupes.');
                    ch:=readkey;
                    freemem(saucer,size);
                    Halt;
                    end;
      putimage(X,Y,saucer^,xorput);
      delay(50);
      putimage(X,Y,saucer^,xorpUT);
      y:=y-5;
      MoveSaucer(X,Y,lrx-ulx+1,lry-uly+1);
until (Y>=184);
putimage(X,Y,saucer^,XORPUT);
couleur:=1;
{martien (bulle)}
PUTPIXEL(324,145,Couleur);
PUTPIXEL(323,145,Couleur);
PUTPIXEL(322,145,Couleur);
PUTPIXEL(321,145,Couleur);
PUTPIXEL(320,145,Couleur);
PUTPIXEL(320,146,Couleur);
PUTPIXEL(319,146,Couleur);
PUTPIXEL(319,147,Couleur);
PUTPIXEL(318,147,Couleur);
PUTPIXEL(318,148,Couleur);
PUTPIXEL(317,148,Couleur);
PUTPIXEL(317,149,Couleur);
PUTPIXEL(317,150,Couleur);
PUTPIXEL(316,150,Couleur);
PUTPIXEL(316,151,Couleur);
PUTPIXEL(316,152,Couleur);
PUTPIXEL(317,153,Couleur);
PUTPIXEL(317,154,Couleur);
PUTPIXEL(318,155,Couleur);
PUTPIXEL(319,156,Couleur);
PUTPIXEL(320,156,Couleur);
PUTPIXEL(320,157,Couleur);
PUTPIXEL(321,157,Couleur);
PUTPIXEL(321,158,Couleur);
PUTPIXEL(322,158,Couleur);
PUTPIXEL(322,159,Couleur);
PUTPIXEL(323,159,Couleur);
PUTPIXEL(323,160,Couleur);
PUTPIXEL(324,160,Couleur);
PUTPIXEL(325,161,Couleur);
PUTPIXEL(326,161,Couleur);
PUTPIXEL(326,162,Couleur);
PUTPIXEL(327,163,Couleur);
PUTPIXEL(327,164,Couleur);
PUTPIXEL(328,164,Couleur);
PUTPIXEL(329,164,Couleur);
PUTPIXEL(330,163,Couleur);
PUTPIXEL(331,162,Couleur);
PUTPIXEL(332,162,Couleur);
PUTPIXEL(332,161,Couleur);
PUTPIXEL(333,161,Couleur);
PUTPIXEL(333,160,Couleur);
PUTPIXEL(334,160,Couleur);
PUTPIXEL(334,159,Couleur);
PUTPIXEL(335,159,Couleur);
PUTPIXEL(335,158,Couleur);
PUTPIXEL(336,158,Couleur);
PUTPIXEL(336,157,Couleur);
PUTPIXEL(337,157,Couleur);
PUTPIXEL(338,157,Couleur);
PUTPIXEL(338,156,Couleur);
PUTPIXEL(339,156,Couleur);
PUTPIXEL(340,155,Couleur);
PUTPIXEL(341,155,Couleur);
PUTPIXEL(342,154,Couleur);
PUTPIXEL(343,154,Couleur);
PUTPIXEL(344,153,Couleur);
PUTPIXEL(345,153,Couleur);
PUTPIXEL(346,152,Couleur);
PUTPIXEL(347,152,Couleur);
PUTPIXEL(348,152,Couleur);
PUTPIXEL(348,151,Couleur);
PUTPIXEL(348,150,Couleur);
PUTPIXEL(349,149,Couleur);
PUTPIXEL(349,148,Couleur);
PUTPIXEL(349,147,Couleur);
PUTPIXEL(348,146,Couleur);
PUTPIXEL(348,145,Couleur);
PUTPIXEL(347,145,Couleur);
PUTPIXEL(347,144,Couleur);
PUTPIXEL(346,144,Couleur);
PUTPIXEL(346,143,Couleur);
PUTPIXEL(345,143,Couleur);
PUTPIXEL(344,142,Couleur);
PUTPIXEL(343,142,Couleur);
PUTPIXEL(342,142,Couleur);
PUTPIXEL(341,142,Couleur);
PUTPIXEL(340,142,Couleur);
PUTPIXEL(340,141,Couleur);
PUTPIXEL(339,141,Couleur);
PUTPIXEL(338,141,Couleur);
PUTPIXEL(337,141,Couleur);
PUTPIXEL(336,141,Couleur);
PUTPIXEL(335,141,Couleur);
PUTPIXEL(334,141,Couleur);
PUTPIXEL(333,141,Couleur);
PUTPIXEL(332,141,Couleur);
PUTPIXEL(331,142,Couleur);
PUTPIXEL(330,142,Couleur);
PUTPIXEL(329,143,Couleur);
PUTPIXEL(328,143,Couleur);
PUTPIXEL(327,143,Couleur);
PUTPIXEL(326,143,Couleur);
PUTPIXEL(325,143,Couleur);
PUTPIXEL(324,143,Couleur);
PUTPIXEL(323,144,Couleur);
PUTPIXEL(322,144,Couleur);
PUTPIXEL(319,180,Couleur);
PUTPIXEL(320,181,Couleur);
PUTPIXEL(321,181,Couleur);
PUTPIXEL(322,181,Couleur);
PUTPIXEL(322,182,Couleur);
PUTPIXEL(321,182,Couleur);
PUTPIXEL(320,183,Couleur);
PUTPIXEL(319,183,Couleur);
PUTPIXEL(319,182,Couleur);
PUTPIXEL(320,182,Couleur);
PUTPIXEL(318,181,Couleur);
PUTPIXEL(317,181,Couleur);
PUTPIXEL(317,182,Couleur);
PUTPIXEL(316,182,Couleur);
PUTPIXEL(316,183,Couleur);
PUTPIXEL(315,183,Couleur);
PUTPIXEL(314,183,Couleur);
PUTPIXEL(313,183,Couleur);
PUTPIXEL(312,183,Couleur);
PUTPIXEL(311,183,Couleur);
PUTPIXEL(310,183,Couleur);
PUTPIXEL(311,182,Couleur);
PUTPIXEL(311,181,Couleur);
PUTPIXEL(312,181,Couleur);
PUTPIXEL(313,180,Couleur);
PUTPIXEL(314,180,Couleur);
PUTPIXEL(315,180,Couleur);
PUTPIXEL(316,180,Couleur);
PUTPIXEL(316,179,Couleur);
PUTPIXEL(315,179,Couleur);
PUTPIXEL(314,179,Couleur);
PUTPIXEL(314,178,Couleur);
PUTPIXEL(313,178,Couleur);
PUTPIXEL(313,177,Couleur);
PUTPIXEL(314,176,Couleur);
PUTPIXEL(314,175,Couleur);
PUTPIXEL(315,175,Couleur);
PUTPIXEL(315,174,Couleur);
PUTPIXEL(315,173,Couleur);
PUTPIXEL(309,176,Couleur);
PUTPIXEL(310,176,Couleur);
PUTPIXEL(310,175,Couleur);
PUTPIXEL(311,175,Couleur);
PUTPIXEL(311,174,Couleur);
PUTPIXEL(312,174,Couleur);
PUTPIXEL(313,174,Couleur);
PUTPIXEL(313,173,Couleur);
PUTPIXEL(314,173,Couleur);
PUTPIXEL(314,172,Couleur);
PUTPIXEL(311,176,Couleur);
PUTPIXEL(312,177,Couleur);
PUTPIXEL(314,177,Couleur);
PUTPIXEL(315,177,Couleur);
PUTPIXEL(319,172,Couleur);
PUTPIXEL(319,173,Couleur);
PUTPIXEL(320,173,Couleur);
PUTPIXEL(320,174,Couleur);
PUTPIXEL(320,175,Couleur);
PUTPIXEL(320,176,Couleur);
PUTPIXEL(321,176,Couleur);
PUTPIXEL(321,177,Couleur);
PUTPIXEL(321,178,Couleur);
PUTPIXEL(321,179,Couleur);
PUTPIXEL(321,180,Couleur);
PUTPIXEL(322,180,Couleur);
PUTPIXEL(323,181,Couleur);
PUTPIXEL(323,182,Couleur);
PUTPIXEL(321,173,Couleur);
PUTPIXEL(322,174,Couleur);
PUTPIXEL(323,175,Couleur);
PUTPIXEL(323,176,Couleur);
PUTPIXEL(324,176,Couleur);
PUTPIXEL(324,177,Couleur);
PUTPIXEL(325,177,Couleur);
PUTPIXEL(325,178,Couleur);
PUTPIXEL(324,178,Couleur);
PUTPIXEL(323,178,Couleur);
PUTPIXEL(322,178,Couleur);
PUTPIXEL(322,177,Couleur);
PUTPIXEL(316,165,Couleur);
PUTPIXEL(315,165,Couleur);
PUTPIXEL(314,165,Couleur);
PUTPIXEL(314,166,Couleur);
PUTPIXEL(313,166,Couleur);
PUTPIXEL(312,166,Couleur);
PUTPIXEL(311,167,Couleur);
PUTPIXEL(311,168,Couleur);
PUTPIXEL(312,168,Couleur);
PUTPIXEL(312,169,Couleur);
PUTPIXEL(313,169,Couleur);
PUTPIXEL(314,169,Couleur);
PUTPIXEL(315,169,Couleur);
PUTPIXEL(316,169,Couleur);
PUTPIXEL(317,169,Couleur);
PUTPIXEL(318,169,Couleur);
PUTPIXEL(319,169,Couleur);
PUTPIXEL(320,169,Couleur);
PUTPIXEL(321,169,Couleur);
PUTPIXEL(322,169,Couleur);
PUTPIXEL(323,169,Couleur);
PUTPIXEL(324,169,Couleur);
PUTPIXEL(324,168,Couleur);
PUTPIXEL(324,167,Couleur);
PUTPIXEL(324,166,Couleur);
PUTPIXEL(323,166,Couleur);
PUTPIXEL(322,166,Couleur);
PUTPIXEL(321,166,Couleur);
PUTPIXEL(321,167,Couleur);
PUTPIXEL(320,167,Couleur);
PUTPIXEL(320,166,Couleur);
PUTPIXEL(320,165,Couleur);
PUTPIXEL(319,165,Couleur);
PUTPIXEL(318,165,Couleur);
PUTPIXEL(317,165,Couleur);
PUTPIXEL(315,167,Couleur);
PUTPIXEL(311,164,Couleur);
PUTPIXEL(312,164,Couleur);
PUTPIXEL(313,165,Couleur);
PUTPIXEL(317,163,Couleur);
PUTPIXEL(316,163,Couleur);
PUTPIXEL(316,164,Couleur);
PUTPIXEL(316,170,Couleur);
PUTPIXEL(315,170,Couleur);
PUTPIXEL(314,170,Couleur);
PUTPIXEL(314,171,Couleur);
PUTPIXEL(313,172,Couleur);
PUTPIXEL(318,170,Couleur);
PUTPIXEL(317,170,Couleur);
PUTPIXEL(317,171,Couleur);
PUTPIXEL(318,171,Couleur);
PUTPIXEL(318,172,Couleur);
ELLIPSE(311,164,0,360,0,0);
ELLIPSE(316,163,0,360,0,0);
{ecrire … l'endroit de
ce point pour ‚crire
dans la bulle}
PUTPIXEL(321,151,Couleur);
outtextXY(321,151,'Ouf !');
freemem(saucer,size);
end.