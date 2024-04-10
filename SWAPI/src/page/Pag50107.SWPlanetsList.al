namespace SWAPI.SWAPI;

page 50107 "SW Planets List"
{
    ApplicationArea = All;
    Caption = 'SW Planets List';
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
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Diameter; Rec.Diameter)
                {
                    ToolTip = 'Specifies the value of the Diameter field.';
                }
                field(RotationPeriod; Rec.RotationPeriod)
                {
                    ToolTip = 'Specifies the value of the Rotation period field.';
                }
                field(OrbitalPeriod; Rec.OrbitalPeriod)
                {
                    ToolTip = 'Specifies the value of the Orbital period field.';
                }
                field(Gravity; Rec.Gravity)
                {
                    ToolTip = 'Specifies the value of the Gravity field.';
                }
                field(Population; Rec.Population)
                {
                    ToolTip = 'Specifies the value of the Population field.';
                }
                field(Climate; Rec.Climate)
                {
                    ToolTip = 'Specifies the value of the Climate field.';
                }
                field(Terrain; Rec.Terrain)
                {
                    ToolTip = 'Specifies the value of the Terrain field.';
                }
                field(SurfaceWater; Rec.SurfaceWater)
                {
                    ToolTip = 'Specifies the value of the Surface water field.';
                }
                field(Residents; Rec.Residents)
                {
                    DrillDownPageId = "SW Ressource Assosiation List";
                    ToolTip = 'Specifies the value of the Residents field.';
                }
                field(Films; Rec.Films)
                {
                    DrillDownPageId = "SW Ressource Assosiation List";
                    ToolTip = 'Specifies the value of the Films field.';
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
            action(FillSWPlanets)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Planets';

                trigger OnAction()
                var
                    l_SWAPISetup: Record SWAPISetup;
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                    l_Url: Text;
                begin
                    l_Url := StrSubstNo('%1/planets', l_SWAPISetup.Endpoint);
                    if l_SWAPIMng.FillSWPlanets(l_Url) then
                        Message(g_ImportSuccess);
                end;
            }
        }
    }
    var
        g_ImportSuccess: Label 'Data Imported Successfully';
}
