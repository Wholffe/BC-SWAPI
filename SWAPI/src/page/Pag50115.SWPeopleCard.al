namespace SWAPI.SWAPI;

page 50115 "SW People Card"
{
    ApplicationArea = All;
    Caption = 'SW People Card';
    PageType = Card;
    SourceTable = "SW People";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(ID; Rec.ID)
                {
                }
                field(Name; Rec.Name)
                {
                }
            }
            group(Details)
            {
                field(BirthYear; Rec.BirthYear)
                {
                }
                field(EyeColor; Rec.EyeColor)
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field(HairColor; Rec.HairColor)
                {
                }
                field(Height; Rec.Height)
                {
                }
                field(Mass; Rec.Mass)
                {
                }
                field(SkinColor; Rec.SkinColor)
                {
                }
                field(Homeworld; Rec.Homeworld)
                {
                }
            }

            part(FilmsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Films';
                SubPageLink = ResourceType = const("SW Resource Types"::people), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::films);
            }
            part(SpeciesResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Species';
                SubPageLink = ResourceType = const("SW Resource Types"::people), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::species);
            }
            part(StarshipsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Starships';
                SubPageLink = ResourceType = const("SW Resource Types"::people), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::starships);
            }
            part(VehiclesResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Vehicles';
                SubPageLink = ResourceType = const("SW Resource Types"::people), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::vehicles);
            }
            group(Meta)
            {
                Caption = 'Meta';

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
}