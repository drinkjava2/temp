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
unit pubstr;

interface
uses strutils, DateUtils,DdeMan,shellapi, ExtCtrls,Clipbrd,Windows,SysUtils,forms,Classes,
dialogs,StdCtrls;

  function rp(s,olds,news:string):string;
  function rep(s,olds,news:string):string;
  function reps(s,olds,news:string):string;
  procedure tell(s:string);
  procedure mmm;
  procedure slep(seconds:integer);
  procedure callButton(fm:tform;captionTxt:String); //根据button标题来call它
  function reads(filenames,s:string):string;
  procedure writes(filenames:string;var s:string);
  procedure tellLog;
  procedure writeLogFile(filename:string);

var log:tstringlist;
implementation

  procedure mmm;
  var i:integer;
  begin
   for i:=1 to 20 do application.ProcessMessages;
   sleep(10);
  end;

  function rp(s,olds,news:string):string; //为什么要这么多rp, rep, reps? 我不告诉你
  begin
  result:=stringreplace(s,olds,news,[rfReplaceAll]);
  end;

  function rep(s,olds,news:string):string;
  begin
  result:=stringreplace(s,olds,news,[rfReplaceAll]);
  end;

  function reps(s,olds,news:string):string;
  begin
  result:=stringreplace(s,olds,news,[rfReplaceAll]);
  end;

  procedure tell(s:string);
    begin
      application.BringToFront;
      showmessage(s)
    end;

      
  procedure slep(seconds:integer);
  var i:integer;
  begin
  for i:=1 to 10 do
  begin
     mmm;
     sleep(seconds div 10);
  end;
 end;


function reads(filenames,s:string):string;
var mm: TMemoryStream;i:integer;ss:string;ch:char;
begin
  mm:= tmemorystream.create;
  ss:='';
  try
    mm.LoadFromFile(FileNames);
    for i:=1 to mm.Size do ss:=ss+' ';
    mm.Position:=0;
    mm.ReadBuffer(ss[1],length(ss));
  finally
    mm.free;
  end;
  result:=ss;
end;

procedure writes(filenames:string;var s:string);
var f:file;
begin
  try
    assignfile(f,filenames);
    rewrite(f,1);
    blockwrite(f,s[1],length(s));
  finally
    try  closefile(f);except end;
  end;
end;

 
 procedure callButton(fm:tform;captionTxt:String);
var 
  i: Integer; 
begin 
  for i:=0 to fm.ComponentCount -1 do
  begin 
    if fm.Components[i] is TButton then
     if TButton(fm.Components[i]).caption = captionTxt then
        TButton(fm.Components[i]).Click;
  end; 
end;

procedure tellLog;
 begin
   tell(log.Text);
 end;

procedure writeLogFile(filename:string);
var stemp:string;
begin
 stemp:=log.Text;
 writes(filename,stemp);
end;

initialization
 log:=tstringlist.Create;
 log.Add('====================Log Begin=====================');
finalization
 log.Add('====================Log End=====================');
 writeLogFile('c:\log.txt');
 log.Free;
end.
