USES crt;

VAR
  liste:array[1..100] of string;

  ch,e:char;
  i:integer;
  z,w,c:integer;
  vitesse:integer;
  j,m,pa:integer;
  tiry,tirx,has:integer;
  n2,n:integer;
  j2:integer;
  vie,p:word;
  v:string;
  restore:integer;
  x,y,t:integer;
  ta:integer;
  a:integer;
  x1,y1:integer;
  x2,y2:integer;
  x3,y3:integer;
  x4,y4:integer;
  x5,y5:integer;
  h,b,d,g,k:boolean;
  b1,b2,b3,b4,b5,s:boolean;
  r:integer;

  procedure jeu;
  forward;


  procedure depart;
  var j,k,n,m:integer;
  BEGIN
  n:=n2;j:=j2;
     for ta:=1 to 20 do
       BEGIN
     for m:=1 to 35 do
         BEGIN
         if Copy(liste[n],m,1)='1' then
            BEGIN
            textcolor(green);
            HighVideo;
            gotoXY(m,n-(20*j));write('í');
            END;
         if Copy(liste[n],m,1)='2' then
            BEGIN
            textcolor(white);
            HighVideo;
            gotoXY(m,n-(20*j));write('ê');
            END;
         if copy(liste[n],m,1)=' ' then
            BEGIN
            gotoXY(m,n-(20*j));write(' ');
            END;
         if m=35 then n:=n+1;
         END;
       END;
jeu;
END;

procedure jeu;
begin
repeat
t:=0;
repeat
gotoXY(1,21);textcolor(9+blink);write('----------------------------------------');
gotoXY(5,22);textcolor(11);write('VIE    : ',vie);
gotoXY(5,23);textcolor(11);write('POINTS : ',p);
   if vie=0 then
      begin
      gotoXY(14,12);textcolor(143);HighVideo;write('  GAME OVER  ');
      gotoXY(14,12);textcolor(magenta);write('®');
      gotoXY(26,12);write('¯');
      repeat
      a:=0;
      ch:=readkey;
      if (ch='s') or (ch='S') then a:=2
      until a=2;
      Clrscr;
      repeat
      a:=9;
      repeat
      textcolor(a);gotoXY(6,12);write('JEU TERMINE AVEC ',p,' POINTS');
      a:=a+1;
      delay(200);
      until a=16;
      sound(660);delay(100);Nosound;
      until keypressed;
      Halt;
      end;
gotoXY(x,y);textcolor(Yellow);write('®');
delay(200);
gotoXY(x,y);textcolor(Yellow);write(' ');
t:=t+1;
if not(k) then x:=x-1;
if x=34 then x:=x-1;
if keypressed then
   BEGIN
   ch:=readkey;
   if ch=chr(77) then
      begin
      if x=34 then x:=x-1;
      x:=x+1;
      k:=true;
      end;
   if ch=chr(80) then
      begin
      y:=y+1;
      if y=21 then y:=y-1;
      k:=false;
      end;
   if ch=chr(72) then
      begin
      y:=y-1;
      if y=1 then y:=y+1;
      k:=false;
      end;
   if ch=chr(75) then
      begin
      x:=x-1;
      k:=false;
      end;
   END;
