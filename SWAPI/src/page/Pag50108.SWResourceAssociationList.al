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
                    ToolTip = 'Specifies the value of the ResourceType field.';
                }
                field(ResourceID; Rec.ResourceID)
                {
                    ToolTip = 'Specifies the value of the ResourceID field.';
                }
                field(AssociatedResourceType; Rec.AssociatedResourceType)
                {
                    ToolTip = 'Specifies the value of the AssociatedResourceType field.';
                }
                field(AssociatedResourceValue; Rec.AssociatedResourceValue)
                {
                    ToolTip = 'Specifies the value of the AssociatedResourceValue field.';
                }
                field(AssRessourceID; Rec.AssRessourceID)
                {
                    ToolTip = 'Specifies the value of the Associated Ressource ID field.';
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
