unit draw;
Interface

procedure info;
procedure spellmagis(regim:boolean);
procedure romb(n1,n2,n3,n4,s:integer);{рисует ромб}
procedure writexy(x,y:integer;Line:string);
procedure ColorMap;{рисует карту}
procedure BattleMapDraw;{рисует карту поля боя}
procedure frame(y01,y02,Color:integer); {рисует рамку со строки Y01 до строки Y02}
procedure OutString(x01,y02:integer;s:string);
procedure vmap;{Рисует карту}
procedure readtailmap; {читает картинки для походного режима}
procedure readvil(s:integer);
function town2(xn,yn:integer):boolean;

Implementation

uses
  Crt,  Constant, Initial, Grtext,drawtail,beep,enemys,filreads;

procedure writexy(x,y:integer;Line:string);
begin
  puttext(x ,y,Line)
end;

procedure animsrp(XT,YT,n,s:integer); {n-ячейка картинки,s-ячейка фона}
var
  k:integer;
begin
  k:=n;
  REPEAT
   Puttilecell(XT,YT,s);
   Putsprcell(XT,YT,k);
   deltat(3);
   k:=k+1;
   if k = n+4 then
     k:=n;
  until keypressed;
end;

procedure spellmagis(regim:boolean);
begin
 if emag then begin
  frame(5,17,1);
  outfilblock(0,5,65);
  outstring(0,8,istr(spellarray[1]) + '                        ' + istr(spellarray[8]));
  outstring(0,9,istr(spellarray[2]) + '                        ' + istr(spellarray[9]));
  outstring(0,10,istr(spellarray[3]) + '                        ' + istr(spellarray[10]));
  outstring(0,11,istr(spellarray[4]) + '                        ' + istr(spellarray[11]));
  outstring(0,12,istr(spellarray[5]) + '                        ' + istr(spellarray[12]));
  outstring(0,13,istr(spellarray[6]) + '                        ' + istr(spellarray[13]));
  outstring(0,14,istr(spellarray[7]) + '                        ' + istr(spellarray[14]));
  waitkey;
  if regim = true then begin
    case num_key of
      30:if spellarray[8]>0 then
         begin spellarray2[8]:=1; dec(spellarray[8]) end;
      48:if spellarray[9]>0 then
         begin spellarray2[9]:=1; dec(spellarray[9]) end;
      46:if spellarray[10]>0 then
         begin spellarray2[10]:=1; dec(spellarray[10]) end;
      32:if spellarray[11]>0 then
         begin spellarray2[11]:=1; dec(spellarray[11]) end;
      18:if spellarray[12]>0 then
         begin spellarray2[12]:=1; dec(spellarray[12]) end;
      33:if spellarray[13]>0 then
         begin spellarray2[13]:=1; dec(spellarray[13]) end;
      34:if spellarray[14]>0 then
         begin spellarray2[14]:=1; dec(spellarray[14]) end;
    end;
  end else
    case num_key of
      30:if spellarray[1]>0 then
         begin spellarray2[1]:=1; dec(spellarray[1]) end;
      48:if spellarray[2]>0 then
         begin spellarray2[2]:=1; dec(spellarray[2]) end;
      46:if spellarray[3]>0 then
         begin spellarray2[3]:=1; dec(spellarray[3]) end;
      32:if spellarray[4]>0 then
         begin spellarray2[4]:=1; dec(spellarray[4]) end;
      18:if spellarray[5]>0 then
         begin spellarray2[5]:=1; dec(spellarray[5]) end;
      33:if spellarray[6]>0 then
         begin spellarray2[6]:=1; dec(spellarray[6]) end;
      34:if spellarray[7]>0 then
         begin spellarray2[7]:=1; dec(spellarray[7]) end;
    end;
  end else begin
    frame(12,15,1);
    outfilblock(1,13,66);
    waitkey;
  end;
end;

procedure info;
var
 k : integer;
