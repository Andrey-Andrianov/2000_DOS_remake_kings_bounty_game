{ввод картинок из .SPA - файла}
unit drawtail;
interface
procedure bmpp;
procedure putsprbuffer(Xt,Yt,s:integer); {Большая картинка на экран}
procedure putpichbuffer(X1,Y1,x2,y2:integer); {Большая картинка на экран}
procedure puttilebuffer(Xt,Yt,s:integer); {Большая картинка на экран}
procedure putpich2(X1,Y1,x2,y2:integer); {Большая картинка на экран}
procedure colorbar(x01,y01,x02,y02,color:integer);
procedure Rectangle(x01,y01,x02,y02,color:integer);
procedure bar(x,y:integer);
procedure putpixel(x01,y01,c:integer);
function getpixel(x01,y01:integer):byte;
procedure epspr(n1,n2:integer);{переписывает из одной ячейки в другую}
procedure pspr(n1,n2:integer); {ПЕРеворачивает Тайлик }
procedure puttile(XT,YT,s:integer); {Тайлик на экран}
procedure puttilecell(XT,YT,s:integer); {Спрайт на экран}
procedure readpich(b:string;n:integer);{n-число кадров,s-номер ячейки}
procedure putpich(X1,Y1,x2,y2:integer); {Большая картинка на экран}
procedure putsprcell(XT,YT,s:integer); {Спрайт на экран}
procedure puttailsprcell(xt,yt,s,n:integer);
procedure animspr(XT,YT,n,s,h:integer); {n-ячейка картинки,s-ячейка фона}
procedure animsprn(XT,YT:integer;var x2:integer); {n-ячейка картинки,s-ячейка фона}
procedure eanimspr(XT,YT,n,s,h:integer); {n-ячейка картинки,s-ячейка фона}
procedure readtail(b:string;n,s:integer);{n-число кадров,s-номер ячейки}
{procedure writepich(n:string);{запись видеопамяти на диск}
procedure readarmy(s,n:integer);{s-номер ячейки,n-номер рода войск}
procedure getmemtail;  {выделяет память для мелких картинок}
procedure freememtail;  {освобождает память}
procedure setpalknight;  {устанавливает нужную палитру}
procedure putpichviem(x,y,n:integer);
procedure readtown(x,y,n,n1:integer);
procedure readtables;
implementation
uses crt,pal,initial,constant,grtext,draw,timer;
type
   spaheader = record   {заголовок .SPA-файла}
      idfile : array[0..5]of char;   {идентификатор файла}
      lenfp  : word;                 {длина файла}
      nver   : word;                 {номер версии формата}
      bperp  : word;                 {бит на точку}
      ncadr  : word;                 {число кадров/рисунков в файле}
      x1,y1  : word;                 {координаты верхнего левого угла}
      x2,y2  : word;                 {координаты нижнего правого угла}
      horr   : word;                 {горизонтальное разрешение дисплея (точек)}
      verr   : word;                 {вертикальное разрешение дисплея (точек)}
      bperl  : word;                 {байт на строку}
      ipal   : word;                 {информация о палитре}
      reserv : word;                 {резерв}
   end;
   tiletype = array[0..33,0..47]of byte; {тип массива для одного кадра}
   tileptr = ^tiletype;                    {указатель на массив кадра}
   scrtype = array[0..199,0..319]of byte; {тип массива для экрана}
   scrptr = ^scrtype;                    {указатель на массив экрана}
const
   idf : array[0..5]of char = ('A','N','D','S','P','R');
   nvr : array[1..25]of string[12]=
('EMILITIA.SPA','EARCHERS.SPA','EPICKMAN.SPA','ECAVAL.SPA','EKNIGHT.SPA',
'EPEASANT.SPA','EVOLWES.SPA','ENOMADS.SPA','EBARBAR.SPA','EARCMAG.SPA',
'ESPRITES.SPA','EELVES.SPA','EGNOMES.SPA','ETROLL.SPA','EDRUID.SPA',
'EORCS.SPA','EDWARV.SPA','EOGRES.SPA','EGIANT.SPA','EDRAGON.SPA',
'ESKELET.SPA','EZOMBY.SPA','EGHOST.SPA','EVAMPIR.SPA','EDEMON.SPA');
var
   sp : spaheader;               {заголовок}
   np  : array[0..120]of tileptr;     {указатель на массив кадров}
   np2 : scrptr;                 {указазатель на экран}
   np3 : scrptr;                 {указазатель на буфер}
   fin : file;                   {файловая переменная}
   i,j : word;                   {переменные цикла}
   p : array[0..767]of byte;   {палитра}
   scr : scrptr;

procedure bmpp;
type
  bitmapfileneader = record
    ch1 : char;
    ch2 : char;
    dword : longint;
    ch3 : word;
    ch4 : word;
    dword2 : longint;
  end;
  bitmapinfoheader = record
    dword : longint;
    long1 : longint;
    long2 : longint;
    word1 : word;
    word2 : word;
    word3 : longint;
    dword2 : longint;
    long3 : longint;
    long4 : longint;
    dword3 : longint;
    dword4 : longint;
  end;
  rgbquad = record
    byte1 : byte;
    byte2 : byte;
    byte3 : byte;
    byte4 : byte;
  end;
var
  c : bitmapfileneader;
  c1: bitmapinfoheader;
  i,j : integer;
  aaa : array [0..255] of rgbquad;
  f : file;
begin
  c.ch1 := 'B';
  c.ch2 := 'M';
  c.dword := 65078;
  c.ch3 := 0;
  c.ch4 := 0;
  c.dword2 := 1078;
  c1.dword := 40;
  c1.long1 := 320;
  c1.long2 := 200;
  c1.word1 := 1;
  c1.word2 := 8;
  c1.word3 := 0;
  c1.dword2 := 64000;
  c1.long3 := 0;
  c1.long4 := 0;
  c1.dword3 := 256;
  c1.dword4 := 256;
  j := -1;
  for i := 0 to 255 do begin
    aaa[i].byte1 := p[i*3+2]*4;
    aaa[i].byte2 := p[i*3+1]*4;
    aaa[i].byte3 := p[i*3]*4;
    aaa[i].byte4 := 0;
  end;
  assign(f,'aaa001p.bmp');
  rewrite(f,1);
  blockwrite(f,c,sizeof(c));
  blockwrite(f,c1,sizeof(c1));
  blockwrite(f,aaa,sizeof(aaa));
  for j := 199 downto 0 do
    for i := 0 to 319 do
      blockwrite(f,scr^[j,i],sizeof(byte));
  close(f);
end;


procedure puttile(XT,YT,s:integer); {Тайлик на экран}
var
   j,k:word;
begin
   for j:=0 to 33 do
     move(np[s]^[j],scr^[yt+j,xt],48);
{     for k:=0 to 47 do
       scr^[Yt+j,Xt+k]:=np[s]^[j,k];}
end;

procedure puttilecell(XT,YT,s:integer); {Спрайт на экран}
begin
  puttile(x3+dx1*XT-1,y3+dy1*YT-1,s);
end;

procedure putpich(X1,Y1,x2,y2:integer); {Большая картинка на экран}
var
   j,k:word;
begin
   for j:=0 to (y2-y1) do
     move(np2^[j],scr^[Y1+j,X1],x2-x1+1);
{     for k:=0 to (x2-x1) do
       scr^[Y1+j,X1+k]:=np2^[j,k];}
end;

procedure putpich2(X1,Y1,x2,y2:integer); {Большая картинка на экран}
var
   j,k:word;
begin
   for j:=y1 to y2 do
     move(np3^[j,x1],scr^[j,x1],x2-x1);
{     for k:=x1 to x2 do
       scr^[j,k]:=np3^[j,k];}
end;

procedure putpichbuffer(X1,Y1,x2,y2:integer); {Большая картинка на экран}
var
   j,k:word;
begin
   for j:=0 to (y2-y1) do
     move(np2^[j],np3^[j+y1,x1],x2-x1+1);
{     for k:=0 to (x2-x1) do
       np3^[j+y1,k+x1]:=np2^[j,k];       }
end;

procedure puttilebuffer(Xt,Yt,s:integer); {Большая картинка на экран}
var
   j,k:word;
begin
   for j:=0 to 33 do
     move(np[s]^[j],np3^[Yt+j,Xt],48);
{     for k:=0 to 47 do
       np3^[Yt+j,Xt+k]:=np[s]^[j,k];}
end;

procedure putsprbuffer(Xt,Yt,s:integer); {Большая картинка на экран}
var
   j,k:word;
begin
   for j:=0 to 33 do
     for k:=0 to 47 do
       if np[s]^[j,k] <> 255 then
         np3^[(j+yt),(k+xt)]:=np[s]^[j,k];
end;

procedure putspr(XT,YT,s:integer); {Спрайт на экран}
var
   j,k:word;
begin
   for j:=0 to 33 do
     for k:=0 to 47 do
       if np[s]^[j,k]<>255 then
         scr^[Yt+j,Xt+k]:=np[s]^[j,k];
end;

procedure putsprcell(XT,YT,s:integer); {Спрайт на экран}
begin
  putspr(x3+dx1*XT-1,y3+dy1*YT-1,s);
end;

procedure puttailspr(xt,yt,s,n:integer);
var
   j,k:word;
begin
   for j:=0 to 33 do
     for k:=0 to 47 do
       if np[s]^[j,k]<>255 then
         scr^[Yt+j,Xt+k]:=np[s]^[j,k]
       else
         scr^[Yt+j,Xt+k]:=np[n]^[j,k];
end;

procedure puttailsprcell(xt,yt,s,n:integer);
begin
  puttailspr(x3+dx1*XT-1,y3+dy1*YT-1,s,n);
end;

procedure putpichviem(x,y,n:integer);  {n=0 чтение n=1 запись}
var
  f : file;
  i,j : integer;
const
  name : array[0..3] of string[4] =
  ('kni','pal','bar','mage');
begin
 if n = 0 then begin
  assign(f,name[a1]+'.kni');
  reset(f,1);
  for j := 0 to 101 do
{    for i := 0 to 95 do}
      blockread(f,np3^[j,0],{sizeof(byte)}96);
  close(f);
 end else begin
  for j := 0 to 101 do
    move(np3^[j],scr^[j+y,x],96);
{    for i := 0 to 95 do
      scr^[j+y,i+x] := np3^[j,i];}
 end;
end;

procedure readtown(x,y,n,n1:integer);
var
  i,j : integer;
  f : file;
const
  a : array[1..2] of string[8] =
  ('town','castle');
begin
  if n1 = 0 then begin
    assign(f,a[n] + '.kni');
    reset(f,1);
    for j := 0 to 103 do
 {     for i := 0 to 239 do}
        blockread(f,np2^[j,0],240);
   close(f);
  end else begin
    for j := 0 to 103 do
      move(np2^[j],scr^[j+y,x],240);
{      for i := 0 to 239 do
        scr^[j+y,i+x] := np2^[j,i];}
  end;
end;

procedure readtables;
var
  f : file;
  i,j : integer;
begin
  assign(f,'tablos.kni');
  reset(f,1);
  for i := 0 to 4 do
    blockread(f,np2^[i],288);
  close(f);
  for i := 0 to 4 do
    move(np2^[i],scr^[y2+i+1,x1],288);
{    for j := 0 to 287 do
      scr^[y2+i+1,x1+j] := np2^[i,j];}
end;

procedure pspr(n1,n2:integer); {ПЕРеворачивает Тайлик }
var
   j,k:word;
begin
   for j:=0 to 33 do
     for k:=0 to 47 do
       np[n2]^[j,47-k]:=np[n1]^[j,k];
end;

procedure animspr(XT,YT,n,s,h:integer); {n-ячейка картинки,s-ячейка фона}
var
  k:integer;
begin
  k:=n;
  REPEAT
   puttailsprcell(xt,yt,k,s);
   puttext((x3+dx1*XT+2),y3+dy1*(YT+1)-8,strk(h));
   deltat(3);
   k:=k+1;
   if k = n+4 then
     k:=n;
  until keypressed;
end;

procedure animsprn(XT,YT:integer;var x2:integer);
var
  k:integer;
  n,s:integer;
  x1,y1:integer;
begin
  n:=cir3;
  k:=n;
  REPEAT
  y1 :=0;
  clearkeybuffer;
          if battlemap[xt,yt] > 50 then
            Puttilecell(XT,YT,battlemap[xt,yt])
          else
            Puttilecell(XT,YT,plai3);
         case battlemap[xt,yt] of
           1..25:begin
                s:=-1;
                for x1:=0 to 4 do if (xarmy[x1]=xt)and(yarmy[x1]=yt)
                       and(narmy[x1]>0) then s:=x1;
                puttailsprcell(xt,yt,1+s*4,plai3);
                writexy((x3+dx1*xt+2),y3+dy1*(yt+1)-8,strk(narmy[s]));
                y1 := 1;
              end;
           26..50:begin
                s:=-1;
                for x1:=0 to 4 do if (xarmye[x1]=xt)and(yarmye[x1]=yt)
                                and (narmye[x1]>0)  then s:=x1;
                puttailsprcell(xt,yt,1+s*4+25,plai3);
                writexy(x3+dx1*xt+dx1 div 2,y3+dy1*(yt+1)-8,strk(narmye[s]));
                y1 := 2;
              end;
         end;
   Putsprcell(XT,YT,k);

   deltat(4);
   k:=k+1;
   if k = n+4 then
     k:=n;
  until keypressed;
  if y1 =0 then
    Puttilecell(XT,YT,battlemap[xt,yt]);
  if y1 =1 then begin
    Puttilecell(XT,YT,plai3);
    putsprcell(xt,yt,1+s*4);
    writexy((x3+dx1*xt+2),y3+dy1*(yt+1)-8,strk(narmy[s]));
  end;
  if y1 =2 then begin
    Puttilecell(XT,YT,plai3);
    putsprcell(xt,yt,1+s*4+25);
    writexy(x3+dx1*xt+dx1 div 2,y3+dy1*(yt+1)-8,strk(narmye[s]));
  end;
  x2 :=s;
end;

procedure eanimspr(XT,YT,n,s,h:integer); {n-ячейка картинки,s-ячейка фона}
var
  k,j:integer;
begin
  k:=n;
  j:=0;
  REPEAT
   puttailsprcell(xt,yt,k,s);
   puttext((x3+dx1*XT+dx1 div 2),y3+dy1*(YT+1)-8,strk(h));
   deltat(3);
   k:=k+1;
   if k = n+4 then  begin
     j:=j+1;
     k:=n;
   end;
  until j>1;
end;

procedure readtail(b:string;n,s:integer);{n-число кадров,s-номер ячейки}
var
   k:integer;
begin
   assign(fin,b);
   reset(fin,1);
   blockread(fin,sp,sizeof(sp));  {читаем из файла заголовок}
   if (sp.idfile<>idf)then begin  {проверяем совпадение идентификатора}
     writeln('Неверный тип файла');
     halt;
   end;
   for k:=0 to n-1 do
     blockread(fin,np[s+k]^,sizeof(tiletype));
   close(fin);                          {закрываем файл}
end;

procedure readpich(b:string;n:integer);{n-число кадров,s-номер ячейки}
var
  fin2 : file;
  i,j:integer;
  long : array[1..320]of byte;
begin
   assign(fin2,b);
   reset(fin2,1);
   if n = 1 then
     blockread(fin2,np2^,64000);
   if n = 2 then
     for j := 0 to 101 do begin
      blockread(fin2,long,240);
      for i := 0 to 239 do
        np2^[j,i] := long[i];
     end;
   if n = 3 then
     for j := 0 to 169 do begin
      blockread(fin2,long,144);
      for i := 0 to 143 do
        np2^[j,i] := long[i];
     end;
   close(fin2);                          {закрываем файл}
end;

{procedure writepich(n:string);{запись видеопамяти на диск}
{var
  f   : file;
  i,j : integer;
begin
  assign(f,n);
  rewrite(f,1);
  for j := 0 to 199 do
    for i := 0 to 319 do
      blockwrite(f,scr^[j,i],1);
  close(f);
end;}

procedure readarmy(s,n:integer);{s-номер ячейки,n-номер рода войск}
var
  k:integer;
begin
  if n <= 25 then
    readtail(nvr[n],4,s)
  else begin
    readtail(nvr[n-25],4,s);
    for k:=0 to 3 do begin
      pspr(s+k,0);
      np[s+k]^:=np[0]^;
   end;
  end;
end;

procedure epspr(n1,n2:integer);{переписывает из одной ячейки в другую}
begin
  np[n2]^:=np[n1]^;
end;

procedure getmemtail;
begin
   for i:=0 to 120 do
     getmem(np[i],sizeof(tiletype));    {выделяем память для кадров}
   getmem(np2,sizeof(scrtype));    {выделяем память для больших картинок}
   getmem(np3,sizeof(scrtype));    {выделяем память для больших картинок}
end;

procedure freememtail;
begin
   for i:=120 downto 0 do
     freemem(np[i],sizeof(tiletype));    {освобождаем память}
   freemem(np2,sizeof(scrtype));    {выделяем память для больших картинок}
   freemem(np3,sizeof(scrtype));    {выделяем память для больших картинок}
end;

procedure setpalknight;
begin
   assign(fin,'pal.dat');               {файл с палитрой}
   reset(fin,1);
   blockread(fin,p,768);
   close(fin);                          {закрываем файл}
   setpal(p[0],0,256);                {устанавливаем нужную палитру}
end;

procedure colorbar(x01,y01,x02,y02,color:integer);
var
  i,j : integer;
  t1,t2 : longint;
begin
{  t1 := gettimer;}
  for j :=y01 to y02 do
    fillchar(scr^[j,x01],x02-x01+1,color);
{    for i := x01 to x02 do
      scr^[j,i] := color;
{  t2 := gettimer;}
{  setgttyp(3);
  outstring(8,20,lstr(t2-t1));}
end;

procedure Rectangle(x01,y01,x02,y02,color:integer);
var
  k : integer;
begin
  fillchar(scr^[y01,x01],x02-x01,color);
  fillchar(scr^[y02,x01],x02-x01,color);
{  for k := x01 to x02 do begin
    scr^[y01,k] := color;
    scr^[y02,k] := color;
  end;  }
  for k := y01 to y02 do begin
    scr^[k,x01] := color;
    scr^[k,x02] := color;
  end;
end;

procedure bar2(x,y:integer);
var
 i,j : integer;
begin
  for j :=y to (y+5) do
    for i := x to (x+7) do
      scr^[j,i] := 4;
  for j :=y to (y+5) do
      scr^[j,(x+8)] := 0;
  for j :=x to (x+7) do
      scr^[(y+5),j] := 0;
end;

procedure bar(x,y:integer);
var
 i,j,k,k1 : integer;
begin
 for k1 :=0 to 4 do
  for k :=0 to 4 do
  if not tainmap[k,k1] then
   for j :=(y+k1*6) to (y+k1*6+5) do
    for i := (x+k*9)  to (x+k*9+7) do
      np3^[j,i] := 4;   {scr}
 for k1 :=0 to 4 do
  for k :=0 to 3 do
  if not tainmap[k,k1] then
  for j :=y+k1*6 to (y+k1*6+5) do
      np3^[j,(x+k*9+8)] := 0;
 for k1 :=0 to 4 do
  for k :=0 to 4 do
  if not tainmap[k,k1] then
  for j :=x+k*9 to (x+k*9+7) do
      np3^[(y+k1*6+5),j] := 0;
 for k1 :=0 to 4 do
  if not tainmap[k1,0] then
  for j :=x+k1*9 to (x+k1*9+7) do
      np3^[y-1,j] := 0;
 for k1 :=0 to 4 do
  if not tainmap[k1,4] then
  for j :=x+k1*9 to (x+k1*9+7) do
      np3^[y+30,j] := 0;
end;

procedure putpixel(x01,y01,c:integer);
begin
  scr^[y01,x01] := c;
end;

function getpixel(x01,y01:integer):byte;
begin
  getpixel := scr^[y01,x01] ;
end;


begin
   scr:=ptr(SegA000,0);
end.
