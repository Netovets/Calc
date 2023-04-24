unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, ExtCtrls, LCLType;

type

  CompInfo = record
    index, top, left, width, height, fontsize: integer;
  end;
  complist = array of CompInfo;

  { TForm1 }

  TForm1 = class(TForm)
    Bun_umn: TButton;
    But_1: TButton;
    But_0: TButton;
    But_umn: TButton;
    But_minus: TButton;
    But_plus: TButton;
    But_ravno: TButton;
    But_zap: TButton;
    But_del: TButton;
    But_sqrt: TButton;
    But_qrt: TButton;
    But_2: TButton;
    But_proz: TButton;
    But_delit: TButton;
    But_deloper: TButton;
    But_delvse: TButton;
    But_3: TButton;
    But_4: TButton;
    But_5: TButton;
    But_6: TButton;
    But_7: TButton;
    But_8: TButton;
    But_9: TButton;
    Pole: TEdit;
    Photo: TImage;
    procedure PoleChange(Sender: TObject);
    procedure PoleKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure ButtonSumClick(Sender: TObject);
    procedure ButtonResult(Sender: TObject);
    procedure ButtonSqrt(Sender: TObject);
    procedure ButtonStep(Sender: TObject);
    procedure ButtonProts(Sender: TObject);
    procedure ButtonDel(Sender: TObject);
    procedure ButtonSterdel(Sender: TObject);
    procedure ButtonClear(Sender: TObject);
    procedure ButtonZap(Sender: TObject);
    procedure PhotoClick(Sender: TObject);
  private
    { private declarations }
    DefWidth,defHeight:integer;
    clist:complist;
  public
    { public declarations }

  end;

var
  Form1: TForm1;
  num1, num2, result, a: real;
  sign: string;

implementation
uses math;
{$R *.lfm}
{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
begin
  defwidth := width;
  defheight := height;
  for i := 0 to ComponentCount-1 do
    if (Components[i].Classname = 'TRadioButton')
    or (Components[i].Classname ='TCheckBox')
    or (Components[i].Classname ='TButton')
    or (Components[i].Classname ='TEdit')
    or (Components[i].Classname ='TSpinEdit')
    or (Components[i].Classname ='TLabel') then begin
      setlength(clist,Length(clist)+1);
      clist[Length(clist)-1].top := (Components[i] as tcontrol).top;
      clist[Length(clist)-1].left := (Components[i]as tcontrol).left;
      clist[Length(clist)-1].width := (Components[i] as tcontrol).width;
      clist[Length(clist)-1].height := (Components[i]as tcontrol).height;
      clist[Length(clist)-1].fontsize := (Components[i]as tcontrol).font.Size;
      clist[Length(clist)-1].index := i;
    end;
end;



procedure TForm1.FormResize(Sender: TObject);
var i: integer;
begin
  For i:=0 to length(clist)-1 do begin
    (components[clist[i].index] as tcontrol).Top := round(clist[i].top * height/defheight);
    (components[clist[i].index] as tcontrol).height := round(clist[i].height * height/defheight);
    (components[clist[i].index] as tcontrol).left := round(clist[i].left * width/defwidth);
    (components[clist[i].index] as tcontrol).width := round(clist[i].width * width/defwidth);
    (components[clist[i].index] as tcontrol).font.Size := round(clist[i].fontsize * min(width/defwidth, height/defheight));
  end;
end;

procedure TForm1.ButtonClick(Sender: TObject);
begin
  if (Pole.Text = '0') then Pole.Text := (Sender as TButton).Caption
  else Pole.Text := Pole.Text + (Sender as TButton).Caption;
end;

procedure TForm1.ButtonSumClick(Sender: TObject);
begin
  if Pole.Text <> '' then
  begin
    num1 := StrToFloat(Pole.Text);
    Pole.Clear;
    sign := (Sender as TButton).Caption;
  end;
end;

procedure TForm1.ButtonResult(Sender: TObject);
begin
  if Pole.Text <> '' then
  begin
    num2 := StrToFloat(Pole.Text);
    Pole.Clear;
      case sign of
        '+': result := num1 + num2;
        '-': result := num1 - num2;
        '*': result := num1 * num2;
        '/': if num2 <> 0 then
        result := num1 / num2
        else ShowMessage('Нельзя делить на 0')
      end;
    Pole.Text := FloatToStr(result);
  end;
end;

procedure TForm1.ButtonSqrt(Sender: TObject);
begin
  if Pole.Text <> '' then
  begin
    num1 := strtofloat(Pole.Text);
    if num1 > 0 then
    num1 := sqrt(num1);
    Pole.Text := floattostr(num1);
  end;
end;

procedure TForm1.ButtonStep(Sender: TObject);
begin
  if Pole.Text <> '' then
  begin
    num1 := strtofloat(Pole.Text);
    num1 := sqr(num1);
    Pole.Text := floattostr(num1);
  end;
end;

procedure TForm1.ButtonProts(Sender: TObject);
begin
  if Pole.Text <> '' then
  begin
    num2 := strtofloat(Pole.Text);
    result := num1 / 100 * num2;
    Pole.Text := floattostr(result);
  end;
end;

procedure TForm1.ButtonDel(Sender: TObject);
var l: integer;
    s: string;
begin
    s := Pole.Text;
    l := length(s);
    delete(s,l,1);
    Pole.Text := s;
end;

procedure TForm1.ButtonSterdel(Sender: TObject);
begin
  Pole.Clear;
  num1 := 0;
  num2 := 0;
  result := 0;
end;

procedure TForm1.ButtonClear(Sender: TObject);
begin
  Pole.Clear;
end;

procedure TForm1.ButtonZap(Sender: TObject);
begin
  if (pos(',', Pole.Text) = 0) and (Pole.Text <> '') then
  Pole.Text := Pole.Text + (Sender as TButton).Caption;
end;

procedure TForm1.PhotoClick(Sender: TObject);
begin

end;

procedure TForm1.PoleChange(Sender: TObject);
begin
    Pole.Maxlength := 16;
end;

procedure TForm1.PoleKeyPress(Sender: TObject; var Key: char);
var
   simvol: set of char;
begin
  simvol := ['0'..'9'];
  if ord(key) = 13 then Pole.SetFocus;
  if not (key in simvol)and (ord(key)<>8) then key := chr(0);
end;

end.

