uses crt;

var
  w : char;
  num_key,num_char : byte;

Procedure WaitKey; { ��楤�� ���� ������ �� ������� � ������ � �������� }
assembler;         { ��६���� Num_Key - ����� ����⮩ ������, }
    asm;           {            Num_Char - ����� ���������� ᨬ���� }
    mov ax,0
    int 16h
    mov Num_Key,ah
    mov Num_Char,al
    end;


begin
  repeat
    waitkey;
    writeln('����� = ',num_key);
  until num_key = 1;
{  repeat
    w := readkey;
    if byte(w)=13 then
      writeln('�����0 = ',w);
    if byte(w)=8 then
      writeln('�����10 = ',w);
    writeln('�����1 = ',w);
  until (w = 'a') or (w = 'A');}
  waitkey;
end.