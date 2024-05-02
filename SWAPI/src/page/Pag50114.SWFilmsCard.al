namespace SWAPI.SWAPI;

page 50114 "SW Film Card"
{
    ApplicationArea = All;
    Caption = 'SW Film Card';
    PageType = Card;
    SourceTable = "SW Film";
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
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    Importance = Promoted;
                }
                field(EpisodeID; Rec.EpisodeID)
                {
                    Caption = 'Episode';
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field(OpeningCrawl; Rec.OpeningCrawl)
                {
                    Importance = Additional;
                    MultiLine = true;
                }
                field(Director; Rec.Director)
                {
                    Importance = Promoted;
                }
                field(Producer; Rec.Producer)
                {
                }
                field(ReleaseDate; Rec.ReleaseDate)
                {
                }
            }
            part(SpeciesResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Species';
                SubPageLink = ResourceType = const("SW Resource Types"::films), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::species);
            }
            part(StarshipsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Starships';
                SubPageLink = ResourceType = const("SW Resource Types"::films), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::starships);
            }
            part(VehiclesResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Vehicles';
                SubPageLink = ResourceType = const("SW Resource Types"::films), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::vehicles);
            }
            part(CharactersResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Characters';
                SubPageLink = ResourceType = const("SW Resource Types"::films), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::people);
            }
            part(PlanetsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Planets';
                SubPageLink = ResourceType = const("SW Resource Types"::films), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::planets);
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