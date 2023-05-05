unit constant;
Interface
const
   mx=63;  {размер карты по горизонтали}
   my=63;  {размер карты по вертикали}
   maxY=199;
   maxX=319;
   dx1=48;{ширина клетки}
   dy1=34; {высота клетки}
   dx2=17; {ширина боковой рамки}
   dx3=0; {ширина внутренней рамки}
   dy2=8; {высота крайней рамки}
   dy3=5;  {высота средней рамки}
   dy4=9; {высота верхнего поля}
   dx5=dx1*5;{ширина поля сообщений}
   dy5=8; {высота 0 сообщения}
   dy6=8; {высота строки}
   dx7=8; {ширина зазора до маленького квадрата}
   dy7=8; {высота зазора до маленького квадрата}

   x1=dx2-1;
   y1=dy2;
   x2=maxX-dx2+1;
   y2=dy2+dy4+1-2;
   x3=x1+1;
   y3=y2+dy3+2;
   x4=x3+dx1*5;
   y4=y3+dy1*5;
   x5=maxX-dx2-dx1+dx3;
   y5=y3;
   x6=x2;
   y6=y4;
   x7=x3+(dx1*5-dx5)div 2;
   x8=x4-(dx1*5-dx5)div 2;
   y8=y4-dy1 div 2;
   y74=y8-dy6*4 -dy5;
   y75=y8-dy6*5 -dy5;

   enem1  = 0;                   {бр.рыцарь}
   brid1  = 4;    brid2  = 5;    {мост}
   plai1  =  6;  plai2  = 9;   {равнина}
   plai25 =  8;
   ches1  = 10;                 {сундук}
   ches2  = 11;                 {сундук с картой}
   enem2  = 12;  enem3  = 15;   {присоединяющиеся рыцари}
   town1  = 26;                 {город}
   arti1  = 28;  arti2  = 35;  {артифакты}
   boat1  = 36;  boat2  = 37;  {корабль}
   cart1  = 38;                 {повозка}
   cell1  = 39;                 {клетка}
   tree1  = 40;                 {дерево}
   cave1  = 41;                 {пещера}
   unde1  = 42;                 {под зем.ход}
   star1  = 43;                 {пещера со звездой}
   dese1  = 44;  dese2  = 57;  {пустыня}
   mark1  = 58;                 {указатель}
   wate1  = 60;  wate2  = 73;  {вода}
   moun1  = 74;  moun2  = 87;  {горы}
   fore1  = 88;  fore2  = 101;  {лес}
   pala1  = 102;  pala2  = 103;  {дворец}
   cast1  = 104;  cast2  = 109;  {замок}
   cast3  = 107;                  {вход в замок}

   cir3  = 46;               { кольца для поля боя }
   fir3  = 50;               { огонь(удар) для поля боя }
   plai3 = 51;               { равнина для поля боя }
   fore3 = 52;               { лес для поля боя }
   moun3 = 53;               { гора для поля боя }
   wate3 = 54;               { озеро для поля боя }
   wall3 = 55;  wall4 = 64;  { крепостная стена для поля боя }

   motions:array[1..25]of integer =   {число шагов для родов войск}
      (2,2,2,4,1,  1,3,2,3,1,  1,3,1,1,2,  2,1,1,3,1,  2,1,3,1,1);
   vistr:array[1..25]of integer =   {число выстрелов для родов войск}
      (0,12,0,0,0,  0,0,0,0,2,  0,24,0,0,3,  6,0,0,6,0,  0,0,0,0,0);
   flu:array[1..25]of byte =   {способность родов войск летать }
      (0,0,0,0,0,  0,0,0,0,1,  1,0,0,0,0,  0,0,0,0,1,  0,0,0,1,1);
   priz:array[1..25]of integer =      {приз за победу}
      (25,125,150,400,500, 5,20,150,375,600, 5,100,30,500,350, 35,150,375,1500,2500, 20,25,200,750,1500);
   prise:array[1..25]of longint =     {стоимость родов войск}
      (50,250,300,800,1000, 10,40,300,750,1200, 15,200,60,1000,700, 75,300,750,3000,5000, 40,50,400,1500,3000);
   lidir:array[1..25]of byte =     {лидершип для родов войск}
      (2,10,10,20,35, 1,3,15,40,25, 1,10,5,50,30, 4,20,40,60,205, 3,5,10,31,50);

   nacharmy:array[1..4,1..25]of integer =   {размер начальных армий врага}
   ((0,0,0,0,0, 10,5,2,2,0, 10,5,5,2,0, 5,4,2,2,0, 5,5,2,2,0),
   (0,0,0,0,0, 20,10,4,4,0, 20,10,10,4,5, 10,8,4,4,0, 10,10,4,4,0),
   (0,0,0,0,0, 40,20,8,8,2, 40,20,20,8,10, 20,16,8,8,2, 20,20,8,8,2),
   (0,0,0,0,0, 80,40,16,16,4, 80,40,40,16,10, 20,16,10,10,5, 40,40,8,8,4));

   nachsund:array[1..4,1..25]of byte =
   ((0,0,0,0,0, 200,100,50,50,0, 200,100,100,50,25, 200,100,50,0,0, 100,100,50,0,0),
   (0,0,0,0,0, 200,100,50,50,0, 200,100,100,50,25, 200,100,50,0,0, 100,100,50,0,0),
   (0,0,0,0,0, 200,100,50,50,0, 200,100,100,50,25, 200,100,50,0,0, 100,100,50,0,0),
   (0,0,0,0,0, 200,100,50,50,25, 200,100,100,50,25, 200,100,50,50,25, 100,100,50,25,25));

   liderarray : array[1..25,1..25] of byte =
   ((2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
   (1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1),
   (1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1),
   (1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1),
   (1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1),
   (1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
   (0,1,1,1,1,0,2,1,1,0,0,1,0,1,1,1,0,0,1,1,1,1,1,1,1),
   (1,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
   (0,1,1,1,1,0,0,0,2,2,1,2,0,1,1,1,0,1,1,1,1,1,1,1,1),
   (1,1,1,1,1,0,0,1,1,2,1,0,1,1,2,0,1,1,1,1,1,1,1,1,1),
   (1,1,1,1,1,1,1,1,1,0,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1),
   (1,1,1,1,1,1,1,1,2,1,2,2,1,2,2,1,1,1,1,1,1,1,1,1,1),
   (1,1,1,1,1,1,1,1,1,1,2,2,2,1,2,1,1,1,1,1,1,1,1,1,1),
   (0,1,1,1,1,0,0,1,1,1,1,2,1,2,2,0,1,0,1,1,1,1,1,1,1),
   (1,1,1,1,1,1,1,1,1,1,2,2,1,2,2,1,1,1,1,1,1,1,1,1,1),
   (0,0,0,0,0,0,1,1,1,0,0,0,1,1,0,2,1,1,2,1,1,1,1,1,1),
   (1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,2,2,0,1,1,1,1,1,1,1),
   (0,1,1,1,1,1,1,0,1,1,1,0,1,1,0,1,1,2,1,1,1,1,1,1,1),
   (1,1,1,1,1,0,0,1,1,1,1,0,1,1,1,1,1,1,2,1,1,1,1,1,1),
   (0,1,1,1,0,0,1,1,1,1,0,1,0,1,0,0,1,1,1,2,1,1,0,0,1),
   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,1,1,1,1),
   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,2,1,1,1),
   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,2,1,1),
   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,2,1),
   (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,2));

   ncont : array[1..4]of string[12]=('','',
   '','');

   contvil : array[1..4]of string[12]=('','',
   '','');

   zaklin : array[1..14]of string = ('','',
   '','','','','',
   '','','','','',
   '','');

