namespace SWAPI.SWAPI;

page 50105 "SW Vehicles List"
{
    ApplicationArea = All;
    Caption = 'SW Vehicles List';
    PageType = List;
    SourceTable = "SW Vehicles";
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
                field(Name; Rec.Name)
                {
                }
                field(Model; Rec.Model)
                {
                }
                field(VehicleClass; Rec.VehicleClass)
                {
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                }
                field(Lenght; Rec.Lenght)
                {
                }
                field(CostInCredits; Rec.CostInCredits)
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
                field(CargoCapacity; Rec.CargoCapacity)
                {
                }
                field(Consumables; Rec.Consumables)
                {
                }
                field(Film; Rec.Film)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::vehicles, Rec.ID, Enum::"SW Resource Types"::films);
                    end;
                }
                field(Pilots; Rec.Pilots)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::vehicles, Rec.ID, Enum::"SW Resource Types"::people);
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
            action(FillSWVehicles)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Vehicles';

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    l_SWAPIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::vehicles);
                end;
            }
        }
    }
    var
        g_APIMng: Codeunit "SWAPI Mng";
}