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
unit pubkey;


interface
   uses
  strutils, DateUtils,DdeMan,shellapi, ExtCtrls,Clipbrd,Windows,SysUtils,forms,Classes,Dialogs,

     Messages,Graphics, Controls,
  jpeg ,Registry ;


procedure openIE(txt:string;handle:HWND);
procedure writekeys(s:string);
procedure moveTo(x,y:integer);
procedure clickAt(x,y:integer);
procedure click1;
procedure click2;
procedure return;
procedure waitfor(bmpFileName:string);

//below is new
procedure clickAtBMP(bmpFileName:string);



 var   mousex,mousey:integer; 
implementation
  uses pubstr,pubimage,unit1;
var dde:TDdeClientConv;
 testName:String;


procedure openIE(txt:string;handle:HWND);
begin
//调用ShellExecute打开默认浏览器，将窗口模式设为SW_SHOWNORMAL
try
ShellExecute(Handle,nil,PChar(txt),nil,nil,SW_SHOWNORMAL);
except
end;
end;

procedure writekeys(s:string);
var b:byte;   King:thandle; 
    i:integer;
begin
s:=uppercase(s);
s:=rp(s,'.',char(VK_DECIMAL));
s:=rp(s,'/',char(VK_DIVIDE));
s:=rp(s,'-',char(VK_SUBTRACT));
s:=rp(s,':',char(186));

     for i:=1 to length(S) do
     begin
      b:=byte(s[i]);
      keybd_event(b, MapVirtualKey(b, 0), 0, 0);
      keybd_event(b, MapVirtualKey(b, 0), KEYEVENTF_KEYUP, 0);
     end;
     slep(1000);
 {
    //模拟Ctrl+C复制的操作方法
    keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), 0, 0);
    keybd_event(Ord('C'), MapVirtualKey(Ord('C'), 0), 0, 0);
    keybd_event(Ord('C'), MapVirtualKey(Ord('C'), 0), KEYEVENTF_KEYUP, 0);
    keybd_event(VK_CONTROL, MapVirtualKey(VK_CONTROL, 0), KEYEVENTF_KEYUP, 0);}
end;


procedure moveTo(x,y:integer);
begin
 setcursorpos(x,y);
end;

procedure clickAt(x,y:integer);
begin
setcursorpos(x,y);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
setcursorpos(1023,767);
mmm;sleep(1000);
end;


procedure clickAtBMP(bmpFileName:string);
var small,big:Tbitmap;x,y:integer;
begin
try
  small:=tbitmap.Create;
  big:=tbitmap.create;
  small.LoadFromFile(Unit1.getWholeFileName(bmpFileName));
  pubimage.getClientBMP('c:\big.bmp'); //只会用硬盘缓存一下，本人很笨，也很懒
  big.LoadFromFile('c:\big.bmp');
  pubimage.findpic(small,big,x,y);
if x=-1 then raise ematherror.Create('Not found pic:'+bmpFileName);
mousex:=x+small.Width div 2;mousey:= y+small.Height div 2;
setcursorpos(mousex,mousey);
click1;
setcursorpos(1023,767);
mmm;sleep(1000);
finally
  small.free;big.Free;
end;
end;

procedure click1;
begin
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
end;

procedure click2;
begin
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
end;

procedure return;
begin
writekeys(#13#10);
end;

procedure waitfor(bmpFileName:string);
var small,big:Tbitmap;x,y:integer;
begin
try
  small:=tbitmap.Create;
  big:=tbitmap.create;
  small.LoadFromFile(Unit1.getWholeFileName(bmpFileName));
  pubimage.getClientBMP('c:\big.bmp'); 
  big.LoadFromFile('c:\big.bmp');
  pubimage.findpic(small,big,x,y);
if x=-1 then raise ematherror.Create('Not found pic:'+bmpFileName);
finally
  small.free;big.Free;
end;
end;


end.