{   m_zakl : array[1..14]of byte =
   (4,2,4,2,4,4,4,2,4,4,4,4,4,2);}

   p_zakl : array[1..14]of integer =
   (2000,500,2000,500,300,1500,2000,100,200,2000,1000,1000,1000,2000);

   s_zakl : array[1..3]of integer =
   (50,35,60);

   prosmp  : array[0..4,0..4]of byte=((18,8,19,7,20),(6,16,15,14,5),
   (21,13,17,12,22),(4,11,10,9,3),(23,2,24,1,25));

   colzlkor : array[1..3]of byte=(4,3,6);

type {определение типа}
   maparr= array[0..mx,0..my] of byte;
   castl = record
     x   : integer;
     y   : integer;
     s   : string[15];        {название}
     v   : integer;                    {номер злодея}
     c   : integer;          {номер континента}
     a   : array[0..4] of integer;     {армии врага}
     na  : array[0..4] of integer;     {размеры армий врага}
     P   : boolean;                    {были или нет}
   end;
   town_1 = record
     s   : string[15];
     z   : integer;
     x   : integer;
     y   : integer;
     c   : integer;
     m   : integer;
     P   : boolean;                    {были или нет}
   end;
   vilian = record
{     x   : integer;
     y   : integer;}
     p   : word;          {плата за злодея}
     c   : integer;          {номер континента}
     m   : byte;             {можно ли заключить конкракт}
     n   : string[20];        {имя}
     nc  : integer;           {номер замка}
     a   : array[0..4] of integer;     {армии врага}
     na  : array[0..4] of integer;     {размеры армий врага}
   end;
   magsund = record
     c   : integer;          {вид}
     n   : byte;             {номер в массиве сундуков}
     a   : byte;
     na  : byte;
   end;
   enemp = record
     n   : byte;             {номер в массиве сундуков}
     a   : byte;             {армия}
     na  : integer;             {количество}
   end;
