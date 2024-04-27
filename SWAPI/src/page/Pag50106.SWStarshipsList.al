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
                        g_PageMng.DrillDownPage("SW Resource Types"::starships, Rec.ID, "SW Resource Types"::films);
                    end;
                }
                field(Pilots; Rec.Pilots)
                {
                    DrillDownPageId = "SW Resource Association List";
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::starships, Rec.ID, "SW Resource Types"::people);
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
            action(FillSWStarships)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Starships';

                trigger OnAction()
                var
                    l_DataImporter: Codeunit "SWAPI Data Import Mng";
                begin
                    l_DataImporter.FillAllResourcesOfAKind("SW Resource Types"::starships);
                end;
            }
        }
    }
    var
        g_PageMng: Codeunit "SW Page Mng";
}