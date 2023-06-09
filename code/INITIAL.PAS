unit initial;

interface

const
    Num_Key:byte=0;      { ����� ����⮩ ������ }
    Num_Char:byte=0;     { ����� ���������� ᨬ���� }
Procedure WaitKey;       { ���� ����஢ ������ � ᨬ���� � ��������� }
function istr(i:integer):string;  {�८�ࠧ������ integer -> string[5]}
function strk(i:integer):string; {�८�ࠧ������ integer -> string[3] (c K)}
function inpnum(xx,yy:integer):integer;  {��楤��  ���� �᫠ � ����������}
 { xx, yy - ���न����, ��稭�� � ������ �㤥� �뢮������ "��" �᫠ �� ��࠭}
 { �᫨ �� ������� �������� �᫠, �����頥� -1 }
 { ॠ����� ⮫쪮 �� ��஢� ������, BackSpace � Enter, ���������� ���� }
function askyn : boolean;{�᫨ ����� ������ 'Y',������. TRUE,�᫨ 'N'-FALSE}
  {�� ��⠫�� �� ॠ�����}
procedure deltat(n:integer);  {�६����� ����প� �� n/18 ᥪ㭤}
function deltat2(n:integer):boolean;  {�६����� ����প� �� n/18 ᥪ㭤}
procedure ClearKeyBuffer;   {���� ���� ����������}
function lstr(i:longint):string;  {�८�ࠧ������ longint -> string[7]}
function lstrk(i:longint):string; {�८�ࠧ������ longint -> string[5] (c K)}

implementation

uses
  Crt, Dos, draw,grtext,drawtail;

Procedure WaitKey; { ��楤�� ���� ������ �� ������� � ������ � �������� }
assembler;         { ��६���� Num_Key - ����� ����⮩ ������, }
    asm;           {            Num_Char - ����� ���������� ᨬ���� }
    mov ax,0
    int 16h
    mov Num_Key,ah
    mov Num_Char,al
    end;

function istr(i:integer):string;  {�८�ࠧ������ integer -> string[5]}
var
  s:string;
begin
  str(i,s);
  istr := s;
end;

function lstr(i:longint):string;  {�८�ࠧ������ longint -> string[7]}
var
  s:string;
begin
  str(i,s);
  lstr := s;
end;

function strk(i:integer):string; {�८�ࠧ������ integer -> string[3] (c K)}
var
   str1,s:string;
begin
   str(i,str1);
   if length(str1) > 3 then begin
      str1[length(str1)-2] := 'K';
      str1[0] := char(length(str1)-2);
   end;
   strk := str1;
end;

function lstrk(i:longint):string; {�८�ࠧ������ longint -> string[5] (c K)}
var
   str1,s:string;
begin
   str(i,str1);
   if length(str1) > 3 then begin
      str1[length(str1)-2] := 'K';
      str1[0] := char(length(str1)-2);
   end;
   lstrk := str1;
end;

function inpnum(xx,yy:integer):integer;  {��楤��  ���� �᫠ � ����������}
var
   i0: array[0..5] of integer;
   j,k:integer;
   i : longint;
begin
   j:=0;                        {���稪 ������}
   num_key:=255;
   while num_key <> 28 do       { 28 - ����� ������ Enter }
      begin                { ���� ��᫥����⥫쭮�� ��� }
         waitkey;
         case Num_key of
         2..11 :  { �᫨ ������ ������, ᮮ⢥�����騥 ��ࠬ, }
                 if j < 5 then begin
                   i0[j]:=num_key-1;  { � ���� ������������ � ���ᨢ� i0 }
                   if i0[j]=10 then i0[j]:=0;  { ������ "0" ����� ����� 11 }
                   puttext(xx+j*8,yy,chr(i0[j]+48)); { �� �� ��࠭ }
                   j:=j+1;                          { 㢥��稢��� ���稪 }
                 end;
         14    : if j > 0 then begin  { �᫨ ����� ������ BackSpace }
                   j:=j-1;                          { 㬥��蠥� ���稪 }
                   ColorBar(xx+j*8,yy,xx+j*8+8,yy+8,1);  { � ��ࠥ� ���� }
                 end;
         end;           { ��⠫�� ������ ����������� }
      end;
   if j>0 then begin     { �᫨ ������� ��� �� ���� ���,}
      i:=0;                      { ����塞 ���祭�� �᫠, }
      for k:= 0 to j-1 do i:=i*10+i0[k];  { ����饣� �� ��� ��� }
      inpnum:=i;
      if i > 32000 then
        inpnum:=0;
   end
   else  inpnum:=-1; { �᫨ �� ������� �� ����� ����, �����頥��� �᫮ -1 }
end;

function askyn : boolean;{�᫨ ����� ������ 'Y',������. TRUE,�᫨ 'N'-FALSE}
var                      {�� ��⠫�� �� ॠ�����}
   correct:boolean;
begin
   correct:=false;
   while correct=false do begin
      waitkey;
      case num_key of
         21:begin                    { ������ 'Y'}
            correct:=true;
            askyn:=true;
         end;
         49:begin                     { ������ 'N'}
            correct:=true;
            askyn:=false;
         end;
      else correct:=false;
      end;
   end;
end;

function clock:longint;
begin
   Inline($0FA);{����頥� ���뢠���}
   clock:=MemL[Seg0040:$6c];
   Inline($0FB);{ࠧ�蠥� ���뢠���}
end;

procedure deltat(n:integer);  {�६����� ����প� �� n/18 ᥪ㭤}
var
   l:longint;
begin
   l:=clock;
   while clock<(l+n) do;
end;

function deltat2(n:integer):boolean;  {�६����� ����প� �� n/18 ᥪ㭤}
var
   l:longint;
begin
   l:=clock;
   while (clock<(l+n)) and (not keypressed) do;
   if (clock<(l+n)) then
     deltat2 := true
   else
     deltat2 := false;
end;

procedure ClearKeyBuffer;   {���� ���� ����������}
begin
   asm
      @p0: mov ah,01h
           int 16h      {ᬮ�ਬ ���� ����������}
           jz @p1       {�᫨ ����, �� ��室}
           mov ah,0h
           int 16h      {�᫨ �� ����, �⠥� �� ���� ᨬ���}
           jmp @p0      {� �����塞 �஢��� �� ���௠��� ����}
       @p1:
   end;
end;

end.