begin
       frame(1,18,1);
     if evil > 0 then begin
       readtail(readspavil[evil],4,91);
       readvil(evil);
       for k := 1 to 17 do
         outstring(0,k,textvil[k]);
       outstring(3,5,contvil[vilians[evil].c]);
       if castle[vilians[evil].nc].p then
         outstring(9,6,castle[vilians[evil].nc].s)
       else
         outfilblock(9,6,67);
       k := 0;
       repeat
         puttile(21,36,91+k);
         inc(k);
         deltat(3);
         if k > 3 then
           k := 0;
       until keypressed;
    end else begin
         puttile(21,36,115);
         outfilblock(7,2,68);
         waitkey;
    end;
end;


procedure romb(n1,n2,n3,n4,s:integer);{рисует ромб}
var
  i1,i2,i3,i4:integer;
  e1,e2,e3,e4:integer;
  k,i,j,nmagsp,nmagsp2,l :integer;
begin
  i1 :=n1;
  e1 :=3;
  i2 :=n2;
  e2 :=4;
  i3 :=n3;
  e3 :=4;
  i4 :=n4;
  e4 :=4;
{  if not boat then begin
    e1 := 3;
  end els begin }
  if boat then begin
    n1:=19;
    i1:=19;
  end;
  if eflu then begin
    n1 := 110;
    i1 := 110;
  end;
  if not ecata then begin
    e4 :=1;
    n4 :=116;
    i4 :=116;
  end;
  if evil=0{not evil} then begin
    e2 :=1;
    n2 :=115;
    i2 :=115;
  end;
  if not emag{not evil} then begin
    e3 :=1;
    n3 :=117;
    i3 :=117;
  end;
      nmagsp2:=0;
      for nmagsp := 8 to 14 do
        if spellarray2[nmagsp] <> 0 then
          nmagsp2 := nmagsp;
        colorbar(x1,y1,x2,y2,4);
{        if nmagsp2 = 0 then begin}
          outfilblockxy(40,9,69,1);
          outfilblockxy(160,9,69,2);
        if (timestop = 0) or ((map[cont,x,y]>=dese1) and (map[cont,x,y]<=dese2)) then begin
          outfilblockxy(264,9,69,3);
          writexy(232,9,lstrk(time));
        end else begin
          outfilblockxy(264,9,69,4);
          writexy(232,9,lstrk(timestop));
        end;
{      Puttilecell(5,3,118);}
          Puttilebuffer(256,124,118);
          bar(258{+i*9},126{+j*6});
          putpich2(256,124,303,157);
          Puttilecell(5,4,119);
          writexy(272+8-(length(lstrk(money))*4),183,lstrk(money));
{        end else} begin
          case nmagsp2 of
            8:begin
        if map[cont,x,y] > 3 then
          Puttailsprcell(2,2,n1+3,tab[map[cont,x,y]])
        else
          Puttailsprcell(2,2,n1+3,tab[cont-1]);
                waitkey;
                case num_key of
                  75:
                  for nmagsp := 1 to sila_zaklinanii do begin
                    if (map[cont,x-nmagsp,y] >= wate1) and
                        (map[cont,x-nmagsp,y] <= wate2) then begin
                        map[cont,x-nmagsp,y] := brid1;
                        spellarray2[nmagsp2] := 0;
                    end;
                  end;
                  77:
                  for nmagsp := 1 to sila_zaklinanii do begin
                    if (map[cont,x+nmagsp,y] >= wate1) and
                        (map[cont,x+nmagsp,y] <= wate2) then begin
                        map[cont,x+nmagsp,y] := brid1;
                        spellarray2[nmagsp2] := 0;
                    end;
                  end;
                  72:
                  for nmagsp := 1 to sila_zaklinanii do begin
                    if (map[cont,x,y-nmagsp] >= wate1) and
                        (map[cont,x,y-nmagsp] <= wate2) then begin
                        map[cont,x,y-nmagsp] := brid2;
                        spellarray2[nmagsp2] := 0;
                    end;
                  end;
                  80:
                  for nmagsp := 1 to sila_zaklinanii do begin
                    if (map[cont,x,y+nmagsp] >= wate1) and
                        (map[cont,x,y+nmagsp] <= wate2) then begin
                        map[cont,x,y+nmagsp] := brid2;
                        spellarray2[nmagsp2] := 0;
                    end;
                  end;
                end; spellarray2[nmagsp2] := 0;
              end;
            9:begin
                 inc(timestop,sila_zaklinanii*10)
              end;
            10:begin
                 if not flaglider then
                   inc(lidersaip,sila_zaklinanii*10);
                 flaglider := true;
               end;
            11:begin
                if not boat then begin
                 frame(1,19,1);
                 outstring(3,1,'Выберите замок (A-Z)?');
                 for i := 1 to 13 do begin
                  if (castle[i].p) then
                   outstring(1,2+i,char(byte('A')-1+i) + ': ' + castle[i].s);
                  if (castle[i+13].p) then
                   outstring(16,2+i,char(byte('A')+12+i)+': '+castle[i+13].s);
                 end;
                 waitkey;
                 i := (num_char - byte('A') + 1);
                 if i > 26 then
                   i := (num_char - byte('a') + 1);
                 if (i>0) and (i<27) and (castle[i].p) then begin
                   cont := castle[i].c;
                   x := castle[i].x;
                   y := castle[i].y+1;
                 end;
                end else begin
                  frame(12,14,1);
                  outfilblock(1,13,70);
                  waitkey;
                end;
                 colormap;
               end;
            12:begin
                 frame(1,19,1);
                 outfilblock(3,1,71);
                 for i := 1 to 13 do begin
                  if (towns[i].p) then
                   outstring(1,2+i,char(byte('A')-1+i) + ': ' + towns[i].s);
                  if (towns[i+13].p) then
                   outstring(16,2+i,char(byte('A')+12+i)+': '+towns[i+13].s);
                 end;
                 waitkey;
                 i := (num_char - byte('A') + 1);
                 if i > 26 then
                   i := (num_char - byte('a') + 1);
                 if (i>0) and (i<27) and (towns[i].p) then begin
                   cont := towns[i].c;
                 if not boat then begin
                  for j:=towns[i].y-1 to towns[i].y+1 do
                   for l:=towns[i].x-1 to towns[i].x+1 do
                     if (map[cont,l,j]=plai1) then begin
                       x := l;
                       y := j;
                       eboat := false;
                       break;
                     end;
                 end else
                  for j:=towns[i].y-1 to towns[i].y+1 do
                   for l:=towns[i].x-1 to towns[i].x+1 do
                     if (map[cont,l,j]>=wate1) and (map[cont,l,j]<=wate2) then begin
                       x := l;
                       y := j;
                       xk := l;
                       yk := j;
                       break;
                     end;
                 end;
                 colormap;
               end;
            13:begin
                 repeat
                   j := random(20)+6;
                 until nacharmy[cont,j]> 0;
                   for i := 0 to 4 do begin
                     if (army[i] = j) and (narmy[i]>0) then begin
                       inc(narmy[i],nacharmy[cont,j]*(sila_zaklinanii-1));
                       break;
                     end;
                     if (narmy[i]<=0) then begin
                       narmy[i] := round(nacharmy[cont,j]*(sila_zaklinanii-1)/10+1);
                       army[i] := j;
                       break;
                     end;
                   end;
               end;
            14:begin
                 castle[vilians[evil].nc].p := true;
                 info;
                 colormap;
               end;
          end;
        end;
        spellarray2[nmagsp2] := 0;
{      for i := 0 to 4 do
        for j := 0 to 4 do}
    repeat
      if s = 1 then begin
{        Puttilecell(2,2,tab[map[cont,x,y]]);
        Putsprcell(2,2,i1);}
{        Puttailsprcell(2,2,i1,tab[map[cont,x,y]]);}
        if map[cont,x,y] > 3 then
          Puttailsprcell(2,2,i1,tab[map[cont,x,y]])
        else
          Puttailsprcell(2,2,i1,tab[cont-1]);
      end;
      Puttilecell(5,0,i2);
      Puttilecell(5,1,i3);
      Puttilecell(5,2,i4);
      setgttyp(0);
      deltat(3);
      inc(i1);
      inc(i2);
      inc(i3);
      inc(i4);
      if i1=(e1+n1) then
        i1 := n1;
      if i2=(e2+n2) then
        i2 :=n2 ;
      if i3=(e3+n3) then
        i3 :=n3 ;
      if i4=(e4+n4) then
        i4 :=n4 ;
    until keypressed;
       waitkey;
      if s = 1 then begin
{        Puttilecell(2,2,tab[map[cont,x,y]]);
        Putsprcell(2,2,n1+3);}
       if (num_key = 75) or(num_key = 77) or(num_key = 72) or(num_key = 80) or(num_key = 71) or(num_key = 73)
             or(num_key = 79) or (num_key = 81) then begin
        if map[cont,x,y] > 3 then
          Puttailsprcell(2,2,n1+3,tab[map[cont,x,y]])
        else
          Puttailsprcell(2,2,n1+3,tab[cont-1]);
        beginbeep;
        beep01(17);
        deltat(1);
        endbeep;
        deltat(2);
      end;
      end;
