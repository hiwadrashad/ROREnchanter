program new;
{$define SMART}
{$I SRL/osr.simba}
{$I RSWalker/Walker.simba}
//{$I Reflection/Reflection.simba}
var
RSW : TRSWalker;
path, TPA: TPointArray;
x, y : Integer;
DTM_RingOfRecoil, DTM_LoginExistingUser, DTM_Login, DTM_WorldMap, DTM_SaphireRing, DTM_CosmicRune,DTM_BankFirstTab, DTM_ActiveMageTab, DTM_ActiveInvTab, DTM_CastleWarsRing: Integer;
ATPA: T2DPointArray;
NeedMoreItems : Boolean;
SA : Array[0..3] of byte;
CastleWarsBankColor: integer;
GE : TGrandExchStub;
 GeInterfaceColor : TCTS2Color;
Compass : TRSMinimap;
Player : Tplayer;
TSRLI : TSRL;
breakAfterTime, breakLength: Integer;



const

P_USERNAME := 'hiwadrashad1@gmail.com';
P_PASSWORD := 'Groothoofd3';
P_PIN := '';
USEBREAKS := true;
breakAfterHours_MIN := 2;
breakAfterHours_MAX := 3;  {breaks after random (MIN, MAX) hours}
breakForMinutes_MIN := 15;
breakForMinutes_MAX := 30; {for random (MIN, MAX) minutes}
BuyingAmountOfRingsAtGE :=  '10';
LOGIN_WORLD := 515;
UseSmart := False;


{ const MSX1, MSY1, MSX2, MSY2;
  Description: Main Screen EdgePoints. }
const
  MSX1 = 4;
  MSY1 = 4;
  MSX2 = 515;
  MSY2 = 337;

{ Fullscreen coordinates}
const
FSX1 = 0;
FSY1 = 0;
FSX2 = 763;
FSY2 = 501;

  { const MIX1, MIY1, MIX2, MIY2;
  Description: Inventory EdgePoints. }
const
  MIX1 = 547;
  MIY1 = 204;
  MIX2 = 736;
  MIY2 = 465;

  { const MCX1, MCY1, MCX2, MCY2;
  Description: Chat Screen EdgePoints. }
const
  MCX1 = 7;
  MCY1 = 345;
  MCX2 = 512;
  MCY2 = 473;

procedure declarePlayers();
begin
Player.LoginName := P_USERNAME;
Player.PassWord := P_PASSWORD;
Player.IsMember := True;
Player.World := LOGIN_WORLD;
end;

function IsLoggedIn(): Boolean;
begin
 if (findDTM(DTM_WorldMap, x, y, 705, 115, 744, 145)) then
 begin
 exit(True);
 end
 else
 begin
 exit(False);
 end
end

procedure free;
begin
freeDTM(DTM_RingOfRecoil);
freeDTM(DTM_SaphireRing);
freeDTM(DTM_CosmicRune);
freeDTM(DTM_BankFirstTab);
freeDTM(DTM_ActiveMageTab);
freeDTM(DTM_ActiveInvTab);
freeDTM(DTM_CastleWarsRing);
end;

procedure antiban();
var
TSRLV : TSRL;
TRSV : TRSStats;
TRSMV :  TRSMinimap;
begin
begin
 SA[0] := 0;
 SA[1] := 1;
 SA[2] := 2;
 SA[3] := 3;
end
    case random(0, 60) of
    0..35:
        TSRLV.MouseOffClient(SA[random(0,3)]);
    41..45:
    begin
    TRSV.HoverSkill(SKILL_MAGIC,random(1000,3000), True);
    end
    46..60:
    begin
    TRSMV.SetCompassAngle(random(-200,180));
    end
    end;
end;


procedure customMouseNoClick(pointcoordinate: TPoint);
begin
sleep(random(100,200))
case random(0, 5) of
    0..1:
    begin
    mouse.Miss(point(pointcoordinate.X + (random(-5,5)),pointcoordinate.Y + random(-5,5)));
    mouse.Move(point(pointcoordinate.X + (random(-5,5)),pointcoordinate.Y + random(-5,5)));
    end
    2..6:
    begin
    mouse.Move(point(pointcoordinate.X + (random(-5,5)),pointcoordinate.Y + random(-5,5)));
    end
  end
end;

procedure customMouseLeft(pointcoordinate: TPoint);
begin
sleep(random(100,200))
case random(0, 5) of
    0..1:
    begin
    mouse.Miss(point(pointcoordinate.X + (random(-5,5)),pointcoordinate.Y + random(-5,5)));
    mouse.Move(point(pointcoordinate.X + (random(-5,5)),pointcoordinate.Y + random(-5,5)));
    end
    2..6:
    begin
    mouse.Move(point(pointcoordinate.X + (random(-5,5)),pointcoordinate.Y + random(-5,5)));
    end
  end
