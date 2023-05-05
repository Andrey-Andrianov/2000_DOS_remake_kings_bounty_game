unit battl;
Interface

Procedure varmy;
function sumarmye:integer;    {подсчит.сумму разм-ов армий}
procedure battle;{сражение}

Implementation

uses
  Crt, Dos, Initial, Constant, Draw, Enemys, Markers,drawtail,filreads;

var
  stop : array[0..4]of boolean;

const
  priority:array[1..25]of integer=(12,24,2,16,5,  17,8,7,6,22,
           10,25,11,9,23,  21,3{9},1,20,17,  13,14,15,4,19);

  damage:array[1..25]of integer=(1,1,2,3,5,  1,2,2,3,3,
           1,1,2,2,3,  2,2,3,10,25,  1,2,2,3,5);

  HitPts:array[1..25]of integer=(2,10,10,20,35,  1,3,15,40,25,
           1,10,5,50,25,  5,20,40,60,200,  3,5,10,30,50);

  silaarmy:array[1..25]of byte=(2,2,3,4,5,  1,2,3,4,5,
           1,3,2,4,5,  2,3,4,5,6,  2,2,4,5,6);


Procedure varmy;
var
  i,j,color,i1,j1:integer;
begin
     readtail('lbattle.spa',4,plai3);
     readtail('Walls.spa',6,wall3);
     readtail('Fire.spa',1,fir3);
     readtail('Circle2.spa',4,cir3);
     for i:=0 to 4 do
       if narmy[i] > 0 then
         readarmy(1+i*4,army[i]);
  for i := 0 to 4 do
    if narmy[i] > 0 then begin
      puttailsprcell(0,i,1+i*4,plai3);
      if (army[i] >=1) and (army[i] <=5) then
        color := 5;
      if (army[i] >=6) and (army[i] <=10) then
        color := 255;
      if (army[i] >=11) and (army[i] <=15) then
        color := 2;
      if (army[i] >=16) and (army[i] <=20) then
        color := 1;
      if (army[i] >=21) and (army[i] <=25) then
        color := 4;
      colorbar(64,22+34*i,255+48,54+34*i+1,color);
      if (lidersaip div lidir[army[i]]) >= narmy[i] then begin
        moral[i] := 3;
        for j1 := 0 to 4 do
          if narmy[j1] > 0 then begin
            case liderarray[army[j1],army[i]] of
              0:moral[i] := 1;
              1:if moral[i]=3 then moral[i]:=2;
              2:;
            end;
          end;
        case moral[i] of
          1:begin outfilblockxy(65,22+34*i,78,1); writexy(65,22+34*i,istr(narmy[i]) {+ '  Мораль : низкая'}); end;
          2:begin outfilblockxy(65,22+34*i,78,2); writexy(65,22+34*i,istr(narmy[i]) {+ '  Мораль : нормальная'}); end;
          3:begin outfilblockxy(65,22+34*i,78,3); writexy(65,22+34*i,istr(narmy[i]) {+ '  Мораль : высокая'}); end;
        end;
{        writexy(65,22+34*i,istr(narmy[i]) + '  Мораль : нормальная');
        moral[i] := 2;}
      end else begin
        outfilblockxy(65,22+34*i,78,4);
        writexy(65,22+34*i,istr(narmy[i]) {+ '  Мораль : бунтуют'});
        moral[i] := 4;
      end;
      writexy(65+7*8,30+34*i,{'Сила : ' + }istr(silaarmy[army[i]]) +
      '         ' + istr(damage[army[i]]) + '-' + istr(damage[army[i]]*2));
      outfilblockxy(65,30+34*i,78,5);
      writexy(65+9*8,38+34*i,{'Защита : ' +} istr(hitpts[army[i]]) +
      '             ' + istr(vistr[army[i]]));
      outfilblockxy(65,38+34*i,78,6);
      writexy(65+8*8,46+34*i,{'Ходов : ' +} istr(motions[army[i]]) +
      '              ' + lstr((prise[army[i]] div 10) * narmy[i]));
      outfilblockxy(65,46+34*i,78,7);
    end else begin
      puttilecell(0,i,plai3);
      colorbar(64,22+34*i,255+48,54+34*i+1,8);
    end;
    j := 0;
    repeat
      for i := 0 to 4 do
        if narmy[i] > 0 then
          puttailsprcell(0,i,1+i*4+j,plai3);
    inc(j);
    deltat(3);
    if j = 4 then
      j := 0;
    until keypressed;
  readtailmap;
end;

