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
//                    ΢��ͼ v1.0
////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////
//                        ˵��
// ���򿪷�Ŀ��: ��ȡ΢�������¼��һ����JPGͼƬ���
// ���л���: Delphi7�µ���ͨ��,û�õ������ؼ�,�����汾DelphiҲӦ��ͨ��
// ʹ��˵����
//1. ��΢��PC��
//2. ����WeJieTu.exe�����ı�����������ͼƬ���Ŀ¼
//3.����΢�Ŵ��ڣ���������ͼ���ֺ�WeJieTu����λ���غ�
//4. ���WeJieTu�����ϵ�start��������3������΢�Ŵ����ϵ�����
//5. ��ͼ��ʼ�����Զ���������10001.jpgΪ��ʼ����Ϊͼ����
//6. �������׺�, �ֹ���Exit���˳�
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
