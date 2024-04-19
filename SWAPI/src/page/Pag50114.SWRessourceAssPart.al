namespace SWAPI.SWAPI;

page 50114 SWRessourceAssListPart
{
    ApplicationArea = All;
    Caption = 'Ressource Association Part';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "SW Resource Association";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(AssRessourceID; Rec.AssRessourceID)
                {
                    Caption = 'ID';
                }
                field(AssRessourceName; Rec.AssRessourceName)
                {
                    CaptionClass = g_AssRessourceNameCaption;
                }
                field(AssRessourceValue; Rec.AssRessourceValue)
                {
                    CaptionClass = g_AssRessourceValueCaption;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AddAssociation)
            {
                ApplicationArea = All;
                Caption = 'Add Association';

                trigger OnAction()
                begin
                end;
            }
        }
    }
    var
        g_AssRessourceNameCaption: Text;
        g_AssRessourceValueCaption: Text;

    trigger OnAfterGetCurrRecord()
    begin
        SetCaptions();
    end;

    local procedure SetCaptions()
    var
        l_RecRef: RecordRef;
        l_DBNo: Integer;
        l_FilterGroup: Integer;
    begin
        if not Rec.FindFirst() then
            exit;
        case Rec.AssociatedResourceType of
            "SW Resource Types"::films:
                l_DBNo := Database::"SW Films";
            "SW Resource Types"::people:
                l_DBNo := Database::"SW People";
            "SW Resource Types"::planets:
                l_DBNo := Database::"SW Planets";
            "SW Resource Types"::species:
                l_DBNo := Database::"SW Species";
            "SW Resource Types"::starships:
                l_DBNo := Database::"SW Starships";
            "SW Resource Types"::vehicles:
                l_DBNo := Database::"SW Vehicles";
        end;
        l_RecRef.Open(l_DBNo);
        g_AssRessourceNameCaption := l_RecRef.Field(2).Caption;
        g_AssRessourceValueCaption := l_RecRef.Field(3).Caption;
        l_RecRef.Close();
    end;
}
