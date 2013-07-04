unit uProperts;

interface

uses
  TypInfo;

type
  TProperts = class
  protected
    function GetListNameProperts: string;
    function GetNameField(psText: string): string;
    function GetTypeField(psText: string): string;
    function GetListProperts(PropList: PPropList): Integer; virtual; abstract;
    function GetListInfo(const PropName: string): PPropInfo;  virtual; abstract;
  public
    function GetCdsOleVariant: olevariant;
  end;

implementation

uses
  classes, SysUtils;

{ TProperts }

function TProperts.GetCdsOleVariant: olevariant;
begin

end;

function TProperts.GetListNameProperts: string;
var
  Count, I: Integer;
  List : TPropList;
  Info : PPropInfo;
  lListProperts: TStringList;
begin
  lListProperts := TStringList.Create;
  try
    Count := GetListProperts(@List);

    for I := 0 to Pred(Count) do
    begin
      Info := GetListInfo(List[I]^.Name);
      lListProperts.Add(List[I]^.Name + '|' + Info^.PropType^.Name);
    end;
    Result := lListProperts.CommaText;
  finally
    FreeAndNil(lListProperts)
  end;
end;

function TProperts.GetNameField(psText: string): string;
begin
  result := copy(psText, 1, pos('|', psText));
end;

function TProperts.GetTypeField(psText: string): string;
begin
  result := copy(psText, pos('|', psText), Length(psText));
end;

end.
 