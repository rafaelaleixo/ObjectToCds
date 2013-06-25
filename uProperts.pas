unit uProperts;

interface

uses
  TypInfo;

type
  TProperts = class
  private
    function GetListNameProperts: string;
  protected
    function GetListProperts(PropList: PPropList): Integer; virtual; abstract;
    function GetListInfo(const PropName: string): PPropInfo;  virtual; abstract;
  end;

implementation

uses
  classes, SysUtils;

{ TProperts }

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


end.
 