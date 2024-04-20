namespace SWAPI.SWAPI;

page 50102 "SW Films List"
{
    ApplicationArea = All;
    Caption = 'SW Films List';
    CardPageId = 50114;
    Editable = false;
    PageType = List;
    SourceTable = "SW Films";
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
                field(Title; Rec.Title)
                {
                }
                field(EpisodeID; Rec.EpisodeID)
                {
                }
                field(OpeningCrawl; Rec.OpeningCrawl)
                {
                }
                field(Director; Rec.Director)
                {
                }
                field(Producer; Rec.Producer)
                {
                }
                field(ReleaseDate; Rec.ReleaseDate)
                {
                }
                field(Species; Rec.Species)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::films, Rec.ID, Enum::"SW Resource Types"::species);
                    end;
                }
                field(Starships; Rec.Starships)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::films, Rec.ID, Enum::"SW Resource Types"::starships);
                    end;
                }
                field(Vehicles; Rec.Vehicles)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::films, Rec.ID, Enum::"SW Resource Types"::vehicles);
                    end;

                }
                field(Characters; Rec.Characters)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::films, Rec.ID, Enum::"SW Resource Types"::people);
                    end;
                }
                field(Planets; Rec.Planets)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::films, Rec.ID, Enum::"SW Resource Types"::planets);
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
            action(FillSWFilms)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Films';

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    l_SWAPIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::films);
                end;
            }
        }
    }
    var
        g_APIMng: Codeunit "SWAPI Mng";
}
