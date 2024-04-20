namespace SWAPI.SWAPI;

page 50113 SWResourceAssListPart
{
    ApplicationArea = All;
    Caption = 'Resource Association Part';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "SW Resource Association";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(AssResourceID; Rec.AssResourceID)
                {
                    Caption = 'ID';
                }
                field(AssResourceName; Rec.AssResourceName)
                {
                    CaptionClass = g_AssResourceNameCaption;
                }
                field(AssResourceValue; Rec.AssResourceValue)
                {
                    CaptionClass = g_AssResourceValueCaption;
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
        g_AssResourceNameCaption: Text;
        g_AssResourceValueCaption: Text;

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
        g_AssResourceNameCaption := l_RecRef.Field(2).Caption;
        g_AssResourceValueCaption := l_RecRef.Field(3).Caption;
        l_RecRef.Close();
    end;
}