end;

procedure readtailmap; {читает картинки для походного режима}
begin
  readtail('enemys.spa',4,1);      {врагов}
  readtail('bridges.spa',2,5);      {мосты}
  readtail('lplain2.spa',2,7);      {равнина}
  readtail('ches.spa',1,9);      {}
  readtail('town.spa',1,10);      {}
  readtail('artifact.spa',8,11);      {}
  readtail('ship.spa',4,19);      {}
  readtail('magazin.spa',4,23);      {}
  readtail('ldesert.spa',13,27);      {}
  readtail('mark.spa',1,41);      {}
  readtail('lwater.spa',13,42);      {}
  readtail('lmount.spa',13,56);      {}
  readtail('lforest.spa',13,70);      {}
  readtail('castle.spa',6,84);      {}
  readtail('catapult.spa',4,101);      {}
  readtail('dragon.spa',4,110);      {}
  readtail('star.spa',4,96);      {}
  if evil>0 then
    readtail(readspavil[evil],4,91);      {}
  readtail('empty2.spa',5,115);      {}
  readtail('knight.spa',4,106);      {}
  nap := -1;
  nap2:= -1;
  nap3:= -1;
end;

procedure ColorMap;{рисует карту}
var
    i,j:integer;
begin
 for i:=0 to 4 do
  for j:=0 to 4 do begin
   if (x+i-2>=0)and(y+j-2>=0)and (x+i-2<=mx) and (y+j-2<=my) then begin
   puttilecell(i,j,tab[map[cont,x+i-2,y+j-2]]);
   if map[cont,x+i-2,y+j-2] = enem1 then
     puttilecell(i,j,tab[map[cont,x+i-2,y+j-2]]+cont-1);
   end else puttilecell(i,j,54);{вода с краю}
   end;
   if (x-2<=xk)and(y-2<=yk)and (x+2>=xk)and(y+2>=yk)and(eboat=true) then
     putsprcell(2+(xk-x),2+(yk-y),19); {корабль}
