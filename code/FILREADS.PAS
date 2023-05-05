unit filreads;
interface
type
  fil = record
    s : string[40];
    b : integer;
  end;
  fil_type = ^fil;

var
  fils : array[1..500] of fil_type;
  kol,kolst : integer;

procedure initfils;
procedure closefils;
procedure readfils;
procedure outfilblock(x,y,n:integer);
procedure outfilblockxy(x,y,n,s:integer);


implementation
uses draw,constant;

procedure initfils;
var
  i,j : integer;
begin
  for i := 1 to 500 do
    getmem(fils[i],sizeof(fils[i]^));
end;

procedure closefils;
var
  i,j : integer;
begin
  for i := 1 to 500 do
    freemem(fils[i],sizeof(fils[i]^));
end;

procedure readfils;
var
  i,j,blok,kolstr : integer;
  f : text;
begin
  assign(f,'fils.dat');
  reset(f);
  readln(f,kol);
  kolst := 0;
  for i := 1 to kol do begin
    readln(f,blok,kolstr);
    for j := 1 to kolstr do begin
      inc(kolst);
      readln(f,fils[kolst]^.s);
      fils[kolst]^.b := blok;
    end;
  end;
  for i := 1 to 25 do
    readln(f,namear[i]);
  for i := 1 to 25 do
    readln(f,namear2[i]);
  for i := 1 to 4 do
    readln(f,ncont[i]);
  for i := 1 to 4 do
    readln(f,contvil[i]);
  for i := 1 to 14 do
    readln(f,zaklin[i]);
  for i := 1 to 26 do
    readln(f,castle[i].s);
  for i := 1 to 17 do
    readln(f,vilians[i].n);
  for i := 0 to 3 do
  for j := 0 to 3 do
    readln(f,ime[i,j]);
  close(f);
  fils[kolst+1]^.b := -1000;
end;

procedure outfilblock(x,y,n:integer);
var
  i,j,b : integer;
begin
  for i := 1 to kolst do
    if fils[i]^.b = n then begin
      b := i;
      break;
    end;
  i := b;
  repeat
    outstring(x,y+i-b,fils[i]^.s);
    inc(i);
  until fils[i]^.b <> n;
end;

procedure outfilblockxy(x,y,n,s:integer);
var
  i,j,b : integer;
begin
  for i := 1 to kolst do
    if fils[i]^.b = n then begin
      b := i;
      break;
    end;
  i := b;
  writexy(x,y,fils[i+s-1]^.s);
  inc(i);
end;

procedure rconst;
var
  i,j : integer;
begin
end;

end.

