namespace SWAPI.SWAPI;

page 50109 SWResourceEntriesPart
{
    ApplicationArea = All;
    Caption = 'SW Resource Entries';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            cuegroup(ResourceEntries)
            {
                Caption = 'Resource Entries';

                field(SWFilmsEntries; g_ChartsMng.GetSWFilmCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW Films Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Films List");
                    end;
                }
                field(SWPeopleEntries; g_ChartsMng.GetSWPeopleCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW People Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW People List");
                    end;
                }
                field(SWPlanetEntries; g_ChartsMng.GetSWPlanetCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW Planet Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Planets List");
                    end;
                }
                field(SWSpeciesEntries; g_ChartsMng.GetSWSpeciesCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW Species Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Species List");
                    end;
                }
                field(SWStarshipEntries; g_ChartsMng.GetSWStarshipCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW Starships Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Starships List");
                    end;
                }
                field(SWVehicleEntries; g_ChartsMng.GetSWVehicleCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW Vehicle Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Vehicles List");
                    end;
                }
            }
        }
    }

    var
        g_ChartsMng: Codeunit SWChartsMng;
}
