namespace SWAPI.SWAPI;

codeunit 50101 "SWAPI Mng"
{
    var
        g_APISetup: Record SWAPISetup;
        g_ImportSuccessfullL: Label 'Data imported successfully.';

    procedure FillAllResourcesOfAKind(p_Resource: Enum "SW Resource Types")
    var
        l_Dialog: Dialog;
        l_CurrID: Integer;
        l_ID: Integer;
        l_MaxID: Integer;
        l_JObject: JsonObject;
        l_DialogL: Label 'Filling %1 tables, please wait... \Importing #2## \Total #3##';
        l_ResourceRouteUrl: Text;
        l_Url: Text;
    begin
        l_Dialog.Open(StrSubstNo(l_DialogL, p_Resource));
        l_ResourceRouteUrl := StrSubstNo('%1%2', g_APISetup.Endpoint, p_Resource);
        l_MaxID := GetCategoryCount(l_ResourceRouteUrl);
        l_Dialog.Update(3, l_MaxID);
        for l_CurrID := 1 to l_MaxID do begin
            l_Dialog.Update(2, l_CurrID);
            if not RessourceWithCurrentIDExist(p_Resource, l_CurrID) then begin
                l_Url := StrSubstNo('%1/%2', l_ResourceRouteUrl, l_CurrID);
                l_JObject := GetJObjectFromUrl(l_Url);
                if l_JObject.Keys().Count <> 0 then
                    StartFillJObjectContentInSWResource(p_Resource, l_CurrID, l_JObject);
            end;
        end;
        l_Dialog.Close();
        OnAfterFillAllResourcesOfAKind(p_Resource);
    end;

    procedure FillJObjectContentInSWFilms(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Films: Record "SW Films";
    begin
        if not l_Films.Get(p_ID) then begin
            l_Films.Init();
            l_Films.ID := p_ID;
            l_Films.Title := GetJsonTextField(p_JObject, 'title');
            l_Films.EpisodeID := GetJsonIntegerField(p_JObject, 'episode_id');
            l_Films.OpeningCrawl := GetJsonTextField(p_JObject, 'opening_crawl');
            l_Films.Director := GetJsonTextField(p_JObject, 'director');
            l_Films.Producer := GetJsonTextField(p_JObject, 'producer');
            l_Films.ReleaseDate := GetJsonDateField(p_JObject, 'release_date');
            l_Films.Url := GetJsonTextField(p_JObject, 'url');
            l_Films.Created := GetJsonDateTimeField(p_JObject, 'created');
            l_Films.Edited := GetJsonDateTimeField(p_JObject, 'edited');
            l_Films.Insert();
        end;
        FillResourceAssosiation(p_JObject, 'species', Enum::"SW Resource Types"::films, p_ID);
        FillResourceAssosiation(p_JObject, 'starships', Enum::"SW Resource Types"::films, p_ID);
        FillResourceAssosiation(p_JObject, 'vehicles', Enum::"SW Resource Types"::films, p_ID);
        FillResourceAssosiation(p_JObject, 'characters', Enum::"SW Resource Types"::films, p_ID);
        FillResourceAssosiation(p_JObject, 'planets', Enum::"SW Resource Types"::films, p_ID);
        Commit();
    end;

    procedure FillJObjectContentInSWPeople(p_ID: Integer; p_JObject: JsonObject)
    var
        l_People: Record "SW People";
    begin
        if not l_People.Get(p_ID) then begin
            l_People.Init();
            l_People.ID := p_ID;
            l_People.Name := GetJsonTextField(p_JObject, 'name');
            l_People.BirthYear := GetJsonTextField(p_JObject, 'birth_year');
            l_People.EyeColor := GetJsonTextField(p_JObject, 'eye_color');
            l_People.Gender := GetJsonTextField(p_JObject, 'gender');
            l_People.HairColor := GetJsonTextField(p_JObject, 'hair_color');
            l_People.Height := GetJsonTextField(p_JObject, 'height');
            l_People.Mass := GetJsonTextField(p_JObject, 'mass');
            l_People.SkinColor := GetJsonTextField(p_JObject, 'skin_color');
            l_People.Homeworld := GetJsonTextField(p_JObject, 'homeworld');
            l_People.Url := GetJsonTextField(p_JObject, 'url');
            l_People.Created := GetJsonDateTimeField(p_JObject, 'created');
            l_People.Edited := GetJsonDateTimeField(p_JObject, 'edited');
            l_People.Insert();
        end;
        FillResourceAssosiation(p_JObject, 'films', Enum::"SW Resource Types"::people, p_ID);
        FillResourceAssosiation(p_JObject, 'species', Enum::"SW Resource Types"::people, p_ID);
        FillResourceAssosiation(p_JObject, 'starships', Enum::"SW Resource Types"::people, p_ID);
        FillResourceAssosiation(p_JObject, 'vehicles', Enum::"SW Resource Types"::people, p_ID);
        Commit();
    end;

    procedure FillJObjectContentInSWPlanets(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Planets: Record "SW Planets";
    begin
        if not l_Planets.Get(p_ID) then begin
            l_Planets.Init();
            l_Planets.ID := p_ID;
            l_Planets.Name := GetJsonTextField(p_JObject, 'name');
            l_Planets.Diameter := GetJsonTextField(p_JObject, 'diameter');
            l_Planets.RotationPeriod := GetJsonTextField(p_JObject, 'rotation_period');
            l_Planets.OrbitalPeriod := GetJsonTextField(p_JObject, 'orbital_period');
            l_Planets.Gravity := GetJsonTextField(p_JObject, 'gravity');
            l_Planets.Population := GetJsonTextField(p_JObject, 'population');
            l_Planets.Climate := GetJsonTextField(p_JObject, 'climate');
            l_Planets.Terrain := GetJsonTextField(p_JObject, 'terrain');
            l_Planets.SurfaceWater := GetJsonTextField(p_JObject, 'surface_water');
            l_Planets.Url := GetJsonTextField(p_JObject, 'url');
            l_Planets.Created := GetJsonDateTimeField(p_JObject, 'created');
            l_Planets.Edited := GetJsonDateTimeField(p_JObject, 'edited');
            l_Planets.Insert();
        end;
        FillResourceAssosiation(p_JObject, 'residents', Enum::"SW Resource Types"::planets, p_ID);
        FillResourceAssosiation(p_JObject, 'films', Enum::"SW Resource Types"::planets, p_ID);
        Commit();
    end;

    procedure FillJObjectContentInSWSpecies(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Species: Record "SW Species";
    begin
        if not l_Species.Get(p_ID) then begin
            l_Species.Init();
            l_Species.ID := p_ID;
            l_Species.Name := GetJsonTextField(p_JObject, 'name');
            l_Species.Classification := GetJsonTextField(p_JObject, 'classification');
            l_Species.Designation := GetJsonTextField(p_JObject, 'designation');
            l_Species.AverageHeight := GetJsonTextField(p_JObject, 'average_height');
            l_Species.AverageLifeSpan := GetJsonTextField(p_JObject, 'average_lifespan');
            l_Species.EyeColor := GetJsonTextField(p_JObject, 'eye_colors');
            l_Species.HairColors := GetJsonTextField(p_JObject, 'hair_colors');
            l_Species.SkinColors := GetJsonTextField(p_JObject, 'skin_colors');
            l_Species.Language := GetJsonTextField(p_JObject, 'language');
            l_Species.Homeworld := GetJsonTextField(p_JObject, 'homeworld');
            l_Species.Url := GetJsonTextField(p_JObject, 'url');
            l_Species.Created := GetJsonDateTimeField(p_JObject, 'created');
            l_Species.Edited := GetJsonDateTimeField(p_JObject, 'edited');
            l_Species.Insert();
        end;
        FillResourceAssosiation(p_JObject, 'people', Enum::"SW Resource Types"::species, p_ID);
        FillResourceAssosiation(p_JObject, 'films', Enum::"SW Resource Types"::species, p_ID);
        Commit();
    end;

    procedure FillJObjectContentInSWStarships(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Starships: Record "SW Starships";
    begin
        if not l_Starships.Get(p_ID) then begin
            l_Starships.Init();
            l_Starships.ID := p_ID;
            l_Starships.Name := GetJsonTextField(p_JObject, 'name');
            l_Starships.Model := GetJsonTextField(p_JObject, 'model');
            l_Starships.StarshipClass := GetJsonTextField(p_JObject, 'starship_class');
            l_Starships.Manufacturer := GetJsonTextField(p_JObject, 'manufacturer');
            l_Starships.CostInCredits := GetJsonTextField(p_JObject, 'cost_in_credits');
            l_Starships.Crew := GetJsonTextField(p_JObject, 'crew');
            l_Starships.Passengers := GetJsonTextField(p_JObject, 'passengers');
            l_Starships.MaxAtmospheringSpeed := GetJsonTextField(p_JObject, 'max_atmosphering_speed');
            l_Starships.HyperdriveRating := GetJsonTextField(p_JObject, 'hyperdrive_rating');
            l_Starships.MGLT := GetJsonTextField(p_JObject, 'MGLT');
            l_Starships.CargoCapacity := GetJsonTextField(p_JObject, 'cargo_capacity');
            l_Starships.Consumables := GetJsonTextField(p_JObject, 'consumables');
            l_Starships.Url := GetJsonTextField(p_JObject, 'url');
            l_Starships.Created := GetJsonDateTimeField(p_JObject, 'created');
            l_Starships.Edited := GetJsonDateTimeField(p_JObject, 'edited');
            l_Starships.Insert();
        end;
        FillResourceAssosiation(p_JObject, 'films', Enum::"SW Resource Types"::starships, p_ID);
        FillResourceAssosiation(p_JObject, 'pilots', Enum::"SW Resource Types"::starships, p_ID);
        Commit();
    end;

    procedure FillJObjectContentInSWVehicles(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Vehicles: Record "SW Vehicles";
    begin
        if not l_Vehicles.Get(p_ID) then begin
            l_Vehicles.Init();
            l_Vehicles.ID := p_ID;
            l_Vehicles.Name := GetJsonTextField(p_JObject, 'name');
            l_Vehicles.Model := GetJsonTextField(p_JObject, 'model');
            l_Vehicles.VehicleClass := GetJsonTextField(p_JObject, 'vehicle_class');
            l_Vehicles.Manufacturer := GetJsonTextField(p_JObject, 'manufacturer');
            l_Vehicles.Lenght := GetJsonTextField(p_JObject, 'length');
            l_Vehicles.CostInCredits := GetJsonTextField(p_JObject, 'cost_in_credits');
            l_Vehicles.Crew := GetJsonTextField(p_JObject, 'crew');
            l_Vehicles.Passengers := GetJsonTextField(p_JObject, 'passengers');
            l_Vehicles.MaxAtmospheringSpeed := GetJsonTextField(p_JObject, 'max_atmosphering_speed');
            l_Vehicles.CargoCapacity := GetJsonTextField(p_JObject, 'cargo_capacity');
            l_Vehicles.Consumables := GetJsonTextField(p_JObject, 'consumables');
            l_Vehicles.Url := GetJsonTextField(p_JObject, 'url');
            l_Vehicles.Created := GetJsonDateTimeField(p_JObject, 'created');
            l_Vehicles.Edited := GetJsonDateTimeField(p_JObject, 'edited');
            l_Vehicles.Insert();
        end;
        FillResourceAssosiation(p_JObject, 'films', Enum::"SW Resource Types"::vehicles, p_ID);
        FillResourceAssosiation(p_JObject, 'pilots', Enum::"SW Resource Types"::vehicles, p_ID);
        Commit();
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

    procedure SendStatusNotification()
    var
        l_StatusNotification: Notification;
    begin
        l_StatusNotification.Message(g_ImportSuccessfullL);
        l_StatusNotification.Send();
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

    local procedure GetRecRefTableNoFromResourceEnum(p_Resource: Enum "SW Resource Types"): Integer
    begin
        case p_Resource of
            Enum::"SW Resource Types"::films:
                exit(Database::"SW Films");
            Enum::"SW Resource Types"::people:
                exit(Database::"SW People");
            Enum::"SW Resource Types"::planets:
                exit(Database::"SW Planets");
            Enum::"SW Resource Types"::species:
                exit(Database::"SW Species");
            Enum::"SW Resource Types"::starships:
                exit(Database::"SW Starships");
            Enum::"SW Resource Types"::vehicles:
                exit(Database::"SW Vehicles");
        end;
    end;

    local procedure RessourceWithCurrentIDExist(p_Resource: Enum "SW Resource Types"; l_CurrID: Integer): Boolean
    var
        l_RecRef: RecordRef;
        l_IDFieldRef: FieldRef;
    begin
        l_RecRef.Open(GetRecRefTableNoFromResourceEnum(p_Resource));
        l_IDFieldRef := l_RecRef.Field(1);
        l_IDFieldRef.SetRange(l_CurrID);
        if not l_RecRef.FindSet() then begin
            l_RecRef.Close();
            exit(false);
        end;
        l_RecRef.Close();
        exit(true);
    end;

    local procedure StartFillJObjectContentInSWResource(p_Resource: Enum "SW Resource Types"; l_ID: Integer; l_JObject: JsonObject)
    begin
        case p_Resource of
            Enum::"SW Resource Types"::films:
                FillJObjectContentInSWFilms(l_ID, l_JObject);
            Enum::"SW Resource Types"::people:
                FillJObjectContentInSWPeople(l_ID, l_JObject);
            Enum::"SW Resource Types"::planets:
                FillJObjectContentInSWPlanets(l_ID, l_JObject);
            Enum::"SW Resource Types"::species:
                FillJObjectContentInSWSpecies(l_ID, l_JObject);
            Enum::"SW Resource Types"::starships:
                FillJObjectContentInSWStarships(l_ID, l_JObject);
            Enum::"SW Resource Types"::vehicles:
                FillJObjectContentInSWVehicles(l_ID, l_JObject);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SWAPI Mng", 'OnAfterFillAllResourcesOfAKind', '', false, false)]
    local procedure SendStatus()
    begin
        SendStatusNotification();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillAllResourcesOfAKind(p_Resource: Enum "SW Resource Types")
    begin
    end;
}
