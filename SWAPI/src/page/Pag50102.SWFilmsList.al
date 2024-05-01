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
                field(Name; Rec.Name)
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
                        g_PageMng.DrillDownPage("SW Resource Types"::films, Rec.ID, "SW Resource Types"::species);
                    end;
                }
                field(Starships; Rec.Starships)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::films, Rec.ID, "SW Resource Types"::starships);
                    end;
                }
                field(Vehicles; Rec.Vehicles)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::films, Rec.ID, "SW Resource Types"::vehicles);
                    end;

                }
                field(Characters; Rec.Characters)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::films, Rec.ID, "SW Resource Types"::people);
                    end;
                }
                field(Planets; Rec.Planets)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::films, Rec.ID, "SW Resource Types"::planets);
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
            action(FillSWFilms)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Films';

                trigger OnAction()
                var
                    l_DataImporter: Codeunit "SWAPI Data Import Mng";
                    l_SWUtilityMng: Codeunit "SW Utility Mng";
                begin
                    l_DataImporter.FillAllResourcesOfAKind("SW Resource Types"::films);
                    l_SWUtilityMng.ValidateAllResourcesAss();
                end;
            }
        }
    }
    var
        g_PageMng: Codeunit "SW Page Mng";
}
