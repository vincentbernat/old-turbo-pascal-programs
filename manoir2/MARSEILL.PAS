uses crt;

var i,w:integer;


begin
i:=500;
sound(156);delay(i DIV 3);Nosound;delay(15);
sound(156);delay(i DIV 2);Nosound;delay(15);
sound(156);delay(i DIV 3);nosound;delay(15);
sound(208);delay(i);nosound;delay(15);
sound(208);delay(i);nosound;delay(15);
sound(233);delay(i);nosound;delay(15);
sound(233);delay(i);nosound;delay(15);
w:=round(i*1.5);
sound(312);delay(w);
sound(247);delay(i DIV 2);nosound;delay(15);
sound(208);delay(i DIV 2);Nosound;
delay(150);
{Nosound;
delay(15);
}sound(208);delay(i DIV 3);
w:=round((i DIV 3)*1.5);
sound(247);delay(w);nosound;delay(15);
sound(208);delay(i DIV 3);nosound;delay(10);
sound(165);delay(i);nosound;delay(15);
sound(278);delay(i*2);nosound;delay(15);
w:=round((i DIV 3)*1.5);
sound(233);delay(w);nosound;delay(15);
w:=i DIV 3;
sound(185);delay(w);nosound;delay(15);
sound(208);delay(i*2);nosound;delay(1000);
end.
