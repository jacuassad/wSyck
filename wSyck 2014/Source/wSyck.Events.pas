unit wSyck.Events;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,
  {wSyck}
  wSyck.Addrs,
  wSyck.Defines,
  wSyck.Basics,
  wSyck.Functions,
  wSyck.Client,
  wSyck.Packet,
  wSyck.Game;

type
  TEvent = class
  private

  public

    constructor Create;

    procedure Erase(I, ItemID : WORD); overload;
    procedure Erase(Items : STRING); overload;
    procedure Buy(NPC : WORD; Slot : BYTE); overload;
    procedure Buy(NPC : WORD; Slot : BYTE; Qtd : INTEGER); overload;
    procedure ClickNPC(NPC : WORD); overload;
    procedure ClickNPC(NPC : WORD; Qtd : INTEGER); overload;
    procedure Sell(NPC : WORD; I : WORD); overload;
    procedure Sell(NPC : WORD; Items : STRING); overload;
    procedure MoveItem(srcSlot, srcType, dstSlot, dstType : BYTE);
    procedure Amount(Item : DWORD); overload;
    procedure Amount(Items : STRING); overload;
    procedure ReAmount(Item : WORD); overload;
    procedure ReAmount(Items : STRING); overload;
  end;

var
  Event : TEvent;

implementation

constructor TEvent.Create;
begin

end;

procedure TEvent.Erase(I, ItemID : WORD);
var
  Packet : TPacket;
begin
  if Game.Online then
  begin
    Packet := TPacket.Create($2E4, $14);
    Packet.Write[12] := I;
    Packet.Write[16] := ItemID;
    Packet.Send(2);
    Delay(200);
    Game.ShowMsg('Erase: [%d][%s] = %d', [
      (I div 15)+1,
      AddZero((I mod 15)+1, 2),
      ItemID
    ]);
  end;
end;

procedure TEvent.Erase(Items : STRING);
var
  I, P, X : INTEGER;
  Item : TSTRINGLIST;
begin
  if Items = 'all' then
  begin
    for X := 1 to Client.Bolsas do
      for I := 1 to 15 do
        if Client.Char.Items[X][I].ID <> 0 then
          Erase(I + ((X-1)*15)-1, Client.Char.Items[X][I].ID);
  end
  else
  begin
    Item := Explode(Items, ' ');
    for X := 1 to Client.Bolsas do
      for I := 1 to 15 do
        for P := 0 to Item.Count-1 do
           if Client.Char.Items[X][I].ID = StrToInt(Item[P]) then
             Erase(I + ((X-1)*15)-1, Client.Char.Items[X][I].ID);
  end;
end;

procedure TEvent.Buy(NPC : WORD; Slot : BYTE);
var
  Packet : TPacket;
  P : INTEGER;
begin
  P := FirstSlotItem(INVENTORY, 0);
  if Game.Online and (NPC >= 0) and (Slot >= 0) and (P <> -1) then
  begin
    Packet := TPacket.Create($379, $18);
    Packet.Write[12] := NPC;
    Packet.Write[14] := Slot;
    Packet.Write[16] := P;
    Packet.Send;
    Delay(100);
    Game.ShowMsg('Buy: [%d][%d] = %d', [NPC, Slot, P]);
  end;
end;

procedure TEvent.Buy(NPC : WORD; Slot : BYTE; Qtd : INTEGER);
var
  i, j : INTEGER;
begin
  if Qtd <= Client.Bolsas*15 then
  begin
    while Qtd > 0 do
    begin
      Buy(NPC, Slot);
      Dec(Qtd);
    end;
  end;
end;

procedure TEvent.ClickNPC(NPC : WORD);
var
  Packet : TPacket;
begin
  if Game.Online and (NPC > 0) then
  begin
    Packet := TPacket.Create($28B, $14);
    Packet.Write[12] := NPC;
    Packet.Send;
    Delay(100);
    Game.ShowMsg('ClickNPC: %d', [NPC]);
  end;
end;

procedure TEvent.ClickNPC(NPC : WORD; Qtd : INTEGER);
begin
  while Qtd > 0 do
  begin
    ClickNPC(NPC);
    Dec(Qtd);
  end;
end;

procedure TEvent.Sell(NPC : WORD; I : WORD);
var
  Packet : TPacket;
begin
  if Game.Online then
  begin
    Packet := TPacket.Create($37A, $14);
    Packet.Write[12] := NPC;
    Packet.Write[14] := INVENTORY;
    Packet.Write[16] := I;
    Packet.Send(2);
    Delay(200);
    Game.ShowMsg('Sell: %d [%d][%d]', [
      NPC,
      (I div 15)+1,
      AddZero((I mod 15)+1, 2)
    ]);
  end;
end;

procedure TEvent.Sell(NPC : WORD; Items : STRING);
var
  I, P, X : INTEGER;
  Item : TSTRINGLIST;
