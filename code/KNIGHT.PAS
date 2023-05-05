program knight;
uses
  Crt, Dos, Initial, Constant, Draw, Enemys, Markers, zamok,drawtail,beep,
                                                                     grtext,
                                                                     battl,
                                                                     filreads;
procedure InitMap;{Считывает карту}
var
  mapfile : file of maparr;
  l,i,j : integer;
begin
  assign(mapfile,'map1.dat');
  reset(mapfile);
  for l := 1 to 4 do
    read(mapfile,map[l]);
  x:=11;y:=58;
  xk:=11;yk:=60;
  cont := 1;
  close(mapfile);
  for l := 1 to 4 do
    for i := 0 to 63 do
      for j := 0 to 63 do
        mapb[i,j] := 0;
{        mapb[i,j] := mapb[i,j] or (1 shl (cont-1));}
  for i := x - 2 to x + 2 do
    for j := y - 2 to y + 2 do
      mapb[i,j] := mapb[i,j] or (1 shl (cont-1));
  mapcont := 1;
end;

procedure initsund;
var
  i,j,l,m,k1,k2,k3,n,k4 : integer;
  asboolean : array [1..250] of boolean;
  b : boolean;
begin
  m := 0;
  colsund := 0;
  k2 := 0;
  for i := 1 to 250 do
    asboolean[i] := true;
  for l := 1 to 4 do begin
    for i := 0 to 63 do
      for j := 0 to 63 do
        if map[l,i,j] = ches1 then begin
          inc(colsund);
          arraysundx[colsund] := i;
          arraysundy[colsund] := j;
          arraysundc[colsund] := l;
        end;
    for m := 1 to 2 do  begin
    b := false;
      repeat
        k1 := random(colsund-k2)+1+k2;
        if (asboolean[k1])   then begin
          map[l,arraysundx[k1],arraysundy[k1]] := (arti1+m+(l-1)*2-1);
          asboolean[k1] := false;
          b := true;
        end;
      until b;
    end;
    for m := 1 to 5 do  begin
      b := false;
      repeat
        k1 := random(colsund-k2)+1+k2;
        if (asboolean[k1])   then begin
          map[l,arraysundx[k1],arraysundy[k1]] := (enem2+l-1);
          asboolean[k1] := false;
          enemprise[l*5-5+m].n := k1;
          repeat
            k1 := random(25)+1;
            enemprise[l*5-5+m].a := k1;
            enemprise[l*5-5+m].na :=nacharmy[l,k1];
          until nacharmy[l,k1] > 0;
          b := true;
        end;
      until b;
    end;
          k2 := colsund;
  end;
  for m := 1 to 3 do begin
    b := false;
    repeat
      k2 := random(colsund);
      if asboolean[k2] and (arraysundc[k2]=m) then begin
        b := true;
        asboolean[k2]:=false;
        mapcontnsun[m]:=k2;
        map[m,arraysundx[k2],arraysundy[k2]] := ches2;
      end;
    until b;
  end;
          arraysundx[colsund+1] :=27;
          arraysundy[colsund+1] :=52;
          arraysundc[colsund+1] :=1;
  repeat
    k1 := random(colsund)+1;
    if asboolean[k1] then begin
      inc(m);
      asboolean[k1] := false;
      magsundrec[m].n := k1;
      k2 := random(4);
      map[arraysundc[k1],arraysundx[k1],arraysundy[k1]] := cart1 + k2;
      b := false;
      repeat
        k1 := random(5)+1;
        if k2 = 0 then
          if nachsund[arraysundc[magsundrec[m].n],5+k1] > 0 then begin
            b := true;
            magsundrec[m].a := 5+k1;
            magsundrec[m].na:= nachsund[arraysundc[magsundrec[m].n],5+k1];
          end;
        if k2 = 1 then
          if nachsund[arraysundc[magsundrec[m].n],20+k1] > 0 then begin
            b := true;
            magsundrec[m].a := 20+k1;
            magsundrec[m].na:= nachsund[arraysundc[magsundrec[m].n],20+k1];
          end;
        if k2 = 2 then
          if nachsund[arraysundc[magsundrec[m].n],10+k1] > 0 then begin
            b := true;
            magsundrec[m].a := 10+k1;
            magsundrec[m].na:= nachsund[arraysundc[magsundrec[m].n],10+k1];
          end;
        if k2 = 3 then
          if nachsund[arraysundc[magsundrec[m].n],15+k1] > 0 then begin
            b := true;
            magsundrec[m].a := 15+k1;
            magsundrec[m].na:= nachsund[arraysundc[magsundrec[m].n],15+k1];
          end;
      until b;
    end;
  until m = 44;
    magsundrec[45].a := 6;
    magsundrec[45].na:= nachsund[arraysundc[magsundrec[m].n],6];
    magsundrec[45].n:=colsund+1;
