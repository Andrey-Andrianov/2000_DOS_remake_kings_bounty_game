unit markers;
Interface

procedure InitMark;{Считывает дорожные знаки}
function marker (xn,yn:integer):boolean;

Implementation
uses
  Crt, Dos, Initial, Constant, Draw,filreads;

var
  nm          : integer;                        { количество знаков}
  mes         : array[1..80,0..2]of string[24]; { надписи на знаках}
  Markx,Marky : array[1..80]of integer;         { координаты знаков}
  ncontmark   : array[1..80]of byte;

procedure InitMark;{Считывает дорожные знаки}
var
  markfile :text;
  k,m,n:integer;
begin
  assign(markfile,'mark1.dat');
  reset(markfile);
  readln(markfile,nm);
  for k:=1 to nm do
  begin
    readln(markfile,ncontmark[k],n,Markx[k],Marky[k]);
    for m:=0 to 2 do readln (markfile, mes [k ,m]);
  end;
  close(markfile);
end;

function marker (xn,yn:integer):boolean;
var
    k,n:integer;
begin
  n:=-1;
  for k:=1 to nm do if (xn=MarkX[k]) and (yn=MarkY[k]) and
                 (ncontmark[k]=cont)                 then n:=k;
  if n>0 then begin
      frame(14,18,1);
      outfilblock(3,14,45);
      for k:=0 to 2 do
         if length(mes[n,k])>0 then
         outstring(1,k+15,mes[n,k]);
  end
  else begin
      frame(14,18,4);
      outstring(5,16,'ошибка номера');
  end;
  waitkey;
  marker:=zem;
end;

end.
