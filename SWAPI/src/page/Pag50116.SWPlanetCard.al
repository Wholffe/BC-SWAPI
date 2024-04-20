namespace SWAPI.SWAPI;

page 50116 "SW Planet Card"
{
    ApplicationArea = All;
    Caption = 'SW Planet Card';
    PageType = Card;
    SourceTable = "SW Planets";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
            group(Details)
            {
                Caption = 'Meta';

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
            }
            part(ResidentsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Residents';
                SubPageLink = ResourceType = const("SW Resource Types"::planets), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::people);
            }
            part(FilmsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Films';
                SubPageLink = ResourceType = const("SW Resource Types"::planets), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::films);
            }
            group(Meta)
            {
                Caption = 'Meta';

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
}