end;

procedure dismit;
var
  n,l : integer;
begin
  repeat
    frame(7,14,1);
    outfilblock(1,7,1);
    for n:=0 to 4 do
      if narmy[n]<=0 then
        for l := (n + 1) to 3  do begin
          narmy[l-1]:=narmy[l];
          army[l-1]:=army[l];
          narmy[l]:=0;
        end;
        for l := 4 downto 1 do
          if (narmy[l]>0) and (narmy[l-1]=0) then begin
            narmy[l-1]:=narmy[l];
            army[l-1]:=army[l];
            narmy[l]:=0;
          end;
    if narmy[0] > 0 then
      outstring(3,9,'A');
    if narmy[1] > 0 then
      outstring(3,10,'B');
    if narmy[2] > 0 then
      outstring(3,11,'C');
    if narmy[3] > 0 then
      outstring(3,12,'D');
    if narmy[4] > 0 then
      outstring(3,13,'E');
    for n := 0 to 4 do  begin
      if narmy[n] > 0 then begin
        outstring(5,9+n,namear2[army[n]]);
      end;
    end;
    waitkey;
    case num_key of
      30 : if narmy[1]>0 then narmy[0] := 0 else begin
             frame(9,12,1);
             outfilblock(1,10,2);
             waitkey;
           end;
      48 : if narmy[0]>0 then narmy[1] := 0;
      46 : if narmy[0]>0 then narmy[2] := 0;
      32 : if narmy[0]>0 then narmy[3] := 0;
      18 : if narmy[0]>0 then narmy[4] := 0;
    end;
  until num_key = 1 ;
end;

procedure continent;
var
  b   : boolean;
  i,j : integer;
begin
  if boat then begin
    b := false;
    repeat
    frame(10,16,1);
    outfilblock(1,10,3);
    for i := 1 to 4 do
     if i <= mapcont then
      outstring(3,11+i,istr(i) + ' ' + ncont[i]);
    waitkey;
    case num_key of
      2 :if mapcont>=1 then begin
      cont := 1;
      if (time mod 5) > 0 then
        time:=time-time mod 5
      else
        time := time - 5;
      timestep := 0;
      x := 11;
      y := 62;
      xk := 11;
      yk := 62;
      colormap;
      putsprcell(2,2,19);
      week;
      b := true;
      colormap;
      end;
      3 :if mapcont>=2 then begin
      cont := 2;
      if (time mod 5) > 0 then
        time:=time-time mod 5
      else
        time := time - 5;
      timestep := 0;
      x := 1;
      y := 26;
      xk := 1;
      yk := 26;
      colormap;
      putsprcell(2,2,19);
      week;
      b := true;
      colormap;
      end;
      4 :if mapcont>=3 then begin
      cont := 3;
      if (time mod 5) > 0 then
        time:=time-time mod 5
      else
        time := time - 5;
      timestep := 0;
      x := 14;
      y := 1;
      xk := 14;
      yk := 1;
      colormap;
      putsprcell(2,2,19);
      week;
      b := true;
      colormap;
      end;
      5 :if mapcont>=4 then begin
      cont := 4;
      if (time mod 5) > 0 then
        time:=time-time mod 5
      else
        time := time - 5;
      timestep := 0;
      x := 8;
      y := 62;
      xk := 8;
      yk := 62;
      colormap;
      putsprcell(2,2,19);
      week;
      b := true;
      colormap;
      end;
    end;
    until (num_key=1) or b;
    for i := x-2 to x+2 do
      for j := y-2 to y+2 do
        if (i>=0) and (i<=63) and (j>=0) and (j<=63) then
          mapb[i,j] := mapb[i,j] or (1 shl (cont-1));
  end;
end;

procedure prizekop;
var
  i,j,k : integer;
