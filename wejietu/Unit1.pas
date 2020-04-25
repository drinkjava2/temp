{
  Copyright 2020 the original author or authors.

   Licensed under the Apache License, Version 2.0 (the "License"); you may not
  use this file except in compliance with the License. You may obtain a copy of
  the License at http://www.apache.org/licenses/LICENSE-2.0 Unless required by
  applicable law or agreed to in writing, software distributed under the
  License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS
  OF ANY KIND, either express or implied. See the License for the specific
  language governing permissions and limitations under the License.

  @author Yong Zhu
  @since 1.0
}
////////////////////////////////////////////////////////////////////////
//                       WeJieTu v1.0
////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////
//                        说明
// 程序开发目的: 截微信图
// 运行环境:     Delphi7下调试通过,没用第三方控件,其它版本Delphi也应能通过
// 使用说明：
//1. 打开微信PC版
//2. 运行WeJieTu.exe，在文本框输入它的图片输出目录
//3.调整微信窗口，让它被截图部分和WeJieTu窗口位置重合
//4. 点击WeJieTu窗口上的start键，并在3秒内在微信窗口上点两下
//5. 截图开始，会自动滚屏，以10001.jpg为起始点作为图像名
//6. 滚屏到底后, 手工按Exit键退出
////////////////////////////////////////////////////////////////////////

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,ExtCtrls,mshtml,
  OleCtrls, SHDocVw,Math;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  //For public call
  procedure hideForm1;
  procedure showform1;
  function getWholeFileName(picNo:string):string;

var
  Form1: TForm1;

   hHook: LongWord;
   xy: TPoint;
implementation
uses pubkey,pubstr,pubimage;

{$R *.dfm}


//===================================================================================================init
procedure hideForm1;
begin
//form1.WindowState:= wsMinimized;  mmm;mmm;mmm;mmm;form1.Visible:=false;
form1.Left:=2000;
form1.Top:=2000;
mmm;mmm;mmm;mmm;mmm;
end;

procedure showform1;
begin
 form1.Left:=screen.Width-form1.Width;
 form1.Top:=0;
end;

function getWholeFileName(picNo:string):string;
begin
 
end; 

var canexit:boolean=false;
procedure TForm1.Button1Click(Sender: TObject); label goout;
var i,j:integer;    wechat: THandle;  lparam:DWORD; x,y:integer;
x1,y1,x2,y2:integer;
begin
x1:=left;
y1:=top;
x2:=left+width;
y2:=top+height;

self.Left:=1100;
button1.Enabled:=false;
caption:='请点两次微信窗口';
for j:=1 to 200 do Application.ProcessMessages;
sleep(3000);
{
wechat :=FindWindow('WeChatMainWndForPC',nil);
 if wechat > 0 Then
 begin
  ShowWindow(wechat, SW_RESTORE);
  SetForeGroundWindow(wechat);
  moveTo(600,70);
  click1;
  sleep(200);
  for j:=1 to 200 do Application.ProcessMessages;
 end;
}
for i:=10000 to 20000 do
 begin
   pubimage.getScreenJPG(x1,y1,x2,y2,edit1.Text+'\'+inttostr(i)+'.jpg');
   for j:=1 to 50 do Application.ProcessMessages;
   sleep(500);
   keybd_event(34,0,0,0);   //pagedown
   keybd_event(34,0,KEYEVENTF_KEYUP,0);
   for j:=1 to 50 do Application.ProcessMessages;
   if(canexit) then goto goout;
   for j:=1 to 50 do Application.ProcessMessages;
 end;
 goout:
  close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     self.Left:=400;
     self.Top:=60;
     self.Height:=680;
     self.Width:= 670;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
canexit:=true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
canexit:=true;
end;

end.

