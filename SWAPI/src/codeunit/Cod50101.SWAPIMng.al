namespace SWAPI.SWAPI;

codeunit 50101 "SWAPI Mng"
{

    procedure FillSWFilms(): Boolean
    var
        l_APISetup: Record SWAPISetup;
        l_Films: Record "SW Films";
        l_CurrCounter: Integer;
        l_ID: Integer;
        l_MaxCounter: Integer;
        l_JObject: JsonObject;
        l_ResourceRouteUrl: Text;
        l_Url: Text;
    begin
        l_ResourceRouteUrl := StrSubstNo('%1%2', l_APISetup.Endpoint, Enum::"SW Resource Types"::films);
        l_MaxCounter := GetCategoryCount(l_ResourceRouteUrl);
        for l_CurrCounter := 1 to l_MaxCounter do begin
            l_Url := StrSubstNo('%1/%2', l_ResourceRouteUrl, l_CurrCounter);
            l_JObject := GetJObjectFromUrl(l_Url);
            if l_JObject.Keys().Count <> 0 then begin
                l_ID := l_CurrCounter;
                if not l_Films.Get(l_ID) then begin
                    l_Films.Init();
                    l_Films.ID := l_ID;
                    l_Films.Title := GetJsonTextField(l_JObject, 'title');
                    l_Films.EpisodeID := GetJsonIntegerField(l_JObject, 'episode_id');
                    l_Films.OpeningCrawl := GetJsonTextField(l_JObject, 'opening_crawl');
                    l_Films.Director := GetJsonTextField(l_JObject, 'director');
                    l_Films.Producer := GetJsonTextField(l_JObject, 'producer');
                    l_Films.ReleaseDate := GetJsonDateField(l_JObject, 'release_date');
                    l_Films.Url := GetJsonTextField(l_JObject, 'url');
                    l_Films.Created := GetJsonDateTimeField(l_JObject, 'created');
                    l_Films.Edited := GetJsonDateTimeField(l_JObject, 'edited');
                    l_Films.Insert();
                end;
                FillResourceAssosiation(l_JObject, 'species', Enum::"SW Resource Types"::films, l_ID);
                FillResourceAssosiation(l_JObject, 'starships', Enum::"SW Resource Types"::films, l_ID);
                FillResourceAssosiation(l_JObject, 'vehicles', Enum::"SW Resource Types"::films, l_ID);
                FillResourceAssosiation(l_JObject, 'characters', Enum::"SW Resource Types"::films, l_ID);
                FillResourceAssosiation(l_JObject, 'planets', Enum::"SW Resource Types"::films, l_ID);
            end;
            Commit();
        end;
        exit(true);
    end;

    procedure FillSWPeople(): Boolean
    var
        l_APISetup: Record SWAPISetup;
        l_People: Record "SW People";
        l_CurrCounter: Integer;
        l_ID: Integer;
        l_MaxCounter: Integer;
        l_JObject: JsonObject;
        l_ResourceRouteUrl: Text;
        l_Url: Text;
    begin
        l_ResourceRouteUrl := StrSubstNo('%1%2', l_APISetup.Endpoint, Enum::"SW Resource Types"::people);
        l_MaxCounter := GetCategoryCount(l_ResourceRouteUrl);
        for l_CurrCounter := 1 to l_MaxCounter do begin
            l_Url := StrSubstNo('%1/%2', l_ResourceRouteUrl, l_CurrCounter);
            l_JObject := GetJObjectFromUrl(l_Url);
            if l_JObject.Keys().Count <> 0 then begin
                l_ID := l_CurrCounter;
                if not l_People.Get(l_ID) then begin
                    l_People.Init();
                    l_People.ID := l_ID;
                    l_People.Name := GetJsonTextField(l_JObject, 'name');
                    l_People.BirthYear := GetJsonTextField(l_JObject, 'birth_year');
                    l_People.EyeColor := GetJsonTextField(l_JObject, 'eye_color');
                    l_People.Gender := GetJsonTextField(l_JObject, 'gender');
                    l_People.HairColor := GetJsonTextField(l_JObject, 'hair_color');
                    l_People.Height := GetJsonTextField(l_JObject, 'height');
                    l_People.Mass := GetJsonTextField(l_JObject, 'mass');
                    l_People.SkinColor := GetJsonTextField(l_JObject, 'skin_color');
                    l_People.Homeworld := GetJsonTextField(l_JObject, 'homeworld');
                    l_People.Url := GetJsonTextField(l_JObject, 'url');
                    l_People.Created := GetJsonDateTimeField(l_JObject, 'created');
                    l_People.Edited := GetJsonDateTimeField(l_JObject, 'edited');
                    l_People.Insert();
                end;
                FillResourceAssosiation(l_JObject, 'films', Enum::"SW Resource Types"::people, l_ID);
                FillResourceAssosiation(l_JObject, 'species', Enum::"SW Resource Types"::people, l_ID);
                FillResourceAssosiation(l_JObject, 'starships', Enum::"SW Resource Types"::people, l_ID);
                FillResourceAssosiation(l_JObject, 'vehicles', Enum::"SW Resource Types"::people, l_ID);
            end;
            Commit();
        end;
        exit(true);
    end;

    procedure FillSWPlanets(): Boolean
    var
        l_APISetup: Record SWAPISetup;
        l_Planets: Record "SW Planets";
        l_CurrCounter: Integer;
        l_ID: Integer;
        l_MaxCounter: Integer;
        l_JObject: JsonObject;
        l_ResourceRouteUrl: Text;
        l_Url: Text;
    begin
        l_ResourceRouteUrl := StrSubstNo('%1%2', l_APISetup.Endpoint, Enum::"SW Resource Types"::planets);
        l_MaxCounter := GetCategoryCount(l_ResourceRouteUrl);
        for l_CurrCounter := 1 to l_MaxCounter do begin
            l_Url := StrSubstNo('%1/%2', l_ResourceRouteUrl, l_CurrCounter);
            l_JObject := GetJObjectFromUrl(l_Url);
            if l_JObject.Keys().Count <> 0 then begin
                l_ID := l_CurrCounter;
                if not l_Planets.Get(l_ID) then begin
                    l_Planets.Init();
                    l_Planets.ID := l_ID;
                    l_Planets.Name := GetJsonTextField(l_JObject, 'name');
                    l_Planets.Diameter := GetJsonTextField(l_JObject, 'diameter');
                    l_Planets.RotationPeriod := GetJsonTextField(l_JObject, 'rotation_period');
                    l_Planets.OrbitalPeriod := GetJsonTextField(l_JObject, 'orbital_period');
                    l_Planets.Gravity := GetJsonTextField(l_JObject, 'gravity');
                    l_Planets.Population := GetJsonTextField(l_JObject, 'population');
                    l_Planets.Climate := GetJsonTextField(l_JObject, 'climate');
                    l_Planets.Terrain := GetJsonTextField(l_JObject, 'terrain');
                    l_Planets.SurfaceWater := GetJsonTextField(l_JObject, 'surface_water');
                    l_Planets.Url := GetJsonTextField(l_JObject, 'url');
                    l_Planets.Created := GetJsonDateTimeField(l_JObject, 'created');
                    l_Planets.Edited := GetJsonDateTimeField(l_JObject, 'edited');
                    l_Planets.Insert();
                end;
                FillResourceAssosiation(l_JObject, 'residents', Enum::"SW Resource Types"::planets, l_ID);
                FillResourceAssosiation(l_JObject, 'films', Enum::"SW Resource Types"::planets, l_ID);
            end;
            Commit();
        end;
        exit(true);
    end;

    procedure FillSWSpecies(): Boolean
    var
        l_APISetup: Record SWAPISetup;
        l_Species: Record "SW Species";
        l_CurrCounter: Integer;
        l_ID: Integer;
        l_MaxCounter: Integer;
        l_JObject: JsonObject;
        l_ResourceRouteUrl: Text;
        l_Url: Text;
    begin
        l_ResourceRouteUrl := StrSubstNo('%1%2', l_APISetup.Endpoint, Enum::"SW Resource Types"::species);
        l_MaxCounter := GetCategoryCount(l_ResourceRouteUrl);
        for l_CurrCounter := 1 to l_MaxCounter do begin
            l_Url := StrSubstNo('%1/%2', l_ResourceRouteUrl, l_CurrCounter);
            l_JObject := GetJObjectFromUrl(l_Url);
            if l_JObject.Keys().Count <> 0 then begin
                l_ID := l_CurrCounter;
                if not l_Species.Get(l_ID) then begin
                    l_Species.Init();
                    l_Species.ID := l_ID;
                    l_Species.Name := GetJsonTextField(l_JObject, 'name');
                    l_Species.Classification := GetJsonTextField(l_JObject, 'classification');
                    l_Species.Designation := GetJsonTextField(l_JObject, 'designation');
                    l_Species.AverageHeight := GetJsonTextField(l_JObject, 'average_height');
                    l_Species.AverageLifeSpan := GetJsonTextField(l_JObject, 'average_lifespan');
                    l_Species.EyeColor := GetJsonTextField(l_JObject, 'eye_colors');
                    l_Species.HairColors := GetJsonTextField(l_JObject, 'hair_colors');
                    l_Species.SkinColors := GetJsonTextField(l_JObject, 'skin_colors');
                    l_Species.Language := GetJsonTextField(l_JObject, 'language');
                    l_Species.Homeworld := GetJsonTextField(l_JObject, 'homeworld');
                    l_Species.Url := GetJsonTextField(l_JObject, 'url');
                    l_Species.Created := GetJsonDateTimeField(l_JObject, 'created');
                    l_Species.Edited := GetJsonDateTimeField(l_JObject, 'edited');
                    l_Species.Insert();
                end;
                FillResourceAssosiation(l_JObject, 'people', Enum::"SW Resource Types"::species, l_ID);
                FillResourceAssosiation(l_JObject, 'films', Enum::"SW Resource Types"::species, l_ID);
            end;
            Commit();
        end;
        exit(true);
    end;

    procedure FillSWStarships(): Boolean
    var
        l_APISetup: Record SWAPISetup;
        l_Starships: Record "SW Starships";
        l_CurrCounter: Integer;
        l_ID: Integer;
        l_MaxCounter: Integer;
        l_JObject: JsonObject;
        l_ResourceRouteUrl: Text;
        l_Url: Text;
    begin
        l_ResourceRouteUrl := StrSubstNo('%1%2', l_APISetup.Endpoint, Enum::"SW Resource Types"::starships);
        l_MaxCounter := GetCategoryCount(l_ResourceRouteUrl);
        for l_CurrCounter := 1 to l_MaxCounter do begin
            l_Url := StrSubstNo('%1/%2', l_ResourceRouteUrl, l_CurrCounter);
            l_JObject := GetJObjectFromUrl(l_Url);
            if l_JObject.Keys().Count <> 0 then begin
                l_ID := l_CurrCounter;
                if not l_Starships.Get(l_ID) then begin
                    l_Starships.Init();
                    l_Starships.ID := l_ID;
                    l_Starships.Name := GetJsonTextField(l_JObject, 'name');
                    l_Starships.Model := GetJsonTextField(l_JObject, 'model');
                    l_Starships.StarshipClass := GetJsonTextField(l_JObject, 'starship_class');
                    l_Starships.Manufacturer := GetJsonTextField(l_JObject, 'manufacturer');
                    l_Starships.CostInCredits := GetJsonTextField(l_JObject, 'cost_in_credits');
                    l_Starships.Crew := GetJsonTextField(l_JObject, 'crew');
                    l_Starships.Passengers := GetJsonTextField(l_JObject, 'passengers');
                    l_Starships.MaxAtmospheringSpeed := GetJsonTextField(l_JObject, 'max_atmosphering_speed');
                    l_Starships.HyperdriveRating := GetJsonTextField(l_JObject, 'hyperdrive_rating');
                    l_Starships.MGLT := GetJsonTextField(l_JObject, 'MGLT');
                    l_Starships.CargoCapacity := GetJsonTextField(l_JObject, 'cargo_capacity');
                    l_Starships.Consumables := GetJsonTextField(l_JObject, 'consumables');
                    l_Starships.Url := GetJsonTextField(l_JObject, 'url');
                    l_Starships.Created := GetJsonDateTimeField(l_JObject, 'created');
                    l_Starships.Edited := GetJsonDateTimeField(l_JObject, 'edited');
                    l_Starships.Insert();
                end;
                FillResourceAssosiation(l_JObject, 'films', Enum::"SW Resource Types"::starships, l_ID);
                FillResourceAssosiation(l_JObject, 'pilots', Enum::"SW Resource Types"::starships, l_ID);
            end;
            Commit();
        end;
        exit(true);
    end;

    procedure FillSWVehicles(): Boolean
    var
        l_APISetup: Record SWAPISetup;
        l_Vehicles: Record "SW Vehicles";
        l_CurrCounter: Integer;
        l_ID: Integer;
        l_MaxCounter: Integer;
        l_JObject: JsonObject;
        l_ResourceRouteUrl: Text;
        l_Url: Text;
    begin
        l_ResourceRouteUrl := StrSubstNo('%1%2', l_APISetup.Endpoint, Enum::"SW Resource Types"::vehicles);
        l_MaxCounter := GetCategoryCount(l_ResourceRouteUrl);
        for l_CurrCounter := 1 to l_MaxCounter do begin
            l_Url := StrSubstNo('%1/%2', l_ResourceRouteUrl, l_CurrCounter);
            l_JObject := GetJObjectFromUrl(l_Url);
            if l_JObject.Keys().Count <> 0 then begin
                l_ID := l_CurrCounter;
                if not l_Vehicles.Get(l_ID) then begin
                    l_Vehicles.Init();
                    l_Vehicles.ID := l_ID;
                    l_Vehicles.Name := GetJsonTextField(l_JObject, 'name');
                    l_Vehicles.Model := GetJsonTextField(l_JObject, 'model');
                    l_Vehicles.VehicleClass := GetJsonTextField(l_JObject, 'vehicle_class');
                    l_Vehicles.Manufacturer := GetJsonTextField(l_JObject, 'manufacturer');
                    l_Vehicles.Lenght := GetJsonTextField(l_JObject, 'length');
                    l_Vehicles.CostInCredits := GetJsonTextField(l_JObject, 'cost_in_credits');
                    l_Vehicles.Crew := GetJsonTextField(l_JObject, 'crew');
                    l_Vehicles.Passengers := GetJsonTextField(l_JObject, 'passengers');
                    l_Vehicles.MaxAtmospheringSpeed := GetJsonTextField(l_JObject, 'max_atmosphering_speed');
                    l_Vehicles.CargoCapacity := GetJsonTextField(l_JObject, 'cargo_capacity');
                    l_Vehicles.Consumables := GetJsonTextField(l_JObject, 'consumables');
                    l_Vehicles.Url := GetJsonTextField(l_JObject, 'url');
                    l_Vehicles.Created := GetJsonDateTimeField(l_JObject, 'created');
                    l_Vehicles.Edited := GetJsonDateTimeField(l_JObject, 'edited');
                    l_Vehicles.Insert();
                end;
                FillResourceAssosiation(l_JObject, 'films', Enum::"SW Resource Types"::vehicles, l_ID);
                FillResourceAssosiation(l_JObject, 'pilots', Enum::"SW Resource Types"::vehicles, l_ID);
            end;
            Commit();
        end;
        exit(true);
    end;

    procedure GetCategoryCount(p_Url: Text): Integer
    var
        l_JObject: JsonObject;
    begin
        l_JObject := GetJObjectFromUrl(p_Url);
        exit(GetJsonIntegerField(l_JObject, 'count'))
    end;

    procedure GetEnumFromText(p_Text: Text): Enum "SW Resource Types"
    begin
        case p_Text of
            'films':
                exit(Enum::"SW Resource Types"::films);
            'people', 'characters', 'residents', 'pilots':
                exit(Enum::"SW Resource Types"::people);
            'planets', 'homeworld':
                exit(Enum::"SW Resource Types"::planets);
            'species':
                exit(Enum::"SW Resource Types"::species);
            'starships':
                exit(Enum::"SW Resource Types"::starships);
            'vehicles':
                exit(Enum::"SW Resource Types"::vehicles);
            else
                Error('%1 is not an Enum', p_Text);
        end;
    end;

    procedure GetJObjectFromUrl(p_Url: Text): JsonObject
    var
        l_Client: HttpClient;
        l_Content: HttpContent;
        l_Response: HttpResponseMessage;
        l_JObject: JsonObject;
        l_ResponseTxt: Text;
        l_Url: Text;
    begin
        if not l_Client.Get(p_Url, l_Response) then
            Error('Connection failed, %1', l_Response.HttpStatusCode);

        if not l_Response.IsSuccessStatusCode then
            exit;

        l_Content := l_Response.Content;
        l_Content.ReadAs(l_ResponseTxt);
        l_JObject.ReadFrom(l_ResponseTxt);
        exit(l_JObject)
    end;

    procedure GetUrlFromEnum(p_ResourceType: Enum "SW Resource Types"): Text
    var
        l_SWAPISetup: Record SWAPISetup;
    begin
        exit(StrSubstNo('%1%2/', l_SWAPISetup.Endpoint, p_ResourceType))
    end;

    local procedure FillResourceAssosiation(p_JObject: JsonObject; p_Member: Text; p_ResourceType: Enum "SW Resource Types"; p_ID: Integer)
    var
        l_InnerJsonObject: JsonToken;
        l_JToken: JsonToken;
        l_AssValue: Text[100];
    begin
        l_InnerJsonObject := GetInnerJsonToken(p_JObject, p_Member);
        foreach l_JToken in l_InnerJsonObject.AsArray() do begin
            l_AssValue := l_JToken.AsValue().AsText();
            FillSingleResourceAssosiation(p_ResourceType, p_ID, GetEnumFromText(p_Member), l_AssValue);
        end;
    end;

    local procedure FillSingleResourceAssosiation(p_ResourceType: Enum "SW Resource Types"; p_ID: Integer; p_AssType: Enum "SW Resource Types"; p_AssValue: Text[100])
    var
        l_ResourceAssosiation: Record "SW Resource Assosiation";
    begin
        if not l_ResourceAssosiation.Get(p_ResourceType, p_ID, p_AssType, p_AssValue) then begin
            l_ResourceAssosiation.Init();
            l_ResourceAssosiation.ResourceType := p_ResourceType;
            l_ResourceAssosiation.ResourceID := p_ID;
            l_ResourceAssosiation.AssociatedResourceType := p_AssType;
            l_ResourceAssosiation.AssociatedResourceValue := p_AssValue;
            l_ResourceAssosiation.Insert();
        end;
    end;

    local procedure GetInnerJsonToken(p_JObject: JsonObject; p_Member: Text): JsonToken
    var
        l_Result: JsonToken;
    begin
        if p_JObject.Get(p_Member, l_Result) then
            exit(l_Result.AsArray().AsToken());
    end;

    local procedure GetJsonDateField(p_JObject: JsonObject; p_Member: Text): Date
    var
        l_Result: Date;
        l_JToken: JsonToken;
        l_ResultTxt: Text;
    begin
        if p_JObject.Get(p_Member, l_JToken) then begin
            l_ResultTxt := l_JToken.AsValue().AsText();
            if not Evaluate(l_Result, l_ResultTxt) then
                l_Result := 0D;
            exit(l_Result)
        end;
    end;

    local procedure GetJsonDateTimeField(p_JObject: JsonObject; p_Member: Text): DateTime
    var
        l_Result: DateTime;
        l_JToken: JsonToken;
        l_ResultTxt: Text;
    begin
        if p_JObject.Get(p_Member, l_JToken) then begin
            l_ResultTxt := l_JToken.AsValue().AsText();
            if not Evaluate(l_Result, l_ResultTxt) then
                l_Result := 0DT;
            exit(l_Result)
        end;
    end;

    local procedure GetJsonIntegerField(p_JObject: JsonObject; p_Member: Text): Integer
    var
        l_Result: Integer;
        l_JToken: JsonToken;
        l_ResultTxt: Text;
    begin
        if p_JObject.Get(p_Member, l_JToken) then begin
            l_ResultTxt := l_JToken.AsValue().AsText();
            if not Evaluate(l_Result, l_ResultTxt) then
                l_Result := 0;
            exit(l_Result)
        end;
    end;

    local procedure GetJsonTextField(p_JObject: JsonObject; p_Member: Text): Text
    var
        l_Result: JsonToken;
    begin
        if not p_JObject.Get(p_Member, l_Result) then
            exit('');
        if l_Result.AsValue().IsNull() then
            exit('');
        exit(l_Result.AsValue().AsText());
    end;
}