begin
  for i := 0 to 4 do
    for j := 0 to 4 do begin
      if  tainmap[i,j] then
        puttilecell(i,j,tab[map[contp,xp+i-2,yp+j-2]]);
    end;
  readtail('artifact.spa',16,1);
  for i := 1 to 17 do
    readtail(readspavil[i],4,18+i*4-4);
  k := 0;
  repeat
  for i := 0 to 4 do
    for j := 0 to 4 do
      if not tainmap[i,j] then
          if prosmp[i,j] <= 17 then
            puttilecell(i,j,16+prosmp[i,j]*4+k-1)
          else
            puttilecell(i,j,prosmp[i,j]-17+8);
    deltat(2);
    inc(k);
    if k = 3 then
      k := 0;
  until keypressed;
  readtailmap;
end;

procedure zemkop;
begin
  if (xp=x) and (yp=y) and (cont=contp) then begin
    frame(14,18,1);
    outfilblock(1,15,4);
    waitkey;
    dec(time);
    eckipet:=true;
  end else begin
    frame(14,18,1);
    outfilblock(1,15,5);
    waitkey;
    dec(time);
  end;
end;

procedure victory;
var
  i,j,k,l,m,n : integer;
  t1,t2:longint;
begin
  for i :=1 to 25 do
  readarmy(i*4-3,i);
  readtail('lbattle.spa',4,100);
  readtail('bridges.spa',2,105);
  readtail('knight.spa',4,109);
  l:=4;
  k :=0;
  m :=1;
  for i :=0 to 5 do
    for j :=0 to 4 do
      puttilecell(i,j,100);
  n := 0;
  repeat
  for i :=0 to 1 do
    for j :=0 to 4 do begin
      puttailsprcell(i,j,m*4-3+k,100);
      inc(m);
    end;
  for i :=3 to 5 do
    for j :=0 to 4 do begin
      puttailsprcell(i,j,m*4-3+k,100);
      inc(m);
    end;
    m:=1;
    puttailsprcell(2,l,109+k,106);
    deltat(2);
    inc(k);
    if k = 3 then begin
    k:=0;
    inc(n);
    end;
    if n = 3 then begin
    puttilecell(2,l,106);
    dec(l);
    puttailsprcell(2,l,112,106);
    n :=0;
    end;
  until l= 0;
  colorbar(x1,y2+6,x2,y2+175,1);
  readpich('vic.kni',3);
  putpich(160,22,303,191);
  outstring(0,0,ime[a1,a]);
  outfilblock(0,1,6);
  outstring(0,1,name);
  outstring(0,18,Lstr(Score));
  clearkeybuffer;
  repeat
    waitkey;
  until (num_key = 1);
end;

procedure heroflu;
var
  i : integer;
begin
  if (eflu) and (map[cont,x,y]>=plai1) and (map[cont,x,y]<=plai2) then
    eflu := false
  else begin
    eflu := true;
    for i := 0 to 4 do
      if (narmy[i] > 0) and ((flu[army[i]] = 0) or (army[i] = 11)) then
        eflu := false;
  end;
  if boat then
    eflu := false;
end;

function artif(xn,yn:integer):boolean;
var
  i,j,k : integer;
begin
  frame(14,19,1);
  if map[cont,xn,yn] = 28 then begin
    k := 2;
    outfilblock(1,14,7);
  end;
  if map[cont,xn,yn] = 29 then begin
    k := 8;
    outfilblock(1,14,8);
  end;
  if map[cont,xn,yn]= 30 then begin
    k := 3;
    outfilblock(1,14,9);
    lidersaip := lidersaip * 2;
  end;
  if map[cont,xn,yn]= 31 then begin
    k := 1;
    outfilblock(1,14,10);
  end;
  if map[cont,xn,yn]= 32 then begin
    k := 5;
    sila_zaklinanii := sila_zaklinanii * 2;
    outfilblock(1,14,11);
  end;
  if map[cont,xn,yn]= 33 then begin
    k := 7;
    maksium_zaklinanii := maksium_zaklinanii * 2;
    outfilblock(1,14,12);
  end;
  if map[cont,xn,yn]= 34 then begin
    k := 6;
    inc(plata,2000);
    outfilblock(1,14,13);
  end;
  if map[cont,xn,yn] = 35 then begin
    k := 4;
    outfilblock(1,14,14);
  end;
  for i := 0 to 4 do
    for j := 0 to 4 do
      if prosmp[i,j] = k+17 then begin
        tainmap[i,j] := true;
        map[cont,xn,yn]:=plai1;
        artif:=zem;
        muzbeep(1,13);
        if (naideno_artifaktov = 0) and (a1=0) then
          inc(plata,2000);
        inc(naideno_artifaktov);
        inc(score,200);
        waitkey;
      end;
