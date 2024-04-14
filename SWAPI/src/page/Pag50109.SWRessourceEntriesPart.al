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

    layout
    {
        area(Content)
        {
            cuegroup(ResourceEntries)
            {
                Caption = 'Resource Entries';

                field(SWFilmsEntries; g_SWFilmsEntries)
                {
                    ApplicationArea = All;
                    Caption = 'SW Films Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Films List");
                    end;
                }
                field(SWPeopleEntries; g_SWPeopleEntries)
                {
                    ApplicationArea = All;
                    Caption = 'SW People Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW People List");
                    end;
                }
                field(SWPlanetEntries; g_SWPlanetEntries)
                {
                    ApplicationArea = All;
                    Caption = 'SW Planet Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Planets List");
                    end;
                }
                field(SWSpeciesEntries; g_SWSpeciesEntries)
                {
                    ApplicationArea = All;
                    Caption = 'SW Species Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Species List");
                    end;
                }
                field(SWStarshipEntries; g_SWStarshipEntries)
                {
                    ApplicationArea = All;
                    Caption = 'SW Starships Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Starships List");
                    end;
                }
                field(SWVehicleEntries; g_SWVehicleEntries)
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
        g_SWFilmsEntries: Integer;
        g_SWPeopleEntries: Integer;
        g_SWPlanetEntries: Integer;
        g_SWSpeciesEntries: Integer;
        g_SWStarshipEntries: Integer;
        g_SWVehicleEntries: Integer;

    trigger OnOpenPage()
    begin
        SetResourceEntries();
    end;

    local procedure SetResourceEntries()
    var
        l_Films: Record "SW Films";
        l_People: Record "SW People";
        l_Planets: Record "SW Planets";
        l_Species: Record "SW Species";
        l_Starships: Record "SW Starships";
        l_Vehicles: Record "SW Vehicles";
    begin
        g_SWFilmsEntries := l_Films.Count;
        g_SWPeopleEntries := l_People.Count;
        g_SWPlanetEntries := l_Planets.Count;
        g_SWSpeciesEntries := l_Species.Count;
        g_SWStarshipEntries := l_Starships.Count;
        g_SWVehicleEntries := l_Vehicles.Count;
    end;

}
