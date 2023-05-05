unit enemys;

Interface

procedure week;
function castlle(xn,yn : integer) : boolean;
{procedure readenemy;{Считывает параметры врагов}
procedure movenemy(x,y:integer);{двигает врагов}
function enem (xn,yn:integer):boolean;
procedure initenemy;{просматривает карту и заполняет массивы врагов}
procedure save{(n:string)};


var
  ne          : array[1..4]of integer;                    { количество врагов}
{  ncont       : array[1..64]of integer;}
  earmy       : array[1..4,1..40,0..2]of integer; { вражеские армии}
  earmyn      : array[1..4,1..40,0..2]of integer; { размеры  вражеских армий}
  Enemx,Enemy : array[1..4,1..40]of integer;      { координаты врагов}

Implementation
uses
  Crt, Dos, Initial, Constant, Draw, Battl,drawtail,beep,filreads;

procedure save{(n:string)};
var
  f : file;
begin
  assign(f,name + '.sav');
  rewrite(f,1);
  blockwrite(f,map,sizeof(map));
  blockwrite(f,mapb,sizeof(mapb));
  blockwrite(f,castle,sizeof(castle));
  blockwrite(f,vilians,sizeof(vilians));
  blockwrite(f,enemprise,sizeof(enemprise));
  blockwrite(f,magsundrec,sizeof(magsundrec));
  blockwrite(f,mapcontnsun,sizeof(mapcontnsun));
  blockwrite(f,colzlpl,sizeof(integer));
  blockwrite(f,cont,sizeof(integer));
  blockwrite(f,mapcont,sizeof(byte));
  blockwrite(f,x,sizeof(integer));
  blockwrite(f,y,sizeof(integer));
  blockwrite(f,xk,sizeof(integer));
  blockwrite(f,yk,sizeof(integer));
  blockwrite(f,army,sizeof(army));
  blockwrite(f,narmy,sizeof(narmy));
  blockwrite(f,moral,sizeof(moral));
  blockwrite(f,tainmap,sizeof(tainmap));
  blockwrite(f,lidersaip,sizeof(lidersaip));
  blockwrite(f,plata,sizeof(plata));
  blockwrite(f,sila_zaklinanii,sizeof(sila_zaklinanii));
  blockwrite(f,maksium_zaklinanii,sizeof(maksium_zaklinanii));
  blockwrite(f,poimano_zlodeev,sizeof(poimano_zlodeev));
  blockwrite(f,naideno_artifaktov,sizeof(naideno_artifaktov));
  blockwrite(f,zanito_zamkov,sizeof(zanito_zamkov));
  blockwrite(f,ubito_boevin_edinic,sizeof(ubito_boevin_edinic));
  blockwrite(f,boat,sizeof(boat));
  blockwrite(f,eboat,sizeof(eboat));
  blockwrite(f,eflu,sizeof(boolean));
  blockwrite(f,ecata,sizeof(boolean));
  blockwrite(f,evil,sizeof(integer));
  blockwrite(f,minvil,sizeof(integer));
  blockwrite(f,maxvil,sizeof(integer));
  blockwrite(f,money,sizeof(longint));
  blockwrite(f,lider,sizeof(longint));
  blockwrite(f,a,sizeof(integer));
  blockwrite(f,time,sizeof(integer));
  blockwrite(f,timestep,sizeof(integer));
  blockwrite(f,timew,sizeof(integer));
  blockwrite(f,xp,sizeof(integer));
  blockwrite(f,yp,sizeof(integer));
  blockwrite(f,contp,sizeof(contp));
  blockwrite(f,ne,sizeof(integer));
  blockwrite(f,earmy,sizeof(earmy));
  blockwrite(f,earmyn,sizeof(earmyn));
  blockwrite(f,enemx,sizeof(enemx));
  blockwrite(f,enemy,sizeof(enemy));
  blockwrite(f,a1,sizeof(integer));
  blockwrite(f,emag,sizeof(emag));
  blockwrite(f,spellarray,sizeof(spellarray));
  blockwrite(f,spellarray2,sizeof(spellarray2));
  blockwrite(f,towns,sizeof(towns));
  blockwrite(f,score,sizeof(score));
  close(f);
end;


{procedure readenemy;{Считывает параметры врагов}
{var
  enemfile :text;
  k,m,n:integer;
begin
  assign(enemfile,'enemy1.dat');
  reset(enemfile);
  readln(enemfile,ne);
  for k:=1 to ne do
  begin
    readln(enemfile,m,n,enemx[k],enemy[k]);
    for m:=0 to 2 do readln (enemfile, earmy[k,m], earmyn [k ,m]);
  end;
  close(enemfile);
end;   }

procedure initenemy;{просматривает карту и заполняет массивы врагов}
var
  k,j,i,m,k1,k2,l,l1:integer;
  b:boolean;
  f : text;
begin
 for l := 1 to 4 do
  ne[l]:=0;
 for l := 1 to 4 do  {перебираем континенты }
  for k:=0 to 63 do {просматриваем карту}
    for j:=0 to 63 do
      if map[l,k,j]=enem1 then begin  {нашли врага}
        ne[l]:=ne[l]+1;
{        ncont[ne]:=l;}
        enemx[l,ne[l]]:=k;
        enemy[l,ne[l]]:=j;
        for m:=0 to 2 do begin   {перебор армий}
          b:=false;
          repeat
            i:=random(25)+1;   {номер рода войск}
            if nacharmy[l,i] <> 0 then begin
              earmy[l,ne[l],m]:=i;
              earmyn[l,ne[l],m]:=nacharmy[l,i];
              b:=true;
            end;
          until b;
        end;
      end;
  colcastle := 0;
  coltown := 0;
 for l := 1 to 4 do  {перебираем континенты }
  for i := 0 to 63 do
    for j := 0 to 63 do begin
      if map[l,i,j] = cast3 then begin{Если map[i,j] вход в замок то}
        inc(colcastle);
        castle[colcastle].c := l;
  {      for k2 := 1 to 26 do}
        for m:=0 to 4 do begin   {перебор армий}
          b:=false;
          repeat
            k1:=random(25)+1;   {номер рода войск}
            if nacharmy[l,k1] > 0 then begin
              castle[colcastle].a[m]:=k1;
              castle[colcastle].na[m]:=nacharmy[l,k1]*4;
              b:=true;
            end;
          until b;
        end;
      end;
      if map[l,i,j] = town1 then begin
        inc(coltown);
        towns[coltown].x := i;
        towns[coltown].y := j;
        towns[coltown].c := l;
      end;
    end;
      for m := 1 to 26 do
        castle[m].v := 0;
      assign(f,'armyzl.dat');
      reset(f);
      for m := 1 to 17 do begin
        for l1 := 0 to 4 do
          readln(f,vilians[m].a[l1],vilians[m].na[l1]);
        readln(f);
      end;
      close(f);
      for m := 1 to 6 do begin
        b := false;
        repeat
          k1:=random(11)+1;   {номер рода войск}
          if castle[k1].v = 0  then begin
            castle[k1].v := m;
            vilians[m].nc := k1;
            vilians[m].c := 1;
            for l1 := 0 to 4 do begin
              castle[k1].a[l1] := vilians[m].a[l1];
              castle[k1].na[l1] := vilians[m].na[l1];
            end;
            b := true;
          end;
        until b;
      end;
      for m := 1 to 4 do begin
        b := false;
        repeat
          k1:=random(4)+1;   {номер рода войск}
          if castle[k1+11].v = 0  then begin
            castle[k1+11].v := m+6;
            vilians[m+6].nc := k1+11;
            vilians[m+6].c := 2;
            for l1 := 0 to 4 do begin
              castle[k1+11].a[l1] := vilians[m+6].a[l1];
              castle[k1+11].na[l1] := vilians[m+6].na[l1];
            end;
            b := true;
          end;
        until b;
      end;
      for m := 1 to 4 do begin
        b := false;
        repeat
          k1:=random(4)+1;   {номер рода войск}
          if castle[k1+17].v = 0  then begin
            castle[k1+17].v := m+10;
            vilians[m+10].nc := k1+17;
            vilians[m+10].c := 3;
            for l1 := 0 to 4 do begin
              castle[k1+17].a[l1] := vilians[m+10].a[l1];
              castle[k1+17].na[l1] := vilians[m+10].na[l1];
            end;
            b := true;
          end;
        until b;
      end;
      for m := 1 to 3 do begin
        b := false;
        repeat
          k1:=random(3)+1;   {номер рода войск}
          if castle[k1+23].v = 0  then begin
            castle[k1+23].v := m+14;
            vilians[m+14].nc := k1+23;
            vilians[m+14].c := 4;
            for l1 := 0 to 4 do begin
              castle[k1+23].a[l1] := vilians[m+14].a[l1];
              castle[k1+23].na[l1] := vilians[m+14].na[l1];
            end;
            b := true;
          end;
        until b;
      end;
end;

function castlle(xn,yn : integer) : boolean;
var
  w : char;
  i,j,k,n,l,m,i1 : integer;
  j1 : longint;
  b : boolean;
begin
 readarmy(1,random(5)+1);
 readtown(16,30,2,0);
{ readtown(16,22,2,1);}
 colorbar(16,124,255,133,1);
  frame(13,19,1);
 outfilblock(1,13,46);
 for i := 1 to colcastle{26} do
   if (castle[i].x = xn) and (castle[i].y = yn) and (castle[i].c=cont) then
     k := i;
 castle[k].p := true;
 outstring(8,13,castle[k].s);
 if castle[k].v > 0 then begin
   outfilblock(1,14,47);
   outstring(1,15,vilians[castle[k].v].n{namev[castle[k].v]});
 end ;
 if castle[k].v = 0  then begin
   outfilblock(1,14,48);
 end;
 if castle[k].v < 0  then begin
   repeat
     outfilblock(1,14,49);
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
{     waitkey;}
     case num_key of
       30 : begin
        repeat
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
           {     dec(l);}
                end;
        castle[k].v := -1 ;
{          colormap;}
          frame(13,19,1);
          outfilblock(1,13,46);
          outstring(8,13,castle[k].s);
          if narmy[0] > 0 then
            outstring(0,14,'A');
          if narmy[1] > 0 then
            outstring(0,15,'B');
          if narmy[2] > 0 then
            outstring(0,16,'C');
          if narmy[3] > 0 then
            outstring(0,17,'D');
          if narmy[4] > 0 then
            outstring(0,18,'E');
          for n := 0 to 4 do  begin
            if narmy[n] > 0 then begin
              outstring(2,14+n,namear2[army[n]]);
            end;
            if castle[k].na[n] > 0 then
              outstring(15,14+n,namear2[castle[k].a[n]]);
          end;
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
{          romb(107,91,96,101,0);}
          case num_key of
            30 : begin
              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[0] > 0) and
                (narmy[1] > 0) then begin
                  castle[k].na[n] := narmy[0];
                  castle[k].a[n] := army[0];
                  narmy[0] := 0;
                  break;
                end;
            end;
            48 : begin
              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[1] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[1];
                  castle[k].a[n] := army[1];
                  narmy[1] := 0;
                  break;
                end;
            end;
            46 : begin
              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[2] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[2];
                  castle[k].a[n] := army[2];
                  narmy[2] := 0;
                  break;
                end;
            end;
            32 : begin
              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[3] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[3];
                  castle[k].a[n] := army[3];
                  narmy[3] := 0;
                  break;
                end;
            end;
            18 : begin
              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[4] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[4];
                  castle[k].a[n] := army[4];
                  narmy[4] := 0;
                  break;
                end;
            end;
          end;
          clearkeybuffer;
{          waitkey;}
        until num_key = 1 ;
        {упорядочивание нашей армии}
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
           {     dec(l);}
                end;
       end;
       48 :begin
        repeat
        for n:=0 to 4 do
           if castle[k].na[n]<=0 then
              for l := (n + 1) to 3  do begin
                castle[k].na[l-1]:=castle[k].na[l];
                castle[k].a[l-1]:=castle[k].a[l];
                castle[k].na[l]:=0;
              end;
              for l := 4 downto 1 do
                if (castle[k].na[l]>0) and (castle[k].na[l-1]=0) then begin
                  castle[k].na[l-1]:=castle[k].na[l];
                  castle[k].a[l-1]:=castle[k].a[l];
                  castle[k].na[l]:=0;
           {     dec(l);}
                end;
        castle[k].v := -1 ;
{          colormap;}
          frame(13,19,1);
          outfilblock(1,13,46);
          outstring(8,13,castle[k].s);
          if castle[k].na[0] > 0 then
            outstring(0,14,'A');
          if castle[k].na[1] > 0 then
            outstring(0,15,'B');
          if castle[k].na[2] > 0 then
            outstring(0,16,'C');
          if castle[k].na[3] > 0 then
            outstring(0,17,'D');
          if castle[k].na[4] > 0 then
            outstring(0,18,'E');
          for n := 0 to 4 do  begin
            if narmy[n] > 0 then begin
              outstring(2,14+n,namear2[army[n]]);
{              outstring(0,14+n,char(30+n));}
            end;
            if castle[k].na[n] > 0 then
              outstring(15,14+n,namear2[castle[k].a[n]]);
          end;
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
{          romb(107,91,96,101,0);}
          case num_key of
            30 : begin
              for n := 0 to 4 do
                if ((narmy[n] <= 0)or(army[n]=castle[k].a[0])) and (castle[k].na[0] > 0)
                 then begin
                  if army[n]=castle[k].a[0] then
                    narmy[n] :=castle[k].na[0]+narmy[n]
                  else
                    narmy[n]:=castle[k].na[0];
                  army[n]:=castle[k].a[0];
                  castle[k].na[0] := 0;
                  break;
                end;
            end;
            48 : begin
              for n := 0 to 4 do
                if ((narmy[n] <= 0)or(army[n]=castle[k].a[1])) and (castle[k].na[1] > 0)
                 then begin
                  if army[n]=castle[k].a[1] then
                    narmy[n] :=castle[k].na[1]+narmy[n]
                  else
                    narmy[n]:=castle[k].na[1];
                  army[n]:=castle[k].a[1];
                  castle[k].na[1] := 0;
                  break;
                end;
{              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[1] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[1];
                  castle[k].a[n] := army[1];
                  narmy[1] := 0;
                  break;
                end;}
            end;
            46 : begin
              for n := 0 to 4 do
                if ((narmy[n] <= 0)or(army[n]=castle[k].a[2])) and (castle[k].na[2] > 0)
                 then begin
                  if army[n]=castle[k].a[2] then
                    narmy[n] :=castle[k].na[2]+narmy[n]
                  else
                  narmy[n]:=castle[k].na[2];
                  army[n]:=castle[k].a[2];
                  castle[k].na[2] := 0;
                  break;
                end;
{              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[2] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[2];
                  castle[k].a[n] := army[2];
                  narmy[2] := 0;
                  break;
                end;}
            end;
            32 : begin
              for n := 0 to 4 do
                if ((narmy[n] <= 0)or(army[n]=castle[k].a[3])) and (castle[k].na[3] > 0)
                 then begin
                  if army[n]=castle[k].a[3] then
                    narmy[n] :=castle[k].na[3]+narmy[n]
                  else
                  narmy[n]:=castle[k].na[3];
                  army[n]:=castle[k].a[3];
                  castle[k].na[3] := 0;
                  break;
                end;
{              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[3] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[3];
                  castle[k].a[n] := army[3];
                  narmy[3] := 0;
                  break;
                end;}
            end;
            18 : begin
              for n := 0 to 4 do
                if ((narmy[n] <= 0)or(army[n]=castle[k].a[4])) and (castle[k].na[4] > 0)
                 then begin
                  if army[n]=castle[k].a[4] then
                    narmy[n] :=castle[k].na[4]+narmy[n]
                  else
                  narmy[n]:=castle[k].na[4];
                  army[n]:=castle[k].a[4];
                  castle[k].na[4] := 0;
                  break;
                end;
{              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[4] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[4];
                  castle[k].a[n] := army[4];
                  narmy[4] := 0;
                  break;
                end;}
            end;
          end;
          clearkeybuffer;
{          waitkey;}
        until num_key = 1 ;
       end;
     end;
   until num_key = 1;
 end;
 if castle[k].v >= 0 then begin
 repeat
   w := readkey;
 until (w = 'y') or (w = 'Y') or (w =  'n') or (w = 'N');
 if not (ecata) and ((w = 'y') or (w = 'Y')) then begin
   frame(14,17,1);
   outfilblock(3,15,50);
   waitkey;
 end;
 if ecata and ((w =  'y') or (w = 'Y')) then begin
     readtail('lbattle.spa',4,plai3);
     readtail('Walls.spa',6,wall3);
     readtail('Fire.spa',1,fir3);
     readtail('Circle2.spa',4,cir3);
     for j:=0 to 4 do begin  {заполнение массивов для battle } colorbar(16,124,255,133,1);
        for i:=1 to 4 do battlemap[i,j]:=plai3;
        battlemap[0,j] := wall3+3;
        battlemap[5,j] := wall3+4;
     end;
     battlemap[0,4] := wall3;
     battlemap[5,4] := wall3+1;
     battlemap[1,4] := wall3+2;
     battlemap[4,4] := wall3+5;
     n :=0;
      for j := 4 downto 3 do  {расстановка нашей армии}
        for i := 1 to 4 do
          if (n<5) and (narmy[n] > 0) and
           (battlemap[i,j] = plai3) then  begin battlemap[i,j] := army[n];
             xarmy[n]:=i;
             yarmy[n]:=j;
             inc(n);
          end;
     n :=0;
     for j := 0 to 1 do       {расстановка вражеской армии}
       for i := 1 to 4 do
         if (n<5) and (castle[k].na[n] > 0) and
         (battlemap[i,j] = plai3) then  begin battlemap[i,j] := (castle[k].a[n]+25);
           xarmye[n]:=i;
           yarmye[n]:=j;
           armye[n] := castle[k].a[n];
           narmye[n] := castle[k].na[n];
           inc(n);
         end;
{        if (( k < 3 ) and ( earmyn[n,k] > 0 )) then begin
           narmye[k]:=earmyn[n,k];
           armye[k]:=earmy[n,k];
           battlemap[5,k] := armye[k]+25;
        end
        else  narmye[k]:=0;}
     for i:=0 to 4 do
       if narmy[i] > 0 then
       readarmy(1+i*4,army[i]);
     for i:=0 to 4 do
       if narmye[i] > 0 then
       readarmy(1+i*4+25,armye[i]+25);
    { battlemapdraw;}
     colorbar(x1,y1,x2,y2,4);
     battle;
     if flaglider then
       dec(lidersaip,sila_zaklinanii*10);
     flaglider := false;

{ end;}

     if sumarmye=0 then begin

        j1:=0;
        for n:=0 to 4 do
         j1:=longint(priz[castle[k].a[n]])*castle[k].na[n]+j1;
        for n:=0 to 4 do
         ubito_boevin_edinic:=castle[k].na[n]+ubito_boevin_edinic;

        {вывод сообщения о победе}
        frame(3,15,1);
        outfilblock(0,3,51);
        outstring(15,8,lstr(j1));
        money:=money+j1;
        inc(score,100);
        if (evil > 0) and (castle[k].v=evil) then begin
          outfilblock(0,10,52);
          outstring(0,11,vilians[evil].n + ' .');
          outstring(20,12, lstr(vilians[evil].p));
          inc(score,200);
        end;
      colorbar(x1,y1,x2,y2,4);
        muzbeep(2,10);
        inc(zanito_zamkov);
        waitkey;

        if (evil > 0) and (castle[k].v=evil) then begin
        inc(poimano_zlodeev);
        dec(colzlpl);
        for i := 0 to 4 do
          for j := 0 to 4 do
            if prosmp[i,j]=evil then
              tainmap[i,j]:=true;
          money := money + vilians[evil].p;
          vilians[evil].m := 0;
          if minvil = evil then begin
            minvil := 0;
            for n := evil+1 to maxvil do
              if vilians[n].m = 1 then begin
                minvil := n;
                break;
              end;
          end;
          if maxvil < 17 then begin
            inc(maxvil);
            vilians[maxvil].m := 1;
          end;
          evil:=0;
          castle[k].v := -1;
        end;
        if (castle[k].v > 0) and (castle[k].v<>evil) then begin
         b := false;
         for n := 1 to 4 do begin
           for i := 0 to 63 do begin
             for j := 0 to 63 do
               if (map[n,i,j]=cast3) then begin
                 for m := 1 to colcastle do
                   if (castle[m].x=i) and (castle[m].y=j) and
                   (castle[m].v=0) and (castle[m].c=n) then begin
                      castle[m].v:=castle[k].v;
                      vilians[castle[k].v].nc := m;
                      b := true;
                      castle[k].v := -1;
                      break;
                   end;
               if b then break;
               end;
             if b then break;
           end;
           if b then break;
         end;
        end;
        {упорядочивание нашей армии}
        for n := 0 to 4 do
          castle[k].na[n] := 0;
        readarmy(1,random(5)+1);
        Puttilecell(5,0,115);
        if not emag then
          Puttilecell(5,1,117)
        else
          Puttilecell(5,1,96);
        Puttilecell(5,2,101);
        Puttilebuffer(256,124,118);
        bar(258{+i*9},126{+j*6});
        putpich2(256,124,303,157);
        Puttilecell(5,4,119);
        writexy(272+8-(length(lstrk(money))*4),183,lstrk(money));
        repeat
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
           {     dec(l);}
                end;
        castle[k].v := -1 ;
{          colormap;}
          colorbar(16,124,255,133,1);
          frame(13,19,1);
          outfilblock(1,13,46);
          outstring(8,13,castle[k].s);
          if narmy[0] > 0 then
            outstring(0,14,'A');
          if narmy[1] > 0 then
            outstring(0,15,'B');
          if narmy[2] > 0 then
            outstring(0,16,'C');
          if narmy[3] > 0 then
            outstring(0,17,'D');
          if narmy[4] > 0 then
            outstring(0,18,'E');
          for n := 0 to 4 do  begin
            if narmy[n] > 0 then begin
              outstring(2,14+n,namear2[army[n]]);
            end;
            if castle[k].na[n] > 0 then
              outstring(15,14+n,namear2[castle[k].a[n]]);
          end;
{          romb(107,91,96,101,0);}
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
            30 : begin
              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[0] > 0) and
                (narmy[1] > 0) then begin
                  castle[k].na[n] := narmy[0];
                  castle[k].a[n] := army[0];
                  narmy[0] := 0;
                  break;
                end;
            end;
            48 : begin
              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[1] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[1];
                  castle[k].a[n] := army[1];
                  narmy[1] := 0;
                  break;
                end;
            end;
            46 : begin
              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[2] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[2];
                  castle[k].a[n] := army[2];
                  narmy[2] := 0;
                  break;
                end;
            end;
            32 : begin
              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[3] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[3];
                  castle[k].a[n] := army[3];
                  narmy[3] := 0;
                  break;
                end;
            end;
            18 : begin
              for n := 0 to 4 do
                if (castle[k].na[n] <= 0) and (narmy[4] > 0) and
                (narmy[0] > 0) then begin
                  castle[k].na[n] := narmy[4];
                  castle[k].a[n] := army[4];
                  narmy[4] := 0;
                  break;
                end;
            end;
          end;
          clearkeybuffer;
{          waitkey;}
        until num_key = 1 ;
        {упорядочивание нашей армии}
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
           {     dec(l);}
                end;
      end else begin    {if sumarmye=0}
        for n:=0 to 4 do
         ubito_boevin_edinic:=castle[k].na[n]-narmye[n]+ubito_boevin_edinic;
        frame(3,12,1);
        outfilblock(1,3,53);
        muzbeep(3,9);
        army[0]:=6;
        narmy[0]:=20;
        x := 11 ; y := 58;
        ecata := false;
        if cont > 1 then
          eboat := false;
        cont := 1;
        waitkey;
        for n:=0 to 4 do
           if narmye[n]<=0 then
              for l := (n + 1) to 3  do begin
                narmye[l-1]:=narmye[l];
                armye[l-1]:=armye[l];
                narmye[l]:=0;
              end;
              for l := 4 downto 1 do
                if (narmye[l]>0) and (narmye[l-1]<=0) then begin
                  narmye[l-1]:=narmye[l];
                  armye[l-1]:=armye[l];
                  narmye[l]:=0;
           {     dec(l);}
                end;
              for n := 0 to 4 do
                castle[k].na[n] := 0;
              for n := 0 to 4 do
                if narmye[n] > 0 then begin
                  castle[k].na[n] := narmye[n];
                  castle[k].a[n] := armye[n];
                end;
              save;
{        l:=0;
        for n:=0 to 4 do
           if narmye[n]<=0 then
              for l := (n + 1) to 3  do begin
                narmy[l-1]:=narmy[l];
                army[l-1]:=army[l];
              end;  }
      end;
  end;  {if ecata and ((w =  'y') or (w = 'Y'))}
  end;
  readtail('enemys.spa',4,1);      {врагов}
  castlle := false;