end;

function sund(xn,yn:integer):boolean;{Сундук}
var
  s:char;
  exitbeep : boolean;
  summa    : integer;
begin
  case cont of
    1 : summa := random(9)+2;
    2 : summa := random(31)+10;
    3 : summa := random(61)+20;
    4 : summa := random(121)+80;
  end;
  exitbeep := false;
  sund:=zem;
  frame(13,19,1);
  outfilblock(1,14,15);
  outstring(14,15,istr(summa*50));
  outstring(23,17,istr(summa));
  beginbeep;
  muzbeep(1,13);
  repeat
    s:=readkey;
  until (s='a') or (s='b') or (s='A') or (s='B');
  if (s='a') or (s='A') then
    money:=money+(summa*50)
  else
    lidersaip:=lidersaip+summa;
  map[cont,xn,yn]:=plai1;
  inc(score);
end;

function sund2(xn,yn:integer):boolean;
begin
  frame(14,18,1);
  outfilblock(1,15,16);
  outstring(12,16,ncont[cont+1]);
  muzbeep(1,13);
  waitkey;
  inc(mapcont);
  map[cont,xn,yn] := plai1;
  sund2 := zem;
end;

function enem2a(xn,yn:integer):boolean;
var
  i,j : integer;
  b : boolean;
begin
  for i := 1 to 20 do
    if (arraysundx[enemprise[i].n] = xn) and (arraysundy[enemprise[i].n] = yn)
     and (arraysundc[enemprise[i].n] = cont)   then begin j := i; break; end;
    frame(14,19,1);
    outstring(1,14,istr(enemprise[j].na) + ' ' + namear[enemprise[j].a]);
    outfilblock(1,15,17);
    b := true;
    if askyn then
      for i := 0 to 4 do begin
        if (army[i] = enemprise[j].a) and (narmy[i] > 0) then begin
          narmy[i] := narmy[i] + enemprise[j].na;
          b := false;
        end;
        if ((narmy[i] <= 0) and b) then begin
          army[i] := enemprise[j].a;
          narmy[i] := enemprise[j].na;
          break;
        end;
      end;
    map[cont,xn,yn] := plai1;
    enem2a := zem;
    inc(score);
end;

function step(xn,yn:integer):boolean;{проверяет куда можно идти}
var
  k,i,j : integer;