if (x+2)-2-3+3<3 then
   begin
   n2:=n2+20;
   j2:=j2+1;
   j:=j+1;
   vie:=vie+1;
   x:=34;
   if j2=5 then
      begin
      gotoXY(14,12);textcolor(143);write('BONUS 5000');
      p:=p+5000;
      repeat
      a:=0;
      ch:=readkey;
      if ch='s' then a:=1;
      if ch='S' then a:=1;
      until a=1;
      Clrscr;
      repeat
      a:=0;
      repeat
      textcolor(a);gotoXY(6,12);write('JEU TERMINE AVEC ',p,' POINTS');
      a:=a+1;
      sound(1660);delay(100);Nosound;
      if a=16 then a:=0;
      until keypressed;
      until keypressed;
      HALT;
      end;
     repeat
     a:=0;
     randomize;
     x1:=random(28)+2;y1:=random(16)+1;
     x2:=random(32)+2;y2:=random(11)+1;
     x3:=random(31)+2;y3:=random(14)+1;
     x4:=random(16)+2;y4:=random(18)+1;
     x5:=random(14)+2;y5:=random(16)+1;
     if copy(liste[y1+(j*20)],x1,1)='1' then a:=a else a:=a+1;
     if copy(liste[y2+(j*20)],x2,1)='1' then a:=a else a:=a+1;
     if copy(liste[y3+(j*20)],x3,1)='1' then a:=a else a:=a+1;
     if copy(liste[y4+(j*20)],x4,1)='1' then a:=a else a:=a+1;
     if copy(liste[y5+(j*20)],x5,1)='1' then a:=a else a:=a+1;
     until a=5;
   Clrscr;
   depart;
   end;
v:=copy(liste[y+(20*j)],x,1);
if v='1' then
   begin
   gotoXY(x,y);textcolor(red);write('°');
   sound(20);delay(900);Nosound;
   j:=j2;
   j2:=j;
   delete(liste[y+(20*j)],x,1);
   gotoXY(x,y);write(' ');
   vie:=vie-1;x:=34;
   a:=0;
   end;
v:=copy(liste[y+(20*j)],x,1);
if v='2' then
   begin
   p:=p+100;
   j:=j2;
   j2:=j;
   delete(liste[y+(20*j)],x,1)
   end;
if (x=x1) and (y=y1) then
   begin
   gotoXY(x,y);textcolor(red);write('°');
   sound(20);delay(900);Nosound;
   j:=j2;
   j2:=j;
   delete(liste[y+(20*j)],x,1);
   gotoXY(x,y);write(' ');
   vie:=vie-1;x:=34;
   a:=0;
   repeat
   a:=0;
     x1:=random(28)+2;y1:=random(16)+1;
     if copy(liste[y1],x1,1)='1' then a:=a else a:=a+1;
     until a=1;
   end;
if (x=x2) and (y=y2) then
   begin
   gotoXY(x,y);textcolor(red);write('°');
   sound(20);delay(900);Nosound;
   j:=j2;
   j2:=j;
   delete(liste[y+(20*j)],x,1);
   gotoXY(x,y);write(' ');
   vie:=vie-1;x:=34;
     repeat
     a:=0;
     x2:=random(28)+2;y2:=random(16)+1;
     if copy(liste[y2],x2,1)='1' then a:=a else a:=a+1;
     until a=1;
   end;
if (x=x3) and (y=y3) then
   begin
   gotoXY(x,y);textcolor(red);write('°');
   sound(20);delay(900);Nosound;
   j:=j2;
   j2:=j;
   delete(liste[y+(20*j)],x,1);
   gotoXY(x,y);write(' ');
   vie:=vie-1;x:=34;
     repeat
     a:=0;
     x3:=random(28)+2;y3:=random(16)+1;
     if copy(liste[y3],x3,1)='1' then a:=a else a:=a+1;
     until a=1;
   end;
if (x=x4) and (y=y4) then
   begin
   gotoXY(x,y);textcolor(red);write('°');
   sound(20);delay(900);Nosound;
   j:=j2;
   j2:=j;
   delete(liste[y+(20*j)],x,1);
   gotoXY(x,y);write(' ');
   vie:=vie-1;x:=34;
     repeat
     a:=0;
     x4:=random(28)+2;y4:=random(16)+1;
     if copy(liste[y4],x4,1)='1' then a:=a else a:=a+1;
     until a=1;
   end;
if (x=x5) and (y=y5) then
   begin
   gotoXY(x,y);textcolor(red);write('°');
   sound(20);delay(900);Nosound;
   j:=j2;
   j2:=j;
   delete(liste[y+(20*j)],x,1);
   gotoXY(x,y);write(' ');
   vie:=vie-1;x:=34;
     repeat
     a:=0;
     x5:=random(28)+2;y5:=random(16)+1;
     if copy(liste[y5],x5,1)='1' then a:=a else a:=a+1;
     until a=1;
   end;