const
   castle : array[1..26] of castl =
      ((x:6;y:6),(x:57;y:5),
      (x:22;y:14),(x:36;y:14),
       (x:11;y:33),(x:22;y:39),
       (x:30;y:36),(x:40;y:22),
       (x:58;y:40),(x:54;y:57),
       (x:40;y:58),(x:42;y:7),
       (x:25;y:24),(x:41;y:29),
       (x:19;y:44),(x:30;y:45),
       (x:47;y:57),(x:52;y:6),
       (x:11;y:17),(x:41;y:27),
       (x:43;y:36),(x:9;y:45),
       (x:45;y:57),(x:46;y:20),
       (x:17;y:24),(x:41;y:51));
   vilians : array[1..17] of vilian =
      ((p:5000;c:1;m:1;n:''),
      (p:6000;c:1;m:1;n:''),
      (p:7000;c:1;m:1;n:''),
      (p:8000;c:1;m:1;n:''),
       (p:9000;c:1;m:1;n:''),
       (p:10000;c:1;m:0;n:''),
       (p:12000;c:2;m:0;n:''),
       (p:14000;c:2;m:0;n:''),
       (p:16000;c:2;m:0;n:''),
       (p:18000;c:2;m:0;n:''),
       (p:20000;c:3;m:0;n:''),
       (p:25000;c:3;m:0;n:''),
       (p:30000;c:3;m:0;n:''),
       (p:35000;c:3;m:0;n:''),
       (p:40000;c:4;m:0;n:''),
       (p:45000;c:4;m:0;n:''),
       (p:50000;c:4;m:0;n:''));
   towns : array[1..26] of town_1 =
       ((s:'A'),(s:'B'),
       (s:'C'),(s:'D'),
       (s:'E'),(s:'F'),
       (s:'G'),(s:'H'),
       (s:'I'),(s:'J'),
       (s:'K'),(s:'L'),
       (s:'M'),(s:'N'),
       (s:'O'),(s:'P'),
       (s:'Q'),(s:'R'),
       (s:'S'),(s:'T'),
       (s:'U'),(s:'V'),
       (s:'W'),(s:'X'),
       (s:'Y'),(s:'Z'));
   readspavil : array[1..17] of string[8]=
       (('vmm.spa'),('vhr.spa'),('vpa.spa'),('vbjm.spa'),
       ('vdpr.spa'),('vcm.spa'),('vsmc.spa'),('vpb.spa'),
       ('vbe.spa'),('vrd.spa'),('vr.spa'),('vmb.spa'),
       ('vaw.spa'),('vcn.spa'),('vmd.spa'),('vuk.spa'),('vad.spa'));

