unit ucom;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils, graphics;

function ReverseNum(dat: byte): byte;
function ReverseByte(dat: byte): byte;
function ReverseWord(dat: Word): Word;
procedure ExtractRGB(Color: TColor;var R,G,B:Byte);

implementation

function ReverseNum(dat: byte): byte;
const
  RevTable: array[0..15] of byte =
    ($0, $8, $4, $C, $2, $A, $6, $E, $1, $9, $5, $D, $3, $B, $7, $F);
begin
  if dat < 16 then
    Result := RevTable[dat]
  else
    Result := 0;
end;

function ReverseByte(dat: byte): byte;
begin
  Result := ReverseNum(dat div 16) + ReverseNum(dat mod 16) * 16;
end;

function ReverseWord(dat: Word): Word;
begin
  Result := ReverseByte(dat div 256) + Word(ReverseByte(dat mod 256)) * 256;
end;

procedure ExtractRGB(Color: TColor;var R,G,B:Byte);
begin
  R := Color and $FF;
  G := (Color and $FF00) shr 8;
  B := (Color and $FF0000) shr 16;
end;

end.
