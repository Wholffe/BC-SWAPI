namespace SWAPI.SWAPI;

page 50108 "SW Resource Assosiation List"
{
    ApplicationArea = All;
    Caption = 'SW Resource Assosiation List';
    PageType = List;
    SourceTable = "SW Resource Assosiation";
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
            }
        }
    }
}
