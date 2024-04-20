namespace SWAPI.SWAPI;

page 50108 "SW Resource Association List"
{
    ApplicationArea = All;
    Caption = 'SW Resource Association List';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                }
                field(ResourceID; Rec.ResourceID)
                {
                }
                field(AssociatedResourceType; Rec.AssociatedResourceType)
                {
                }
                field(AssResourceID; Rec.AssResourceID)
                {
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
                    l_APIMng: Codeunit "SWAPI Mng";
                begin
                    l_APIMng.ValidateAllResourcesAss();
                end;
            }
        }
    }
}
