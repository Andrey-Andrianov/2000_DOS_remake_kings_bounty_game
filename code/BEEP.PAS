unit beep;
interface

procedure beginbeep;
procedure endbeep;
procedure beep01(k:integer);
procedure muzbeep(n,k : integer);

implementation

uses initial;

var
  tranbeep : array[0..83] of real;

procedure beginbeep;
begin
  Port[$61] := Port[$61] or 3;
end;

procedure endbeep;
begin
  Port[$61] := Port[$61] and $FC;
end;

procedure beep01(k:integer);
var
  n : word;
begin
  n := round(1190000/tranbeep[k]);
  Port[$43] := $B6;
  Port[$42] := lo(n);
  Port[$42] := hi(n);
end;

procedure muzbeep(n,k : integer);
const
  notbeep : array [1..3,1..15] of integer =
             ((36,38,39,41,43,41,39,38,36,39,38,34,36,1,1),
              (32,36,37,39,39,41,41,39,36,37,1,1,1,1,1),
              (41,39,37,36,37,36,34,36,32,1,1,1,1,1,1));
  timbeep : array [1..3,1..15] of integer =
             ((5,5,4,4,4,4,4,4,4,4,4,4,12,1,1),
              (10,10,5,10,10,5,5,5,10,10,1,1,1,1,1),
              (10,5,5,5,10,5,5,5,10,1,1,1,1,1,1));
var
  i        : integer;
  exitbeep : boolean;
begin
  beginbeep;
  for i :=1 to k do begin
    beep01(notbeep[n,i]);
    exitbeep := deltat2(timbeep[n,i]);
    if exitbeep then
      break;
  end;
  endbeep;
end;

var
  i : integer;

begin
  tranbeep[0]:=27.5;
  for i := 1 to 83 do
    tranbeep[i]:=(tranbeep[i-1] * exp(1/12 * ln (2)));

end.















