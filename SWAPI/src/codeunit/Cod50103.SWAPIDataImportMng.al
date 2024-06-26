namespace SWAPI.SWAPI;

codeunit 50103 "SWAPI Data Import Mng"
{
    var
        g_JMng: Codeunit "SW Json Mng";
        g_SWResourceMng: Codeunit "SW Resource Type Helper";
        g_SWUtilityMng: Codeunit "SW Utility Mng";


    /// <summary>
    /// Fills all resources of a specified Star Wars resource type.
    /// </summary>
    /// <param name="p_Resource">The resource type you want to fill the database with.</param>
    /// <remarks>
    ///     This function retrieves data for the specified resource type from the corresponding API route and fills the database with the retrieved data.
    /// </remarks>
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
        l_Dialog.Open(StrSubstNo(l_DialogL, g_SWResourceMng.GetTableNameFromResourceEnum(p_Resource)));
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
        l_Dialog.Close();
        OnAfterFillAllResourcesOfAKind(p_Resource);
    end;

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

    local procedure FillJObjectContentInSWCharacter(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Character: Record "SW Character";
    begin
        if not l_Character.Get(p_ID) then begin
            l_Character.Init();
            l_Character.ID := p_ID;
            l_Character.Name := g_JMng.GetJsonTextField(p_JObject, 'name');
            l_Character.BirthYear := g_JMng.GetJsonTextField(p_JObject, 'birth_year');
            l_Character.EyeColor := g_JMng.GetJsonTextField(p_JObject, 'eye_color');
            l_Character.Gender := g_JMng.GetJsonTextField(p_JObject, 'gender');
            l_Character.HairColor := g_JMng.GetJsonTextField(p_JObject, 'hair_color');
            l_Character.Height := g_JMng.GetJsonIntegerField(p_JObject, 'height');
            l_Character.Mass := g_JMng.GetJsonIntegerField(p_JObject, 'mass');
            l_Character.SkinColor := g_JMng.GetJsonTextField(p_JObject, 'skin_color');
            l_Character.HomeworldID := GetAssIDFromAssUrl(g_JMng.GetJsonTextField(p_JObject, 'homeworld'), "SW Resource Types"::planets);
            l_Character.SpeciesID := GetSpeciesID(p_JObject);
            l_Character.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Character.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Character.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Character.Insert();
        end;
        FillResourceAssociation(p_JObject, 'films', "SW Resource Types"::people, p_ID);
        FillResourceAssociation(p_JObject, 'starships', "SW Resource Types"::people, p_ID);
        FillResourceAssociation(p_JObject, 'vehicles', "SW Resource Types"::people, p_ID);
        Commit();
    end;

    local procedure FillJObjectContentInSWFilm(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Film: Record "SW Film";
    begin
        if not l_Film.Get(p_ID) then begin
            l_Film.Init();
            l_Film.ID := p_ID;
            l_Film.Name := g_JMng.GetJsonTextField(p_JObject, 'title');
            l_Film.EpisodeID := g_JMng.GetJsonIntegerField(p_JObject, 'episode_id');
            l_Film.OpeningCrawl := g_JMng.GetJsonTextField(p_JObject, 'opening_crawl');
            l_Film.Director := g_JMng.GetJsonTextField(p_JObject, 'director');
            l_Film.Producer := g_JMng.GetJsonTextField(p_JObject, 'producer');
            l_Film.ReleaseDate := g_JMng.GetJsonDateField(p_JObject, 'release_date');
            l_Film.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Film.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Film.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Film.Insert();
        end;
        FillResourceAssociation(p_JObject, 'species', "SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'starships', "SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'vehicles', "SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'characters', "SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'planets', "SW Resource Types"::films, p_ID);
        Commit();
    end;

    local procedure FillJObjectContentInSWPlanet(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Planet: Record "SW Planet";
    begin
        if not l_Planet.Get(p_ID) then begin
            l_Planet.Init();
            l_Planet.ID := p_ID;
            l_Planet.Name := g_JMng.GetJsonTextField(p_JObject, 'name');
            l_Planet.Diameter := g_JMng.GetJsonIntegerField(p_JObject, 'diameter');
            l_Planet.RotationPeriod := g_JMng.GetJsonIntegerField(p_JObject, 'rotation_period');
            l_Planet.OrbitalPeriod := g_JMng.GetJsonIntegerField(p_JObject, 'orbital_period');
            l_Planet.Gravity := g_JMng.GetJsonIntegerField(p_JObject, 'gravity');
            l_Planet.Population := g_JMng.GetJsonIntegerField(p_JObject, 'population');
            l_Planet.Climate := g_JMng.GetJsonTextField(p_JObject, 'climate');
            l_Planet.Terrain := g_JMng.GetJsonTextField(p_JObject, 'terrain');
            l_Planet.SurfaceWater := g_JMng.GetJsonIntegerField(p_JObject, 'surface_water');
            l_Planet.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Planet.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Planet.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Planet.Insert();
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
            l_Species.HomeworldID := GetAssIDFromAssUrl(g_JMng.GetJsonTextField(p_JObject, 'homeworld'), "SW Resource Types"::planets);
            l_Species.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Species.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Species.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Species.Insert();
        end;
        FillResourceAssociation(p_JObject, 'people', "SW Resource Types"::species, p_ID);
        FillResourceAssociation(p_JObject, 'films', "SW Resource Types"::species, p_ID);
        Commit();
    end;

    local procedure FillJObjectContentInSWStarship(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Starship: Record "SW Starship";
    begin
        if not l_Starship.Get(p_ID) then begin
            l_Starship.Init();
            l_Starship.ID := p_ID;
            l_Starship.Name := g_JMng.GetJsonTextField(p_JObject, 'name');
            l_Starship.Model := g_JMng.GetJsonTextField(p_JObject, 'model');
            l_Starship.StarshipClass := g_JMng.GetJsonTextField(p_JObject, 'starship_class');
            l_Starship.Manufacturer := g_JMng.GetJsonTextField(p_JObject, 'manufacturer');
            l_Starship.CostInCredits := g_JMng.GetJsonIntegerField(p_JObject, 'cost_in_credits');
            l_Starship.Length := g_JMng.GetJsonIntegerField(p_JObject, 'length');
            l_Starship.Crew := g_JMng.GetJsonIntegerField(p_JObject, 'crew');
            l_Starship.Passengers := g_JMng.GetJsonIntegerField(p_JObject, 'passengers');
            l_Starship.MaxAtmospheringSpeed := g_JMng.GetJsonIntegerField(p_JObject, 'max_atmosphering_speed');
            l_Starship.HyperdriveRating := g_JMng.GetJsonDecimalField(p_JObject, 'hyperdrive_rating');
            l_Starship.MGLT := g_JMng.GetJsonIntegerField(p_JObject, 'MGLT');
            l_Starship.CargoCapacity := g_JMng.GetJsonIntegerField(p_JObject, 'cargo_capacity');
            l_Starship.Consumables := g_JMng.GetJsonTextField(p_JObject, 'consumables');
            l_Starship.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Starship.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Starship.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Starship.Insert();
        end;
        FillResourceAssociation(p_JObject, 'films', "SW Resource Types"::starships, p_ID);
        FillResourceAssociation(p_JObject, 'pilots', "SW Resource Types"::starships, p_ID);
        Commit();
    end;

    local procedure FillJObjectContentInSWVehicle(p_ID: Integer; p_JObject: JsonObject)
    var
        l_Vehicle: Record "SW Vehicle";
    begin
        if not l_Vehicle.Get(p_ID) then begin
            l_Vehicle.Init();
            l_Vehicle.ID := p_ID;
            l_Vehicle.Name := g_JMng.GetJsonTextField(p_JObject, 'name');
            l_Vehicle.Model := g_JMng.GetJsonTextField(p_JObject, 'model');
            l_Vehicle.VehicleClass := g_JMng.GetJsonTextField(p_JObject, 'vehicle_class');
            l_Vehicle.Manufacturer := g_JMng.GetJsonTextField(p_JObject, 'manufacturer');
            l_Vehicle.Lenght := g_JMng.GetJsonDecimalField(p_JObject, 'length');
            l_Vehicle.CostInCredits := g_JMng.GetJsonIntegerField(p_JObject, 'cost_in_credits');
            l_Vehicle.Crew := g_JMng.GetJsonIntegerField(p_JObject, 'crew');
            l_Vehicle.Passengers := g_JMng.GetJsonIntegerField(p_JObject, 'passengers');
            l_Vehicle.MaxAtmospheringSpeed := g_JMng.GetJsonIntegerField(p_JObject, 'max_atmosphering_speed');
            l_Vehicle.CargoCapacity := g_JMng.GetJsonIntegerField(p_JObject, 'cargo_capacity');
            l_Vehicle.Consumables := g_JMng.GetJsonTextField(p_JObject, 'consumables');
            l_Vehicle.Url := g_JMng.GetJsonTextField(p_JObject, 'url');
            l_Vehicle.Created := g_JMng.GetJsonDateTimeField(p_JObject, 'created');
            l_Vehicle.Edited := g_JMng.GetJsonDateTimeField(p_JObject, 'edited');
            l_Vehicle.Insert();
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
            exit(0);
    end;

    local procedure GetSpeciesID(p_JObject: JsonObject): Integer
    var
        l_SpeciesID: Integer;
        l_InnerJsonToken: JsonToken;
        l_JToken: JsonToken;
        l_UrlSpecies: Text;
    begin
        l_InnerJsonToken := g_JMng.GetInnerJsonToken(p_JObject, 'species');
        if not l_InnerJsonToken.AsArray().Get(0, l_JToken) then
            exit(0);
        l_UrlSpecies := l_JToken.AsValue().AsText();
        l_SpeciesID := GetAssIDFromAssUrl(l_UrlSpecies, "SW Resource Types"::species);
        exit(l_SpeciesID);
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
                FillJObjectContentInSWFilm(l_ID, l_JObject);
            "SW Resource Types"::people:
                FillJObjectContentInSWCharacter(l_ID, l_JObject);
            "SW Resource Types"::planets:
                FillJObjectContentInSWPlanet(l_ID, l_JObject);
            "SW Resource Types"::species:
                FillJObjectContentInSWSpecies(l_ID, l_JObject);
            "SW Resource Types"::starships:
                FillJObjectContentInSWStarship(l_ID, l_JObject);
            "SW Resource Types"::vehicles:
                FillJObjectContentInSWVehicle(l_ID, l_JObject);
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