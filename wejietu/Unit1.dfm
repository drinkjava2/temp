object Form1: TForm1
  Left = 1140
  Top = 455
  Width = 226
  Height = 140
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'WeJieTu v1.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 58
    Height = 13
    Caption = 'BMP Folder:'
  end
  object Edit1: TEdit
    Left = 72
    Top = 12
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'e:\pic'
  end
  object Button1: TButton
    Left = 32
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Start!'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 120
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Exit'
    TabOrder = 2
    OnClick = Button2Click
  end
end
