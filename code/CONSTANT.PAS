unit constant;
Interface
const
   mx=63;  {ࠧ��� ����� �� ��ਧ��⠫�}
   my=63;  {ࠧ��� ����� �� ���⨪���}
   maxY=199;
   maxX=319;
   dx1=48;{�ਭ� ���⪨}
   dy1=34; {���� ���⪨}
   dx2=17; {�ਭ� ������� ࠬ��}
   dx3=0; {�ਭ� ����७��� ࠬ��}
   dy2=8; {���� �ࠩ��� ࠬ��}
   dy3=5;  {���� �।��� ࠬ��}
   dy4=9; {���� ���孥�� ����}
   dx5=dx1*5;{�ਭ� ���� ᮮ�饭��}
   dy5=8; {���� 0 ᮮ�饭��}
   dy6=8; {���� ��ப�}
   dx7=8; {�ਭ� ����� �� �����쪮�� ������}
   dy7=8; {���� ����� �� �����쪮�� ������}

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

   enem1  = 0;                   {��.�����}
   brid1  = 4;    brid2  = 5;    {����}
   plai1  =  6;  plai2  = 9;   {ࠢ����}
   plai25 =  8;
   ches1  = 10;                 {�㭤�}
   ches2  = 11;                 {�㭤� � ���⮩}
   enem2  = 12;  enem3  = 15;   {��ᮥ�����騥�� ����}
   town1  = 26;                 {��த}
   arti1  = 28;  arti2  = 35;  {���䠪��}
   boat1  = 36;  boat2  = 37;  {��ࠡ��}
   cart1  = 38;                 {�������}
   cell1  = 39;                 {���⪠}
   tree1  = 40;                 {��ॢ�}
   cave1  = 41;                 {����}
   unde1  = 42;                 {��� ���.室}
   star1  = 43;                 {���� � �������}
   dese1  = 44;  dese2  = 57;  {������}
   mark1  = 58;                 {㪠��⥫�}
   wate1  = 60;  wate2  = 73;  {����}
   moun1  = 74;  moun2  = 87;  {����}
   fore1  = 88;  fore2  = 101;  {���}
   pala1  = 102;  pala2  = 103;  {�����}
   cast1  = 104;  cast2  = 109;  {�����}
   cast3  = 107;                  {�室 � �����}

   cir3  = 46;               { ����� ��� ���� ��� }
   fir3  = 50;               { �����(㤠�) ��� ���� ��� }
   plai3 = 51;               { ࠢ���� ��� ���� ��� }
   fore3 = 52;               { ��� ��� ���� ��� }
   moun3 = 53;               { ��� ��� ���� ��� }
   wate3 = 54;               { ���� ��� ���� ��� }
   wall3 = 55;  wall4 = 64;  { �९��⭠� �⥭� ��� ���� ��� }

   motions:array[1..25]of integer =   {�᫮ 蠣�� ��� த�� ����}
      (2,2,2,4,1,  1,3,2,3,1,  1,3,1,1,2,  2,1,1,3,1,  2,1,3,1,1);
   vistr:array[1..25]of integer =   {�᫮ ����५�� ��� த�� ����}
      (0,12,0,0,0,  0,0,0,0,2,  0,24,0,0,3,  6,0,0,6,0,  0,0,0,0,0);
   flu:array[1..25]of byte =   {ᯮᮡ����� த�� ���� ����� }
      (0,0,0,0,0,  0,0,0,0,1,  1,0,0,0,0,  0,0,0,0,1,  0,0,0,1,1);
   priz:array[1..25]of integer =      {�ਧ �� ������}
      (25,125,150,400,500, 5,20,150,375,600, 5,100,30,500,350, 35,150,375,1500,2500, 20,25,200,750,1500);
   prise:array[1..25]of longint =     {�⮨����� த�� ����}
      (50,250,300,800,1000, 10,40,300,750,1200, 15,200,60,1000,700, 75,300,750,3000,5000, 40,50,400,1500,3000);
   lidir:array[1..25]of byte =     {�����訯 ��� த�� ����}
      (2,10,10,20,35, 1,3,15,40,25, 1,10,5,50,30, 4,20,40,60,205, 3,5,10,31,50);

   nacharmy:array[1..4,1..25]of integer =   {ࠧ��� ��砫��� �ନ� �ࠣ�}
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

