UNIT piece;
INTERFACE
USES graph;

const fill1 : FillPatternType = ($AA,$55,$AA,$55,$AA,$55,$AA,$55);
      Tapis : FillPatternType = ($29,$94,$42,$29,$94,$42,$29,$94);
      fill2 : FillPatternType = ($88,$44,$22,$11,$88,$44,$22,$11);
      fill3 : FillPatternType = ($C1,$E3,$E3,$F7,$F7,$22,$F7,$E3);
      rond1 : FillPatternType = ($FF,$FF,$7E,$BD,$BD,$7E,$FF,$FF);
      rond2 : FillPatternType = ($FF,$3C,$DB,$DB,$DB,$DB,$3C,$FF);

var endroit:string[20];
    tableau,grille,epee,essuie,lave,bouteille,mouchoir,bombe      : boolean;
    vaiselle,lampe,bougeoir,tresor,parchemin,clef,collier,gara    : boolean;
    colle,peinture,contact,thermometre,marteau,huile,boulon,tuyau : boolean;
    P_hall,P_salon,cave_ecl,P_cave,rustine,torchon,boulon_mis     : boolean;

procedure init;

IMPLEMENTATION

procedure init;
begin
grille:=true;epee:=false;tableau:=false;essuie:=false;lave:=false;bombe:=false;
mouchoir:=false;bouteille:=false;clef:=false;vaiselle:=false;lampe:=false;collier:=false;
p_hall:=false;p_salon:=false;cave_ecl:=false;P_cave:=false;tresor:=false;parchemin:=false;
colle:=false;peinture:=false;contact:=false;thermometre:=false;marteau:=false;gara:=false;
boulon:=false;boulon_mis:=false;tuyau:=false;torchon:=false;rustine:=false;huile:=false;
bougeoir:=false;
end;

begin
init;
end.


