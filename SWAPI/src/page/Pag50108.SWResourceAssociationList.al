namespace SWAPI.SWAPI;

page 50108 "SW Resource Association List"
{
    ApplicationArea = All;
    Caption = 'SW Resource Association List';
    PageType = List;
    SourceTable = "SW Resource Association";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ResourceType; Rec.ResourceType)
                {
                    Visible = g_IsVisible;
                }
                field(ResourceID; Rec.ResourceID)
                {
                    Visible = g_IsVisible;
                }
                field(AssociatedResourceType; Rec.AssociatedResourceType)
                {
                    Visible = g_IsVisible;
                }
                field(AssResourceID; Rec.AssResourceID)
                {
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        exit(SetAssResourceIDFromLookupPage(Text));
                    end;
                }
                field(AssResourceName; Rec.AssResourceName)
                {
                }
                field(AssResourceValue; Rec.AssResourceValue)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ValidateAllResources)
            {
                ApplicationArea = All;
                Caption = 'Validate All Resources';

                trigger OnAction()
                var
                    l_UtilityMng: Codeunit "SW Utility Mng";
                begin
                    l_UtilityMng.ValidateAllResourcesAss();
                end;
            }
        }
    }
    var
        g_IsVisible: Boolean;

    trigger OnOpenPage()
    begin
        if Rec.GetFilters() = '' then begin
            g_IsVisible := true;
        end;
    end;

    local procedure SetAssResourceIDFromLookupPage(var Text: Text): Boolean
    var
        l_SWResourceHelper: Codeunit "SW Resource Type Helper";
        l_RecRef: RecordRef;
        l_PageNo: Integer;
        l_TableNo: Integer;
        l_VarRecRef: Variant;
    begin
        l_PageNo := l_SWResourceHelper.GetListPageNoFromResourceEnum(Rec.AssociatedResourceType);
        l_TableNo := l_SWResourceHelper.GetRecRefTableNoFromResourceEnum(Rec.AssociatedResourceType);
        l_RecRef.Open(l_TableNo);
        l_VarRecRef := l_RecRef;
        if Page.RunModal(l_PageNo, l_VarRecRef) = Action::LookupOK then begin
            l_RecRef := l_VarRecRef;
            Text := l_RecRef.Field(1).Value;
            l_RecRef.Close();
            exit(true);
        end;
    end;

    procedure SetupPage(p_IsVisible: Boolean; var p_ResourceAss: Record "SW Resource Association")
    begin
        g_IsVisible := p_IsVisible;
        Rec.CopyFilters(p_ResourceAss);
    end;
}