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
//                    微截图 v1.0
////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////
//                        说明
// 程序开发目的: 截取微信聊天记录成一张张JPG图片输出
// 运行环境: Delphi7下调试通过,没用第三方控件,其它版本Delphi也应能通过
// 使用说明：
//1. 打开微信PC版
//2. 运行WeJieTu.exe，在文本框输入它的图片输出目录
//3.调整微信窗口，让它被截图部分和WeJieTu窗口位置重合
//4. 点击WeJieTu窗口上的start键，并在3秒内在微信窗口上点两下
//5. 截图开始，会自动滚屏，以10001.jpg为起始点作为图像名
//6. 滚屏到底后, 手工按Exit键退出
////////////////////////////////////////////////////////////////////////
program WeJieTu;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  pubstr in 'pubstr.pas',
  pubkey in 'pubkey.pas',
  pubImage in 'pubImage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
