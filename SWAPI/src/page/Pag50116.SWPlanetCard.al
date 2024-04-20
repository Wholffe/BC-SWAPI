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
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    Importance = Promoted;
                }
            }
            group(Details)
            {
                Caption = 'Meta';

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
                    Importance = Promoted;
                }
                field(Terrain; Rec.Terrain)
                {
                    Importance = Promoted;
                }
                field(SurfaceWater; Rec.SurfaceWater)
                {
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
                }
                field(Created; Rec.Created)
                {
                    Importance = Additional;
                }
                field(Edited; Rec.Edited)
                {
                    Importance = Additional;
                }
            }
        }
    }
}