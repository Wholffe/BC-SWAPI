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
    SourceTable = "SW Resource Association";

    layout
    {
        area(Content)
        {
            cuegroup(ResourceAnalysis)
            {
                CueGroupLayout = Wide;
                field(TotalEntries; GetTotalEntries())
                {
                    ApplicationArea = All;
                    Caption = 'Total Entries';
                    ToolTip = 'Specifies the total number of resource entries.';
                }
                field(AverageLifeSpan; GetAverageLifeSpan())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Average Life Span';
                    ToolTip = 'Specifies average life span of all species resources.';

                    trigger OnDrillDown()
                    var
                        l_Species: Record "SW Species";
                    begin
                        l_Species.SetCurrentKey(AverageLifeSpan);
                        l_Species.Ascending(false);
                        Page.Run(Page::"SW Species List", l_Species);
                    end;
                }
                field(TotalStarshipPrice; GetTotalStarshipCostInMillionCredits())
                {
                    ApplicationArea = All;
                    Caption = 'Total starship price';
                    ToolTip = 'Specifies the cost of all starships resources in million credits.';

                    trigger OnDrillDown()
                    var
                        l_Starships: Record "SW Starships";
                    begin
                        l_Starships.Reset();
                        l_Starships.SetCurrentKey(CostInCredits);
                        l_Starships.Ascending(false);
                        Page.Run(Page::"SW Starships List", l_Starships);
                    end;
                }
            }
            cuegroup(ResourceEntries)
            {
                Caption = 'Resource Entries';

                field(SWFilmsEntries; g_DataStatisticsMng.GetSWFilmCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW Films Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Films List");
                    end;
                }
                field(SWPeopleEntries; g_DataStatisticsMng.GetSWPeopleCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW People Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW People List");
                    end;
                }
                field(SWPlanetEntries; g_DataStatisticsMng.GetSWPlanetCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW Planet Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Planets List");
                    end;
                }
                field(SWSpeciesEntries; g_DataStatisticsMng.GetSWSpeciesCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW Species Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Species List");
                    end;
                }
                field(SWStarshipEntries; g_DataStatisticsMng.GetSWStarshipCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW Starships Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Starships List");
                    end;
                }
                field(SWVehicleEntries; g_DataStatisticsMng.GetSWVehicleCount())
                {
                    ApplicationArea = All;
                    Caption = 'SW Vehicle Entries';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Vehicles List");
                    end;
                }
            }
            cuegroup(ResourceAssEntries)
            {
                Caption = 'Resource Associations';

                field(ResourceAss; g_DataStatisticsMng.GetResourceAssCount())
                {
                    ApplicationArea = All;
                    Caption = 'Resource Association';
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"SW Resource Association List");
                    end;
                }
            }
        }
    }

    var
        g_DataStatisticsMng: Codeunit "SW Data Statistics Mng";

    local procedure GetAverageLifeSpan(): Decimal
    var
        l_Species: Record "SW Species";
        l_TotalLifeSpan: Integer;
    begin
        if l_Species.FindFirst() then
            repeat
                if l_Species.AverageLifeSpan <> 0 then
                    l_TotalLifeSpan += l_Species.AverageLifeSpan;
            until l_Species.Next() = 0;
        if l_TotalLifeSpan <> 0 then
            exit(l_TotalLifeSpan / l_Species.Count);
    end;

    local procedure GetTotalEntries(): Integer
    var
        l_Count: Integer;
    begin
        l_Count :=
            g_DataStatisticsMng.GetSWFilmCount() +
            g_DataStatisticsMng.GetSWPeopleCount() +
            g_DataStatisticsMng.GetSWPlanetCount() +
            g_DataStatisticsMng.GetSWSpeciesCount() +
            g_DataStatisticsMng.GetSWStarshipCount() +
            g_DataStatisticsMng.GetSWVehicleCount();
        exit(l_Count);
    end;

    local procedure GetTotalStarshipCostInMillionCredits(): Decimal
    var
        l_Starships: Record "SW Starships";
        l_CostTotal: Integer;
    begin
        if l_Starships.FindFirst() then
            repeat
                l_CostTotal += l_Starships.CostInCredits;
            until l_Starships.Next() = 0;
        exit(l_CostTotal / 1000000);
    end;
}
