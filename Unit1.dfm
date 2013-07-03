object Form1: TForm1
  Left = 330
  Top = 147
  Width = 718
  Height = 247
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TDBGrid
    Left = 0
    Top = 8
    Width = 320
    Height = 120
    DataSource = ds
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 240
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 344
    Top = 16
    Width = 297
    Height = 153
    ItemHeight = 13
    TabOrder = 2
  end
  object Button2: TButton
    Left = 64
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 120
  end
  object ds: TDataSource
    DataSet = cds
    Left = 64
    Top = 120
  end
end