sleep(random(100,200));
mouse.Click(1);
end;

procedure customMouseRight(pointcoordinate: TPoint);
begin
sleep(random(100,200))
case random(0, 5) of
    0..1:
    begin
    mouse.Miss(point(pointcoordinate.X + (random(-5,5)),pointcoordinate.Y + random(-5,5)));
    mouse.Move(point(pointcoordinate.X + (random(-5,5)),pointcoordinate.Y + random(-5,5)));
    end
    2..6:
    begin
    mouse.Move(point(pointcoordinate.X + (random(-5,5)),pointcoordinate.Y + random(-5,5)));
    end
  end
sleep(random(100,200));
mouse.Click(0);
end;

procedure clickMenuOption(upText: String);
begin
sleep(random(100,200));
chooseoption.Select(upText);
end

Procedure typeSend(Text: String; Send: Boolean = True);
var
  I: Integer;
begin
  for I := 1 to Length(Text) do
  begin
    sendKeys(Text[i], 40+Random(40), 15+Random(30));
    Wait(20 + Random(40));
  end;

  if Send then
  begin
    if (UseSmart) then

    begin
    KeyDown(10);
    wait(RandomRange(50, 100));
    KeyUp(10);
    end
    else
    begin
      pressKey(VK_ENTER);
    end
  end
end;


procedure LogOutAccount();
begin
customMouseLeft(point(642,484));
customMouseLeft(point(640,430));
sleep(random(1000,2000));
end;

procedure LogoutAndTerminate();
begin
LogOutAccount();
sleep(random(300,600));
Terminatescript();
end;

procedure Login();
begin
Player.Login();
sleep(random(1000,4000));
customMouseLeft(point(400,335));
sleep(random(400,800));
mainscreen.SetAngle(True);
end;


procedure AFKSimulator();
var
TSRLV: TSRL;
begin
 if (random(0,2) = 0) then
 begin
 customMouseNoClick(point((random(0,760)),(random(0,500))));
 end
 else
 begin
 SA[0] := 0;
 SA[1] := 1;
 SA[2] := 2;
 SA[3] := 3;
 TSRLV.MouseOffClient(SA[random(0,3)]);
 end
end;



procedure OpenBank();
var
  TPA : TPointArray;
  TPTA: Integer;
  ATPA: T2DPointArray;
  limitHit: Boolean;
  X: Integer;
begin
if (SRL.FindColors(TPA,CTS2(CastleWarsBankColor, 100, 0.01, 0.01), MainScreen.GetBounds) > 0) then
begin
  begin
  SRL.FindColors(TPA,CTS2(CastleWarsBankColor, 100, 0.01, 0.01), MainScreen.GetBounds);
  X := X + 1;
  ATPA := TPA.Cluster(2);
  ATPA.FilterSize(100,500);
  ATPA.SortByIndex(MainScreen.GetMiddle);
  //writeln(Length(ATPA[0]));
  TPTA := Random(0,Length(ATPA[0]));
  customMouseLeft(point(ATPA[0][TPTA].X,ATPA[0][TPTA].Y));
  sleep(random(800,1300))
  end
end
end;



procedure WithdrawBank();
var
InvCoord : Integer;
Deposited : Boolean;
begin
 if (findDTM(DTM_BankFirstTab, x, y, MSX1, MSY1, MSX2, MSY2)) then
 begin
 customMouseLeft(point(122,57));
 end
if (findDTM(DTM_RingOfRecoil, x, y, MIX1,MIY1,MIX2,MIY2)) then
begin
repeat
begin
InvCoord := random(1,27);
if (FindDTM(DTM_RingOfRecoil, x, y, inventory.GetSlotBox(InvCoord).X1, inventory.GetSlotBox(InvCoord).Y1, inventory.GetSlotBox(InvCoord).X2, inventory.GetSlotBox(InvCoord).Y2)) then
begin
customMouseRight(point(x,y));
clickMenuOption('Deposit-All');
Deposited := True;
end
end
until (Deposited = True)
end
Deposited := False;
sleep(random(300,600));
if (findDTM(DTM_SaphireRing, x, y, MSX1, MSY1, MSX2, MSY2)) then
 begin
 customMouseRight(point(x,y));
   begin
   clickMenuOption('Withdraw-All');
   sleep(random(600,800));
   end
   if ( not (findDTM(DTM_SaphireRing, x, y, MSX1, MSY1, MSX2, MSY2))) then
   begin
   NeedMoreItems := True;
   writeln('you need more items!');
   end
   customMouseLeft(point(487,22));
   sleep(random(300,600));
 end
 else
 begin
 customMouseLeft(point(487,22));
 end