end;

procedure BattleMapDraw;{рисует карту поля боя}
var
    i,j,k,n:integer;
    s:string[12];
begin
   for i:=0 to 5 do
      for j:=0 to 4 do begin
         if  battlemap[i,j] > 50 then
            puttilecell(i,j,battlemap[i,j]); {ландшафт}
{         else
            puttilecell(i,j,plai3);     {равнина}
         case battlemap[i,j] of
           1..25:begin
                n:=-1;
                for k:=0 to 4 do if (xarmy[k]=i)and(yarmy[k]=j)
                       and(narmy[k]>0) then n:=k;
{                putsprcell(i,j,1+n*4);}
                puttailsprcell(i,j,1+n*4,plai3);
                writexy((x3+dx1*i+2),y3+dy1*(j+1)-8,strk(narmy[n]));
              end;
           26..50:begin
                n:=-1;
                for k:=0 to 4 do if (xarmye[k]=i)and(yarmye[k]=j)
                                and (narmye[k]>0)  then n:=k;
                puttailsprcell(i,j,1+n*4+25,plai3);
{                putsprcell(i,j,1+n*4+25);}
                writexy(x3+dx1*i+dx1 div 2,y3+dy1*(j+1)-8,strk(narmye[n]));
              end;
         end;
      end;
end;

procedure frame(y01,y02,Color:integer); {рисует рамку со строки Y01 до строки Y02}
begin
   ColorBar(x7-1,y3+dy5+dy6*(y01-1)-1,x8-2,y3+dy5+dy6*(y02+1),Color);
   Rectangle(x7+3,y3+dy5+dy6*(y01-1)+4,x8-5,y3+dy5+dy6*(y02+1)-6,15);
end;

procedure OutString(x01,y02:integer;s:string);
begin
{   setgttyp(0);}
   puttext(x7+8+x01*8,y3+dy5+dy6*y02,s);
end;

procedure vmap;{Рисует карту}
var
  j,i,k,k1:integer;
begin
  frame(0,19,1);
  setgttyp(0);
  puttext(12*8,22*8,'X='+istr(x)+' Y='+istr(y));
  outstring(8,0,ncont[cont]);
  for k:=0 to 63 do     {x}
    for j:=0 to 63 do Begin {y}
     if (mapb[k,j] and (1 shl (cont-1))) <> 0 then
     case map[cont,k,j] of
      plai1..plai2 : colorbar(k*2+72,j*2+44,k*2+73,j*2+45,10);     {равнина}
      dese1..dese2 : colorbar(k*2+72,j*2+44,k*2+73,j*2+45,14);     {равнина}
      fore1..fore2 : colorbar(k*2+72,j*2+44,k*2+73,j*2+45,2);         {лес}
      moun1..moun2 : colorbar(k*2+72,j*2+44,k*2+73,j*2+45,6);         {горы}
      72           : colorbar(k*2+72,j*2+44,k*2+73,j*2+45,1);   {вода вокруг}
      wate1..wate2 : colorbar(k*2+72,j*2+44,k*2+73,j*2+45,9);         {вода}
{      enem2..enem3 : colorbar(k*2+72,j*2+44,k*2+73,j*2+45,0);}
     else
       colorbar(k*2+72,j*2+44,K*2+73,j*2+45,12);         {остальное}
    end
     else
       colorbar(k*2+72,j*2+44,k*2+73,j*2+45,0);         {вода}
     end;
    k1 :=6;
    repeat
       colorbar(x*2+72,y*2+44,x*2+73,Y*2+45,k1);     {равнина}
       inc(k1);
       if k1 >= 17 then
         k1 :=6;
    until keypressed;
    waitkey;
end;

procedure readvil(s:integer);
var
  f   : text;
  i,j : integer;
begin
  assign(f,'castle.dat');
  reset(f);
  for j := 1 to s do
    for i := 1 to 17 do
      readln(f,textvil[i]);
  close(f);
end;

function town2(xn,yn:integer):boolean;
var
  i,j,i1,j1,k,nv,tow,z : integer;
  v           : char;
begin
  tow := 1;
  for i := 1 to 26 do
    if (towns[i].x = xn) and (towns[i].y = yn) and (towns[i].c = cont) then begin
      tow := i;
      break;
    end;
  towns[tow].p := true;
  readarmy(1,random(20)+6);
  readtown(16,30,1,0);
  readtown(16,22,1,1);
  repeat
  colorbar(16,124,255,133,1);
  frame(13,19,1);
  outfilblockxy(x7+12,y75+dy6,72,1);
  puttext(x7+12+12*8,y75+dy6, towns[tow].s);
  outfilblockxy(x7+12,y75+dy6+8,72,2);
  IF eboat then
    outfilblockxy(x7+12,y75+dy6+16,72,3)
  else
    outfilblockxy(x7+12,y75+dy6+16,72,4);
    outfilblockxy(x7+12,y75+dy6+24,72,5);
    outfilblockxy(x7+12,y75+dy6+32,72,6);
    outfilblockxy(x7+12,y75+dy6+40,72,7);
  puttext(x7+12+7*8,y75+dy6+40, zaklin[towns[tow].m] + '(' + istr(p_zakl[towns[tow].m]) + ')');
{  romb(107,91,96,101,0);}
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
       30: begin
     for k := minvil to maxvil do
      if vilians[k].m = 1  then begin
       frame(1,18,1);
       if maxvil <> -1 then
        if evil <  maxvil then
         for k := evil+1 to maxvil do
           if vilians[k].m = 1 then begin
             evil := k;
             break;
           end else
        else evil := minvil;
       readtail(readspavil[evil]{'vmm.spa'},4,91);
       readvil(evil);
       for k := 1 to 17 do
         outstring(0,k,textvil[k]);
       outstring(3,5,contvil[vilians[evil].c]);
       if castle[vilians[evil].nc].p then
         outstring(9,6,castle[vilians[evil].nc].s)
       else
         outfilblock(9,6,67);
       k := 0;
       repeat
         puttile(21,36,91+k);
         inc(k);
         deltat(3);
         if k > 3 then
           k := 0;
       until keypressed;
       waitkey;
       puttile(256,22,91+k);
       num_key := 2;
       break;
      end;
      {colormap;}
{       outstring(6,5,'t');}
{       waitkey;}
    {   evil := {true};
    end;
       48:
      if (not eboat) and (money>=500) then begin
        money := money - 500;
        eboat := true;
        for j:=yn-1 to yn+1 do
          for i:=xn-1 to xn+1 do
            if (map[cont,i,j]>=wate1) and (map[cont,i,j]<=wate2) then
              for j1:=j-1 to j+1 do
                for i1:=i-1 to i+1 do
                  if (map[cont,i1,j1]>=plai1) and (map[cont,i1,j1]<=plai2)
                         then begin
                    xk:=i;
                    yk:=j;
            end;
      end else
        eboat := false;
      46:
      if (not ecata) and (money>=3000) then begin
        money := money - 3000;
        ecata := true;
        Puttilecell(5,2,101);
      end;
      32:begin
           frame(12,19,1);
           outfilblock(1,12,73);
           outstring(1+8,12, castle[tow].s);
           if castle[tow].v > 0 then begin
             outstring(1,13,'обитает ' + vilians[castle[tow].v].n);
             castle[tow].p := true;
           end else
           outfilblock(1,13,74);
           for i := 0 to 4 do
             if castle[tow].na[i] > 0 then begin
               case  castle[tow].na[i] of
                 1..3:begin outfilblock(3,14+i,58); outstring(3+5,14+i, namear[castle[tow].a[i]]); end;
                 4..10:begin outfilblock(3,14+i,59); outstring(3+10,14+i, namear[castle[tow].a[i]]); end;
                 11..30:begin outfilblock(3,14+i,60); outstring(3+6,i+14,namear[castle[tow].a[i]]);    end;
                 31..100:begin outfilblock(3,14+i,61); outstring(3+8,i+14,namear[castle[tow].a[i]]); end;
                 101..32000:begin outfilblock(3,14+i,62); outstring(3+5,i+14, namear[castle[tow].a[i]]); end;
               end;
             end;
           waitkey;
         end;
      18:begin
           frame(12,19,1);
         if emag then begin
           z := 0;
           for i := 1 to 14 do
             inc(z,spellarray[i]);
           if (maksium_zaklinanii > z{m_zakl[towns[tow].m]}) {and (maksium_zaklinanii > spellarray[towns[tow].m])} and
                                  (money>=p_zakl[towns[tow].m]) then begin
             inc(spellarray[towns[tow].m]);
             dec(money,p_zakl[towns[tow].m]);
             outfilblock(1,14,75);
             outstring(1+21,14, istr(maksium_zaklinanii - z-1{spellarray[towns[tow].m])}));
           end else begin
             outfilblock(1,14,77);
           end;
         end else begin
             outfilblock(1,14,76);
         end;
           waitkey;
         end;
  end;
  until num_key =1;
  readtail('enemys.spa',4,1);      {врагов}
  town2 := false;
end;

end.
