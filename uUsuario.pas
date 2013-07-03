unit uUsuario;

interface

uses
  uProperts, TypInfo;

type
  TUsuario = class(TProperts)
  protected
    function GetListProperts(PropList: PPropList): Integer;
    function GetListInfo(const PropName: string): PPropInfo;
  public
    function GetCdsOlevariant: OleVariant;
  end;

implementation

uses
  classes, SysUtils;

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
begin

end;

end.
 