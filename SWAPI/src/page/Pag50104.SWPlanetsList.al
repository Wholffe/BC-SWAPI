namespace SWAPI.SWAPI;

page 50104 "SW Planet List"
{
    ApplicationArea = All;
    Caption = 'SW Planet List';
    CardPageId = 50116;
    Editable = false;
    PageType = List;
    SourceTable = "SW Planet";
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
                field(Diameter; Rec.Diameter)
                {
                }
                field(RotationPeriod; Rec.RotationPeriod)
                {
                }
                field(OrbitalPeriod; Rec.OrbitalPeriod)
                {
                }
                field(Gravity; Rec.Gravity)
                {
                }
                field(Population; Rec.Population)
                {
                }
                field(Climate; Rec.Climate)
                {
                }
                field(Terrain; Rec.Terrain)
                {
                }
                field(SurfaceWater; Rec.SurfaceWater)
                {
                }
                field(Residents; Rec.Residents)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::planets, Rec.ID, "SW Resource Types"::people);
                    end;
                }
                field(Films; Rec.Films)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::planets, Rec.ID, "SW Resource Types"::films);
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
            action(FillSWPlanets)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Planets';

                trigger OnAction()
                var
                    l_DataImporter: Codeunit "SWAPI Data Import Mng";
                    l_SWUtilityMng: Codeunit "SW Utility Mng";
                begin
                    l_DataImporter.FillAllResourcesOfAKind("SW Resource Types"::planets);
                    l_SWUtilityMng.ValidateAllResourcesAss();
                end;
            }
        }
    }
    var
        g_PageMng: Codeunit "SW Page Mng";
}
