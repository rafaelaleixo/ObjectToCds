unit uUsuario;

interface

uses
  uProperts, TypInfo, DB;

type
  TUsuario = class(TProperts)
  private
    FId: Integer;
    FNome: string;
      
    function ReturnTypeField(psField: string): TFieldType;
  protected
    function GetListProperts(PropList: PPropList): Integer; override;
    function GetListInfo(const PropName: string): PPropInfo; override;
  public
    function GetCdsOlevariant: OleVariant;
  published
    property Id: integer read FId write FId;
    property Nome: String read FNome write FNome;
  end;

implementation

uses
  classes, SysUtils, dbclient;

{ TUsuario }

function TUsuario.GetListProperts(PropList: PPropList): Integer;
begin
  result := GetPropList(TypeInfo(TUsuario), tkProperties, @PropList);
end;

function TUsuario.GetListInfo(const PropName: string): PPropInfo;
begin
  result := GetPropInfo(TypeInfo(TUsuario), PropName);
end;

function TUsuario.GetCdsOlevariant: OleVariant;
var
  oCds: TClientDataSet;
  oListNameProperts: TStringList;
  nIdx: Integer;
  oFieldType: TFieldType;
  sText: string;
begin
  oCds := TClientDataSet.Create(nil);
  oListNameProperts := TStringList.Create;
  oListNameProperts.CommaText := GetListNameProperts;

  if oListNameProperts.Count = 0 then
    Exit;

  for nIdx := 0 to oListNameProperts.Count -1 do
  begin
    sText := oListNameProperts[nidx];
    oFieldType := ReturnTypeField(GetTypeField(sText));

    with ocds do
    begin
      case oFieldType of
        ftString : FieldDefs.Add(GetNameField(sText), oFieldType, 50, False);
        ftInteger, ftBoolean: FieldDefs.Add(GetNameField(sText), oFieldType);
      end;
    end;
  end;

  ocds.CreateDataSet;

  ocds.Append;
  ocds.FieldByName('id').AsInteger := 1;
  ocds.Post;
end;

function TUsuario.ReturnTypeField(psField: string): TFieldType;
begin
  result := ftUnknown;
  
  if lowerCase(psField) = 'integer' then
    result := ftInteger
  else if lowerCase(psField) = 'string' then
    result := ftString;
end;

end.