begin
  if(xn>=0)and(xn<=mx)and(yn>=0)and(yn<=my)then begin
 {   if (xk=xn) and (yk=yn) then
      step:=kor(xn,yn);}
   if not boat then begin
    if (nap<>(x-xn)) and((x-xn)<>0) and(not eflu) then begin
        for k :=0 to 3 do
          if not eflu then begin
            pspr(106+k,0);
            epspr(0,106+k);
          end;
      if not eflu then
       if nap = 1 then
         nap := -1
       else
         nap := 1
      end;
    if (nap3<>(x-xn)) and((x-xn)<>0)and(eflu) then begin
        for k :=0 to 3 do
          if eflu then begin
            pspr(110+k,0);
            epspr(0,110+k);
          end;    if nap3 = 1 then
         nap3 := -1
       else
         nap3 := 1;
    end;
   end else
    if (nap2<>(x-xn)) and((x-xn)<>0) then begin
        for k :=0 to 3 do begin
            pspr(19+k,0);
            epspr(0,19+k);
          end;
       if nap2 = 1 then
         nap2 := -1
       else
         nap2 := 1;
{    if nap <> nap2 then begin
      nap := nap2;
      for k :=0 to 3 do begin
        pspr(106+k,0);
        epspr(0,106+k);
      end;
    end;    {}
    end;
   if not eflu then
    case map[cont,xn,yn] of
      enem1        : step:=enem(xn,yn);          {бр.рыцарь}
      brid1..brid2 : step:=zem;          {мост}
      plai1..plai2 : step:=zem ;          {равнина}
      ches1        : step:=sund(xn,yn) ;         {сундук}
      ches2        : step:=sund2(xn,yn);         {сундук с картой}
      enem2..enem3 : step:=enem2a(xn,yn);         {сундук с картой}
      town1        : step:=town2(xn,yn);         {город}
      arti1..arti2 : step:=artif(xn,yn) ;         {артифакты}
    {  boat1..boat2 : step:=kor(xn,yn);         {корабль}
      cart1        : step:=mag(xn,yn){false} ;         {повозка}
      cell1        : step:=mag(xn,yn){false} ;         {клетка}
      tree1        : step:=mag(xn,yn){false} ;         {дерево}
      cave1        : step:=mag(xn,yn){false} ;         {пещера}
      unde1        : step:=false ;         {под зем.ход}
      star1        : step:=stars1(xn,yn);         {пещера со звездой}
      dese1..dese2 : step:=zem ;         {пустыня}
      mark1        : step:=marker(xn,yn);  {указатель}
      wate1..wate2 : step:=wat(xn,yn) ;         {вода}
      moun1..moun2 : step:=false ;         {горы}
      fore1..fore2 : step:=false ;         {лес}
      pala1        : step:=zamak ;         {ворота дворца}
      pala1+1..pala2 : step:=false;       {дворец}
      cast1+3      : step:=castlle(xn,yn){false} ;
      cast1..cast2 : step:=false ;         {замок}
{   else step :=false {проверка}
    end
   else step:=true;
  end else step:=false;
   if  (timestop = 0) or ((map[cont,xn,yn]>=dese1) and (map[cont,xn,yn]<=dese2)) then begin
      if (map[cont,x,y] >=dese1) and (map[cont,x,y] <=dese2) then
       if not eflu then begin
        dec(time);
        timestep :=0;
       end else
         inc(timestep)
      else
        inc(timestep);
      if (timestep >=40) then begin
        dec(time);
        timestep := 0;
      end;
      if ((time mod 5) = 0) and (timestep=0) then
        week;
{      setgttyp(0);}
      colorbar(x1,y1,x2,y2,4);
      writexy(40,9,'H - Помощь');
      writexy(160,9,'Осталось ');
      writexy(264,9,'дней ');
      writexy(232,9,lstrk(time));
   end else begin
     dec(timestop);
     colorbar(x1,y1,x2,y2,4);
      writexy(40,9,'H - Помощь');
     writexy(160,9,'Осталось ');
     writexy(264,9,'шагов');
     writexy(232,9,lstrk(timestop));
   end;
      for i := xn-2 to xn+2 do
        for j := yn-2 to yn+2 do
          if (i>=0) and (i<=63) and (j>=0) and (j<=63) then
            mapb[i,j] := mapb[i,j] or (1 shl (cont-1));
end;

procedure view;   {просмотр характеристик героя}
begin
   putpichviem(20,20,0);
   frame(0,19,1);
   putpichviem(24,32,1);
   OutString(12, 0,name + ' -');
   OutString(14, 1,ime[a1,a]);
   outfilblock(0,3,18);
   OutString(12+11, 3,lstr(lidersaip));
   OutString(12+11, 5,lstr(plata + zanito_zamkov*1000));
   OutString(12+11,7,lstrk(money));
   OutString(12+11,9,istr(sila_zaklinanii));{заклинаний}
   OutString(24,18, lstr(score));
   OutString(23,13,istr(maksium_zaklinanii));
   OutString(23,15,istr(poimano_zlodeev));
   OutString(23,14,istr(naideno_artifaktov));
   OutString(23,17,istr(zanito_zamkov));
   OutString(23,16,lstr(ubito_boevin_edinic));
   WaitKey;
end;

procedure c_help;
begin
  frame(0,19,1);
  outfilblock(1,0,19);
  OutString(1, 2,char(16));
  OutString(1, 3,char(17));
  OutString(1, 4,char(30));
  OutString(1, 5,char(31));
  waitkey;
end;

procedure InitGame;
var
  i,j : integer;
  b   : boolean;
begin
   for i := 1 to 14 do
     spellarray[i] := 0;
   for i := 1 to 14 do
     spellarray2[i] := 0;
   for i := 1 to 26 do
     towns[i].m := random(14)+1;
   for i := 1 to 26 do
     towns[i].p := false;
   for i := 1 to 26 do
     castle[i].p := false;
{   regim := false;}
{     spellarray[12] := 0;}
{     spellarray14 := 3;   }
   minvil:=1;
   maxvil:=5;
   lidersaip:=100;
   plata:=1000;
   money:=5000;
   a:=0;
   sila_zaklinanii:=2;
   maksium_zaklinanii:=4;
   poimano_zlodeev:=0;
   naideno_artifaktov:=0;
   zanito_zamkov:=0;
   ubito_boevin_edinic:=0;
     army[0]:=1{5};
     narmy[0]:=20;
     army[1]:=2{10};
     narmy[1]:=2{50};
     army[2]:=20{15};
     narmy[2]:=0{10};
     army[3]:=25{20};
     narmy[3]:=0{10};
     army[4]:=5;
     narmy[4]:=0;
   repeat
     b := false;
     xp := random(64);
     yp := random(64);
     contp := random(4)+1;
     if map[contp,xp,yp] = plai1 then
       b := true;
   until b;
   for i := 0 to 4 do
     for j := 0 to 4 do
       tainmap[i,j] := false;
   eckipet := false;
   mapcont :=1;

{   x := xp;
   y := yp;
   cont := contp;                          {}
end;

procedure begingame(h:char);
var
  x : integer;
  w : char;
begin
  frame(0,19,1);
  outfilblock(1,1,20);
  waitkey;
  putpich(0,0,319,199);
  name := '';
  x := 11;
  frame(6,10,1);
  outfilblock(7,6,21);
  repeat
    w := readkey;
    if (byte(w)<>13) and (x < 19) and (byte(w)<>8) then begin
      outstring(x,8,w);
      inc(x);
      name := name + w;
    end;
    if (byte(w)=8) and (x > 11) then begin
      dec(x);
      ColorBar(25+x*8,8*11+8-2,25+x*8+8,8*11+8+8-2,1);  { и стираем цифру }
      dec(name[0]);
    end;
  until (byte(w)=13) and (x>11);
  frame(5,12,1);
  outfilblock(0,5,22);
  repeat
    waitkey;
  until (num_key >= 2) and (num_key <= 5);
  case num_key of
    2 : time := 900;
    3 : time := 600;
    4 : time := 400;
    5 : time := 200;
  end;
  case h of
    'a' : begin  lidersaip:=100; plata:=1000; a1 := 0; end;
    'b' : begin  lidersaip:=80;  plata:=3000; a1 := 1; end;
    'd' : begin  lidersaip:=80;  plata:=3000; a1 := 2; end;
    'c' : begin
            lidersaip:=60;
            plata:=3000;
            army[0]:=11;
            narmy[0]:=20;
            army[1]:=6;
            narmy[1]:=10;
            emag := true;
            money := 10000;
            map[1,11,44] := plai1;
          end;
  end;
end;

procedure load(n1:string);
var
  f   : file;
  r   : searchrec;
  s   : array [1..9] of searchrec;{string[12];}
  i,j : integer;
  p   : pathstr;
  d   : dirstr;
  n   : namestr;
  e   : extstr;
  nspl: array [1..9] of namestr;
begin
  frame(5,17,1);
  outfilblock(6,5,23);
  findfirst('*.sav',anyfile,r);
  s[1].name := r.name;
  j := 0;
  for i := 2 to 9 do
    if doserror <> 18 then begin
      findnext(r);
      p := fsearch(s[i-1].name,getenv('path'));
      fsplit(p,d,n,e);
      nspl[i-1] := n;
      s[i].name := r.name;
      inc(j);
      outstring(1,5+i,(istr(i-1) + ' ' + n{s[i-1].name} ));
    end else break;
  repeat
    waitkey;
    if (num_key > 1) and (num_key < (j+2)) then i := (num_key - 1);
  until ((num_key > 1) and (num_key < (j+2))) or (num_key = 1);
  if num_key <> 1 then begin
    name := nspl[i];
    assign(f,s[i].name);
    reset(f,1);
    blockread(f,map,sizeof(map));
    blockread(f,mapb,sizeof(mapb));
    blockread(f,castle,sizeof(castle));
    blockread(f,vilians,sizeof(vilians));
    blockread(f,enemprise,sizeof(enemprise));
    blockread(f,magsundrec,sizeof(magsundrec));
    blockread(f,mapcontnsun,sizeof(mapcontnsun));
    blockread(f,colzlpl,sizeof(integer));
    blockread(f,cont,sizeof(integer));
    blockread(f,mapcont,sizeof(byte));
    blockread(f,x,sizeof(integer));
    blockread(f,y,sizeof(integer));
    blockread(f,xk,sizeof(integer));
    blockread(f,yk,sizeof(integer));
    blockread(f,army,sizeof(army));
    blockread(f,narmy,sizeof(narmy));
    blockread(f,moral,sizeof(moral));
    blockread(f,tainmap,sizeof(tainmap));
    blockread(f,lidersaip,sizeof(lidersaip));
    blockread(f,plata,sizeof(plata));
    blockread(f,sila_zaklinanii,sizeof(sila_zaklinanii));
    blockread(f,maksium_zaklinanii,sizeof(maksium_zaklinanii));
    blockread(f,poimano_zlodeev,sizeof(poimano_zlodeev));
    blockread(f,naideno_artifaktov,sizeof(naideno_artifaktov));
    blockread(f,zanito_zamkov,sizeof(zanito_zamkov));
    blockread(f,ubito_boevin_edinic,sizeof(ubito_boevin_edinic));
    blockread(f,boat,sizeof(boat));
    blockread(f,eboat,sizeof(eboat));
    blockread(f,eflu,sizeof(boolean));
    blockread(f,ecata,sizeof(boolean));
    blockread(f,evil,sizeof(integer));
    blockread(f,minvil,sizeof(integer));
    blockread(f,maxvil,sizeof(integer));
    blockread(f,money,sizeof(longint));
    blockread(f,lider,sizeof(longint));
    blockread(f,a,sizeof(integer));
    blockread(f,time,sizeof(integer));
    blockread(f,timestep,sizeof(integer));
    blockread(f,timew,sizeof(integer));
    blockread(f,xp,sizeof(integer));
    blockread(f,yp,sizeof(integer));
    blockread(f,contp,sizeof(contp));
    blockread(f,ne,sizeof(integer));
    blockread(f,earmy,sizeof(earmy));
    blockread(f,earmyn,sizeof(earmyn));
    blockread(f,enemx,sizeof(enemx));
    blockread(f,enemy,sizeof(enemy));
    blockread(f,a1,sizeof(integer));      (*********************)
    blockread(f,emag,sizeof(emag));
    blockread(f,spellarray,sizeof(spellarray));
    blockread(f,spellarray2,sizeof(spellarray2));
    blockread(f,towns,sizeof(towns));
    blockread(f,score,sizeof(score));
    close(f);
    if evil>0 then
      readtail(readspavil[evil],4,91);      {}
    end;
end;

procedure codes;
var
  s : longint;
  i,j : integer;
begin
  s := 0;
  frame(12,16,1);
  outstring(1,12,'Введите код :');
  s := inpnum(20*8,18*8);
  case s of
    3216:begin     { + один дракон}
           for i := 0 to 4 do begin
             if (narmy[i] > 0) and (army[i] = 20) then begin
               inc(narmy[i]);
               break;
             end;
             if (narmy[i] <= 0) then begin
               army[i] := 20;
               narmy[i] := 1;
               break;
             end;
           end;
         end;
    8675:begin     {разведка карты}
           for i := 0 to 63 do
             for j := 0 to 63 do
               mapb[i,j] := mapb[i,j] or (1 shl (cont-1));
         end;
    1911:eckipet := true;   {победа}
    911 :time := 0;         {поражение}
    4213:begin              {разведка волшебной карты}
           for i := 0 to 4 do
             for j := 0 to 4 do
               tainmap[i,j] := true;
         end;
  end;
end;

var
  xold,yold:integer;
  t1,t2    :longint;
{  frfrfrfr : array[0..31000]of byte;}

begin { program body }
{   beginbeep;
   for xold := 0 to 83 do begin beep01(xold); deltat(3); end;
   endbeep;                              }
{   frfrfrfr[15] := 15;             }
   getmemtail;
   initfils;
   readfils;
   randomize;{устанавливает датчик случайных чисел}
   asm
     mov ax, $0013
     int $10
   end;
 {  InitVGA256;}
   time := 1;
   setpalknight;
   initmap;
   InitGame;
   initmark;
   initenemy;
   initsund;
   readtailmap;
{   inittimer;
{   t1 := gettimer;}
{   colorbar(0,0,maxX,maxY,12);}
{   t2 := gettimer;
   outstring(0,20,lstr(t2-t1));}
{   colorbar(x1,y1,x2,y2,);}
   setgttyp(0);
   readpich('ney2.kni',1);
   putpich(0,0,319,199);
   deltat(9);
   frame(3,18,1);
   outstring(1,3,'Римейк игры King''s Bounty');
   outstring(1,4,'фирмы New World Computing');
   outstring(1,6,'Автор сценария :');
   outstring(1,7,'  Jon Van Caneghem');
   outstring(1,9,'Художники :');
   outstring(1,10,'  Kenneth L. Moyfield');
   outstring(1,11,'  Vincent DeQattro, Jr.');
   outstring(1,13,'Програмист :');
   outstring(1,14,'  А. С. Андрианов');
   outstring(1,16,'E-mail:andriano@tsinet.ru');
   outstring(1,17,'2:5017/13.40@fidonet');
   waitkey;
   putpich(0,0,319,199);
   repeat
   waitkey;
   case num_key of
     38: begin load('ney.sav'); break; end;
     30: begin begingame('a'); num_key := 15; clearkeybuffer; break; end;
     48: begin begingame('b'); num_key := 15; clearkeybuffer; break; end;
     46: begin begingame('c'); num_key := 15; clearkeybuffer; break; end;
     32: begin begingame('d'); num_key := 15; clearkeybuffer; break; end;
   end;
   until num_key = 1;
  if num_key <> 1 then begin
   colorbar(x1,y2,x2,y2+6,8);
   readtables;
   while not((num_key=16) and ((mem[0:$417] and 4)=4)) and (time>0) and (not eckipet) do
     begin
       spellarray[14] := spellarray14;
       xold:=x;{запоминаем координаты для врага}
       yold:=y;
       case num_key of
        46: if (mem[0:$417] and 4) = 4 then codes;
         47: view;       {просмотр характеристик героя}
         30: varmy;
         50: vmap;
         32: dismit;
         49: continent;
         23: info;
         25: prizekop;
         31: zemkop;
         33: heroflu;
         35: c_help;
         22: spellmagis(true);
         16: if (mem[0:$417] and 4)<>4 then save{('ney021.sav')};
         75: if step(x-1,y) then x:=x-1; {влево}
         77: if step(x+1,y) then x:=x+1; {вправо}
         72: if step(x,y-1) then y:=y-1; {вверх}
         80: if step(x,y+1) then  y:=y+1;{вниз}
         71: if step(x-1,y-1) then  begin  x:=x-1; y:=y-1; end; {влево-вверх}
         73: if step(x+1,y-1) then  begin  x:=x+1; y:=y-1; end; {вправо-вверх}
         79: if step(x-1,y+1) then  begin  x:=x-1; y:=y+1; end; {влево-вниз}
         81: if step(x+1,y+1) then  begin  x:=x+1; y:=y+1; end; {вправо-вниз}
         17: if (time mod 5)>0then
          begin time:=time-time mod 5; timestep:=0; week; end else begin
          time := time-5; timestep:=0; week; end
       end;
       if ((x<>xold)or (y<>yold)) and ((timestop = 0) or ((map[cont,x,y]>=dese1) and (map[cont,x,y]<=dese2)))  then
          movenemy(xold,yold);
       IF (MAP[cont,X,Y]=enem1) and
        (not eflu)  then begin {проверка столкнулись или нет с врагом}
          if (enem (x,y) =false)and((x<>11)or(y<>58)) then begin
             x:=xold;
             y:=yold;
             if (x=xk) and (y=yk) then
               boat := true;
          end;
       end;
       clearkeybuffer;
       if not eckipet then begin
         ColorMap;
         romb(106,91,96,101,1);
       end;
       spellarray14 := spellarray[14];
   end;
{   until (num_key=16) or (time<=0) or (eckipet);}

   if (time=0) and (not eckipet) then begin
     colorbar(x1,y2+6,x2,y2+175,1);
     readpich('por.kni',3);
     putpich(160,22,303,191);
     outfilblock(0,1,24);
     outstring(0,0,ime[a1,a]);
     outstring(0,1,name);
     clearkeybuffer;
     repeat
       waitkey;
     until (num_key = 1);
   end;
   if eckipet then
     victory;
  end;
   freememtail;
   freemems;
   asm
     mov ax, $0003
     int $10
   end;
   closefils;
   {CloseVga256;
{  CloseGraph;}
end.
