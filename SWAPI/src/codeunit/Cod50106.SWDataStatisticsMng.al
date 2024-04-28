namespace SWAPI.SWAPI;

codeunit 50106 "SW Data Statistics Mng"
{
    var
        g_SWResourceHelper: Codeunit "SW Resource Type Helper";
        g_EntriesL: Label 'Entries';
        g_ResourceL: Label 'Resource';

    procedure GetFilmCircleChartParam(): JsonArray
    var
        l_Films: Record "SW Films";
        l_CurrentFilmID: Integer;
        l_InnerJArray: JsonArray;
        l_JArray: JsonArray;
    begin
        l_InnerJArray.Add(g_SWResourceHelper.GetResourceL("SW Resource Types"::films));
        l_InnerJArray.Add(g_EntriesL);
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        for l_CurrentFilmID := 1 to l_Films.Count do begin
            l_Films.Get(l_CurrentFilmID);
            l_InnerJArray.Add(l_Films.Name);
            l_InnerJArray.Add(GetNumberResourceAssFilm(l_CurrentFilmID));
            l_JArray.Add(l_InnerJArray);
            clear(l_InnerJArray);
        end;
        exit(l_JArray)
    end;

    procedure GetNumberResourceAssFilm(p_FilmNo: Integer): Integer
    var
        l_ResourceAss: Record "SW Resource Association";
    begin
        l_ResourceAss.SetRange(ResourceType, "SW Resource Types"::films);
        l_ResourceAss.SetRange(ResourceID, p_FilmNo);
        exit(l_ResourceAss.Count);
    end;

    procedure GetResourceAssCount(): Integer
    var
        l_ResourceAss: Record "SW Resource Association";
    begin
        exit(l_ResourceAss.Count)
    end;

    procedure GetResourceEntriesChartParam(): JsonArray
    var
        l_InnerJArray: JsonArray;
        l_JArray: JsonArray;
    begin
        l_InnerJArray.Add(g_ResourceL);
        l_InnerJArray.Add(g_EntriesL);
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_SWResourceHelper.GetResourceL("SW Resource Types"::films));
        l_InnerJArray.Add(GetSWFilmCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_SWResourceHelper.GetResourceL("SW Resource Types"::people));
        l_InnerJArray.Add(GetSWPeopleCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_SWResourceHelper.GetResourceL("SW Resource Types"::planets));
        l_InnerJArray.Add(GetSWPlanetCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_SWResourceHelper.GetResourceL("SW Resource Types"::species));
        l_InnerJArray.Add(GetSWSpeciesCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_SWResourceHelper.GetResourceL("SW Resource Types"::starships));
        l_InnerJArray.Add(GetSWStarshipCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_SWResourceHelper.GetResourceL("SW Resource Types"::vehicles));
        l_InnerJArray.Add(GetSWVehicleCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);
        exit(l_JArray)
    end;

    procedure GetSWFilmCount(): Integer
    var
        l_Films: Record "SW Films";
    begin
        exit(l_Films.Count);
    end;

    procedure GetSWPeopleCount(): Integer
    var
        l_People: Record "SW People";
    begin
        exit(l_People.Count);
    end;

    procedure GetSWPlanetCount(): Integer
    var
        l_Planets: Record "SW Planets";
    begin
        exit(l_Planets.Count);
    end;

    procedure GetSWSpeciesCount(): Integer
    var
        l_Species: Record "SW Species";
    begin
        exit(l_Species.Count)
    end;

    procedure GetSWStarshipCount(): Integer
    var
        l_Starships: Record "SW Starships";
    begin
        exit(l_Starships.Count)
    end;

    procedure GetSWVehicleCount(): Integer
    var
        l_Vehicles: Record "SW Vehicles";
    begin
        exit(l_Vehicles.Count)
    end;
}
