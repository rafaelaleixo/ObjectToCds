unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, dbclient;

type
  TPropriedades = class
  private
    FId: Integer;
    FNome: string;
  published
    property Id: integer read FId write FId;
    property Nome: String read FNome write FNome;
  end;

  TForm1 = class(TForm)
    cds: TClientDataSet;
    ds: TDataSource;
    grid: TDBGrid;
    Button1: TButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    oPropriedades: TPropriedades;
    procedure CriarFields;
    procedure PreencherFields;
    procedure teste;
    procedure ListComponentProperties(Component: TComponent;
      Strings: TStrings);
    procedure ListarPropertys;
    procedure ConvertObjetoToCds(var PoDados: TPropriedades;
      var PoCds: TClientDataSet);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
TypInfo;
{$R *.DFM}

procedure Tform1.CriarFields;
begin
  if cds.FieldDefs.Count > 0 then
    Exit;

  cds.FieldDefs.add('id', ftInteger,0);
  cds.FieldDefs.add('nome', ftString,50);
  cds.CreateDataSet;
end;

procedure Tform1.PreencherFields;
begin
  if not (cds.State in [dsEdit, dsinsert]) then
    cds.Edit;

  cds.Append;
  cds.FieldByName('id').AsInteger := oPropriedades.id;
  cds.FieldByName('nome').AsString := oPropriedades.nome;
  cds.post;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//  CriarFields;
//  PreencherFields;
//  ListComponentProperties(oPropriedades, ListBox1.Items);
//  ListarPropertys

  oPropriedades.Id := 1;
  oPropriedades.Nome := 'aleixo';

  ConvertObjetoToCds(oPropriedades, cds);
  PreencherFields;
end;

procedure Tform1.teste;
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  oPropriedades := TPropriedades.Create;
end;

procedure TForm1.ListComponentProperties(Component: TComponent; Strings: TStrings);
var
  Count, Size, I: Integer;
  List: PPropList;
  PropInfo: PPropInfo;
  PropOrEvent, PropValue: string;
begin
  Count := GetPropList(Component.ClassInfo, tkAny, nil);
  Size  := Count * SizeOf(Pointer);
  GetMem(List, Size);
  try
    Count := GetPropList(Component.ClassInfo, tkAny, List);
    for I := 0 to Count - 1 do
    begin
      PropInfo := List^[I];
      if PropInfo^.PropType^.Kind in tkMethods then
        PropOrEvent := 'Event'
      else
        PropOrEvent := 'Property';
      PropValue := VarToStr(GetPropValue(Component, PropInfo^.Name));
      Strings.Add(Format('[%s] %s: %s = %s', [PropOrEvent, PropInfo^.Name,
        PropInfo^.PropType^.Name, PropValue]));
    end;
  finally
    FreeMem(List);
  end;
end;


procedure TForm1.ListarPropertys;
var
  Count, I: Integer;
  List : TPropList;
  MinhaClasse : TPropriedades;
  Info : PPropInfo;
begin
  MinhaClasse := TPropriedades.Create;
  Count := GetPropList(TypeInfo(TPropriedades), tkProperties, @List);

  for I := 0 to Pred(Count) do
  begin
    Info := GetPropInfo(TypeInfo(TPropriedades), List[I]^.Name);
    Listbox1.Items.Add(List[I]^.Name + ' : ' + Info^.PropType^.Name);
  end;

  MinhaClasse.Free;
end;


procedure Tform1.ConvertObjetoToCds(var PoDados: TPropriedades; var PoCds: TClientDataSet);
var
  nCount: integer;
  List: TPropList;
  info: PPropInfo;
  i: Integer;
begin
  nCount := GetPropList(TypeInfo(TPropriedades), TkProperties, @List);

  for I:= 0 to pred(nCount) do
  begin
    Info := GetPropInfo(TypeInfo(TPropriedades), List[I]^.Name);

    if LowerCase(Info^.PropType^.Name) = 'string' then
      cds.FieldDefs.add(List[I]^.Name, ftString, 50)
    else
    if LowerCase(Info^.PropType^.Name) = 'integer' then
      cds.FieldDefs.add(List[I]^.Name, ftInteger);


  end;
  cds.CreateDataSet;
end;



end.


end.
