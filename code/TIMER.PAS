unit timer;
interface

function gettimer:longint;  { чтение сист.таймера с точн. ~0.8 мкс}
function gettimer1:longint;  { чтение сист.таймера с точн. ~200 мкс}
procedure inittimer; {установка таймера в нужный режим}

implementation
{const Seg0040 = $40;}

function gettimer:longint;   { чтение показаний системного таймера 0.8 мкс}
var
   b:array[0..3]of byte;
   l:longint absolute b;
begin
   Port[$43]:=0;   {замораживаем показания таймера}
   Inline($0FA);
   b[2]:=Mem[Seg0040:$6c];
   b[3]:=Mem[Seg0040:$6d] and $7F;
   b[0]:=255-Port[$40];   {младший байт}
   b[1]:=255-Port[$40];
   gettimer := l;
   Inline($0FB);
end;

function gettimer1:longint;   { чтение показаний системного таймера 200 мкс}
var
   b:array[0..3]of byte;
   l:longint absolute b;
begin
   Inline($0FA);
   Port[$43]:=0;   {замораживаем показания таймера}
   b[0]:=255-Port[$40];   {младший байт}
   b[0]:=255-Port[$40];
   b[1]:=Mem[Seg0040:$6c];
   b[2]:=Mem[Seg0040:$6d];
   b[3]:=Mem[Seg0040:$6e] and $7F;
   Inline($0FB);
   gettimer1 := l;
end;

procedure inittimer; {установка таймера в нужный режим}
begin
   port[$43] := $34;
   port[$40] := $00;
   port[$40] := $00;
end;
end.