end;

procedure EnchantSubRoutine();
var
I,XI : integer;
InvIndex: Integer;
TT : TTimeMarker;
begin
//replace this back to(0,1)
if (random(0,1) = 0) then
begin
InvIndex := (random(2,28));
if (FindDTM(DTM_SaphireRing, x, y, inventory.GetSlotBox(InvIndex).X1, inventory.GetSlotBox(InvIndex).Y1, inventory.GetSlotBox(InvIndex).X2, inventory.GetSlotBox(InvIndex).Y2)) then
begin
  customMouseLeft(point(741,182));
  customMouseLeft(point(693,216));
  customMouseLeft(point(x, y));
  sleep(random(1000,1500));
  customMouseLeft(point(643,185));
  sleep(random(100,300));
  AFKSimulator();
   begin
   for XI := 1 to 28 do
 begin
 begin
 if(not(findDTM(DTM_ActiveInvTab, x, y, 517,163,673,207))) then
 begin
 customMouseLeft(point(644,185));
 AFKSimulator();
 end
 end
 if (FindDTM(DTM_SaphireRing, x, y, inventory.GetSlotBox(XI).X1, inventory.GetSlotBox(XI).Y1, inventory.GetSlotBox(XI).X2, inventory.GetSlotBox(XI).Y2)) then
  begin
  sleep(5000);
  if (FindDTM(DTM_SaphireRing, x, y, inventory.GetSlotBox(XI).X1, inventory.GetSlotBox(XI).Y1, inventory.GetSlotBox(XI).X2, inventory.GetSlotBox(XI).Y2)) then
   begin
   EnchantSubRoutine();
   end
  end
  end
 end
end
else
begin
EnchantSubRoutine();
end
end
else
begin
for I := 1 to 28 do
 begin
  if (FindDTM(DTM_SaphireRing, x, y, inventory.GetSlotBox(I).X1, inventory.GetSlotBox(I).Y1, inventory.GetSlotBox(I).X2, inventory.GetSlotBox(I).Y2)) then
  begin
  customMouseLeft(point(741,182));
  customMouseLeft(point(693,216));
  customMouseLeft(point(x, y));
  sleep(random(200,300));
  customMouseLeft(point(643,185));
  sleep(random(100,300));
  AFKSimulator();
  break();
  end
 end

   begin
   for XI := 1 to 28 do
 begin
 begin
 if(not(findDTM(DTM_ActiveInvTab, x, y, 517,163,673,207))) then
 begin
 customMouseLeft(point(644,185));
 AFKSimulator();
 end
 end
 if (FindDTM(DTM_SaphireRing, x, y, inventory.GetSlotBox(XI).X1, inventory.GetSlotBox(XI).Y1, inventory.GetSlotBox(XI).X2, inventory.GetSlotBox(XI).Y2)) then
  begin
  sleep(5000);
  if (FindDTM(DTM_SaphireRing, x, y, inventory.GetSlotBox(XI).X1, inventory.GetSlotBox(XI).Y1, inventory.GetSlotBox(XI).X2, inventory.GetSlotBox(XI).Y2)) then
   begin
   EnchantSubRoutine();
   end
  end
  end
 end
end
end;

procedure EnchantMainRoutine();
var
TPa : TPointArray;
I,X : Integer;
TT : TTimeMarker;
TP : TPoint;
begin
if(findDTM(DTM_SaphireRing, x, y, MIX1,MIY1,MIX2,MIY2)) then
 begin
 EnchantSubRoutine();
 end
end;

procedure randomBreakTime();
var
TSRLV : TSRL;
begin
  breakAfterTime := GetTimeRunning + (RandomRange(breakAfterHours_MIN, breakAfterHours_MAX) * 3600000) + RandomRange(2000, 3500000);
  Writeln('breakAfterTime = ' + TSRLV.MsToTime(breakAfterTime, Time_Bare));
  breakLength := (RandomRange(breakForMinutes_MIN, breakForMinutes_MAX) * 60000) + RandomRange(2000, 59000);
  Writeln('breakLength = ' + TSRLV.MsToTime(breakLength, Time_Bare));
end;