begin
  if Items = 'all' then
  begin
    for X := 1 to Client.Bolsas do
      for I := 1 to 15 do
        if Client.Char.Items[X][I].ID <> 0 then
          Sell(NPC, I + ((X-1)*15)-1);
  end
  else
  begin
    Item := Explode(Items, ' ');
    for X := 1 to Client.Bolsas do
      for I := 1 to 15 do
        for P := 0 to Item.Count-1 do
           if Client.Char.Items[X][I].ID = StrToInt(Item[P]) then
           begin
            if (Client.Char.Items[X][I].Effect[1].ID = 61) and (Client.Char.Items[X][I].Effect[1].Value > 1) then
              continue;
            Sell(NPC, I + ((X-1)*15)-1);
           end;
  end;
end;

procedure TEvent.MoveItem(srcSlot, srcType, dstSlot, dstType : BYTE);
var
  Packet : TPacket;
begin
  if (srcSlot >= 0) and (srcType >= 0) and (dstSlot >= 0) and (dstType >= 0) then
  begin
    Packet := TPacket.Create($376, $14);
    Packet.Write[12] := dstType;
    Packet.Write[13] := dstSlot;
    Packet.Write[14] := srcType;
    Packet.Write[15] := srcSlot;
    Packet.Send;
    Delay(100);
    {Game.ShowMsg('MoveItem [%d][%s] -> [%d][%s]', [
      srcType,
      AddZero(srcSlot, 3),
      dstType,
      AddZero(dstSlot, 3)
    ]);}
  end;
end;


procedure TEvent.Amount(Item : DWORD);
var
  vItem : TItem;
  I, X, vAmount, fItem, faItem : INTEGER;
begin
  if Game.Online then
  begin
    faItem :=  0;
    fItem  := -1;

    for X := 1 to Client.Bolsas do
      for I := 1 to 15 do
      begin
        vItem := Client.Char.Items[X][I];
        if vItem.ID = Item then
        begin
          vAmount := 0;
          if vItem.Effect[1].ID = 61 then vAmount := vItem.Effect[1].Value else
          if vItem.Effect[2].ID = 61 then vAmount := vItem.Effect[2].Value else
          if vItem.Effect[3].ID = 61 then vAmount := vItem.Effect[3].Value;
          if vAmount >= 120 then continue;
          if faItem >= 120 then fItem := -1;

          if fItem = -1 then
          begin
            fItem := I + ((X-1)*15)-1;
            faItem := vAmount;
            continue;
          end;

          faItem := + vAmount;
          if Item = Client.Char.Items[X][I].ID then
            MoveItem(I + ((X-1)*15)-1, INVENTORY, fItem, INVENTORY);
        end;
      end;
      Game.ShowMsg('Amount %d', [Item]);
  end;
end;


procedure TEvent.Amount(Items : STRING);
var
  I : INTEGER;
  Item : TSTRINGLIST;
begin
  Item := Explode(Items, ' ');
  for I := 0 to Item.Count-1 do
    Amount(StrToInt(Item[I]));
end;

procedure TEvent.ReAmount(Item : WORD);
var
  vItem : TITEM;
  I, J, KI, KX, X, vAmount, mv : INTEGER;

  procedure ReAmountPacket(I, ItemID : DWORD);
  var
    Packet : TPacket;
  begin
    if Game.Online then
    begin
      Packet := TPacket.Create($2E5, $18);
      Packet.Write[12] := I;
      Packet.Write[16] := ItemID;
      Packet.Write[20] := INVENTORY;
      Packet.Send;
      Delay(100);
    end;
  end;

begin
  if Game.Online then
  begin
    for X := 1 to Client.Bolsas do
      for I := 1 to 15 do
      begin
        vItem := Client.Char.Items[X][I];
        if vItem.ID = Item then
        begin
          vAmount := 1;
          if vItem.Effect[1].ID = 61 then vAmount := vItem.Effect[1].Value else
          if vItem.Effect[2].ID = 61 then vAmount := vItem.Effect[2].Value else
          if vItem.Effect[3].ID = 61 then vAmount := vItem.Effect[3].Value;
          Dec(vAmount);
          mv := 0;

          for KX := 1 to Client.Bolsas do
            for KI := 1 to 15 do
              if Client.Char.Items[KX][KI].ID = 0 then
                Inc(mv);

          if vAmount > mv then
            Dec(mv)
          else
            mv := vAmount-1;

          for J := 0 to mv  do
            ReAmountPacket(I + ((X-1)*15)-1, Item);
        end;
      end;
    Game.ShowMsg('ReAmount: %d', [Item]);
  end;
end;

procedure TEvent.ReAmount(Items : STRING);
var
  I : INTEGER;
  Item : TSTRINGLIST;
begin
  Item := Explode(Items, ' ');
  for I := 0 to Item.Count-1 do
    ReAmount(StrToInt(Item[I]));
end;

begin
  Event := TEvent.Create;
end.
