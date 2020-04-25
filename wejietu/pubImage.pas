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
unit pubImage;
interface
 uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls,
   Forms, Dialogs ,jpeg ,Registry ;

procedure getScreenBMP(LeftPos,TopPos,RightPos,BottomPos:integer;filename:string);
procedure getScreenJPG(LeftPos,TopPos,RightPos,BottomPos:integer;filename:string);
procedure findpic(var smallBMP,bigBMP:tbitmap;var x,y:integer);
procedure findpicAt(var smallBMP,bigBMP:tbitmap;var x,y:integer;No:integer);

procedure getClientJPG(filename:string);
procedure getClientBMP(filename:string);

implementation
uses pubstr;

procedure getScreenBMP(LeftPos,TopPos,RightPos,BottomPos:integer;filename:string);
var
  RectWidth,RectHeight:integer;
  SourceDC,DestDC,Bhandle:integer;
  Bitmap:TBitmap;
begin
  RectWidth:=RightPos-LeftPos;
  RectHeight:=BottomPos-TopPos;
  SourceDC:=CreateDC('DISPLAY','','',nil);
  DestDC:=CreateCompatibleDC(SourceDC);
  Bhandle:=CreateCompatibleBitmap(SourceDC,
  RectWidth,RectHeight);
  SelectObject(DestDC,Bhandle);
  BitBlt(DestDC,0,0,RectWidth,RectHeight,SourceDC, LeftPos,TopPos,SRCCOPY);
  log.Add(inttostr(RectWidth)+','+inttostr(RectHeight)+',');
  Bitmap:=TBitmap.Create;
  try
  Bitmap.Handle:=BHandle;
  Bitmap.SaveToFile(filename);
  finally
  Bitmap.free
  end;
end;

procedure getScreenJPG(LeftPos,TopPos,RightPos,BottomPos:integer;filename:string);
var
  RectWidth,RectHeight:integer;
  SourceDC,DestDC,Bhandle:integer;
  Bitmap:TBitmap;
  MyJpeg: TJpegImage;
  Stream:TMemoryStream;
begin
  MyJpeg:= TJpegImage.Create;
  RectWidth:=RightPos-LeftPos;
  RectHeight:=BottomPos-TopPos;
  SourceDC:=CreateDC('DISPLAY','','',nil);
  DestDC:=CreateCompatibleDC(SourceDC);
  Bhandle:=CreateCompatibleBitmap(SourceDC,
  RectWidth,RectHeight);
  SelectObject(DestDC,Bhandle);
  BitBlt(DestDC,0,0,RectWidth,RectHeight,SourceDC,
  LeftPos,TopPos,SRCCOPY);
  Bitmap:=TBitmap.Create;
  Bitmap.Handle:=BHandle;
  Stream := TMemoryStream.Create;
  Bitmap.SaveToStream(Stream);
  Stream.Free;
  try
    MyJpeg.Assign(Bitmap);
    MyJpeg.CompressionQuality:=80;
    MyJpeg.Compress;
    MyJpeg.SaveToFile(filename);
  finally
    MyJpeg.Free;
    Bitmap.Free;
    DeleteDC(DestDC);
    ReleaseDC(Bhandle,SourceDC);
  end;
end;

procedure getClientJPG(filename:string);
begin
 getScreenJPG(0,0,screen.Width,screen.Height-1,filename);
end;

procedure getClientBMP(filename:string);
begin
 getScreenBMP(0,0,screen.Width,screen.Height-1,filename);
end;

type plong=array[0..1600] of longint;
     PLongArray=^plong;
function equpic(var smallBMP,bigBMP:tbitmap;var i,j:integer;divn:integer):boolean;
var ix,iy:integer;
    sx,sy,bs,by:integer;
begin
result:=false;
 for ix:=0 to (smallbmp.Width-1) div divn  do
 for iy:=0 to (smallbmp.Height-1) div divn do
   begin
       sx:=ix*divn;
       sy:=iy*divn;
       if PLongArray(smallbmp.ScanLine[sy])^[sx]<>PLongArray(bigBMP.ScanLine[j+sy])^[i+sx] then exit;
   end;
result:=true;
end;


     
type randompot=record
     x,y:integer;
     c:longint;
     end;
const topcount=20;
var tops:array[1..topcount] of randompot;



//Fuck! 网上找不到现成的, 花了很多时间
//快速在大图上找小图,No表示要找匹配的第几个,先比前n个特征点,再一个点一个点的比
//返回：
//X,Y为找到的图左上角。
//X=-1表示没找到, -2表示取的小图太简单了,以至于都找不出特征点, 比如取了一大块纯白
procedure findpicAt(var smallBMP,bigBMP:tbitmap;var x,y:integer;No:integer);
 var i,j,k,times:integer; w,h:integer;  equtop10:boolean;  myno:integer;
begin
x:=-1;y:=-1;      myno:=0;
k:=0;   w:=smallbmp.Width;h:=smallbmp.Height;   times:=0;

//start find top n pixels,
repeat
randomize;i:=round(random*(w-3));randomize;j:=round(random*(h-3));
  if (PLongArray(smallbmp.ScanLine[j])^[i]<>PLongArray(smallbmp.ScanLine[j+1])^[i+1]) and
        ( (k=0) or
          ((k>0) and (PLongArray(smallbmp.ScanLine[j])^[i]<> tops[k].c)
          )
        )
  then
       begin
           inc(k);
           tops[k].x:=i;
           tops[k].y:=j;
           tops[k].c:=PLongArray(smallbmp.ScanLine[j])^[i];
       end;
inc(times);
until (k>=topcount) or (times>500000);

if times>500000 then begin x:=-2;exit end;
 for i:=1 to bigbmp.Width-smallbmp.Width do
 for j:=1 to bigbmp.Height-smallbmp.Height do
   begin
       equtop10:=true;
       for k:=1 to topcount do
          begin
             if tops[k].c<> PLongArray(bigbmp.ScanLine[j+tops[k].y])^[i+tops[k].x]
                  then begin equtop10:=false; break; end;
          end;
       if equtop10 then
         if equpic(smallbmp,bigbmp,i,j,40) then
            if equpic(smallbmp,bigbmp,i,j,2) then
               begin
                   inc(myno);
                   if myno=No then
                      begin
                         x:=i;y:=j;exit;
                      end;
               end;
   end;
end;

procedure findpic(var smallBMP,bigBMP:tbitmap;var x,y:integer);
begin
  findpicAt(smallBMP,bigBMP,x,y,1);
end;

//不用了，老的，有点慢，
{
procedure findpicSlowAt(var smallBMP,bigBMP:tbitmap;var x,y:integer;No:integer);
 var i,j,k:integer;myno:integer;
begin
myno:=0;
x:=-1;y:=-1;
 for i:=1 to bigbmp.Width-smallbmp.Width do
 for j:=1 to bigbmp.Height-smallbmp.Height do
   begin
            if equpic(smallbmp,bigbmp,i,j,40) then
            if equpic(smallbmp,bigbmp,i,j,8) then
            if equpic(smallbmp,bigbmp,i,j,2) then
               begin
                   inc(myno);
                   if myno=No then
                      begin
                         x:=i;y:=j;exit;
                      end;
               end;
   end;
end;
}

end.
