uses crt,printer;

var ch:char;
    i:integer;

begin
textbackground(0);
clrscr;
textcolor(white);
writeln('                                  MORSE                                    ');
writeln;
repeat
ch:=readkey;
if ch='a' then writeln('.- ');
if ch='b' then writeln('-... ');
if ch='c' then writeln('-.-. ');
if ch='d' then writeln('-.. ');
if ch='e' then writeln('. ');
if ch='f' then writeln('..-. ');
if ch='g' then writeln('--. ');
if ch='h' then writeln('.... ');
if ch='i' then writeln('.. ');
if ch='j' then writeln('.--- ');
if ch='k' then writeln('.-. ');
if ch='l' then writeln('.-.. ');
if ch='m' then writeln('-- ');
if ch='n' then writeln('-. ');
if ch='o' then writeln('--- ');
if ch='p' then writeln('.--. ');
if ch='q' then writeln('--.- ');
if ch='r' then writeln('.-. ');
if ch='s' then writeln('... ');
if ch='t' then writeln('- ');
if ch='u' then writeln('..- ');
if ch='v' then writeln('...- ');
if ch='w' then writeln('.-- ');
if ch='x' then writeln('-..- ');
if ch='y' then writeln('-.-- ');
if ch='z' then writeln('--.. ');
if ch=' ' then writeln('  ');
if ch='1' then writeln('.---- ');
if ch='2' then writeln('..--- ');
if ch='3' then writeln('...-- ');
if ch='4' then writeln('....- ');
if ch='5' then writeln('..... ');
if ch='6' then writeln('-.... ');
if ch='7' then writeln('--... ');
if ch='8' then writeln('---.. ');
if ch='9' then writeln('-----.');
if ch='0' then writeln('----- ');
if ch='?' then writeln('..--.. ');
if ch='!' then writeln('--..-- ');
until ch=chr(27);
end.