procedure breakHandlerCustom();
var
TSRLV : TSRL;
begin
writeln('starting breakhandler');
  while (IsLoggedIn()) do
  begin
  LogOutAccount();
  end
  while not (getTimeRunning >= (breakAfterTime + breakLength)) do
  begin
    Writeln('Break handler active');
    Writeln('TimeRunning: ' + TSRLV.MsToTime(getTimeRunning, Time_Bare));
    Writeln('Breaking till: ' + TSRLV.MsToTime((breakAfterTime + breakLength), Time_Bare));
    Writeln('Time left until break is done: ' + TSRLV.MsToTime(((breakAfterTime + breakLength) - getTimeRunning), Time_Bare));
    Sleep(5000);
    ClearDebug;
  end;
  randomBreakTime;
end;

procedure setup();
begin
 // Aerolib dependant objects
 // tCol.create(2042682, 40, 0.01, 0.01);// duel arena
 // tCol.create(605521, 10, 0.01, 0.01);//  edgeville
 // al kharid pass tCol.create(1647407, 50, 0.01, 0.01);
 // castle wars
 // TMS.create('Chest', ['Use Bank chest', 'Bank chest'],[createCol(5921377, 100, 0.01, 0.01)],[createCol(1976375, 100, 0.01, 0.01)]);

DTM_CastleWarsRing := DTMFromString('mQwAAAHicY2ZgYJjGxMAwBYjnAPETIP81ED8E4ken1cFYeo4CAx4AAIegCP8=');
DTM_RingOfRecoil := DTMFromString('mQwAAAHicY2ZgYMhlYmDIBuIiIH4C5L8F4odA/PKiOsP1g8oM0gqLGfAAAGpZCIA=');
DTM_SaphireRing  := DTMFromString('mQwAAAHicY2ZgYOgC4m4gbgXiRCDOAuI4IP75QIvh9WUtBmWt4wx4AABExgfG');
DTM_CosmicRune := DTMFromString('mWAAAAHicY2FgYJjExMAwHYhnA/E8IH4KFHsOxC+h+OljdYYZE/rB9MLp0xmIAQDsZQ1x=');
DTM_BankFirstTab := DTMFromString('mQwAAAHicY2ZgYAgA4hggdgZiGyD2BmIPIM6O82bwsDMGYzwAALWoBEg=');
DTM_ActiveMageTab := DTMFromString('mQwAAAHicY2ZgYHjGxMBwD4jfAvF2IH8jEB8G4lk5JgylGnIMNqICDHgAAFqUBzw=');
DTM_ActiveInvTab := DTMFromString('mQwAAAHicY2ZgYGhhYmCoAOIeIN4B5K8H4hNAXOUhwVCqIcegzMPFgAcAAAPCBY8=');
DTM_WorldMap := DTMFromString('mQwAAAHicY2ZgYLjOxMBwE4jvAHErkF8PxG1A3HP1JUN3XwCDgaMoAxcDBMBoJAAAeWAIbQ==');
CastleWarsBankColor := 3951971;
declarePlayers();
randomBreakTime();
end;

function getState(): Integer;
begin
//LogoutWhenOutOfItems
if (NeedMoreItems) then
begin
exit(6);
end
// breakhandler
if (GetTimeRunning >= breakAfterTime) then
begin
exit(0);
end
// Loginhandler
if (not isLoggedIn()) then
begin
exit(1);
end
//antiban
if ((random(0, 2) = 0) and (not (bankscreen.IsOpen()))) then
begin
exit(2);
end
//enchatmainroutine
if ((findDTM(DTM_SaphireRing, x, y, MIX1,MIY1,MIX2,MIY2)) and (findDTM(DTM_CosmicRune, x, y, MIX1,MIY1,MIX2,MIY2)) and not (bankscreen.IsOpen())) then
begin
exit(5);
end
//openbank
if ((SRL.FindColors(TPA,CTS2(CastleWarsBankColor, 100, 0.01, 0.01), MainScreen.GetBounds) > 0) and not (bankscreen.IsOpen())  and not (findDTM(DTM_SaphireRing, x, y, MIX1,MIY1,MIX2,MIY2))) then
begin
exit(3);
end
//withdrawbank
if ((bankscreen.IsOpen()) and not (NeedMoreItems)) then
begin
exit(4);
end
end;

procedure executeState(State: Integer);
begin
case (State) of
 0: breakHandlerCustom();
 1 : Login();
 2 : antiban();
 3 : openbank();
 4 : withdrawbank();
 5 : EnchantMainRoutine();
 6 : LogoutAndTerminate();
 end
 sleep(random(100,300));
end;

begin
   setup();
   repeat
   executeState(getState());
   until (False);
   Free();
end.
