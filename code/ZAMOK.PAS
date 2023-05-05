unit zamok;

interface

function zamak:boolean;{Вход в замок}
function mag(xn,yn:integer):boolean;
function stars1(xn,yn:integer):boolean;

implementation

uses crt,draw,constant,grtext,initial,drawtail,filreads;

procedure pokupka(c,d:integer);{Набор войска}
var
 j,i,k,z:integer;
 n,s,s1,s2:longint;
begin
   s2 := lidersaip div lidir[c];
   for s1 := 0 to 4 do
     if (narmy[s1]>0) and (army[s1]=c) then
       s2 := s2 - narmy[s1];
   frame(13,18,1);
   outfilblock(1,13,40);
   puttext((4+9)*8,19*8,lstr(s2));
   puttext(19*8,18*8,namear[c]);{Название выбранного рода войск}
   puttext((4+6)*8,17*8,lstr(money));
   s:=inpnum(20*8,20*8); {Ввод числа}
   if s<>-1 then begin
    n:=s*prise[c];{стоимость покупки}
    if (money < n) or (s2<s) then begin {Хватает ли денег}
      frame(14,18,1);
      if (money < n) then
        outfilblock(5,15,41)
      else
        outfilblock(5,15,42);
      waitkey;
    end else begin
      k:=-1;
      z:=0;
      REPEAT  {Ищем подходящую ячейку для покупки}
        if (army[z]=c) or (narmy[z]=0) then k:=z;
        z:=z+1;
      until (army[z-1]=c) or (narmy[z-1]=0) or (z-1=4);
      if (k > -1) then  {покупаем}
       if (d>0) and (magsundrec[d].na<s) then begin
         frame(14,18,1);
         outfilblock(5,15,43);
         waitkey;
       end else if (s2>=s)then begin
        narmy[k]:=narmy[k]+s;
        army[k]:=c;
        money:=money - n;
        if d > 0 then
          dec(magsundrec[d].na,s);
      end else begin
        frame(14,18,1);
        outfilblock(5,15,44);
        waitkey;
      end;
    end;
   end;
   Puttilecell(5,4,119);
   writexy(272+8-(length(lstrk(money))*4),183,lstrk(money));
end;

procedure korol;{К королю}
var
  i1 : integer;
 begin
   frame(13,18,1);
   outfilblock(0,13,25);
   if a < 3 then begin
     if colzlpl > 0 then begin
       outfilblock(1,15,26);
       outstring(6,17, istr(colzlpl) );
     end else begin
       outfilblock(1,15,27);
       outstring(1,17, ime[a1,a+1] );
       colzlpl:=colzlkor[a+2]+colzlpl;
       inc(a);
       inc(lidersaip,100);
       inc(plata,1000);
       inc(maksium_zaklinanii,10);
       inc(sila_zaklinanii,5);
     end;
   end else begin
     outfilblock(1,15,28);
   end;
{   romb(106,91,96,101,0);}
 {  waitkey ;}
    i1 := 1;
    repeat
     putpichbuffer(x1,y2+6,x1+239,y2+107);
     putsprbuffer(64,89,i1);
     putpich2(x1,y2+6,x1+239,y2+107);
     inc(i1);
     deltat(3);
     if i1 = 5 then
       i1 := 1;
    until keypressed;
    waitkey;
   num_key := 32;
 end;

procedure magazin;{Вход в магазин}
 var
  b,c,d,e:integer;
  w:char;
  i1 : integer;
 begin
   repeat
   frame(13,18,1);
   outfilblock(1,13,29);
    i1 := 1;
    repeat
     putpichbuffer(x1,y2+6,x1+239,y2+107);
     putsprbuffer(64,89,i1);
     putpich2(x1,y2+6,x1+239,y2+107);
     inc(i1);
     deltat(3);
     if i1 = 5 then
       i1 := 1;
    until keypressed;
    waitkey;
{   romb(107,91,96,101,0);}
{   waitkey;}
   case num_key of {Выбор рода войск}
     30:pokupka(1,0);
     48:pokupka(2,0);
     46:pokupka(3,0);
     32:if a > 0 then pokupka(4,0) else begin
       frame(14,17,1);
       outfilblock(1,14,30);
       waitkey;
     end;
     18:if a > 1 then pokupka(5,0) else begin
       frame(14,17,1);
       outfilblock(1,14,31);
       waitkey;
     end;
   end;
   until num_key = 1;
   num_key := 32;
 end;

function  stars1(xn,yn:integer):boolean;
var
  i,k,m,i1,s1,s2 : integer;
