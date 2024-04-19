namespace SWAPI.SWAPI;

page 50113 "SW Films Card"
{
    ApplicationArea = All;
    Caption = 'SW Films Card';
    PageType = Card;
    SourceTable = "SW Films";
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
                field(Title; Rec.Title)
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
                    MultiLine = true;
                    Importance = Additional;
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
            part(SpeciesResourceAssPart; SWRessourceAssListPart)
            {
                Caption = 'Species';
                SubPageLink = ResourceType = const("SW Resource Types"::films), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::species);
            }
            part(StarshipsResourceAssPart; SWRessourceAssListPart)
            {
                Caption = 'Starships';
                SubPageLink = ResourceType = const("SW Resource Types"::films), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::starships);
            }
            part(VehiclesResourceAssPart; SWRessourceAssListPart)
            {
                Caption = 'Vehicles';
                SubPageLink = ResourceType = const("SW Resource Types"::films), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::vehicles);
            }
            part(CharactersResourceAssPart; SWRessourceAssListPart)
            {
                Caption = 'Characters';
                SubPageLink = ResourceType = const("SW Resource Types"::films), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::people);
            }
            part(PlanetsResourceAssPart; SWRessourceAssListPart)
            {
                Caption = 'Planets';
                SubPageLink = ResourceType = const("SW Resource Types"::films), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::planets);
            }
        }
    }

    var
        g_APIMng: Codeunit "SWAPI Mng";
}