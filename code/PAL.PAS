unit pal;
interface
procedure setpal(var pal:byte;nbegpal,lenpal:integer);
procedure getpal(var pal:byte;nbegpal,lenpal:integer);
implementation
{��⠭���� 256 梥⭮� �������}
procedure setpal(var pal:byte;nbegpal,lenpal:integer);
assembler;
asm
              push ds
              push es
              les dx,pal
              mov ax,1012h
              mov bx,nbegpal
              mov cx,lenpal
              int 10h
              pop es
              pop ds
end;
{�⥭�� 256 梥⭮� �������}
procedure getpal(var pal:byte;nbegpal,lenpal:integer);
assembler;
asm
              push ds
              push es
              les dx,pal
              mov ax,1017h
              mov bx,nbegpal
              mov cx,lenpal
              int 10h
              pop es
              pop ds
end;
end.