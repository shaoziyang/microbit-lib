unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterPython, SynEdit, Forms, Controls,
  Graphics, Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, LCLIntf,
  Spin, ExtDlgs, EditBtn, Types, FastIniFile, ucom;

const
  NEOPIXEL16x16_MAX_TEXTWIDTH = 2048;
  NEOPIXEL16x16_MAX_IMAGEWIDTH = 64;

  VERSION = '1.0.0';

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnColorNeopixel_16x16: TColorButton;
    btnMakeNeopixel_16x16_Img: TSpeedButton;
    btnImageFontNeopixel_16x16: TSpeedButton;
    btnMakeNeopixel_strip: TSpeedButton;
    cbbPinNeopixel: TComboBox;
    dlgFont: TFontDialog;
    dlgFontTextNeopixel_16x16: TFontDialog;
    dlgSaveImg: TSavePictureDialog;
    EdtBrightnessNeopixel: TSpinEdit;
    edtMakeNeopixel_16x16_Img: TSynEdit;
    edtMakeNeopixel_strip: TSynEdit;
    edtTextNeopixel_16x16: TEdit;
    edtFileNameNeopixel_16x16_Img: TFileNameEdit;
    rbNeopixelStripEffect: TRadioGroup;
    Image1: TImage;
    Image2: TImage;
    imgNeopixel_16x16_Img: TImage;
    imgSrcNeopixel_16x16: TImage;
    imgNeopixel_16x16: TImage;
    ImageListToolBar: TImageList;
    dlgOpenImg: TOpenPictureDialog;
    imgSrcNeopixel_16x16_Img: TImage;
    lbWarnNeopixel_16x16_img: TLabel;
    lbLenNeopixel_16x16: TLabel;
    lbLenNeopixel_16x16_Img: TLabel;
    lbTPNeopixel_16x16: TListBox;
    lbTPNeopixel_16x16_Img: TListBox;
    Panel4: TPanel;
    Panel5: TPanel;
    pnlBrightnessNeopixel: TPanel;
    pnlPinNeopixel: TPanel;
    pnlCountNeopixel: TPanel;
    Panel3: TPanel;
    pgctMain: TPageControl;
    pgctNeopixel: TPageControl;
    ScrollBox1: TScrollBox;
    EdtCountNeopixel: TSpinEdit;
    edtMakeNeopixel_16x16: TSynEdit;
    btnTextFontNeopixel_16x16: TSpeedButton;
    btnMakeNeopixel_16x16: TSpeedButton;
    ScrollBox2: TScrollBox;
    SynPythonSyn: TSynPythonSyn;
    ToolButton5: TToolButton;
    TrackBarBrightnessNeopixel: TTrackBar;
    tsNeopixel_16x16_Img: TTabSheet;
    tmrInit: TTimer;
    ToolButton4: TToolButton;
    tsNeopixel: TTabSheet;
    tsNeopixel_16x16: TTabSheet;
    tsNeopixel_Strip: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    tbNeopixel: TToolBar;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    UpDown1: TUpDown;
    procedure btnColorNeopixel_16x16ColorChanged(Sender: TObject);
    procedure btnImageFontNeopixel_16x16Click(Sender: TObject);
    procedure btnMakeNeopixel_16x16Click(Sender: TObject);
    procedure btnMakeNeopixel_16x16_ImgClick(Sender: TObject);
    procedure btnMakeNeopixel_stripClick(Sender: TObject);
    procedure btnTextFontNeopixel_16x16Click(Sender: TObject);
    procedure EdtBrightnessNeopixelChange(Sender: TObject);
    procedure edtTextNeopixel_16x16Change(Sender: TObject);
    procedure edtFileNameNeopixel_16x16_ImgAcceptFileName(Sender: TObject;
      var Value: string);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgNeopixel_16x16Click(Sender: TObject);
    procedure tmrInitTimer(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure TrackBarBrightnessNeopixelChange(Sender: TObject);
  private
    procedure TextImageNoepixel_16x16(Sender: TObject);
    procedure redrawNeopixel_16x16(Sender: TObject);
  public

  end;

var
  frmMain: TfrmMain;
  ini: TFastIniFile;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  ini := TFastIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  BoundsRect := ini.ReadRect('Last', 'Postion', BoundsRect);

end;

procedure TfrmMain.imgNeopixel_16x16Click(Sender: TObject);
begin
  if dlgSaveImg.Execute then
    imgSrcNeopixel_16x16.Picture.SaveToFile(dlgSaveImg.FileName);
end;

procedure TfrmMain.tmrInitTimer(Sender: TObject);
begin
  tmrInit.Enabled := False;

  pgctMain.ActivePageIndex := ini.ReadInteger('Last', 'Page', 0);
  pgctNeopixel.ActivePageIndex := ini.ReadInteger('Neopixel', 'Page', 1);

  // Neopixel
  cbbPinNeopixel.ItemIndex := ini.ReadInteger('Neopixel', 'Pin', 1);
  EdtCountNeopixel.Value := ini.ReadInteger('Neopixel', 'Count', 8);
  EdtBrightnessNeopixel.Value := ini.ReadInteger('Neopixel', 'Brightness', 32);

  // NeoPixel 16x16
  imgNeopixel_16x16.Width := NEOPIXEL16x16_MAX_TEXTWIDTH;
  imgNeopixel_16x16.Canvas.Brush.Color := 0;
  imgNeopixel_16x16.Canvas.Clear;

  dlgFontTextNeopixel_16x16.Font :=
    ini.ReadFont('Neopixel', '16x16', dlgFontTextNeopixel_16x16.Font);
  edtTextNeopixel_16x16.Text := ini.ReadString('Neopixel', '16x16_Text', '');

  imgSrcNeopixel_16x16.Width := NEOPIXEL16x16_MAX_TEXTWIDTH div 4;
  btnColorNeopixel_16x16.ButtonColor := dlgFontTextNeopixel_16x16.Font.Color;

end;

procedure TfrmMain.ToolButton3Click(Sender: TObject);
begin
  OpenURL('http://microbit.site');
end;

procedure TfrmMain.ToolButton5Click(Sender: TObject);
begin
  OpenURL('http://www.micropython.org.cn');
end;

procedure TfrmMain.TrackBarBrightnessNeopixelChange(Sender: TObject);
begin
  EdtBrightnessNeopixel.Value := TrackBarBrightnessNeopixel.Position;
end;

procedure TfrmMain.TextImageNoepixel_16x16(Sender: TObject);
begin
  imgSrcNeopixel_16x16.Canvas.Brush.Color := 0;
  imgSrcNeopixel_16x16.Canvas.Clear;
  imgSrcNeopixel_16x16.Canvas.Font := dlgFontTextNeopixel_16x16.Font;
  imgSrcNeopixel_16x16.Canvas.TextOut(0, 0, edtTextNeopixel_16x16.Text);
end;

procedure TfrmMain.redrawNeopixel_16x16(Sender: TObject);
var
  i, j, w, h: integer;
begin
  imgNeopixel_16x16.Canvas.Brush.Color := 0;
  imgNeopixel_16x16.Canvas.Clear;
  imgNeopixel_16x16.Canvas.Brush.Color := dlgFontTextNeopixel_16x16.Font.Color;
  w := 0;
  for i := 0 to imgSrcNeopixel_16x16.Width - 1 do
    for j := 0 to 15 do
    begin
      if imgSrcNeopixel_16x16.Canvas.Pixels[i, j] <> 0 then
      begin
        imgNeopixel_16x16.Canvas.FillRect(i * 4, j * 4, i * 4 + 4, j * 4 + 4);
        w := i;
      end;
    end;
  lbLenNeopixel_16x16.Tag := w;
  lbLenNeopixel_16x16.Caption := IntToStr(lbLenNeopixel_16x16.Tag) + ' x 16';
  imgNeopixel_16x16.Canvas.Pen.Color := clGray;
  imgNeopixel_16x16.Canvas.Pen.Style := psSolid;
  imgNeopixel_16x16.Canvas.Pen.Width := 1;
  for i := 0 to (2048 div 4) do
    imgNeopixel_16x16.Canvas.Line(i * 4, 0, i * 4, 64);
  for i := 0 to (64 div 4) do
    imgNeopixel_16x16.Canvas.Line(0, i * 4, 2047, i * 4);

end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  try
    ini.WriteRect('Last', 'Postion', BoundsRect);
    ini.WriteInteger('Last', 'Page', pgctMain.ActivePageIndex);
    ini.WriteInteger('Neopixel', 'Page', pgctNeopixel.ActivePageIndex);

    // Neopixel
    ini.WriteInteger('Neopixel', 'Pin', cbbPinNeopixel.ItemIndex);
    ini.WriteInteger('Neopixel', 'Count', EdtCountNeopixel.Value);
    ini.WriteInteger('Neopixel', 'Brightness', EdtBrightnessNeopixel.Value);

    // Neopixel 16x16
    ini.WriteFont('Neopixel', '16x16', dlgFontTextNeopixel_16x16.Font);
    ini.WriteString('Neopixel', '16x16_Text', edtTextNeopixel_16x16.Text);
  finally
    ini.Free;
  end;
end;

// new input Text
procedure TfrmMain.edtTextNeopixel_16x16Change(Sender: TObject);
begin
  edtTextNeopixel_16x16.Tag := 0;
  TextImageNoepixel_16x16(Sender);
  redrawNeopixel_16x16(Sender);
end;

procedure TfrmMain.edtFileNameNeopixel_16x16_ImgAcceptFileName(Sender: TObject;
  var Value: string);
var
  w, h: integer;
begin
  try
    lbLenNeopixel_16x16_Img.Caption := '';
    imgSrcNeopixel_16x16_Img.Stretch := False;
    imgSrcNeopixel_16x16_Img.Picture.LoadFromFile(Value);
    w := imgSrcNeopixel_16x16_Img.Picture.Width;
    h := imgSrcNeopixel_16x16_Img.Picture.Height;
    imgSrcNeopixel_16x16_Img.Stretch := True;
    imgSrcNeopixel_16x16_Img.Height := 16;
    imgSrcNeopixel_16x16_Img.Width := w * 16 div h;
    lbLenNeopixel_16x16_Img.Caption :=
      Format('%d x 16', [imgSrcNeopixel_16x16_Img.Width]);
    lbLenNeopixel_16x16_Img.Tag := imgSrcNeopixel_16x16_Img.Width;
    imgNeopixel_16x16_Img.Width := imgSrcNeopixel_16x16_Img.Width * 4;
    imgNeopixel_16x16_Img.Picture := imgSrcNeopixel_16x16_Img.Picture;
  except

  end;
end;

// select display Font
procedure TfrmMain.btnTextFontNeopixel_16x16Click(Sender: TObject);
begin
  if dlgFontTextNeopixel_16x16.Execute then
  begin
    if edtTextNeopixel_16x16.Tag = 0 then
      TextImageNoepixel_16x16(Sender);
    redrawNeopixel_16x16(Sender);
    btnColorNeopixel_16x16.ButtonColor := dlgFontTextNeopixel_16x16.Font.Color;
  end;
end;

procedure TfrmMain.EdtBrightnessNeopixelChange(Sender: TObject);
begin
  TrackBarBrightnessNeopixel.Position := EdtBrightnessNeopixel.Value;
end;

// create Text/image list
procedure TfrmMain.btnMakeNeopixel_16x16Click(Sender: TObject);
var
  i, j, w: integer;
  r, g, b: byte;
  n: word;
  s: string;
begin
  if edtTextNeopixel_16x16.Text = '' then
    Exit;

  edtMakeNeopixel_16x16.Clear;
  edtMakeNeopixel_16x16.Lines := lbTPNeopixel_16x16.Items;
  edtMakeNeopixel_16x16.Lines.Append('npdat=[');
  w := lbLenNeopixel_16x16.Tag;
  s := '';
  for i := 0 to w do
  begin
    n := 0;
    for j := 0 to 15 do
    begin
      if imgSrcNeopixel_16x16.Canvas.Pixels[i, j] <> 0 then
        n := n + (1 shl j);
    end;
    if (i mod 2) = 1 then
      n := ReverseWord(n);
    s := s + '0x' + IntToHex(n, 4) + ',';
    if (i mod 8) = 7 then
    begin
      edtMakeNeopixel_16x16.Lines.Append(s);
      s := '';
    end;
  end;
  edtMakeNeopixel_16x16.Lines.Append(s + ']');
  edtMakeNeopixel_16x16.Lines.Append('');
  edtMakeNeopixel_16x16.Lines.Append('ne = neo16x16(' + cbbPinNeopixel.Text + ')');
  ExtractRGB(dlgFontTextNeopixel_16x16.Font.Color, r, g, b);
  r := r * EdtBrightnessNeopixel.Value div 256;
  g := g * EdtBrightnessNeopixel.Value div 256;
  b := b * EdtBrightnessNeopixel.Value div 256;
  edtMakeNeopixel_16x16.Lines.Append('ne.setcolor((' + IntToStr(r) +
    ',' + IntToStr(g) + ',' + IntToStr(b) + '))');
  if (w > 16) then
  begin
    edtMakeNeopixel_16x16.Lines.Append('n = 0');
    edtMakeNeopixel_16x16.Lines.Append('while True:');
    edtMakeNeopixel_16x16.Lines.Append('    ne.show(npdat, n)');
    edtMakeNeopixel_16x16.Lines.Append('    n = (n+1)%' + IntToStr(w - 8));
    edtMakeNeopixel_16x16.Lines.Append('    _delay(100)');
  end
  else
    edtMakeNeopixel_16x16.Lines.Append('ne.show(npdat)');

  edtMakeNeopixel_16x16.Lines.Append('');
  edtMakeNeopixel_16x16.SelectAll;
  edtMakeNeopixel_16x16.CopyToClipboard;
  edtMakeNeopixel_16x16.SelEnd := 0;
end;

procedure TfrmMain.btnMakeNeopixel_16x16_ImgClick(Sender: TObject);
var
  i, j: integer;
  r1, g1, b1: byte;
  r2, g2, b2: byte;
  c1, c2: TColor;
  s: string;
begin
  if lbLenNeopixel_16x16_Img.Tag = 0 then
    Exit;

  edtMakeNeopixel_16x16_Img.Clear;
  edtMakeNeopixel_16x16_Img.Lines := lbTPNeopixel_16x16_Img.Items;

  edtMakeNeopixel_16x16_Img.Lines.Append('npdat=[');
  s := '';
  for i := 0 to imgSrcNeopixel_16x16_Img.Width - 1 do
  begin
    for j := 0 to 7 do
    begin
      if (i mod 2) = 1 then
      begin
        c1 := imgSrcNeopixel_16x16_Img.Canvas.Pixels[i, j * 2];
        c2 := imgSrcNeopixel_16x16_Img.Canvas.Pixels[i, j * 2 + 1];
      end
      else
      begin
        c1 := imgSrcNeopixel_16x16_Img.Canvas.Pixels[i, 15 - j * 2];
        c2 := imgSrcNeopixel_16x16_Img.Canvas.Pixels[i, 15 - j * 2 - 1];
      end;
      ExtractRGB(c1, r1, g1, b1);
      r1 := r1 shr 4;
      g1 := g1 shr 4;
      b1 := b1 shr 4;
      ExtractRGB(c2, r2, g2, b2);
      r2 := r2 shr 4;
      g2 := g2 shr 4;
      b2 := b2 shr 4;
      s := s + Format('0x%.X%.X%.X%.X%.X%.X, ', [b2, g2, r2, b1, g1, r1]);
      if (j mod 4) = 3 then
      begin
        edtMakeNeopixel_16x16_Img.Lines.Append(s);
        s := '';
      end;
    end;
  end;
  edtMakeNeopixel_16x16_Img.Lines.Append(']');
  edtMakeNeopixel_16x16_Img.Lines.Append('');
  edtMakeNeopixel_16x16_Img.Lines.Append('ne = neo16x16_img(' +
    cbbPinNeopixel.Text + ')');
  if (imgSrcNeopixel_16x16_Img.Width > 16) then
  begin
    edtMakeNeopixel_16x16_Img.Lines.Append('n = 0');
    edtMakeNeopixel_16x16_Img.Lines.Append('while True:');
    edtMakeNeopixel_16x16_Img.Lines.Append('    ne.show(npdat, n)');
    edtMakeNeopixel_16x16_Img.Lines.Append('    n = (n+16)%' +
      IntToStr(imgSrcNeopixel_16x16_Img.Width));
    edtMakeNeopixel_16x16_Img.Lines.Append('    _delay(15000)');
  end
  else
    edtMakeNeopixel_16x16_Img.Lines.Append('ne.show(npdat)');

  edtMakeNeopixel_16x16_Img.Lines.Append('');
  edtMakeNeopixel_16x16_Img.SelectAll;
  edtMakeNeopixel_16x16_Img.CopyToClipboard;
  edtMakeNeopixel_16x16_Img.SelEnd := 0;
end;

procedure TfrmMain.btnMakeNeopixel_stripClick(Sender: TObject);
var
  s: string;
  r, g, b: byte;
  i, n: integer;
begin
  edtMakeNeopixel_strip.Clear;
  edtMakeNeopixel_strip.Lines.Append('from microbit import *');
  edtMakeNeopixel_strip.Lines.Append('import neopixel');
  edtMakeNeopixel_strip.Lines.Append('');
  edtMakeNeopixel_strip.Lines.Append('np = neopixel.NeoPixel(' +
    cbbPinNeopixel.Text + ' ,' + EdtCountNeopixel.Text + ')');
  edtMakeNeopixel_strip.Lines.Append('');

  s := '';
  case rbNeopixelStripEffect.ItemIndex of
    0://rainbow
    begin
      edtMakeNeopixel_strip.Lines.Append(
        'def np_rainbow(np, num, bright=32, offset = 0):');
      edtMakeNeopixel_strip.Lines.Append(
        '    rb = ((255,0,0), (255,127,0), (255,255,0), (0,255,0), (0,255,255),(0,0,255),(136,0,255), (255,0,0))');
      edtMakeNeopixel_strip.Lines.Append('    for i in range(num):');
      edtMakeNeopixel_strip.Lines.Append('        t = 7*i/num');
      edtMakeNeopixel_strip.Lines.Append('        t0 = int(t)');
      edtMakeNeopixel_strip.Lines.Append(
        '        r = round((rb[t0][0] + (t-t0)*(rb[t0+1][0]-rb[t0][0]))*bright)>>8');
      edtMakeNeopixel_strip.Lines.Append(
        '        g = round((rb[t0][1] + (t-t0)*(rb[t0+1][1]-rb[t0][1]))*bright)>>8');
      edtMakeNeopixel_strip.Lines.Append(
        '        b = round((rb[t0][2] + (t-t0)*(rb[t0+1][2]-rb[t0][2]))*bright)>>8');
      edtMakeNeopixel_strip.Lines.Append('        np[(i+offset)%num] = (r, g, b)');
      edtMakeNeopixel_strip.Lines.Append('');
      edtMakeNeopixel_strip.Lines.Append('np_rainbow(np, ' + IntToStr(
        EdtCountNeopixel.Value) + ', bright=' + IntToStr(EdtBrightnessNeopixel.Value) +
        ', offset=0)');
      edtMakeNeopixel_strip.Lines.Append('np.show()');
    end;
    1:
    begin
    end;
    2:
    begin
    end;
    3:
    begin
    end;
    4:
    begin
    end;
  end;

  // copy to clipboard
  edtMakeNeopixel_strip.Lines.Append('');
  edtMakeNeopixel_strip.SelectAll;
  edtMakeNeopixel_strip.CopyToClipboard;
  edtMakeNeopixel_strip.SelEnd := 0;
end;

procedure TfrmMain.btnColorNeopixel_16x16ColorChanged(Sender: TObject);
begin
  dlgFontTextNeopixel_16x16.Font.Color := btnColorNeopixel_16x16.ButtonColor;
  redrawNeopixel_16x16(Sender);
end;

procedure TfrmMain.btnImageFontNeopixel_16x16Click(Sender: TObject);
var
  w, h, i, j: integer;
begin
  if dlgOpenImg.Execute then
  begin
    imgSrcNeopixel_16x16.Stretch := False;
    imgSrcNeopixel_16x16.Picture.LoadFromFile(dlgOpenImg.FileName);
    w := imgSrcNeopixel_16x16.Picture.Width;
    h := imgSrcNeopixel_16x16.Picture.Height;
    imgSrcNeopixel_16x16.Stretch := True;
    imgSrcNeopixel_16x16.Height := 16;
    imgSrcNeopixel_16x16.Width := w * 16 div h;
    redrawNeopixel_16x16(Sender);
    edtTextNeopixel_16x16.Tag := 1;
  end;
end;

end.
