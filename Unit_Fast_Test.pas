unit Unit_Fast_Test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormTest = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    procedure TestDay(const D:TDateTime);
    procedure TestMonth(const D:TDateTime);
    procedure TestYear(const D:TDateTime);
  public
    { Public declarations }
  end;

var
  FormTest: TFormTest;

implementation

{$R *.dfm}

uses
  System.Diagnostics, Tee.FastDateTime, DateUtils;

function Diff(const ASlow,AFast:Int64):String;
var tmp : Single;
begin
  tmp:=100-(AFast*100/ASlow);

  result:='('+FormatFloat('0.##%',tmp)+' faster)';
end;

const
  TestTimes=5000000;

procedure TFormTest.TestYear(const D:TDateTime);
var t1 : TStopwatch;
    t2,t3 : Int64;
    t : Integer;
    y : Word;
begin
  t1:=TStopwatch.StartNew;

  for t:=1 to TestTimes do
      y:=YearOf(D);

  t2:=t1.ElapsedMilliseconds;

  Memo1.Lines.Add('YearOf: '+t2.ToString+' msec '+y.ToString);

  t1:=TStopwatch.StartNew;

  for t:=1 to TestTimes do
      y:=TFastDateTime.YearOf(D);

  t3:=t1.ElapsedMilliseconds;

  Memo1.Lines.Add('Fast YearOf: '+t3.ToString+' msec '+y.ToString+' '+Diff(t2,t3));
end;

procedure TFormTest.TestMonth(const D:TDateTime);
var t1 : TStopwatch;
    t2, t3 : Int64;
    t : Integer;
    day : Word;
begin
  t1:=TStopwatch.StartNew;

  for t:=1 to TestTimes do
      day:=MonthOf(D);

  t2:=t1.ElapsedMilliseconds;

  Memo1.Lines.Add('MonthOf: '+t2.ToString+' msec '+day.ToString);

  t1:=TStopwatch.StartNew;

  for t:=1 to TestTimes do
      day:=TFastDateTime.MonthOf(D);

  t3:=t1.ElapsedMilliseconds;

  Memo1.Lines.Add('Fast MonthOf: '+t3.ToString+' msec '+day.ToString+' '+Diff(t2,t3));
end;

procedure TFormTest.TestDay(const D:TDateTime);
var t1 : TStopwatch;
    t2,t3 : Int64;
    t : Integer;
    day : Word;
begin
  t1:=TStopwatch.StartNew;

  for t:=1 to TestTimes do
      day:=DayOf(D);

  t2:=t1.ElapsedMilliseconds;

  Memo1.Lines.Add('DayOf: '+t2.ToString+' msec '+day.ToString);

  t1:=TStopwatch.StartNew;

  for t:=1 to TestTimes do
      day:=TFastDateTime.DayOf(D);

  t3:=t1.ElapsedMilliseconds;

  Memo1.Lines.Add('Fast DayOf: '+t3.ToString+' msec '+day.ToString+' '+Diff(t2,t3));
end;

procedure TFormTest.FormCreate(Sender: TObject);
var D : TDateTime;
begin
  D:=Now;
  //D:=EncodeDate(1994,7,1);

  TestYear(D);

  Memo1.Lines.Add('');

  TestMonth(D);

  Memo1.Lines.Add('');

  TestDay(D);
end;

end.