until (t=2) or (ch=chr(27));
gotoXY(x,y);textcolor(Yellow);write('®');
gotoXY(x1,y1);textcolor(lightblue);write('®');
gotoXY(x2,y2);textcolor(lightblue);write('®');
gotoXY(x3,y3);textcolor(lightblue);write('®');
gotoXY(x4,y4);textcolor(lightblue);write('®');
gotoXY(x5,y5);textcolor(lightblue);write('®');
g:=false;
d:=false;
h:=false;
b:=false;
if b1 then
  begin
  gotoXY(x1,y1);write(' ');
  if (x<x1) and (copy(liste[y1+(j*20)],x1-1,1)<>'1') then x1:=x1-1;
  if (x>x1) and (copy(liste[y1+(j*20)],x1+1,1)<>'1') then x1:=x1+1;
  if (y<y1) and (copy(liste[(y1-1)+(j*20)],x1,1)<>'1') then y1:=y1-1;
  if (y>y1) and (copy(liste[(y1+1)+(j*20)],x1,1)<>'1') then y1:=y1+1;
  gotoXY(x1,y1);write('®');
  gotoXY(x2,y2);write(' ');
  if (x<x2) and (copy(liste[y2+(j*20)],x2-1,1)<>'1') then x2:=x2-1;
  if (x>x2) and (copy(liste[y2+(j*20)],x2+1,1)<>'1') then x2:=x2+1;
  if (y<y2) and (copy(liste[(y2-1)+(j*20)],x2,1)<>'1') then y2:=y2-1;
  if (y>y2) and (copy(liste[(y2+1)+(j*20)],x2,1)<>'1') then y2:=y2+1;
  gotoXY(x2,y2);write('®');
  end;
if b2 then
  begin
  gotoXY(x3,y3);write(' ');
  if (x<x3) and (copy(liste[y3+(j*20)],x3-1,1)<>'1') then x3:=x3-1;
  if (x>x3) and (copy(liste[y3+(j*20)],x3+1,1)<>'1') then x3:=x3+1;
  if (y<y3) and (copy(liste[(y3-1)+(j*20)],x3,1)<>'1') then y3:=y3-1;
  if (y>y3) and (copy(liste[(y3+1)+(j*20)],x3,1)<>'1') then y3:=y3+1;
  gotoXY(x3,y3);write('®');
  gotoXY(x4,y4);write(' ');
  if (x<x4) and (copy(liste[y4+(j*20)],x4-1,1)<>'1') then x4:=x4-1;
  if (x>x4) and (copy(liste[y4+(j*20)],x4+1,1)<>'1') then x4:=x4+1;
  if (y<y4) and (copy(liste[(y4-1)+(j*20)],x4,1)<>'1') then y4:=y4-1;
  if (y>y4) and (copy(liste[(y4+1)+(j*20)],x4,1)<>'1') then y4:=y4+1;
  gotoXY(x4,y4);write('®');
  end;
if b3 then
  begin
  gotoXY(x5,y5);write(' ');
  if (x<x5) and (copy(liste[y5+(j*20)],x5-1,1)<>'1') then x5:=x5-1;
  if (x>x5) and (copy(liste[y5+(j*20)],x5+1,1)<>'1') then x5:=x5+1;
  if (y<y5) and (copy(liste[(y5-1)+(j*20)],x5,1)<>'1') then y5:=y5-1;
  if (y>y5) and (copy(liste[(y5+1)+(j*20)],x5,1)<>'1') then y5:=y5+1;
  gotoXY(x5,y5);write('®');
  end;
s:=true;
if (b1) and (s) then
   begin
   b2:=true;
   b1:=false;
   s:=false;
   end;
if (b2) and (s) then
   begin
   b3:=true;
   b2:=false;
   s:=false;
   end;
