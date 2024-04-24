namespace SWAPI.SWAPI;

codeunit 50102 SWChartsMng
{

    var
        g_EntriesL: Label 'Entries';
        g_FilmsL: Label 'Films';
        g_PeopleL: Label 'People';
        g_PlanetsL: Label 'Planets';
        g_ResourceL: Label 'Resource';
        g_SpeciesL: Label 'Species';
        g_StarshipsL: Label 'Starships';
        g_VehiclesL: Label 'Vehicles';

    procedure GetResourceEntriesChartParam(): JsonArray
    var
        l_InnerJArray: JsonArray;
        l_JArray: JsonArray;
    begin
        l_InnerJArray.Add(g_ResourceL);
        l_InnerJArray.Add(g_EntriesL);
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_FilmsL);
        l_InnerJArray.Add(GetSWFilmCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_PeopleL);
        l_InnerJArray.Add(GetSWPeopleCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_PlanetsL);
        l_InnerJArray.Add(GetSWPlanetCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_SpeciesL);
        l_InnerJArray.Add(GetSWSpeciesCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_StarshipsL);
        l_InnerJArray.Add(GetSWStarshipCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add(g_VehiclesL);
        l_InnerJArray.Add(GetSWVehicleCount());
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);
        exit(l_JArray)
    end;

    procedure GetFilmCircleChartParam(): JsonArray
    var
        l_InnerJArray: JsonArray;
        l_JArray: JsonArray;
        l_Films: Record "SW Films";
        l_CurrentFilmID: Integer;
    begin
        l_InnerJArray.Add(g_FilmsL);
        l_InnerJArray.Add(g_EntriesL);
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        for l_CurrentFilmID := 1 to l_Films.Count do begin
            l_Films.Get(l_CurrentFilmID);
            l_InnerJArray.Add(l_Films.Title);
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

    procedure GetResourceAssCount(): Integer
    var
        l_ResourceAss: Record "SW Resource Association";
    begin
        exit(l_ResourceAss.Count)
    end;
}
