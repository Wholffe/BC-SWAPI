namespace SWAPI.SWAPI;

page 50104 "SW Starships List"
{
    ApplicationArea = All;
    Caption = 'SW Starships List';
    PageType = List;
    SourceTable = "SW Starships";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field(StarshipClass; Rec.StarshipClass)
                {
                    ToolTip = 'Specifies the value of the Starship Class field.';
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ToolTip = 'Specifies the value of the Manufacturer field.';
                }
                field(CostInCredits; Rec.CostInCredits)
                {
                    ToolTip = 'Specifies the value of the Cost in credits field.';
                }
                field(Length; Rec.Length)
                {
                    ToolTip = 'Specifies the value of the Length field.';
                }
                field(Crew; Rec.Crew)
                {
                    ToolTip = 'Specifies the value of the Crew field.';
                }
                field(Passengers; Rec.Passengers)
                {
                    ToolTip = 'Specifies the value of the Passengers field.';
                }
                field(MaxAtmospheringSpeed; Rec.MaxAtmospheringSpeed)
                {
                    ToolTip = 'Specifies the value of the Max atmosphering speed field.';
                }
                field("HyperdriveRating "; Rec.HyperdriveRating)
                {
                    ToolTip = 'Specifies the value of the Hyperdrive rating  field.';
                }
                field(MGLT; Rec.MGLT)
                {
                    ToolTip = 'Specifies the value of the MGLT field.';
                }
                field(CargoCapacity; Rec.CargoCapacity)
                {
                    ToolTip = 'Specifies the value of the Cargo capacity field.';
                }
                field(Consumables; Rec.Consumables)
                {
                    ToolTip = 'Specifies the value of the Consumables field.';
                }
                field(Films; Rec.Films)
                {
                    DrillDownPageId = "SW Resource Association List";
                    ToolTip = 'Specifies the value of the Films field.';
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::starships, Rec.ID, Enum::"SW Resource Types"::films);
                    end;
                }
                field(Pilots; Rec.Pilots)
                {
                    DrillDownPageId = "SW Resource Association List";
                    ToolTip = 'Specifies the value of the Pilots field.';
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::starships, Rec.ID, Enum::"SW Resource Types"::people);
                    end;
                }
                field(Url; Rec.Url)
                {
                    ToolTip = 'Specifies the value of the Url field.';
                }
                field(Created; Rec.Created)
                {
                    ToolTip = 'Specifies the value of the Created field.';
                }
                field(Edited; Rec.Edited)
                {
                    ToolTip = 'Specifies the value of the Edited field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(FillSWStarships)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Starships';

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    l_SWAPIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::starships);
                end;
            }
        }
    }
    var
        g_APIMng: Codeunit "SWAPI Mng";
}