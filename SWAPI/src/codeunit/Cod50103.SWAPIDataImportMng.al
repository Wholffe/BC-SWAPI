namespace SWAPI.SWAPI;

codeunit 50103 "SWAPI Data Import Mng"
{
    var
        g_JMng: Codeunit "SW Json Mng";
        g_SWResourceMng: Codeunit "SW Resource Type Helper";
        g_SWUtilityMng: Codeunit "SW Utility Mng";

    local procedure DataAlreadyImported(p_Resource: Enum "SW Resource Types"): Boolean
    var
        l_RecRef: RecordRef;
        l_MaxID: Integer;
        l_ResourceRouteUrl: Text;
    begin
        l_ResourceRouteUrl := g_SWResourceMng.GetUrlFromEnum(p_Resource);
        l_MaxID := g_SWUtilityMng.GetCategoryCountFromUrl(l_ResourceRouteUrl);
        l_RecRef.Open(g_SWResourceMng.GetRecRefTableNoFromResourceEnum(p_Resource));
        if not (l_RecRef.Count = l_MaxID) then begin
            l_RecRef.Close();
            exit;
        end;
        l_RecRef.Close();
        OnAfterDataAlreadyImported(p_Resource);
        exit(true)
    end;

    procedure FillAllResourcesOfAKind(p_Resource: Enum "SW Resource Types")
    var
        l_Dialog: Dialog;
        l_CurrID: Integer;
        l_ID: Integer;
        l_MaxID: Integer;
        l_JObject: JsonObject;
        l_DialogL: Label 'Filling %1 tables, please wait... \Looking for ID #2## \Total #3##';
        l_ResourceRouteUrl: Text;
        l_Url: Text;
    begin
        if DataAlreadyImported(p_Resource) then
            exit;
        l_Dialog.Open(StrSubstNo(l_DialogL, p_Resource));
        l_ResourceRouteUrl := g_SWResourceMng.GetUrlFromEnum(p_Resource);
        l_MaxID := g_SWUtilityMng.GetCategoryCountFromUrl(l_ResourceRouteUrl);
        l_Dialog.Update(3, l_MaxID);
        l_CurrID := 1;
        while l_CurrID <= l_MaxID do begin
            l_Dialog.Update(2, l_CurrID);
            if not ResourceWithCurrentIDExist(p_Resource, l_CurrID) then begin
                l_Url := StrSubstNo('%1%2', l_ResourceRouteUrl, l_CurrID);
                l_JObject := g_JMng.GetJObjectFromUrl(l_Url);
                if not (l_JObject.Keys().Count = 0) then
                    StartFillJObjectContentInSWResource(p_Resource, l_CurrID, l_JObject)
                else
                    l_MaxID := l_MaxID + 1;
            end;
            l_CurrID := l_CurrID + 1;
        end;
        g_SWUtilityMng.ValidateAllResourcesAss();
        l_Dialog.Close();
        OnAfterFillAllResourcesOfAKind(p_Resource);
    end;

    local procedure FillJObjectContentInSWFilms(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Films: Record "SW Films";
    begin
        if not l_Films.Get(p_ID) then begin
            l_Films.Init();
            l_Films.ID := p_ID;
            l_Films.Name := g_JMng.GetJsonTextField(p_JObject, 'title');
            l_Films.EpisodeID := g_JMng.GetJsonIntegerField(p_JObject, 'episode_id');
            l_Films.OpeningCrawl := g_JMng.GetJsonTextField(p_JObject, 'opening_crawl');
            l_Films.Director := g_JMng.GetJsonTextField(p_JObject, 'director');
            l_Films.Producer := g_JMng.GetJsonTextField(p_JObject, 'producer');
            l_Films.ReleaseDate := g_JMng.GetJsonDateField(p_JObject, 'release_date');
            l_Films.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Films.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Films.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Films.Insert();
        end;
        FillResourceAssociation(p_JObject, 'species', "SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'starships', "SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'vehicles', "SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'characters', "SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'planets', "SW Resource Types"::films, p_ID);
        Commit();
    end;

    local procedure FillJObjectContentInSWPeople(p_ID: Integer; p_JObject: JsonObject)
    var
        l_People: Record "SW People";
    begin
        if not l_People.Get(p_ID) then begin
            l_People.Init();
            l_People.ID := p_ID;
            l_People.Name := g_JMng.GetJsonTextField(p_JObject, 'name');
            l_People.BirthYear := g_JMng.GetJsonTextField(p_JObject, 'birth_year');
            l_People.EyeColor := g_JMng.GetJsonTextField(p_JObject, 'eye_color');
            l_People.Gender := g_JMng.GetJsonTextField(p_JObject, 'gender');
            l_People.HairColor := g_JMng.GetJsonTextField(p_JObject, 'hair_color');
            l_People.Height := g_JMng.GetJsonIntegerField(p_JObject, 'height');
            l_People.Mass := g_JMng.GetJsonIntegerField(p_JObject, 'mass');
            l_People.SkinColor := g_JMng.GetJsonTextField(p_JObject, 'skin_color');
            l_People.Validate(Homeworld, g_JMng.GetJsonTextField(p_JObject, 'homeworld'));
            l_People.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_People.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_People.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_People.Insert();
        end;
        FillResourceAssociation(p_JObject, 'films', "SW Resource Types"::people, p_ID);
        FillResourceAssociation(p_JObject, 'species', "SW Resource Types"::people, p_ID);
        FillResourceAssociation(p_JObject, 'starships', "SW Resource Types"::people, p_ID);
        FillResourceAssociation(p_JObject, 'vehicles', "SW Resource Types"::people, p_ID);
        Commit();
    end;

    local procedure FillJObjectContentInSWPlanets(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Planets: Record "SW Planets";
    begin
        if not l_Planets.Get(p_ID) then begin
            l_Planets.Init();
            l_Planets.ID := p_ID;
            l_Planets.Name := g_JMng.GetJsonTextField(p_JObject, 'name');
            l_Planets.Diameter := g_JMng.GetJsonIntegerField(p_JObject, 'diameter');
            l_Planets.RotationPeriod := g_JMng.GetJsonIntegerField(p_JObject, 'rotation_period');
            l_Planets.OrbitalPeriod := g_JMng.GetJsonIntegerField(p_JObject, 'orbital_period');
            l_Planets.Gravity := g_JMng.GetJsonIntegerField(p_JObject, 'gravity');
            l_Planets.Population := g_JMng.GetJsonIntegerField(p_JObject, 'population');
            l_Planets.Climate := g_JMng.GetJsonTextField(p_JObject, 'climate');
            l_Planets.Terrain := g_JMng.GetJsonTextField(p_JObject, 'terrain');
            l_Planets.SurfaceWater := g_JMng.GetJsonIntegerField(p_JObject, 'surface_water');
            l_Planets.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Planets.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Planets.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Planets.Insert();
        end;
        FillResourceAssociation(p_JObject, 'residents', "SW Resource Types"::planets, p_ID);
        FillResourceAssociation(p_JObject, 'films', "SW Resource Types"::planets, p_ID);
        Commit();
    end;

    local procedure FillJObjectContentInSWSpecies(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Species: Record "SW Species";
    begin
        if not l_Species.Get(p_ID) then begin
            l_Species.Init();
            l_Species.ID := p_ID;
            l_Species.Name := g_JMng.GetJsonTextField(p_JObject, 'name');
            l_Species.Classification := g_JMng.GetJsonTextField(p_JObject, 'classification');
            l_Species.Designation := g_JMng.GetJsonTextField(p_JObject, 'designation');
            l_Species.AverageHeight := g_JMng.GetJsonIntegerField(p_JObject, 'average_height');
            l_Species.AverageLifeSpan := g_JMng.GetJsonIntegerField(p_JObject, 'average_lifespan');
            l_Species.EyeColor := g_JMng.GetJsonTextField(p_JObject, 'eye_colors');
            l_Species.HairColors := g_JMng.GetJsonTextField(p_JObject, 'hair_colors');
            l_Species.SkinColors := g_JMng.GetJsonTextField(p_JObject, 'skin_colors');
            l_Species.Language := g_JMng.GetJsonTextField(p_JObject, 'language');
            l_Species.Validate(Homeworld, g_JMng.GetJsonTextField(p_JObject, 'homeworld'));
            l_Species.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Species.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Species.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Species.Insert();
        end;
        FillResourceAssociation(p_JObject, 'people', "SW Resource Types"::species, p_ID);
        FillResourceAssociation(p_JObject, 'films', "SW Resource Types"::species, p_ID);
        Commit();
    end;

    local procedure FillJObjectContentInSWStarships(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Starships: Record "SW Starships";
    begin
        if not l_Starships.Get(p_ID) then begin
            l_Starships.Init();
            l_Starships.ID := p_ID;
            l_Starships.Name := g_JMng.GetJsonTextField(p_JObject, 'name');
            l_Starships.Model := g_JMng.GetJsonTextField(p_JObject, 'model');
            l_Starships.StarshipClass := g_JMng.GetJsonTextField(p_JObject, 'starship_class');
            l_Starships.Manufacturer := g_JMng.GetJsonTextField(p_JObject, 'manufacturer');
            l_Starships.CostInCredits := g_JMng.GetJsonIntegerField(p_JObject, 'cost_in_credits');
            l_Starships.Length := g_JMng.GetJsonIntegerField(p_JObject, 'length');
            l_Starships.Crew := g_JMng.GetJsonIntegerField(p_JObject, 'crew');
            l_Starships.Passengers := g_JMng.GetJsonIntegerField(p_JObject, 'passengers');
            l_Starships.MaxAtmospheringSpeed := g_JMng.GetJsonIntegerField(p_JObject, 'max_atmosphering_speed');
            l_Starships.HyperdriveRating := g_JMng.GetJsonDecimalField(p_JObject, 'hyperdrive_rating');
            l_Starships.MGLT := g_JMng.GetJsonIntegerField(p_JObject, 'MGLT');
            l_Starships.CargoCapacity := g_JMng.GetJsonIntegerField(p_JObject, 'cargo_capacity');
            l_Starships.Consumables := g_JMng.GetJsonTextField(p_JObject, 'consumables');
            l_Starships.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Starships.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Starships.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Starships.Insert();
        end;
        FillResourceAssociation(p_JObject, 'films', "SW Resource Types"::starships, p_ID);
        FillResourceAssociation(p_JObject, 'pilots', "SW Resource Types"::starships, p_ID);
        Commit();
    end;

    local procedure FillJObjectContentInSWVehicles(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Vehicles: Record "SW Vehicles";
    begin
        if not l_Vehicles.Get(p_ID) then begin
            l_Vehicles.Init();
            l_Vehicles.ID := p_ID;
            l_Vehicles.Name := g_JMng.GetJsonTextField(p_JObject, 'name');
            l_Vehicles.Model := g_JMng.GetJsonTextField(p_JObject, 'model');
            l_Vehicles.VehicleClass := g_JMng.GetJsonTextField(p_JObject, 'vehicle_class');
            l_Vehicles.Manufacturer := g_JMng.GetJsonTextField(p_JObject, 'manufacturer');
            l_Vehicles.Lenght := g_JMng.GetJsonDecimalField(p_JObject, 'length');
            l_Vehicles.CostInCredits := g_JMng.GetJsonIntegerField(p_JObject, 'cost_in_credits');
            l_Vehicles.Crew := g_JMng.GetJsonIntegerField(p_JObject, 'crew');
            l_Vehicles.Passengers := g_JMng.GetJsonIntegerField(p_JObject, 'passengers');
            l_Vehicles.MaxAtmospheringSpeed := g_JMng.GetJsonIntegerField(p_JObject, 'max_atmosphering_speed');
            l_Vehicles.CargoCapacity := g_JMng.GetJsonIntegerField(p_JObject, 'cargo_capacity');
            l_Vehicles.Consumables := g_JMng.GetJsonTextField(p_JObject, 'consumables');
            l_Vehicles.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Vehicles.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Vehicles.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Vehicles.Insert();
        end;
        FillResourceAssociation(p_JObject, 'films', "SW Resource Types"::vehicles, p_ID);
        FillResourceAssociation(p_JObject, 'pilots', "SW Resource Types"::vehicles, p_ID);
        Commit();
    end;

    local procedure FillResourceAssociation(p_JObject: JsonObject; p_Member: Text; p_ResourceType: Enum "SW Resource Types"; p_ID: Integer)
    var
        l_InnerJsonToken: JsonToken;
        l_JToken: JsonToken;
        l_InnerJsonTokenContent: Text;
        l_AssUrl: Text[100];
    begin
        l_InnerJsonToken := g_JMng.GetInnerJsonToken(p_JObject, p_Member);
        l_InnerJsonToken.WriteTo(l_InnerJsonTokenContent);
        if l_InnerJsonTokenContent = '' then
            exit;
        foreach l_JToken in l_InnerJsonToken.AsArray() do begin
            l_AssUrl := l_JToken.AsValue().AsText();
            FillSingleResourceAssociation(p_ResourceType, p_ID, g_SWResourceMng.GetEnumFromText(p_Member), l_AssUrl);
        end;
    end;

    local procedure FillSingleResourceAssociation(p_ResourceType: Enum "SW Resource Types"; p_ID: Integer; p_AssType: Enum "SW Resource Types"; p_AssUrl: Text[100])
    var
        l_ResourceAssociation: Record "SW Resource Association";
        l_AssResourceID: Integer;
    begin
        l_AssResourceID := GetAssIDFromAssUrl(p_AssUrl, p_AssType);
        if not l_ResourceAssociation.Get(p_ResourceType, p_ID, p_AssType, l_AssResourceID) then begin
            l_ResourceAssociation.Init();
            l_ResourceAssociation.ResourceType := p_ResourceType;
            l_ResourceAssociation.ResourceID := p_ID;
            l_ResourceAssociation.AssociatedResourceType := p_AssType;
            l_ResourceAssociation.AssResourceID := l_AssResourceID;
            l_ResourceAssociation.Insert();
        end;
    end;

    local procedure GetAssIDFromAssUrl(p_AssUrl: Text; p_AssType: Enum "SW Resource Types"): Integer
    var
        l_APISetup: Record SWAPISetup;
        l_AssResourceID: Integer;
        l_RemoveTxt: Text;
    begin
        p_AssUrl := p_AssUrl.TrimEnd('/');
        l_APISetup.FindFirst();
        l_RemoveTxt := StrSubstNo('%1/%2/', l_APISetup.Endpoint, p_AssType);
        p_AssUrl := p_AssUrl.Replace(l_RemoveTxt, '');

        if Evaluate(l_AssResourceID, p_AssUrl) then
            exit(l_AssResourceID)
        else
            Error('%1 is not a valid ID', l_AssResourceID);
    end;

    local procedure ResourceWithCurrentIDExist(p_Resource: Enum "SW Resource Types"; l_CurrID: Integer): Boolean
    var
        l_RecRef: RecordRef;
        l_IDFieldRef: FieldRef;
    begin
        l_RecRef.Open(g_SWResourceMng.GetRecRefTableNoFromResourceEnum(p_Resource));
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
            "SW Resource Types"::films:
                FillJObjectContentInSWFilms(l_ID, l_JObject);
            "SW Resource Types"::people:
                FillJObjectContentInSWPeople(l_ID, l_JObject);
            "SW Resource Types"::planets:
                FillJObjectContentInSWPlanets(l_ID, l_JObject);
            "SW Resource Types"::species:
                FillJObjectContentInSWSpecies(l_ID, l_JObject);
            "SW Resource Types"::starships:
                FillJObjectContentInSWStarships(l_ID, l_JObject);
            "SW Resource Types"::vehicles:
                FillJObjectContentInSWVehicles(l_ID, l_JObject);
            else
                Error('%1 is not a valid enum to import.', p_Resource);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDataAlreadyImported(p_Resource: Enum "SW Resource Types")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillAllResourcesOfAKind(p_Resource: Enum SWAPI.SWAPI."SW Resource Types")
    begin
    end;
}