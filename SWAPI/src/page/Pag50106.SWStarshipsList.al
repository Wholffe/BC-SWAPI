namespace SWAPI.SWAPI;

page 50106 "SW Starships List"
{
    ApplicationArea = All;
    Caption = 'SW Starships List';
    CardPageId = 50118;
    Editable = false;
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
                }
                field(Model; Rec.Model)
                {
                }
                field(StarshipClass; Rec.StarshipClass)
                {
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                }
                field(CostInCredits; Rec.CostInCredits)
                {
                }
                field(Length; Rec.Length)
                {
                }
                field(Crew; Rec.Crew)
                {
                }
                field(Passengers; Rec.Passengers)
                {
                }
                field(MaxAtmospheringSpeed; Rec.MaxAtmospheringSpeed)
                {
                }
                field("HyperdriveRating "; Rec.HyperdriveRating)
                {
                }
                field(MGLT; Rec.MGLT)
                {
                }
                field(CargoCapacity; Rec.CargoCapacity)
                {
                }
                field(Consumables; Rec.Consumables)
                {
                }
                field(Films; Rec.Films)
                {
                    DrillDownPageId = "SW Resource Association List";
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::starships, Rec.ID, Enum::"SW Resource Types"::films);
                    end;
                }
                field(Pilots; Rec.Pilots)
                {
                    DrillDownPageId = "SW Resource Association List";
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::starships, Rec.ID, Enum::"SW Resource Types"::people);
                    end;
                }
                field(Url; Rec.Url)
                {
                }
                field(Created; Rec.Created)
                {
                }
                field(Edited; Rec.Edited)
                {
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