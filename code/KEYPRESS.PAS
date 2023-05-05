uses crt;

var
  w : char;
  num_key,num_char : byte;

Procedure WaitKey; { процедура ждет нажатия на клавишу и заносит в глобальные }
assembler;         { переменные Num_Key - номер нажатой клавиши, }
    asm;           {            Num_Char - номер введенного символа }
    mov ax,0
    int 16h
    mov Num_Key,ah
    mov Num_Char,al
    end;


begin
  repeat
    waitkey;
    writeln('Номер = ',num_key);
  until num_key = 1;
{  repeat
    w := readkey;
    if byte(w)=13 then
      writeln('Номер0 = ',w);
    if byte(w)=8 then
      writeln('Номер10 = ',w);
    writeln('Номер1 = ',w);
  until (w = 'a') or (w = 'A');}
  waitkey;
end.