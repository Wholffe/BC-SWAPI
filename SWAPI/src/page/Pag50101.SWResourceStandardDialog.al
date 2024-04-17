namespace SWAPI.SWAPI;

page 50101 "SW Resource StandardDialog"
{
    ApplicationArea = All;
    Caption = 'Select a Resource type';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(ResourceType; g_ResourceType)
            {
                ApplicationArea = All;
                Caption = 'Resource type';
            }
        }
    }

    var
        g_ResourceType: Enum "SW Resource Types";

    procedure GetResourceType(): Enum "SW Resource Types"
    begin
        exit(g_ResourceType)
    end;

    procedure GetResourceTypeNumber(): Integer
    begin
        exit(g_ResourceType.AsInteger());
    end;

    procedure Setup(p_ResourceType: Enum "SW Resource Types")
    begin
        g_ResourceType := p_ResourceType;
    end;
}
