unit initial;

interface

const
    Num_Key:byte=0;      { номер нажатой клавиши }
    Num_Char:byte=0;     { номер введенного символа }
Procedure WaitKey;       { ввод номеров клавиши и символа с ожиданием }
function istr(i:integer):string;  {преобразование integer -> string[5]}
function strk(i:integer):string; {преобразование integer -> string[3] (c K)}
function inpnum(xx,yy:integer):integer;  {процедура  вода числа с клавиатуры}
 { xx, yy - координаты, начиная с которых будет выводиться "эхо" числа на экран}
 { если не введено никакого числа, возвращает -1 }
 { реагирует только на цифровые клавиши, BackSpace и Enter, завершающую ввод }
function askyn : boolean;{если нажата клавиша 'Y',возвращ. TRUE,если 'N'-FALSE}
  {на остальные не реагирует}
procedure deltat(n:integer);  {временная задержка на n/18 секунд}
function deltat2(n:integer):boolean;  {временная задержка на n/18 секунд}
procedure ClearKeyBuffer;   {чистит буфер клавиатуры}
function lstr(i:longint):string;  {преобразование longint -> string[7]}
function lstrk(i:longint):string; {преобразование longint -> string[5] (c K)}

implementation

uses
  Crt, Dos, draw,grtext,drawtail;

Procedure WaitKey; { процедура ждет нажатия на клавишу и заносит в глобальные }
assembler;         { переменные Num_Key - номер нажатой клавиши, }
    asm;           {            Num_Char - номер введенного символа }
    mov ax,0
    int 16h
    mov Num_Key,ah
    mov Num_Char,al
    end;

function istr(i:integer):string;  {преобразование integer -> string[5]}
var
  s:string;
begin
  str(i,s);
  istr := s;
end;

function lstr(i:longint):string;  {преобразование longint -> string[7]}
var
  s:string;
begin
  str(i,s);
  lstr := s;
end;

function strk(i:integer):string; {преобразование integer -> string[3] (c K)}
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

function lstrk(i:longint):string; {преобразование longint -> string[5] (c K)}
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

function inpnum(xx,yy:integer):integer;  {процедура  вода числа с клавиатуры}
var
   i0: array[0..5] of integer;
   j,k:integer;
   i : longint;
begin
   j:=0;                        {счетчик знаков}
   num_key:=255;
   while num_key <> 28 do       { 28 - номер клавиши Enter }
      begin                { ввод последовательности цифр }
         waitkey;
         case Num_key of
         2..11 :  { если нажаты клавиши, соответствующие цифрам, }
                 if j < 5 then begin
                   i0[j]:=num_key-1;  { то цифры запоминаются в массиве i0 }
                   if i0[j]=10 then i0[j]:=0;  { клавиша "0" имеет номер 11 }
                   puttext(xx+j*8,yy,chr(i0[j]+48)); { эхо на экран }
                   j:=j+1;                          { увеличиваем счетчик }
                 end;
         14    : if j > 0 then begin  { если нажата клавиша BackSpace }
                   j:=j-1;                          { уменьшаем счетчик }
                   ColorBar(xx+j*8,yy,xx+j*8+8,yy+8,1);  { и стираем цифру }
                 end;
         end;           { остальные клавиши игнорируются }
      end;
   if j>0 then begin     { если введена хотя бы одна цифра,}
      i:=0;                      { вычисляем значение числа, }
      for k:= 0 to j-1 do i:=i*10+i0[k];  { состоящего из этих цифр }
      inpnum:=i;
      if i > 32000 then
        inpnum:=0;
   end
   else  inpnum:=-1; { если не введено ни одной цифры, возвращается число -1 }
end;

function askyn : boolean;{если нажата клавиша 'Y',возвращ. TRUE,если 'N'-FALSE}
var                      {на остальные не реагирует}
   correct:boolean;
begin
   correct:=false;
   while correct=false do begin
      waitkey;
      case num_key of
         21:begin                    { клавиша 'Y'}
            correct:=true;
            askyn:=true;
         end;
         49:begin                     { клавиша 'N'}
            correct:=true;
            askyn:=false;
         end;
      else correct:=false;
      end;
   end;
end;

function clock:longint;
begin
   Inline($0FA);{запрещает прерывания}
   clock:=MemL[Seg0040:$6c];
   Inline($0FB);{разрешает прерывания}
end;

procedure deltat(n:integer);  {временная задержка на n/18 секунд}
var
   l:longint;
begin
   l:=clock;
   while clock<(l+n) do;
end;

function deltat2(n:integer):boolean;  {временная задержка на n/18 секунд}
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

procedure ClearKeyBuffer;   {чистит буфер клавиатуры}
begin
   asm
      @p0: mov ah,01h
           int 16h      {смотрим буфер клавиатуры}
           jz @p1       {если пуст, на выход}
           mov ah,0h
           int 16h      {усли не пуст, читаем из него символ}
           jmp @p0      {и повторяем проверку до исчерпания буфера}
       @p1:
   end;
end;

end.