end;

procedure week;
var
  k,i,j,n,n1,mboat,k1,l : integer;
  marmy,marmy2 : longint;
  b : boolean;
begin
  k := random(25)+1;
  inc(timew);
  frame(12,19,1);
  outfilblock(1,12,54);
  outstring(1+9,12, istr(timew));
  outstring(1+7,15, namear[k]);
  outstring(1+11,17, namear[k]);
 for l := 1 to 4 do {цикл по континентам}
  for i :=0 to 63 do
    for j :=0 to 63 do
      if map[l,i,j] = enem1 then
        for n := 1 to ne[l] do
          if (enemx[l,n]=i) and (enemy[l,n]=j) then
            for n1 := 0 to 2 do
              if earmy[l,n,n1] = k then
                 earmyn[l,n,n1] :=round(earmyn[l,n,n1]*1.2)+1;
 for l := 1 to 4 do {цикл по континентам}
  for i :=0 to 63 do
    for j :=0 to 63 do
      if map[l,i,j] = cast3 then
        for n := 1 to colcastle do
          if (castle[n].x=i) and (castle[n].y=j) and (castle[n].c=l)  then
           if castle[n].v = 0 then
            for n1 := 0 to 4 do
              if castle[n].a[n1] = k then
                castle[n].na[n1] := round(castle[n].na[n1]*1.2)+1
              else
           else begin
            if castle[n].na[0] <= 0 then begin
             for n1 := 0 to 4 do begin
               b:=false;
               repeat
                 k1:=random(25)+1;   {номер рода войск}
                 if nacharmy[l,k1] > 0 then begin
                   castle[n].a[n1]:=k1;
                   castle[n].na[n1]:=nacharmy[l,k1]*4;
                   b:=true;
                 end;
               until b;
             end;
             dec(zanito_zamkov);
             castle[n].v:=0;
            end;
           end;
 for l := 1 to 45 do
   if magsundrec[l].a = k then
     magsundrec[l].na := nachsund[arraysundc[magsundrec[l].n],k];
  repeat
    waitkey;
  until num_key = 57;
  frame(12,19,1);
  outfilblock(0,12,55);
  outstring(9,12, istr(timew));
  outstring(6,14,lstrk(money));
  outstring(6,15, istr(plata));
  marmy := 0;
  for k1 :=0 to 4 do
    if narmy[k1] > 0 then begin
      marmy2 := ((prise[army[k1]] div 10) * narmy[k1]);
      outstring(12,14+k1,namear2[army[k1]]);
      outstring(23,14+k1,lstr(marmy2));
      marmy := marmy + marmy2;
    end;
  outstring(6,17,lstr(marmy));
  if eboat then
    mboat := 500
  else
    mboat := 0;
  outstring(6,16,istr(mboat));
  money := (money - marmy + plata - mboat + zanito_zamkov*1000);
  outstring(6,18,lstrk(money));
  waitkey;
  if money < 0 then begin
    for k1 :=0 to 4 do
      if narmy[k1]=0 then
        narmy[k1-1] :=0;
      narmy[4] :=0;
    money :=0;
    if narmy[0]<= 0 then begin
      army[0] := 6;
      narmy[0] := 20;
      x := 11;
      y := 58;
      if cont > 1 then
        eboat := false;
      cont:=1;
      frame(15,19,1);
      outfilblock(1,15,56);
      muzbeep(3,9);
      waitkey;
    end;
  end;