if (b3) and (s) then
   begin
   b1:=true;
   b3:=false;
   s:=false;
   end;
if (y=y1) or (y=y2) or (y=y3) or (y=y4) or (y=y5) then
   begin
   if random(100)<20 then
      begin
      randomize;
      has:=random(5)+1;
      if has=1 then tiry:=y1;
      if has=1 then tirx:=x1;
      if has=2 then tiry:=y2;
      if has=2 then tirx:=x2;
      if has=3 then tirx:=x3;
      if has=4 then tirx:=x4;
      if has=5 then tirx:=x5;
      if has=6 then tirx:=x1;
      if has=3 then tiry:=y3;
      if has=4 then tiry:=y4;
      if has=5 then tiry:=y5;
      if has=6 then tiry:=y1;
      a:=0;
      repeat
      a:=a+1;
      gotoXY(tirx-a,tiry);textcolor(lightred);write('-');
      v:=copy(liste[tiry+(j*20)],tirx-a,1);
      delay(140);
      if v='1' then
         begin
         gotoXY(tirx-a,tiry);textcolor(red);write('°');sound(20);delay(900);Nosound;
         gotoXY(tirx-a,tiry);write(' ');
         a:=4;
         gotoXY(tirx-a,tiry);write(' ');
         delete(liste[tiry+(20*j)],tirx-a,1);
         end;
      if (tirx-a=x) and (tiry=y) then
         begin
         gotoXY(tirx-a,tiry);textcolor(red);write('°');sound(20);delay(900);Nosound;
         a:=4;
         vie:=vie-1;
         end;
      GotoXY(tirx-a,tiry);write(' ');
      until a=4;
      end;
   end;
until ch=chr(27);
halt;
end;

