namespace SWAPI.SWAPI;

page 50103 "SW Films List"
{
    ApplicationArea = All;
    Caption = 'SW Films List';
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
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(EpisodeID; Rec.EpisodeID)
                {
                    ToolTip = 'Specifies the value of the Episode ID field.';
                }
                field(OpeningCrawl; Rec.OpeningCrawl)
                {
                    ToolTip = 'Specifies the value of the Opening crawl field.';
                }
                field(Director; Rec.Director)
                {
                    ToolTip = 'Specifies the value of the Director field.';
                }
                field(Producer; Rec.Producer)
                {
                    ToolTip = 'Specifies the value of the Producer field.';
                }
                field(ReleaseDate; Rec.ReleaseDate)
                {
                    ToolTip = 'Specifies the value of the Release date field.';
                }
                field(Species; Rec.Species)
                {
                    DrillDownPageId = "SW Resource Assosiation List";
                    ToolTip = 'Specifies the value of the Species field.';
                }
                field(Starships; Rec.Starships)
                {
                    DrillDownPageId = "SW Resource Assosiation List";
                    ToolTip = 'Specifies the value of the Starships field.';
                }
                field(Vehicles; Rec.Vehicles)
                {
                    DrillDownPageId = "SW Resource Assosiation List";
                    ToolTip = 'Specifies the value of the Vehicles field.';

                }
                field(Characters; Rec.Characters)
                {
                    DrillDownPageId = "SW Resource Assosiation List";
                    ToolTip = 'Specifies the value of the Characters field.';
                }
                field(Planets; Rec.Planets)
                {
                    DrillDownPageId = "SW Resource Assosiation List";
                    ToolTip = 'Specifies the value of the Planets field.';
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
            action(FillSWFilms)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Films';

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    if l_SWAPIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::films) then
                        l_SWAPIMng.SendStatusNotification();
                end;
            }
        }
    }
}
