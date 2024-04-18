namespace SWAPI.SWAPI;

codeunit 50101 "SWAPI Mng"
{
    var
        g_APISetup: Record SWAPISetup;
        g_AlreadyImportedL: Label 'You have already imported %1. Take a seat.';
        g_ImportSuccessfullL: Label '%1 imported successfully.';

    local procedure DataAlreadyImported(p_Resource: Enum "SW Resource Types"): Boolean
    var
        l_RecRef: RecordRef;
        l_MaxID: Integer;
        l_ResourceRouteUrl: Text;
    begin
        l_ResourceRouteUrl := StrSubstNo('%1%2', g_APISetup.Endpoint, p_Resource);
        l_MaxID := GetCategoryCount(l_ResourceRouteUrl);
        l_RecRef.Open(GetRecRefTableNoFromResourceEnum(p_Resource));
        if not (l_RecRef.Count = l_MaxID) then begin
            l_RecRef.Close();
            exit;
        end;
        SendStatusNotification(StrSubstNo(g_AlreadyImportedL, p_Resource));
        l_RecRef.Close();
        exit(true)
    end;

    procedure DrilldownPage(p_ResourceType: Enum "SW Resource Types"; p_ID: Integer; p_AssociatedResourceType: Enum "SW Resource Types")
    var
        l_RessourceAss: Record "SW Resource Association";
        l_RecRef: RecordRef;
        l_FieldRef: FieldRef;
        l_PageNo: Integer;
        l_RecRefTableNo: Integer;
        l_Filter: Text;
        l_VarRecRef: Variant;
    begin
        l_RessourceAss.Reset();
        l_RessourceAss.SetRange(ResourceType, p_ResourceType);
        l_RessourceAss.SetRange(ResourceID, p_ID);
        l_RessourceAss.SetRange(AssociatedResourceType, p_AssociatedResourceType);
        if not l_RessourceAss.FindSet() then
            exit;
        repeat
            l_Filter := StrSubstNo('%1|%2', l_RessourceAss.AssRessourceID, l_Filter)
        until l_RessourceAss.Next() = 0;
        l_Filter := l_Filter.TrimEnd('|');
        l_RecRefTableNo := GetRecRefTableNoFromResourceEnum(p_AssociatedResourceType);
        l_RecRef.Open(GetRecRefTableNoFromResourceEnum(p_AssociatedResourceType));
        l_FieldRef := l_RecRef.Field(1);
        l_FieldRef.SetFilter(l_Filter);
        l_VarRecRef := l_RecRef;
        l_RecRef.Close();
        case l_RecRefTableNo of
            Database::"SW Films":
                l_PageNo := Page::"SW Films List";
            Database::"SW People":
                l_PageNo := Page::"SW People List";
            Database::"SW Planets":
                l_PageNo := Page::"SW Planets List";
            Database::"SW Species":
                l_PageNo := Page::"SW Species List";
            Database::"SW Starships":
                l_PageNo := Page::"SW Starships List";
            Database::"SW Vehicles":
                l_PageNo := Page::"SW Vehicles List";
        end;
        Page.Run(l_PageNo, l_VarRecRef);
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
        l_ResourceRouteUrl := StrSubstNo('%1%2', g_APISetup.Endpoint, p_Resource);
        l_MaxID := GetCategoryCount(l_ResourceRouteUrl);
        l_Dialog.Update(3, l_MaxID);
        l_CurrID := 1;
        while l_CurrID <= l_MaxID do begin
            l_Dialog.Update(2, l_CurrID);
            if not RessourceWithCurrentIDExist(p_Resource, l_CurrID) then begin
                l_Url := StrSubstNo('%1/%2', l_ResourceRouteUrl, l_CurrID);
                l_JObject := GetJObjectFromUrl(l_Url);
                if not (l_JObject.Keys().Count = 0) then
                    StartFillJObjectContentInSWResource(p_Resource, l_CurrID, l_JObject)
                else
                    l_MaxID := l_MaxID + 1;
            end;
            l_CurrID := l_CurrID + 1;
        end;
        ValidateAllResourcesAss();
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
        FillResourceAssociation(p_JObject, 'species', Enum::"SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'starships', Enum::"SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'vehicles', Enum::"SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'characters', Enum::"SW Resource Types"::films, p_ID);
        FillResourceAssociation(p_JObject, 'planets', Enum::"SW Resource Types"::films, p_ID);
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
            l_People.Height := GetJsonIntegerField(p_JObject, 'height');
            l_People.Mass := GetJsonIntegerField(p_JObject, 'mass');
            l_People.SkinColor := GetJsonTextField(p_JObject, 'skin_color');
            l_People.Validate(Homeworld, GetJsonTextField(p_JObject, 'homeworld'));
            l_People.Url := GetJsonTextField(p_JObject, 'url');
            l_People.Created := GetJsonDateTimeField(p_JObject, 'created');
            l_People.Edited := GetJsonDateTimeField(p_JObject, 'edited');
            l_People.Insert();
        end;
        FillResourceAssociation(p_JObject, 'films', Enum::"SW Resource Types"::people, p_ID);
        FillResourceAssociation(p_JObject, 'species', Enum::"SW Resource Types"::people, p_ID);
        FillResourceAssociation(p_JObject, 'starships', Enum::"SW Resource Types"::people, p_ID);
        FillResourceAssociation(p_JObject, 'vehicles', Enum::"SW Resource Types"::people, p_ID);
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
            l_Planets.Diameter := GetJsonIntegerField(p_JObject, 'diameter');
            l_Planets.RotationPeriod := GetJsonIntegerField(p_JObject, 'rotation_period');
            l_Planets.OrbitalPeriod := GetJsonIntegerField(p_JObject, 'orbital_period');
            l_Planets.Gravity := GetJsonIntegerField(p_JObject, 'gravity');
            l_Planets.Population := GetJsonIntegerField(p_JObject, 'population');
            l_Planets.Climate := GetJsonTextField(p_JObject, 'climate');
            l_Planets.Terrain := GetJsonTextField(p_JObject, 'terrain');
            l_Planets.SurfaceWater := GetJsonIntegerField(p_JObject, 'surface_water');
            l_Planets.Url := GetJsonTextField(p_JObject, 'url');
            l_Planets.Created := GetJsonDateTimeField(p_JObject, 'created');
            l_Planets.Edited := GetJsonDateTimeField(p_JObject, 'edited');
            l_Planets.Insert();
        end;
        FillResourceAssociation(p_JObject, 'residents', Enum::"SW Resource Types"::planets, p_ID);
        FillResourceAssociation(p_JObject, 'films', Enum::"SW Resource Types"::planets, p_ID);
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
            l_Species.AverageHeight := GetJsonIntegerField(p_JObject, 'average_height');
            l_Species.AverageLifeSpan := GetJsonIntegerField(p_JObject, 'average_lifespan');
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
        FillResourceAssociation(p_JObject, 'people', Enum::"SW Resource Types"::species, p_ID);
        FillResourceAssociation(p_JObject, 'films', Enum::"SW Resource Types"::species, p_ID);
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
            l_Starships.CostInCredits := GetJsonIntegerField(p_JObject, 'cost_in_credits');
            l_Starships.Length := GetJsonIntegerField(p_JObject, 'length');
            l_Starships.Crew := GetJsonIntegerField(p_JObject, 'crew');
            l_Starships.Passengers := GetJsonIntegerField(p_JObject, 'passengers');
            l_Starships.MaxAtmospheringSpeed := GetJsonIntegerField(p_JObject, 'max_atmosphering_speed');
            l_Starships.HyperdriveRating := GetJsonDecimalField(p_JObject, 'hyperdrive_rating');
            l_Starships.MGLT := GetJsonIntegerField(p_JObject, 'MGLT');
            l_Starships.CargoCapacity := GetJsonIntegerField(p_JObject, 'cargo_capacity');
            l_Starships.Consumables := GetJsonTextField(p_JObject, 'consumables');
            l_Starships.Url := GetJsonTextField(p_JObject, 'url');
            l_Starships.Created := GetJsonDateTimeField(p_JObject, 'created');
            l_Starships.Edited := GetJsonDateTimeField(p_JObject, 'edited');
            l_Starships.Insert();
        end;
        FillResourceAssociation(p_JObject, 'films', Enum::"SW Resource Types"::starships, p_ID);
        FillResourceAssociation(p_JObject, 'pilots', Enum::"SW Resource Types"::starships, p_ID);
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
            l_Vehicles.Lenght := GetJsonDecimalField(p_JObject, 'length');
            l_Vehicles.CostInCredits := GetJsonIntegerField(p_JObject, 'cost_in_credits');
            l_Vehicles.Crew := GetJsonIntegerField(p_JObject, 'crew');
            l_Vehicles.Passengers := GetJsonIntegerField(p_JObject, 'passengers');
            l_Vehicles.MaxAtmospheringSpeed := GetJsonIntegerField(p_JObject, 'max_atmosphering_speed');
            l_Vehicles.CargoCapacity := GetJsonIntegerField(p_JObject, 'cargo_capacity');
            l_Vehicles.Consumables := GetJsonTextField(p_JObject, 'consumables');
            l_Vehicles.Url := GetJsonTextField(p_JObject, 'url');
            l_Vehicles.Created := GetJsonDateTimeField(p_JObject, 'created');
            l_Vehicles.Edited := GetJsonDateTimeField(p_JObject, 'edited');
            l_Vehicles.Insert();
        end;
        FillResourceAssociation(p_JObject, 'films', Enum::"SW Resource Types"::vehicles, p_ID);
        FillResourceAssociation(p_JObject, 'pilots', Enum::"SW Resource Types"::vehicles, p_ID);
        Commit();
    end;

    local procedure FillResourceAssociation(p_JObject: JsonObject; p_Member: Text; p_ResourceType: Enum "SW Resource Types"; p_ID: Integer)
    var
        l_InnerJsonObject: JsonToken;
        l_JToken: JsonToken;
        l_AssValue: Text[100];
    begin
        l_InnerJsonObject := GetInnerJsonToken(p_JObject, p_Member);
        foreach l_JToken in l_InnerJsonObject.AsArray() do begin
            l_AssValue := l_JToken.AsValue().AsText();
            FillSingleResourceAssociation(p_ResourceType, p_ID, GetEnumFromText(p_Member), l_AssValue);
        end;
    end;

    local procedure FillSingleResourceAssociation(p_ResourceType: Enum "SW Resource Types"; p_ID: Integer; p_AssType: Enum "SW Resource Types"; p_AssValue: Text[100])
    var
        l_ResourceAssociation: Record "SW Resource Association";
    begin
        if not l_ResourceAssociation.Get(p_ResourceType, p_ID, p_AssType, p_AssValue) then begin
            l_ResourceAssociation.Init();
            l_ResourceAssociation.ResourceType := p_ResourceType;
            l_ResourceAssociation.ResourceID := p_ID;
            l_ResourceAssociation.AssociatedResourceType := p_AssType;
            l_ResourceAssociation.Validate(AssociatedResourceValue, p_AssValue);
            l_ResourceAssociation.Insert();
        end;
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

    local procedure GetInnerJsonToken(p_JObject: JsonObject; p_Member: Text): JsonToken
    var
        l_Result: JsonToken;
    begin
        if p_JObject.Get(p_Member, l_Result) then
            exit(l_Result.AsArray().AsToken());
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

    local procedure GetJsonDecimalField(p_JObject: JsonObject; p_Member: Text): Decimal
    var
        l_Result: Decimal;
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
        l_JToken: JsonToken;
        l_Result: Text;
    begin
        if not p_JObject.Get(p_Member, l_JToken) then
            exit('');
        if l_JToken.AsValue().IsNull() then
            exit('');
        l_Result := l_JToken.AsValue().AsText();
        if l_Result in ['unknown', 'n/a'] then
            exit('');
        exit(l_Result);
    end;

    procedure GetRecRefTableNoFromResourceEnum(p_Resource: Enum "SW Resource Types"): Integer
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

    procedure GetUrlFromEnum(p_ResourceType: Enum "SW Resource Types"): Text
    var
        l_SWAPISetup: Record SWAPISetup;
    begin
        exit(StrSubstNo('%1%2/', l_SWAPISetup.Endpoint, p_ResourceType))
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFillAllResourcesOfAKind(p_Resource: Enum "SW Resource Types")
    begin
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SWAPI Mng", 'OnAfterFillAllResourcesOfAKind', '', false, false)]
    local procedure SendStatus(p_Resource: Enum "SW Resource Types")
    begin
        SendStatusNotification(StrSubstNo(g_ImportSuccessfullL, p_Resource));
    end;

    procedure SendStatusNotification(p_StatusL: Text)
    var
        l_StatusNotification: Notification;
    begin
        l_StatusNotification.Message(p_StatusL);
        l_StatusNotification.Send();
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

    procedure ValidateAllResourcesAss()
    var
        l_ResourceAss: Record "SW Resource Association";
        l_Dialog: Dialog;
        l_Counter: Integer;
        l_DialogL: Label 'Validating resource ass, please wait... \Validate #2## \Total #3##';
    begin
        l_ResourceAss.Reset();
        l_Dialog.Open(l_DialogL);
        l_Dialog.Update(3, l_ResourceAss.Count);
        l_Counter := 1;
        if l_ResourceAss.FindSet() then
            repeat
                l_Dialog.Update(2, l_Counter);
                l_ResourceAss.Validate(AssociatedResourceValue);
                l_ResourceAss.Modify();
                l_Counter := l_Counter + 1;
            until l_ResourceAss.Next() = 0;
        l_Dialog.Close();
    end;
}
