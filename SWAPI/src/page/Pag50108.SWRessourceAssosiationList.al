namespace SWAPI.SWAPI;

page 50108 "SW Ressource Assosiation List"
{
    ApplicationArea = All;
    Caption = 'SW Ressource Assosiation List';
    PageType = List;
    SourceTable = "SW Ressource Assosiation";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(RessourceType; Rec.RessourceType)
                {
                    ToolTip = 'Specifies the value of the RessourceType field.';
                }
                field(RessourceID; Rec.RessourceID)
                {
                    ToolTip = 'Specifies the value of the RessourceID field.';
                }
                field(AssociatedRessourceType; Rec.AssociatedRessourceType)
                {
                    ToolTip = 'Specifies the value of the AssociatedRessourceType field.';
                }
                field(AssociatedRessourceValue; Rec.AssociatedRessourceValue)
                {
                    ToolTip = 'Specifies the value of the AssociatedRessourceValue field.';
                }
            }
        }
    }
}