begin
  readarmy(1,13);
  colorbar(x1,y2+107,x1+239,y2+175,1);
  frame(13,19,1);
  outfilblock(1,13,32);
  readpich('cave.kni',2);
  i1 := 1;
  m:=0;
  repeat
    repeat
      putpichbuffer(x1,y2+6,x1+239,y2+107);
      putsprbuffer(64,89,i1);
      putpich2(x1,y2+6,x1+239,y2+107);
      inc(i1);
      deltat(3);
      if i1 = 5 then
        i1 := 1;
    until keypressed;
    waitkey;
  until (num_key = 21) or (num_key = 49);
  readtail('enemys.spa',4,1);      {врагов}
  if (num_key = 21) then
    if money >= 5000 then begin
      dec(money,5000);
      map[cont,xn,yn] := plai1;
      emag := true;
    end else begin
      frame(13,19,1);
      outfilblock(1,13,33);
      waitkey;
    end;
    stars1 := false;
{  colormap;}
end;

function mag(xn,yn:integer):boolean;
var
  i,k,m,i1,s1,s2 : integer;
begin
  for i := 1 to 45 do
    if (arraysundx[magsundrec[i].n]=xn) and (arraysundy[magsundrec[i].n]=yn)
      and (arraysundc[magsundrec[i].n]=cont) then begin
        k := i;
      end;
   s2 := lidersaip div lidir[magsundrec[k].a];
   for s1 := 0 to 4 do
     if (narmy[s1]>0) and (army[s1]=magsundrec[k].a) then
       s2 := s2 - narmy[s1];
    readarmy(1,magsundrec[k].a);
    colorbar(x1,y2+107,x1+239,y2+175,1);
    frame(13,19,1);
    i1 := 1;
    m:=0;
    if (magsundrec[k].a > 20) and (magsundrec[k].a < 26) then
      m := 4;
    if (magsundrec[k].a > 5) and (magsundrec[k].a < 11) then
      m := 1;
    if (magsundrec[k].a > 10) and (magsundrec[k].a < 16) then
      m := 2;
    if (magsundrec[k].a > 15) and (magsundrec[k].a < 21) then
      m := 3;
    if m = 1 then
      readpich('care1.kni',2);
    if m = 2 then
      readpich('tree1.kni',2);
    if m = 3 then
      readpich('cave.kni',2);
    if m = 4 then
      readpich('cell.kni',2);
    case m of
      1 :outfilblock(10,13,34);
      2 :outfilblock(10,13,35);
      3 :outfilblock(10,13,36);
      4 :outfilblock(10,13,37);
    end;
    outfilblock(1,15,38);
    outstring(1+12,15,istr(magsundrec[k].na) + ' ' + namear[magsundrec[k].a]);
    outstring(1+11,16,istr(prise[magsundrec[k].a]));
    outstring(1+6,17,  lstr(money)  );
    outstring(1+21,18,istr(s2));
  repeat
    repeat
      putpichbuffer(x1,y2+6,x1+239,y2+107);
      putsprbuffer(64,89,i1);
      putpich2(x1,y2+6,x1+239,y2+107);
      inc(i1);
      deltat(3);
      if i1 = 5 then
        i1 := 1;
    until keypressed;
    waitkey;
{    waitkey;}
    if num_key <> 1 then begin
      pokupka(magsundrec[k].a,k);
    frame(13,19,1);
    case m of
      1 :outfilblock(10,13,34);
      2 :outfilblock(10,13,35);
      3 :outfilblock(10,13,36);
      4 :outfilblock(10,13,37);
    end;
    s2 := lidersaip div lidir[magsundrec[k].a];
    for s1 := 0 to 4 do
      if (narmy[s1]>0) and (army[s1]=magsundrec[k].a) then
        s2 := s2 - narmy[s1];
    outfilblock(1,15,38);
    outstring(1+12,15,istr(magsundrec[k].na) + ' ' + namear[magsundrec[k].a]);
    outstring(1+11,16,istr(prise[magsundrec[k].a]));
    outstring(1+6,17,lstr(money)  );
    outstring(1+21,18,istr(s2));
    end;
  until num_key = 1;
  readtail('enemys.spa',4,1);      {врагов}
  mag := false;
end;

function zamak:boolean; {Вход в замок}
 var
    v:char;
    i1 : integer;
 begin
    readarmy(1,random(5)+1);
    readtown(16,30,2,0);
    readtown(16,22,2,1);
   repeat
    colorbar(x7-1,y75-1-3,x8-1,y8+8-1,1);
    setgttyp(0);
    rectangle(x7+5,y75+5,x8-7,y8-7+8,15);
    outfilblock(1,13,39);
    i1 := 1;
    repeat
     putpichbuffer(x1,y2+6,x1+239,y2+107);
     putsprbuffer(64,89,i1);
     putpich2(x1,y2+6,x1+239,y2+107);
     inc(i1);
     deltat(3);
     if i1 = 5 then
       i1 := 1;
    until keypressed;
    waitkey;
    case num_key of
      30:korol;
      48:magazin;
    end;
   until num_key = 1;
    readtail('enemys.spa',4,1);      {врагов}
    zamak:=false;
 end;
end.