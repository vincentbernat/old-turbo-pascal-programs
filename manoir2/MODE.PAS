procedure chMode;
var rep:chaine;
    erreur,mode:integer;
    ch:char;
    caVa:boolean;
begin
    entete('Mode graphique (0 a 5): ');
    repeat
    moveto(2+8*24,4);
      litchaine(rep,1,['0'..'5'],sortie);
      if sortie then EXIT;
      val(rep,mode,erreur);
      setgraphmode(mode);
      caVa:=true;
      if graphresult=-10 then
      begin
        entete('mode invalide              <ESC>');
        litcar(ch,[#27]);
        entete('Mode graphique (0 a 5): ');
        caVa:=false;
     end;
     until caVa;
     closegraph;initgraphic(mode);
     xcurseur:=XScreenMaxglb div 2;ycurseur:=ymaxglb div 2;
     calculEcran(0,0);
     preserveSauf(objetcourant);
     dessiner;
     sortie:=true;
end;
