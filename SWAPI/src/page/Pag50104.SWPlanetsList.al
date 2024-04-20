namespace SWAPI.SWAPI;

page 50104 "SW Planets List"
{
    ApplicationArea = All;
    Caption = 'SW Planets List';
    CardPageId = 50116;
    Editable = false;
    PageType = List;
    SourceTable = "SW Planets";
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
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::planets, Rec.ID, Enum::"SW Resource Types"::people);
                    end;
                }
                field(Films; Rec.Films)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::planets, Rec.ID, Enum::"SW Resource Types"::films);
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
            action(FillSWPlanets)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Planets';

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    l_SWAPIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::planets);
                end;
            }
        }
    }
    var
        g_APIMng: Codeunit "SWAPI Mng";
}