type {��।������ ⨯�}
   maparr= array[0..mx,0..my] of byte;
   castl = record
     x   : integer;
     y   : integer;
     s   : string[15];        {��������}
     v   : integer;                    {����� ������}
     c   : integer;          {����� ���⨭���}
     a   : array[0..4] of integer;     {�ନ� �ࠣ�}
     na  : array[0..4] of integer;     {ࠧ���� �ନ� �ࠣ�}
     P   : boolean;                    {�뫨 ��� ���}
   end;
   town_1 = record
     s   : string[15];
     z   : integer;
     x   : integer;
     y   : integer;
     c   : integer;
     m   : integer;
     P   : boolean;                    {�뫨 ��� ���}
   end;
   vilian = record
{     x   : integer;
     y   : integer;}
     p   : word;          {���� �� ������}
     c   : integer;          {����� ���⨭���}
     m   : byte;             {����� �� �������� ����ࠪ�}
     n   : string[20];        {���}
     nc  : integer;           {����� �����}
     a   : array[0..4] of integer;     {�ନ� �ࠣ�}
     na  : array[0..4] of integer;     {ࠧ���� �ନ� �ࠣ�}
   end;
   magsund = record
     c   : integer;          {���}
     n   : byte;             {����� � ���ᨢ� �㭤㪮�}
     a   : byte;
     na  : byte;
   end;
   enemp = record
     n   : byte;             {����� � ���ᨢ� �㭤㪮�}
     a   : byte;             {�ନ�}
     na  : integer;             {������⢮}
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
   map   : array[1..4] of maparr; {���ᨢ}
   mapb  : array[0..63,0..63] of byte;
   arraysundx : array[1..250] of byte;
   arraysundy : array[1..250] of byte;
   arraysundc : array[1..250] of byte;
   mapcontnsun: array[1..4] of byte;
   score : longint;
   colsund:integer;
   colzlpl:integer;
   cont  : integer; {����� ���⨭���}
   mapcont:byte;
   x,y   : integer; {���न���� �����}
   xk,yk : integer; {���न���� ��ࠡ��}
   eckipet:boolean; {��諨 �� �������}
   colcastle : integer; {�������⢮ ������ �� ���⨭���}
   coltown : integer; {�������⢮ ��த�� �� ���⨭���}
   timestop  : integer; {�ਬ����� timestop?}

   battlemap : array [0..5,0..4] of byte;      {���� ���� ���}
   army      : array [0..4]      of integer;   {�ନ� �����}
   narmy     : array [0..4]      of integer;   {ࠧ���� �ନ� �����}
   blows     : array [0..4]      of boolean;   {�⢥⨫� �� ������}
   eblows    : array [0..4]      of boolean;   {      �� 㤠�      }
   armyi     : array [0..4]      of integer;   {�⫮� �� 室 ������}
   narmy2    : array [0..4]      of integer;   {ࠧ���� �ନ� �����}
   moral     : array [0..4]      of integer;   {��ࠫ� �ନ� �����}
   armye     : array [0..4]      of integer;   {�ନ� �ࠣ�}
   narmye    : array [0..4]      of integer;   {ࠧ���� �ନ� �ࠣ�}
   colvis    : array [0..4]      of integer;   {���-�� �����-�� ���� �ନ�}
   ncolvis   : array [0..4]      of integer;   {���-�� �����-�� �ନ� �ࠣ�}
   armyflu   : array [0..4]      of byte;      {����� ��� �ନ� �����}
   narmyflu  : array [0..4]      of byte;      {����� �ନ� �ࠣ� �����}
   xarmy     : array [0..4]      of integer;   {���न���� �ନ� �����}
   yarmy     : array [0..4]      of integer;   {���न���� �ନ� �����}
   xarmye    : array [0..4]      of integer;   {���न���� �ନ� �ࠣ�}
   yarmye    : array [0..4]      of integer;   {���न���� �ନ� �ࠣ�}
   textvil   : array [1..17]     of string[31];
   tainmap   : array [0..4,0..4]     of boolean;

   lidersaip,plata,sila_zaklinanii,maksium_zaklinanii,poimano_zlodeev,
      naideno_artifaktov,zanito_zamkov,ubito_boevin_edinic:longint;
   boat:boolean;             {�� ��ࠡ�� ��� ���}
   eboat:boolean;            {���� ��ࠡ�� ��� ���}
{   eaboat : boolean          {���� 类�� ��� ���}
   eflu :boolean;
   ecata:boolean;            {���� ��⠯��� ��� ���}
   evil:integer;             {���� ����ࠪ� ��� ���}
   emag:boolean;             {���� ����� ��� ���}
   minvil:integer;           {��������� ����� ������}
   maxvil:integer;           {���ᨬ���� ����� ������}
   money:longint;            {}
   lider:longint;            {}
   a:integer;                {����� ������}
   a1:integer;
   name:string[12];          {���}
   nap:integer;               {}
   nap2:integer;               {}
   nap3:integer;
   time :integer;                       {�६� � ����}
   timestep :integer;                   {�६� � 蠣��}
   timew :integer;                      {�६� � 蠣��}
   xp,yp :integer;                      {���न���� �ਧ�}
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


function zem:boolean; {�������� �� �����}
function wat(xn,yn:integer):boolean; {�������� �� ����}

Implementation

uses drawtail;

function zem:boolean; {�������� �� �����}
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

function wat(xn,yn:integer):boolean; {�������� �� ����}
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
