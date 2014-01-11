unit titre;
interface
uses crt,graph;
         procedure debut;

implementation
procedure debut;
var  p,m:integer;
     a,b,c,d,e:integer;
begin
      p:=cga;m:=cgac2;
     initgraph(p,m,'');
     a:=160;b:=0;c:=160;d:=199;e:=1;
     repeat
           setcolor(e);
           line(a,b,c,d);
           if a>319 then a:=a-4;
           a:=a+4;c:=c-4;e:=e+1;
           if a>319 then
                    begin
                         a:=0;c:=319;e:=8;
                    end;
           if e>15 then e:=0;
           if c=0 then c:=c+40;
           outtextXY(111,100,'LA MAISON HANTEE')
     until keypressed;
     closegraph;
 end;
 end.