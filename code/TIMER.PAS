unit timer;
interface

function gettimer:longint;  { �⥭�� ���.⠩��� � ��. ~0.8 ���}
function gettimer1:longint;  { �⥭�� ���.⠩��� � ��. ~200 ���}
procedure inittimer; {��⠭���� ⠩��� � �㦭� ०��}

implementation
{const Seg0040 = $40;}

function gettimer:longint;   { �⥭�� ��������� ��⥬���� ⠩��� 0.8 ���}
var
   b:array[0..3]of byte;
   l:longint absolute b;
begin
   Port[$43]:=0;   {����ࠦ����� ��������� ⠩���}
   Inline($0FA);
   b[2]:=Mem[Seg0040:$6c];
   b[3]:=Mem[Seg0040:$6d] and $7F;
   b[0]:=255-Port[$40];   {����訩 ����}
   b[1]:=255-Port[$40];
   gettimer := l;
   Inline($0FB);
end;

function gettimer1:longint;   { �⥭�� ��������� ��⥬���� ⠩��� 200 ���}
var
   b:array[0..3]of byte;
   l:longint absolute b;
begin
   Inline($0FA);
   Port[$43]:=0;   {����ࠦ����� ��������� ⠩���}
   b[0]:=255-Port[$40];   {����訩 ����}
   b[0]:=255-Port[$40];
   b[1]:=Mem[Seg0040:$6c];
   b[2]:=Mem[Seg0040:$6d];
   b[3]:=Mem[Seg0040:$6e] and $7F;
   Inline($0FB);
   gettimer1 := l;
end;

procedure inittimer; {��⠭���� ⠩��� � �㦭� ०��}
begin
   port[$43] := $34;
   port[$40] := $00;
   port[$40] := $00;
end;
end.