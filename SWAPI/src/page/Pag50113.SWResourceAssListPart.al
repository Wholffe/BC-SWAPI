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
            action(Details)
            {
                ApplicationArea = All;
                Caption = 'Details';

                trigger OnAction()
                begin
                    g_PageMng.DrillDownPage(Rec.ResourceType, Rec.ResourceID, Rec.AssociatedResourceType);
                end;
            }
            action(EditAssociation)
            {
                ApplicationArea = All;
                Caption = 'Edit association';

                trigger OnAction()
                var
                    l_ResourceAss: Record "SW Resource Association";
                    l_ResourceAssList: Page "SW Resource Association List";
                begin
                    l_ResourceAss.SetRange(ResourceType, Rec.ResourceType);
                    l_ResourceAss.SetRange(ResourceID, Rec.ResourceID);
                    l_ResourceAss.SetRange(AssociatedResourceType, Rec.AssociatedResourceType);
                    l_ResourceAssList.SetupPage(false, l_ResourceAss);
                    l_ResourceAssList.RunModal();
                end;
            }
        }
    }
    var
        g_PageMng: Codeunit "SW Page Mng";
        g_SWResourceHelper: Codeunit "SW Resource Type Helper";
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
                l_DBNo := Database::"SW Film";
            "SW Resource Types"::people:
                l_DBNo := Database::"SW Character";
            "SW Resource Types"::planets:
                l_DBNo := Database::"SW Planet";
            "SW Resource Types"::species:
                l_DBNo := Database::"SW Species";
            "SW Resource Types"::starships:
                l_DBNo := Database::"SW Starship";
            "SW Resource Types"::vehicles:
                l_DBNo := Database::"SW Vehicle";
        end;
        l_RecRef.Open(l_DBNo);
        g_AssResourceNameCaption := l_RecRef.Field(2).Caption;
        g_AssResourceValueCaption := l_RecRef.Field(3).Caption;
        l_RecRef.Close();
    end;
}
