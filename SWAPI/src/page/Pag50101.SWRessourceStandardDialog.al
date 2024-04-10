namespace SWAPI.SWAPI;

page 50101 "SW Ressource StandardDialog"
{
    ApplicationArea = All;
    Caption = 'Select a ressource type';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(RessourceType; g_RessouceType)
            {
                ApplicationArea = All;
                Caption = 'Ressource type';
            }
        }
    }

    var
        g_RessouceType: Enum "SW Ressouce Types";

    procedure Setup(p_RessourceType: Enum "SW Ressouce Types")
    begin
        g_RessouceType := p_RessourceType;
    end;

    procedure GetRessourceTypeNumber(): Integer
    begin
        exit(g_RessouceType.AsInteger());
    end;

    procedure GetRessourceType(): Enum "SW Ressouce Types"
    begin
        exit(g_RessouceType)
    end;
}