end;

procedure movenemy(x,y:integer);{двигает врагов}
var {в подпрограмме используются локальные x,y}
   k,l,k0,l0,r0,n,m  :   integer;
begin
  for m :=1 to ne[cont] do   {перебор по врагам}
     if (abs(x-enemx[cont,m])<=2)and(abs(y-enemy[cont,m])<=2)
                     then begin  {в пределах экрана?}
           k0:=enemx[cont,m];
           l0:=enemy[cont,m];
           r0:=(x-enemx[cont,m])*(x-enemx[cont,m])+(y-enemy[cont,m])
                                          *(y-enemy[cont,m]);
           for k:=enemx[cont,m]-1 to enemx[cont,m]+1 do     {перебор по клеткам вокруг врага}
             for l:=enemy[cont,m]-1 to enemy[cont,m]+1 do   {k,l-координаты клетки}
               if(r0>((x-k)*(x-k)+(y-l)*(y-l)))and(map[cont,k,l]>=plai1)
                                         and(map[cont,k,l]<plai25)then begin
                 k0:=k;
                 l0:=l;
                 r0:=(x-k)*(x-k)+(y-l)*(y-l);
               end;
          if (map[cont,enemx[cont,m],enemy[cont,m]]=enem1) then begin
           map[cont,enemx[cont,m],enemy[cont,m]]:=plai1;
           map[cont,k0,l0]:=enem1;
           enemx[cont,m]:=k0;
           enemy[cont,m]:=l0;
          end;
         end;
{  end;}
end;

