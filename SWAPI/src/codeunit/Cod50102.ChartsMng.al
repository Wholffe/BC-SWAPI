namespace SWAPI.SWAPI;

codeunit 50102 ChartsMng
{
    procedure GetResourceEntriesChartParam(): JsonArray
    var
        l_JArray: JsonArray;
        l_InnerJArray: JsonArray;
    begin
        SetResourceEntries();
        l_InnerJArray.Add('Resource');
        l_InnerJArray.Add('Entries');
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add('films');
        l_InnerJArray.Add(g_SWFilmsEntries);
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add('people');
        l_InnerJArray.Add(g_SWPeopleEntries);
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add('planets');
        l_InnerJArray.Add(g_SWPlanetEntries);
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add('species');
        l_InnerJArray.Add(g_SWSpeciesEntries);
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add('starships');
        l_InnerJArray.Add(g_SWStarshipEntries);
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);

        l_InnerJArray.Add('vehicles');
        l_InnerJArray.Add(g_SWVehicleEntries);
        l_JArray.Add(l_InnerJArray);
        clear(l_InnerJArray);
        exit(l_JArray)
    end;

    var
        g_SWFilmsEntries: Integer;
        g_SWPeopleEntries: Integer;
        g_SWPlanetEntries: Integer;
        g_SWSpeciesEntries: Integer;
        g_SWStarshipEntries: Integer;
        g_SWVehicleEntries: Integer;

    procedure SetResourceEntries()
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