procedure loss(k,n,l:integer);  {вычисляет потери при ударе,парам.анал.blow}
var
   s,p:integer;
   g  :real;
begin
   if l=0 then begin
{      if silaarmy[army[k]] >= silaarmy[armye[n]] then
       s:=(damage[army[k]]+random(damage[army[k]]+1))*narmy[k]div 2;{сила удара}
 {     if silaarmy[army[k]] < silaarmy[armye[n]] then}
      case moral[k] of
       1 : s:=round(({damage[army[k]]+}(damage[army[k]]+1))*narmy[k]*
       (silaarmy[army[k]] / silaarmy[armye[n]] / 6 + (1 / 6)));{сила удара}
       2 : s:=round((damage[army[k]]+random(damage[army[k]]+1))*narmy[k]*
       (silaarmy[army[k]] / silaarmy[armye[n]] / 6 + (1 / 6)));{сила удара}
       3 : s:=round((damage[army[k]]+(damage[army[k]]+1))*narmy[k]*
       (silaarmy[army[k]] / silaarmy[armye[n]] / 6 + (1 / 6)));{сила удара}
      end;
{      s := s * longint(g);}
      if (s mod HitPts[armye[n]]) > random(HitPts[armye[n]]) then
         p:=s div HitPts[armye[n]] + 1                      {потери}
      else
         p:=s div HitPts[armye[n]];
      if army[k] = 23 then
       if narmye[n] >= p then
        narmy[k] := narmy[k] + p
       else
        narmy[k] :=narmy[k] + narmye[n];
      colorbar(x1,y1,x2,y2,4);
      if (army[k] = 25) and (random(8) =0) then begin
        narmye[n]:=narmye[n] div 2;
        writexy(273,9,'XAV')
      end;
      writexy(20,9,namear2[army[k]]);
      if p <= narmye[n] then begin
        outfilblockxy(125,9,78,8);
        writexy(125+6*8,9,{'убили ' +} istr(p) + ' ' + namear[armye[n]])
      end else begin
        outfilblockxy(125,9,78,8);
        writexy(125+6*8,9,{'убили ' +} istr(narmye[n]) + ' ' + namear[armye[n]]);
      end;
      narmye[n]:=narmye[n]-p;                            {остаток}
      if narmye[n]<0 then narmye[n]:=0;     {если армия разбита полностью}
   end
   else begin
{      if silaarmy[armye[n]] >= silaarmy[army[k]] then
       s:=(damage[armye[n]]+random(damage[armye[n]]+1))*narmye[n]div 2;{сила удара}
 {     if silaarmy[armye[n]] < silaarmy[army[k]] then}
       s:=round((damage[armye[n]]+random(damage[armye[n]]+1))*narmye[n]*{сила удара}
       (silaarmy[armye[n]] / silaarmy[army[k]] / 6 + (1 / 6)));{сила удара}
      if (s mod HitPts[army[k]]) > random(HitPts[army[k]]) then
         p:=s div HitPts[army[k]] + 1                      {потери}
      else
         p:=s div HitPts[army[k]];
      if armye[n] = 23 then
       if narmy[k] >= p then
        narmye[n] := narmye[n] + p
       else
        narmye[n] := narmye[n] + narmy[k];
      colorbar(x1,y1,x2,y2,4);
      if (armye[n] = 25) and (random(8) =0) then begin
        narmy[k]:=narmy[k] div 2;
        writexy(273,9,'XAV')
      end;
      writexy(20,9,namear2[armye[n]]);
      if p <= narmy[k] then begin
        outfilblockxy(125,9,78,8);
        writexy(125+6*8,9,{'убили ' +} istr(p) + ' ' + namear[army[k]])
      end else begin
        outfilblockxy(125,9,78,8);
        writexy(125+6*8,9,{'убили ' +} istr(narmy[k]) + ' ' + namear[army[k]]);
      end;
      narmy[k]:=narmy[k]-p;                             {остаток}
      if narmy[k]<0 then narmy[k]:=0;     {если армия разбита полностью}
   end;
end;

procedure loss2(k,n,l:integer);  {вычисляет потери при ударе,парам.анал.blow}
var
   s,p:integer;
   g  :real;
begin
      s := round(s_zakl[l]*sila_zaklinanii/5);
      if (s mod HitPts[armye[n]]) > random(HitPts[armye[n]]) then
         p:=s div HitPts[armye[n]] + 1                      {потери}
      else
         p:=s div HitPts[armye[n]];
      colorbar(x1,y1,x2,y2,4);
      writexy(20,9,namear2[army[k]]);
      if p <= narmye[n] then begin
        outfilblockxy(125,9,78,8);
        writexy(125+6*8,9,{'убили ' + }istr(p) + ' ' + namear[armye[n]])
      end else begin
        outfilblockxy(125,9,78,8);
        writexy(125+6*8,9,{'убили ' + }istr(narmye[n]) + ' ' + namear[armye[n]]);
      end;
      narmye[n]:=narmye[n]-p;                            {остаток}
      if narmye[n]<0 then narmye[n]:=0;     {если армия разбита полностью}
end;

procedure blow(k,n,l:integer); {удар:k,n - номера нашей и вражеской армий}
                               {l=0 - мы ударяем врага, l=1 - враг нас }
begin
   if l=0 then begin
      putsprcell(xarmye[n],yarmye[n],fir3);
      loss(k,n,0);
      deltat(18);
      if narmye[n]=0 then
         battlemap[xarmye[n],yarmye[n]]:=plai3
      else if eblows[n] then begin
         battlemapdraw;
         putsprcell(xarmy[k],yarmy[k],fir3);
         loss(k,n,1);
         deltat(18);
         eblows[n] := false;
         if narmy[k]=0 then
            battlemap[xarmy[k],yarmy[k]]:=plai3;
      end;
   end
   else begin
      putsprcell(xarmy[k],yarmy[k],fir3);
      loss(k,n,1);
      deltat(18);
      if narmy[k]=0 then
         battlemap[xarmy[k],yarmy[k]]:=plai3
      else if blows[k] then begin
         battlemapdraw;
         putsprcell(xarmye[n],yarmye[n],fir3);
         loss(k,n,0);
         deltat(18);
         blows[k] := false;
         if narmye[n]=0 then
            battlemap[xarmye[n],yarmye[n]]:=plai3;
      end;
   end;
 {  battlemapdraw;  }
end;

procedure batstep(xn,yn,k:integer;var i:integer);{ход рода войск}
var
   n,j:integer;
begin
if (xn>=0)and(xn<=5)and(yn>=0)and(yn<=4)then
   case battlemap[xn,yn] of
      1..25,fore3,moun3,wate3,wall3:;  {нельзя идти}
      plai3:begin
              battlemap[xarmy[k],yarmy[k]]:=plai3; {ход}
              xarmy[k]:=xn;
              yarmy[k]:=yn;
              battlemap[xarmy[k],yarmy[k]]:=army[k];
              i:=i-1;
      end;
      26..50:begin        {сражение, пока не написано(нельзя идти)}
              n:=-1;
              for j:=0 to 4 do if (narmye[j]>0) and (xarmye[j]=xn) and
                              (yarmye[j]=yn) then n:=j;{находим ном.вр.армии}
              blow(k,n,0);
              i:=0;
         end;
   end;
{                    writeln(i);}
end;

function sumarmy:integer;    {подсчит.сумму разм-ов армий}
var  i,k:integer;
begin
   i:=0;
   for k:=0 to 4 do i:=i+narmy[k];
   sumarmy:=i;
end;

function sumarmye:integer;    {подсчит.сумму разм-ов армий}
var  i,k:integer;
begin
   i:=0;
   for k:=0 to 4 do i:=i+narmye[k];
   sumarmye:=i;
end;

procedure aflu(k :integer);
var
  xs,ys : integer;
  s     : integer;
begin
  xs := xarmy[k];
  ys := yarmy[k];
  repeat
    animsprn(xs,ys,s);
    waitkey;
    case num_key of
     75: if xs>0 then xs := xs-1; {влево}
     77: if xs<5 then xs := xs+1; {вправо}
     72: if ys>0 then ys := ys-1; {вверх}
     80: if ys<4 then ys := ys+1; {вниз}
     71: if (xs>0) and (ys>0) then begin xs := xs-1; ys := ys-1; end; {влево-вверх}
     73: if (xs<5) and (ys>0) then begin xs := xs+1; ys := ys-1; end; {вправо-вверх}
     79: if (xs>0) and (ys<4) then begin xs := xs-1; ys := ys+1; end; {влево-вниз}
     81: if (xs<5) and (ys<4) then begin xs := xs+1; ys := ys+1; end; {вправо-вниз}
    end;
  until (num_key = 28) and (battlemap[xs,ys]=plai3);
  battlemap[xs,ys]:=battlemap[xarmy[k],yarmy[k]];
  battlemap[xarmy[k],yarmy[k]]:=plai3;
  xarmy[k] := xs;
  yarmy[k] := ys;
  battlemapdraw;
end;

procedure vistrel(k,i1:integer;var i:integer);
var
  v : boolean;
  xs,ys,s : integer;
begin
  v :=false;
  xs := xarmy[k];
  ys := yarmy[k];
  repeat
   animsprn(xs,ys,s);
   waitkey;
   case num_key of
     75: if xs>0 then xs := xs-1; {влево}
     77: if xs<5 then xs := xs+1; {вправо}
     72: if ys>0 then ys := ys-1; {вверх}
     80: if ys<4 then ys := ys+1; {вниз}
     71: if (xs>0) and (ys>0) then begin xs := xs-1; ys := ys-1; end; {влево-вверх}
     73: if (xs<5) and (ys>0) then begin xs := xs+1; ys := ys-1; end; {вправо-вверх}
     79: if (xs>0) and (ys<4) then begin xs := xs-1; ys := ys+1; end; {влево-вниз}
     81: if (xs<5) and (ys<4) then begin xs := xs+1; ys := ys+1; end; {вправо-вниз}
   end;
   if (num_key = 28)and(battlemap[xs,ys]>25)and(battlemap[xs,ys]<=50) then
     v :=true;
  until v;
    putsprcell(xarmye[s],yarmye[s],fir3);
    loss(k,s,0);
    deltat(18);
    if narmye[s]=0 then
      battlemap[xarmye[s],yarmye[s]]:=plai3;
    i:=0;
    dec(colvis[k]);
    battlemapdraw;
end;

procedure vistrel2(k,l,i1:integer;var i:integer);
var
  v : boolean;
  xs,ys,s,i2 : integer;
begin
  i2 := i1;
  v :=false;
  xs := xarmy[k];
  ys := yarmy[k];
  repeat
   animsprn(xs,ys,s);
   waitkey;
   case num_key of
     75: if xs>0 then xs := xs-1; {влево}
     77: if xs<5 then xs := xs+1; {вправо}
     72: if ys>0 then ys := ys-1; {вверх}
     80: if ys<4 then ys := ys+1; {вниз}
     71: if (xs>0) and (ys>0) then begin xs := xs-1; ys := ys-1; end; {влево-вверх}
     73: if (xs<5) and (ys>0) then begin xs := xs+1; ys := ys-1; end; {вправо-вверх}
     79: if (xs>0) and (ys<4) then begin xs := xs-1; ys := ys+1; end; {влево-вниз}
     81: if (xs<5) and (ys<4) then begin xs := xs+1; ys := ys+1; end; {вправо-вниз}
   end;
   if (num_key = 28)and(battlemap[xs,ys]>25)and(battlemap[xs,ys]<=50) then
     v :=true;
  until v;
  if (l <> 3) and (l<>10) then begin
   if (armye[s] <> 20) then begin
     putsprcell(xarmye[s],yarmye[s],fir3);
     loss2(k,s,2);
     deltat(18);
   end;
    if narmye[s]=0 then
      battlemap[xarmye[s],yarmye[s]]:=plai3;
    i:=0;
    battlemapdraw;
  end else if (l=3) then begin if armye[s] > 20 then begin
    putsprcell(xarmye[s],yarmye[s],fir3);
    narmy[k] := narmy[k]*sila_zaklinanii;
    loss2(k,s,3);
    deltat(18);
    if narmye[s]=0 then
      battlemap[xarmye[s],yarmye[s]]:=plai3;
    i:=0;
    narmy[k] := round(narmy[k]/sila_zaklinanii);
    battlemapdraw;
   end;
  end else if armye[s] <> 20 then begin
    putsprcell(xarmye[s],yarmye[s],fir3);
    loss2(k,s,1);
    deltat(18);
    if narmye[s]=0 then
      battlemap[xarmye[s],yarmye[s]]:=plai3;
    i:=0;
    battlemapdraw;
  end;
  i := i2;
end;

procedure close(k,l:integer;var i:integer);
var
  v : boolean;
  xs,ys,s,j : integer;
begin
  v :=false;
  xs := xarmy[k];
  ys := yarmy[k];
  repeat
   animsprn(xs,ys,s);
   waitkey;
   case num_key of
     75: if xs>0 then xs := xs-1; {влево}
     77: if xs<5 then xs := xs+1; {вправо}
     72: if ys>0 then ys := ys-1; {вверх}
     80: if ys<4 then ys := ys+1; {вниз}
     71: if (xs>0) and (ys>0) then begin xs := xs-1; ys := ys-1; end; {влево-вверх}
     73: if (xs<5) and (ys>0) then begin xs := xs+1; ys := ys-1; end; {вправо-вверх}
     79: if (xs>0) and (ys<4) then begin xs := xs-1; ys := ys+1; end; {влево-вниз}
     81: if (xs<5) and (ys<4) then begin xs := xs+1; ys := ys+1; end; {вправо-вниз}
   end;
   if (num_key = 28){and(battlemap[xs,ys]>25)}and(battlemap[xs,ys]<=25) then
     v :=true;
  until v;
  for j := 0 to 4 do
    if (xarmy[j] = xs) and (yarmy[j] = ys) and (narmy[j] > 0) then begin
      if l = 1 then
        inc(narmy[j],sila_zaklinanii)
      else
        if (narmy2[j]-sila_zaklinanii) >= (sila_zaklinanii + narmy[j]) then
          inc(narmy[j],sila_zaklinanii)
        else
          narmy[j] := narmy2[j];
      break;
    end;
end;

procedure teleport(k:integer;var i:integer);
var
  v : boolean;
  xs,ys,s,j : integer;
begin
  v :=false;
  xs := xarmy[k];
  ys := yarmy[k];
  repeat
   animsprn(xs,ys,s);
   waitkey;
   case num_key of
     75: if xs>0 then xs := xs-1; {влево}
     77: if xs<5 then xs := xs+1; {вправо}
     72: if ys>0 then ys := ys-1; {вверх}
     80: if ys<4 then ys := ys+1; {вниз}
     71: if (xs>0) and (ys>0) then begin xs := xs-1; ys := ys-1; end; {влево-вверх}
     73: if (xs<5) and (ys>0) then begin xs := xs+1; ys := ys-1; end; {вправо-вверх}
     79: if (xs>0) and (ys<4) then begin xs := xs-1; ys := ys+1; end; {влево-вниз}
     81: if (xs<5) and (ys<4) then begin xs := xs+1; ys := ys+1; end; {вправо-вниз}
   end;
   if (num_key = 28){and(battlemap[xs,ys]>25)}and(battlemap[xs,ys]=plai3) then
     v :=true;
  until v;
  battlemap[xs,ys]:=army[k];
  battlemap[xarmy[k],yarmy[k]]:=plai3;
  xarmy[k] := xs;
  yarmy[k] := ys;
end;

procedure stops(k:integer;var i:integer);
var
  v : boolean;
  xs,ys,s,j : integer;
begin
  v :=false;
  xs := xarmy[k];
  ys := yarmy[k];
  repeat
   animsprn(xs,ys,s);
   waitkey;
   case num_key of
     75: if xs>0 then xs := xs-1; {влево}
     77: if xs<5 then xs := xs+1; {вправо}
     72: if ys>0 then ys := ys-1; {вверх}
     80: if ys<4 then ys := ys+1; {вниз}
     71: if (xs>0) and (ys>0) then begin xs := xs-1; ys := ys-1; end; {влево-вверх}
     73: if (xs<5) and (ys>0) then begin xs := xs+1; ys := ys-1; end; {вправо-вверх}
     79: if (xs>0) and (ys<4) then begin xs := xs-1; ys := ys+1; end; {влево-вниз}
     81: if (xs<5) and (ys<4) then begin xs := xs+1; ys := ys+1; end; {вправо-вниз}
   end;
   if (num_key = 28)and(battlemap[xs,ys]>25)and(battlemap[xs,ys]<=50) then
     v :=true;
  until v;
  if armye[s] <> 20 then
    stop[s]:=false;
end;

procedure battle;{сражение}
var
   i,j,k,k1,n,s,k4,k3,k001,nmagsp2,nmagsp,i1,j1:integer;
   prior,k0,l0,r0,x0,y0,k2,l2,p1,p2:integer;
   b,xodmagis,b1,xodarmy : boolean;
begin
   for i := 0 to 4 do begin
     moral[i] := 3;
     for j := 0 to 4 do
       if narmy[j] > 0 then begin
         case liderarray[army[j],army[i]] of
           0:moral[i] := 1;
           1:if moral[i]=3 then moral[i]:=2;
           2:;
          end;
     end;
   end;
   for i :=0 to 4 do begin
     colvis[i]:=vistr[army[i]];
     if narmye[i] > 0 then
       ncolvis[i]:=vistr[armye[i]];
   end;
   for i :=0 to 4 do
     narmy2[i] := narmy[i];
   for i :=0 to 4 do begin
     armyflu[i]:=flu[army[i]];
     if narmye[i] > 0 then
       narmyflu[i]:=flu[armye[i]];
   end;
   while (sumarmy>0) and (sumarmye>0) do begin {пока кого-то не разобьют}
      for k := 0 to 4 do begin
        blows[k] := true;
        eblows[k] := true;
      end;
      xodmagis := true;
      for k := 0 to 4 do
        stop[k] := true;
      xodarmy := true;
      for k := 0 to 4 do if narmy[k] > 0 then
        armyi[k]:=motions[army[k]]
      else
        armyi[k]:=0;
      k := 0;
      while xodarmy and (sumarmye>0) and (sumarmy>0) do begin {цикл по нашим армиям}
         if narmy[k] <= 0 then if k < 4 then inc(k) else k := 0;
         if (narmy[k]>0) and (sumarmye>0) then {если эта армия еще не разбит}
          if ((lidersaip div lidir[army[k]])>=narmy[k]) then begin
            while armyi[k] > 0 do begin
               colorbar(x1,y1,x2,y2,4);
               writexy(20,9,namear2[army[k]]);
               outfilblockxy(125,9,78,9);
               writexy(125+6*8,9,{'ходов ' +} istr(armyi[k]));
               b1 := true;
               for  i1 := xarmy[k]-1 to xarmy[k]+1 do
                 for  j1 := yarmy[k]-1 to yarmy[k]+1 do
                   if (i1>=0) and (i1<=5) and (j1>=0) and (j1<=4) then
                     if (battlemap[i1,j1] >= 26) and (battlemap[i1,j1] <= 50) then
                       b1 := false;
               if (colvis[k] > 0) and b1 then begin
                 outfilblockxy(190,9,78,10);
                 writexy(190+10*8,9,{'выстрелов ' +} istr(colvis[k]));
               end;
               battlemapdraw;
               clearkeybuffer;
               animspr(xarmy[k],yarmy[k],k*4+1,plai3,narmy[k]);
               waitkey;
               case num_key of
                 75: batstep(xarmy[k]-1,yarmy[k]  ,k,armyi[k]); {влево}
                 77: batstep(xarmy[k]+1,yarmy[k]  ,k,armyi[k]); {вправо}
                 72: batstep(xarmy[k]  ,yarmy[k]-1,k,armyi[k]); {вверх}
                 80: batstep(xarmy[k]  ,yarmy[k]+1,k,armyi[k]); {вниз}
                 71: batstep(xarmy[k]-1,yarmy[k]-1,k,armyi[k]); {влево-вверх}
                 73: batstep(xarmy[k]+1,yarmy[k]-1,k,armyi[k]); {вправо-вверх}
                 79: batstep(xarmy[k]-1,yarmy[k]+1,k,armyi[k]); {влево-вниз}
                 81: batstep(xarmy[k]+1,yarmy[k]+1,k,armyi[k]); {вправо-вниз}
                 31: begin
                       b1 := true;
                       for  i1 := xarmy[k]-1 to xarmy[k]+1 do
                         for  j1 := yarmy[k]-1 to yarmy[k]+1 do
                           if (i1>=0) and (i1<=5) and (j1>=0) and (j1<=4) then
                             if (battlemap[i1,j1] >= 26) and (battlemap[i1,j1] <= 50) then
                               b1 := false;
                       if  (colvis[k]>0) and b1 then vistrel(k,armyi[k],armyi[k]);
                     end;
                 33: if  armyflu[k]=1 then aflu(k);
                 17: if k < 4 then inc(k) else k := 0;
                 22: if xodmagis then begin
                       spellmagis(false);
                       battlemapdraw;
                       nmagsp2 := 0;
                       for nmagsp := 1 to 7 do
                         if spellarray2[nmagsp] <> 0 then
                           nmagsp2 := nmagsp;
                       case nmagsp2 of
                         1:begin
                             close(k,1,armyi[k]);
                           end;
                         2:begin
                             teleport(k,armyi[k]);
                           end;
                         3:begin
                             vistrel2(k,10,armyi[k],armyi[k]);
                           end;
                         4:begin
                             vistrel2(k,0,armyi[k],armyi[k]);
                           end;
                         5:begin
                             stops(k,armyi[k]);
                           end;
                         6:begin
                             close(k,0,armyi[k]);
                           end;
                         7:begin
                             vistrel2(k,3,armyi[k],armyi[k])
                           end;
                       end;
                       spellarray2[nmagsp2] := 0;
                       xodmagis := false;
                     end;
                 57: armyi[k]:=0;
                 35: begin
                       frame(2,18,1);
                       outfilblock(1,2,79);
{                       OutString(1,2,'       H - Помощь');}
                       OutString(1,4,Char(16) {+ '      - Вправо'});
                       OutString(1,5,Char(17) {+ '      - Влево'});
                       OutString(1,6,Char(30) {+ '      - Вверх'});
                       OutString(1,7,Char(31) {+ '      - Вниз'});
{                       OutString(1,8,'Home   - Влево-Вверх');
                       OutString(1,9,'PgUp   - Вправо-Вверх');
                       OutString(1,10,'PgDn   - Вправо-Вниз');
                       OutString(1,11,'End    - Влево-Вниз');
                       OutString(1,12,'Пробел - Пропуск хода');
                       OutString(1,13,'W      - Отложить ход');
                       OutString(1,14,'U      - Магия');
                       OutString(1,15,'S      - Выстрел');
                       OutString(1,16,'F      - Летать');}
                       waitkey;
                     end;
{                30: varmy;}
               end;
               if (sumarmy=0) or (sumarmye=0) then begin {если кто-то разбит}
                 armyi[k]:=0;
                 xodarmy := true;
               end;

            end;
          end else begin
            for i := 0 to 4 do
              if narmye[i] <= 0 then begin
                armye[i] := army[k];
                narmye[i] := narmy[k];
                xarmye[i] := xarmy[k];
                yarmye[i] := yarmy[k];
                ncolvis[i] := colvis[k];
                narmyflu[i] := armyflu[k];
                narmy[k] := 0;
                readarmy(i*4+26,army[k]+25);
                battlemap[xarmye[i],yarmye[i]]:=army[k]+25;
                break;
              end;
              if k < 4 then inc(k) else xodarmy := true;
          end;
            xodarmy := false;
            for i := 0 to 4 do if (narmy[i] > 0) and (armyi[i]>0) then begin
              xodarmy := true;
              break;
            end;
            if armyi[k] = 0 then
              inc(k);
            if k = 5 then
              k := 0;
      end; {конец цикла по нашим армиям}
      {здесь дописывать для врагов}
      for k:=0 to 4 do if stop[k] then begin {цикл по вражеским родам войск}
         if (narmye[k]>0) and (sumarmy>0) then begin {если эта армия еще не разбит}
            i:=motions[armye[k]];
            while i > 0 do begin
               colorbar(x1,y1,x2,y2,4);
               writexy(20,9,namear2[armye[k]]);
               outfilblockxy(125,9,78,9);
               writexy(125+6*8,9,{'ходов ' +} istr(i));
               prior:=0;
               for k1:=0 to 4 do
                        if (narmy[k1]>0) and (prior<priority[army[k1]])

                  then begin
                  x0:=xarmy[k1];        {координаты той клетки,в направлении}
                  y0:=yarmy[k1];        {которой враг будет идти}
                  prior:=priority[army[k1]];
                  s:=k1;
               end;
               k0:=xarmye[k];
               l0:=yarmye[k];
               r0:=(x0-xarmye[k])*(x0-xarmye[k])+(y0-yarmye[k])*(y0-yarmye[k]);
               for k2:=xarmye[k]-1 to xarmye[k]+1 do
                  for l2:=yarmye[k]-1 to yarmye[k]+1 do
                     if (k2<=5) and (k2>=0) and (l2<=4) and (l2>=0) then
                        case battlemap[k2,l2] of
                           plai3:if r0>((x0-k2)*(x0-k2)+(y0-l2)*(y0-l2)) then
                              begin
                                 k0:=k2;    {координаты той клетки}
                                 l0:=l2;    {куда враг будет наступать}
                                 r0:=(x0-k2)*(x0-k2)+(y0-l2)*(y0-l2);
                              end;
                           1..25:if r0>(damage[battlemap[k2,l2]]-32000) then
                              begin
                                 k0:=k2;
                                 l0:=l2;
                                 r0:=damage[battlemap[k2,l2]]-32000;
                              end;
                        end;
      battlemapdraw;
{      if (battlemap[k0,l0] = plai3) and (ncolvis[k]=0) and (narmyflu[k]=0)
       then
        writexy(125,10,'пошли ' );}
      eanimspr(xarmye[k],yarmye[k],(k*4+1)+25,plai3,narmye[k]);
      colorbar(x1,y1,x2,y2,4);
      {deltat(18);  }
               b1 := true;
               for  i1 := xarmye[k]-1 to xarmye[k]+1 do
                for  j1 := yarmye[k]-1 to yarmye[k]+1 do
                 if (i1>=0) and (i1<=5) and (j1>=0) and (j1<=4) then
                  if (battlemap[i1,j1] >= 1) and (battlemap[i1,j1] <= 25) then
                    b1 := false;
               if ncolvis[k]>0 then begin
                if b1 then begin
                 i :=0;
                 dec(ncolvis[k]);
                 putsprcell(xarmy[s],yarmy[s],fir3);
{                 writexy(125,10,'выстрелили ' );}
                 loss(s,k,1);
                 deltat(18);
                 if narmy[s]=0 then
                   battlemap[xarmy[s],yarmy[s]]:=plai3;
                 battlemapdraw;
                 break;
                end;
               end;
               if (narmyflu[k] =1) and (i>0) and b1 then begin
                 p1 := xarmye[k];
                 p2 := yarmye[k];
                 b := false;
                 for k3 := x0-1 to x0+1 do
                   for k4 := y0-1 to y0+1 do
                     if (k3>=0)and(k3<=5)and(k4>=0)and(k4<=4)
                                and(battlemap[k3,k4]=plai3) then begin
                       battlemap[k3,k4]:=battlemap[xarmye[k],yarmye[k]];
                       battlemap[xarmye[k],yarmye[k]]:=plai3;
                       b := true;{
                       if (xarmye[k] = k3) and (yarmye[k] = k4) then
                         b :=false;}
                       xarmye[k] := k3;
                       yarmye[k] := k4;
                       k0 := k3;
                       l0 := k4;
                       i :=0;
{                       break;
                       break;}
                     end;
                     if (p1<>xarmye[k]) or (p2<>yarmye[k]) then begin
                       battlemapdraw;
{                       if b then}
                       writexy(20,9,namear2[armye[k]]);
                       outfilblockxy(125,9,78,11);
{                       writexy(125,9,'полетели ' );}
                       eanimspr(xarmye[k],yarmye[k],(k*4+1)+25,plai3,narmye[k]);
{                       colorbar(x1,y1,x2,y2,4);
{                       writexy(20,10,namear2[armye[k]]);}
{                       writexy(125,10,'атаковали ' );}
                       blow(s,k,1);
                       deltat(3);
{                       colorbar(x1,y1,x2,y2,4);}
                     end else if b then begin
{                       colorbar(x1,y1,x2,y2,4);
{                       writexy(20,10,namear2[armye[k]]);
                       writexy(125,10,'атаковали ' );}
                       blow(s,k,1);
                       deltat(3);
                     end;
               end;
                        case battlemap[k0,l0] of {осуществление хода враж.армии}
                  26..50:if i>0 then begin
                    i:=0;                  {стоим на месте}
                       outfilblockxy(125,9,78,12);
{                    writexy(125,9,'пропустили ход ' );}
                    deltat(18);
                  end;
                  plai3:begin
                      if i>0 then begin
                        battlemap[xarmye[k],yarmye[k]]:=plai3; {ход}
                        xarmye[k]:=k0;
                        yarmye[k]:=l0;
                        battlemap[xarmye[k],yarmye[k]]:=armye[k]+25;
                        i:=i-1;
{                        deltat(18);}
                      end;
                     end;
                  1..25:begin      {сражение, пока не написано(нельзя идти)}
               prior := 0;
               for k2:=xarmye[k]-1 to xarmye[k]+1 do
                  for l2:=yarmye[k]-1 to yarmye[k]+1 do
                     if (k2<=5) and (k2>=0) and (l2<=4) and (l2>=0) then
                       if (battlemap[k2,l2] >= 1) and (battlemap[k2,l2] <= 25) then begin
                         for j1 := 0 to 4 do
                           if (narmy[j1]>0) and (prior<priority[army[j1]])
                           and (xarmy[j1]=k2) and (yarmy[j1]=l2) then begin
                             prior := priority[army[j1]];
{                             l0 := l2;
                             k0 := k2; }
                             n := j1;
                           end;
                       end;
                       if i >0 then begin
{                        n:=-1;
                        for j:=0 to 4 do if (narmy[j]>0) and (xarmy[j]=k0) and
                              (yarmy[j]=l0) then n:=j;{находим ном.нашей армии}
{                       writexy(125,10,'атаковали ' );}
                        blow(n,k,1);
                        i:=0;
                       end;
                     end;
               end;
               if (sumarmy=0) or (sumarmye=0) then i:=0; {если кто-то разбит}
            end;
         end;
      end; {конец цикла по вражеским родам войск}
   end; {конец основного цикла сражения}
   readtailmap;
end;

end.