var
   namear:array[1..25]of string[12];

   namear2:array[1..25]of string[12];

   spellarray : array[1..14] of byte;
   spellarray14 : integer;
   spellarray2: array[1..14] of byte;
{   regim : boolean;}
   enemprise : array[1..20] of enemp;
   magsundrec : array [1..45] of magsund;
   map   : array[1..4] of maparr; {массив}
   mapb  : array[0..63,0..63] of byte;
   arraysundx : array[1..250] of byte;
   arraysundy : array[1..250] of byte;
   arraysundc : array[1..250] of byte;
   mapcontnsun: array[1..4] of byte;
   score : longint;
   colsund:integer;
   colzlpl:integer;
   cont  : integer; {номер континента}
   mapcont:byte;
   x,y   : integer; {координаты рыцаря}
   xk,yk : integer; {координаты корабля}
   eckipet:boolean; {нашли ли Скипетр}
   colcastle : integer; {колличество замков на континенте}
   coltown : integer; {колличество городов на континенте}
   timestop  : integer; {применено timestop?}

   battlemap : array [0..5,0..4] of byte;      {карта поля боя}
   army      : array [0..4]      of integer;   {армии рыцаря}
   narmy     : array [0..4]      of integer;   {размеры армий рыцаря}
   blows     : array [0..4]      of boolean;   {Ответила ли единица}
   eblows    : array [0..4]      of boolean;   {      на удар      }
   armyi     : array [0..4]      of integer;   {Отлож ли ход единица}
   narmy2    : array [0..4]      of integer;   {размеры армий рыцаря}
   moral     : array [0..4]      of integer;   {мораль армий рыцаря}
   armye     : array [0..4]      of integer;   {армии врага}
   narmye    : array [0..4]      of integer;   {размеры армий врага}
   colvis    : array [0..4]      of integer;   {кол-во выстр-ов наших армий}
   ncolvis   : array [0..4]      of integer;   {кол-во выстр-ов армий врага}
   armyflu   : array [0..4]      of byte;      {может наша армия летать}
   narmyflu  : array [0..4]      of byte;      {может армия врага летать}
   xarmy     : array [0..4]      of integer;   {координаты армий рыцаря}
   yarmy     : array [0..4]      of integer;   {координаты армий рыцаря}
   xarmye    : array [0..4]      of integer;   {координаты армий врага}
   yarmye    : array [0..4]      of integer;   {координаты армий врага}
   textvil   : array [1..17]     of string[31];
   tainmap   : array [0..4,0..4]     of boolean;

   lidersaip,plata,sila_zaklinanii,maksium_zaklinanii,poimano_zlodeev,
      naideno_artifaktov,zanito_zamkov,ubito_boevin_edinic:longint;
   boat:boolean;             {На корабле или нет}
   eboat:boolean;            {Есть корабль или нет}
{   eaboat : boolean          {Есть якорь или нет}
   eflu :boolean;
   ecata:boolean;            {Есть катапульта или нет}
   evil:integer;             {Есть контракт или нет}
   emag:boolean;             {Есть Магия или нет}
   minvil:integer;           {минимальный номер злодея}
   maxvil:integer;           {максимальный номер злодея}
   money:longint;            {}
   lider:longint;            {}
   a:integer;                {номер звания}
   a1:integer;
   name:string[12];          {имя}
   nap:integer;               {}
   nap2:integer;               {}
   nap3:integer;
   time :integer;                       {время в днях}
   timestep :integer;                   {время в шагах}
   timew :integer;                      {время в шагах}
   xp,yp :integer;                      {координаты приза}
   contp : byte;
   flaglider : boolean;
const
   ime:array[0..3,0..3]of string[12]=(('','','',''),
                                  ('','','',''),
                                  ('','','',''),
                                  ('','','',''));

const
  tab:array[0..109]of byte=(1,2,3,4,5,6,7,8,7,7,9,9,1,2,3,4,9,9,9,9,
  9,9,9,9,9,9,10,10,11,12,13,14,15,16,17,18,19,22,23,24,
  25,26,26,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,41,
  42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,
  62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,
  82,83,87,84,84,85,86,87,88,89);


function zem:boolean; {Хождение по земле}
function wat(xn,yn:integer):boolean; {Хождение по воде}

Implementation

uses drawtail;

function zem:boolean; {Хождение по земле}
var
  k:integer;
begin
    if (nap <> nap2) and boat then begin
      nap := nap2;
      for k :=0 to 3 do begin
        pspr(106+k,0);
        epspr(0,106+k);
      end;
    end;    {}
  if boat then begin
    boat:=false;
  end;
  zem:=true
end;

function wat(xn,yn:integer):boolean; {Хождение по воде}
begin
  if boat then begin
    xk := xn;
    yk := yn;
    wat := true;
  end else
    if (xn=xk) and (yn=yk) and (eboat=true) then begin
      boat := true;
      wat := true;
    end else
      wat := false;
end;

begin
   score := 0;
   eboat:=false;
   eflu:=false{true};
   boat:=false;
   ecata:=false;
   evil:=0;
   nap :=-1;
   nap3:=-1;
   nap2:=-1;
{   time:=600;}
   a1 := 3;
   timestep:=0;
   timew:=0;
   colzlpl:=4;
   timestop := 0;
   flaglider := false;
   emag := false;
end.
