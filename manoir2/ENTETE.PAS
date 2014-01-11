uses graph;

var mode,pilote:integer;


begin
mode:=0;
pilote:=cga;
initgraph(pilote,mode,'');
RECTANGLE(24,64,301,127);
RECTANGLE(301,70,310,135);
RECTANGLE(301,135,32,127);
FLOODFILL(305,105,Bord);
FLOODFILL(112,133,Bord);
PUTPIXEL(47,98,Couleur);
{ecrire en center text
LE MANOIR HANTE a l'e-
a l'endroit du point}
PUTPIXEL(108,45,Couleur);
end.