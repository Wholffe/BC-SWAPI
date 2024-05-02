namespace SWAPI.SWAPI;

page 50107 "SW Vehicle List"
{
    ApplicationArea = All;
    Caption = 'SW Vehicle List';
    CardPageId = 50119;
    Editable = false;
    PageType = List;
    SourceTable = "SW Vehicle";
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
                field(Films; Rec.Films)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::vehicles, Rec.ID, "SW Resource Types"::films);
                    end;
                }
                field(Pilots; Rec.Pilots)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::vehicles, Rec.ID, "SW Resource Types"::people);
                    end;
                }
                field(Url; Rec.Url)
                {
                    Visible = false;
                }
                field(Created; Rec.Created)
                {
                    Visible = false;
                }
                field(Edited; Rec.Edited)
                {
                    Visible = false;
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
                    l_DataImporter: Codeunit "SWAPI Data Import Mng";
                    l_SWUtilityMng: Codeunit "SW Utility Mng";
                begin
                    l_DataImporter.FillAllResourcesOfAKind("SW Resource Types"::vehicles);
                    l_SWUtilityMng.ValidateAllResourcesAss();
                end;
            }
        }
    }
    var
        g_PageMng: Codeunit "SW Page Mng";
}