BEGIN
     TextMode(1);
     j2:=0;
     j:=0;
     n2:=1;
     n:=1;
     p:=10;
     vie:=5;
     b1:=true;
     b2:=false;
     b3:=false;
     b4:=false;
     b5:=false;
     k:=false;
     h:=false;
     b:=false;
     d:=false;
     g:=false;
     a:=0;
     vitesse:=220;
     x:=34;y:=8;
     liste[1]:='                                   ';
     liste[2]:='                                   ';
     liste[3]:='              111                  ';
     liste[4]:='            1111111  2             ';
     liste[5]:='     111      111     111          ';
     liste[6]:='       1111 11111111               ';
     liste[7]:='             11                    ';
     liste[8]:='                       2           ';
     liste[9]:='                                   ';
     liste[10]:='        111 22   111111111    2    ';
     liste[11]:='     1111            22            ';
     liste[12]:='  111        1111    2  11         ';
     liste[13]:='       111  2  111   1111          ';
     liste[14]:='                 11                ';
     liste[15]:='                     2             ';
     liste[16]:='                                   ';
     liste[17]:='                                   ';
     liste[18]:='            11111  22              ';
     liste[19]:='        11111111        111        ';
     liste[20]:='                  1111        22   ';
     {************************************************}
     liste[21]:='                                   ';
     liste[22]:='                                   ';
     liste[23]:='                                   ';
     liste[24]:='             2       1111          ';
     liste[25]:='111111111              111   4     ';
     liste[26]:='111111                             ';
     liste[27]:='1111111111    11111 2              ';
     liste[28]:='11111111111      111               ';
     liste[29]:='1111111111111                      ';
     liste[30]:='1111111111111         2            ';
     liste[31]:='1111111111111111                   ';
     liste[32]:='111111111111                       ';
     liste[33]:='1111111      222  11      2        ';
     liste[34]:='                1111  1            ';
     liste[35]:='111111111          11211           ';
     liste[36]:='111111              1              ';
     liste[37]:='                                   ';
     liste[38]:='        22      111111             ';
     liste[39]:='                                   ';
     liste[40]:='                                   ';
     {************************************************}
     liste[41]:='   1111                            ';
     liste[42]:='111111111                          ';
     liste[43]:='11111111                           ';
     liste[44]:='11111        2       1111          ';
     liste[45]:='111111111                         1';
     liste[46]:='111111            11111111        1';
     liste[47]:='1111111111    1        1111111    1';
     liste[48]:='111111111111111111    111111      1';
     liste[49]:='1111        1      11111111111    1';
     liste[50]:='      11          1   2           1';
     liste[51]:='11111111111        11     111     1';
     liste[52]:='111111111111              111111  1';
     liste[53]:='1111111          1111     2       1';
     liste[54]:='11111      2    1111  1            ';
     liste[55]:='111111      2222   11211     11   1';
     liste[56]:='111111              1     111     1';
     liste[57]:='    1111                           ';
     liste[58]:='             2  111111             ';
     liste[59]:='        1111                       ';
     liste[60]:='                                   ';
     {************************************************}
     liste[61]:='      1       2          111111    ';
     liste[62]:='     1111                         1';
     liste[63]:='    1111         2        1111    1';
     liste[64]:='     11      2                    1';
     liste[65]:='                     111111111    1';
     liste[66]:='                                  1';
     liste[67]:='          22     2     1111       1';
     liste[68]:='      1111111         111111      1';
     liste[69]:='        111                       1';
     liste[70]:='      11   11     1   2 111        ';
     liste[71]:='                   11             1';
     liste[72]:='      111111              111     1';
     liste[73]:='         1111    11       2       1';
     liste[74]:='                1  1  1  111      1';
     liste[75]:='   11         2                   1';
     liste[76]:=' 11111              1     111     1';
     liste[77]:='    11 2    22                     ';
     liste[78]:='                   111             ';
     liste[79]:='        1111                       ';
     liste[80]:='                                   ';
     {************************************************}
     liste[81]:='      1       2                    ';
     liste[82]:='     1111   1                      ';
     liste[83]:='    1111    11   2                 ';
     liste[84]:='     11      112                   ';
     liste[85]:='       222                         ';
     liste[86]:='               11    111111 1      ';
     liste[87]:='          22    11                 ';
     liste[88]:='      1111111              222     ';
     liste[89]:='        111                        ';
     liste[90]:='      11   11     1   2            ';
     liste[91]:='                   11              ';
     liste[92]:='      111                 11111    ';
     liste[93]:='         1111    11       2        ';
     liste[94]:='                1  1  1            ';
     liste[95]:='   11         2                    ';
     liste[96]:=' 1                  1              ';
     liste[97]:='     11     22               1     ';
     liste[98]:='                   111             ';
     liste[99]:='        1111                       ';
     liste[100]:='                                   ';
     {************************************************}
     repeat
     a:=0;
     randomize;
     x1:=random(28)+2;y1:=random(16)+1;
     x2:=random(32)+2;y2:=random(11)+1;
     x3:=random(31)+2;y3:=random(14)+1;
     x4:=random(16)+2;y4:=random(18)+1;
     x5:=random(14)+2;y5:=random(16)+1;
     if copy(liste[y1],x1,1)='1' then a:=a else a:=a+1;
     if copy(liste[y2],x2,1)='1' then a:=a else a:=a+1;
     if copy(liste[y3],x3,1)='1' then a:=a else a:=a+1;
     if copy(liste[y4],x4,1)='1' then a:=a else a:=a+1;
     if copy(liste[y5],x5,1)='1' then a:=a else a:=a+1;
     until a=5;
     ch:=readkey;
     for i:=1 to 5000 do
         BEGIN
         if random(10)<5 then randomize;
         w:=random(38)+1;
         z:=random(23)+1;
         c:=random(14)+1;
         if random(100)<50 then textcolor(c+blink) else textcolor(c);
         gotoXY(w,z);write('.');
         END;
     textcolor(15);
     gotoXY(10,9);writeln('INTERPLANETARY GAME');textcolor(14);
     gotoXY(9,23);writeln('Appuyez sur une touche');
     ch:=readkey;
     Clrscr;
     depart;
  END.