function enem (xn,yn:integer):boolean;
var
    i,k,n,l,k1,k2,k3,k4:integer;
    exitbeep,b : boolean;
    j:longint;
begin
  ColorMap;
  if not eflu then
    putsprcell(2,2,109)
  else
    putsprcell(2,2,113);
  n:=-1;
  for k:=1 to ne[cont] do if (xn=enemX[cont,k]) and (yn=enemY[cont,k]) then n:=k;
                                                         {находит номер врага}
  if n>0 then begin
  frame(12,19,1);
      outfilblock(1,12,57);
      for k:=0 to 2 do begin
        if earmyn[cont,n,k]<>0 then
                outstring(16,k+14,namear[earmy[cont,n,k]]);
        case earmyn [cont,n,k] of
           0:;
           1..3:outfilblock(4,k+14,58);
           4..10: outfilblock(4,k+14,59);
           11..30: outfilblock(4,k+14,60);
           31..100: outfilblock(4,k+14,61);
           101..32000: outfilblock(4,k+14,62);
        end;
      end;
      outfilblock(1,18,63);
  if askyn then begin

     readtail('lbattle.spa',4,plai3);
     readtail('Walls.spa',6,wall3);
     readtail('Fire.spa',1,fir3);
     readtail('Circle2.spa',4,cir3);
     for k:=0 to 4 do begin  {заполнение массивов для battle}
        for i:=0 to 5 do battlemap[i,k]:=plai3;
        if narmy[k] > 0 then battlemap[0,k] := army[k];
        xarmy[k]:=0;
        yarmy[k]:=k;
        xarmye[k]:=5;
        yarmye[k]:=k;
        if (( k < 3 ) and ( earmyn[cont,n,k] > 0 )) then begin
           narmye[k]:=earmyn[cont,n,k];
           armye[k]:=earmy[cont,n,k];
           battlemap[5,k] := armye[k]+25;
        end
        else  narmye[k]:=0;
     end;
     k1 := random(6);
     for i:=1 to k1 do begin
       b := false;
       repeat
         k2 := random(3)+1;
         k3 := random(6);
         k4 := random(5);
         if battlemap[k3,k4] = plai3 then begin
           battlemap[k3,k4] := (plai3+k2);
           b := true;
         end;
       until b;
     end;
     for i:=0 to 4 do
       readarmy(1+i*4,army[i]);
     for i:=0 to 4 do
       readarmy(1+i*4+25,armye[i]+25);
    { battlemapdraw;}
     colorbar(x1,y1,x2,y2,4);
     battle;
     if flaglider then
       dec(lidersaip,sila_zaklinanii*10);
     flaglider := false;
     if sumarmye=0 then begin

        j:=0;
        for k:=0 to 2 do
         j:=longint(priz[earmy[cont,n,k]])*earmyn[cont,n,k]+j;
        for k:=0 to 2 do
         ubito_boevin_edinic:=earmyn[cont,n,k]+ubito_boevin_edinic;


        {вывод сообщщения о победе}
        frame(3,11,1);
        outfilblock(0,3,64);
        outstring(15,8,lstr(j));
        inc(score,10);
        money:=money+j;
        muzbeep(2,10);
        waitkey;
        {упорядочивание нашей армии}
        l:=0;
        for k:=0 to 4 do
           if narmy[k]>0 then begin
              narmy[l]:=narmy[k];
              army[l]:=army[k];
              l:=l+1;
           end;
        if l<=4 then for k:=l to 4 do narmy[k]:=0;
        enem:=zem;
        if n<ne[cont] then
           for l:=n to ne[cont]-1 do begin {уничтожает врага}
              enemx[cont,l]:=enemx[cont,l+1];
              enemy[cont,l]:=enemy[cont,l+1];
              for k:=0 to 2 do begin
                 earmy[cont,l,k]:=earmy[cont,l+1,K];
                 earmyn[cont,l,k]:=earmyn[cont,l+1,K];
              end;
           end;
        ne[cont]:=ne[cont]-1;
        map[cont,xn,yn]:=plai1;
     end else begin
        for k:=0 to 2 do
         ubito_boevin_edinic:=earmyn[cont,n,k]-narmye[k]+ubito_boevin_edinic;
        frame(3,12,1);
        outfilblock(1,3,53);
        {вывод сообщения о поражении}
        {упорядочивание и перезапись вражеских армий}
        l:=0;
        for k:=0 to 2 do
           if narmye[k]>0 then begin
              earmyn[cont,n,l]:=narmye[k];
              earmy[cont,n,l]:=armye[k];
              l:=l+1;
           end;
        if l<=2 then for k:=l to 2 do earmyn[cont,n,k]:=0;
        enem:=zem;
        if cont > 1 then
          eboat := false;
        cont := 1;
        x:=11;           {возвращение к корoлю}
        y:=58;
        army[0]:=6;      {20 крестьян}
        narmy[0]:=20;
        enem:=false;
        muzbeep(3,9);
        ecata := false;
       waitkey;
       save;
     end;
  end   else begin
     enem:=false;
    { outtextxy(x7+12+8*16,y75+dy6*0,'N'); }
  end;
  end
  else begin
      frame(15,18,4);
      outstring(6,16,'ошибка номера');
      waitkey;
      enem:=zem;
  end;
end;

end.
