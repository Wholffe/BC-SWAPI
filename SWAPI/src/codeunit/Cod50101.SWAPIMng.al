namespace SWAPI.SWAPI;

codeunit 50101 "SWAPI Mng"
{

    local procedure FillRessourceAssosiation(p_JObject: JsonObject; p_Member: Text; p_RessourceType: Enum "SW Ressouce Types"; p_ID: Integer)
    var
        l_InnerJsonObject: JsonToken;
        l_JToken: JsonToken;
        l_AssValue: Text[50];
    begin
        l_InnerJsonObject := GetInnerJsonToken(p_JObject, p_Member);
        foreach l_JToken in l_InnerJsonObject.AsArray() do begin
            l_AssValue := l_JToken.AsValue().AsText();
            FillSingleRessourceAssosiation(p_RessourceType, p_ID, GetEnumFromText(p_Member), l_AssValue);
        end;
    end;

    local procedure FillSingleRessourceAssosiation(p_RessourceType: Enum "SW Ressouce Types"; p_ID: Integer; p_AssType: Enum "SW Ressouce Types"; p_AssValue: Text[50])
    var
        l_RessourceAssosiation: Record "SW Ressource Assosiation";
    begin
        if not l_RessourceAssosiation.Get(p_RessourceType, p_ID, p_AssType, p_AssValue) then begin
            l_RessourceAssosiation.Init();
            l_RessourceAssosiation.RessourceType := p_RessourceType;
            l_RessourceAssosiation.RessourceID := p_ID;
            l_RessourceAssosiation.AssociatedRessourceType := p_AssType;
            l_RessourceAssosiation.AssociatedRessourceValue := p_AssValue;
            l_RessourceAssosiation.Insert();
        end;
    end;

    procedure FillSWFilms(p_Url: Text): Boolean
    var
        l_Films: Record "SW Films";
        l_CurrCounter: Integer;
        l_ID: Integer;
        l_MaxCounter: Integer;
        l_JObject: JsonObject;
        l_Url: Text;
    begin
        l_MaxCounter := GetCategoryCount(p_Url);
        for l_CurrCounter := 1 to l_MaxCounter do begin
            l_Url := StrSubstNo('%1/%2', p_Url, l_CurrCounter);
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
                FillRessourceAssosiation(l_JObject, 'species', Enum::"SW Ressouce Types"::films, l_ID);
                FillRessourceAssosiation(l_JObject, 'starships', Enum::"SW Ressouce Types"::films, l_ID);
                FillRessourceAssosiation(l_JObject, 'vehicles', Enum::"SW Ressouce Types"::films, l_ID);
                FillRessourceAssosiation(l_JObject, 'characters', Enum::"SW Ressouce Types"::films, l_ID);
                FillRessourceAssosiation(l_JObject, 'planets', Enum::"SW Ressouce Types"::films, l_ID);
            end;
            Commit();
        end;
        exit(true);
    end;

    procedure FillSWPeople(p_Url: Text): Boolean
    var
        l_People: Record "SW People";
        l_CurrCounter: Integer;
        l_ID: Integer;
        l_MaxCounter: Integer;
        l_JObject: JsonObject;
        l_Url: Text;
    begin
        l_MaxCounter := GetCategoryCount(p_Url);
        for l_CurrCounter := 1 to l_MaxCounter do begin
            l_Url := StrSubstNo('%1/%2', p_Url, l_CurrCounter);
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
                FillRessourceAssosiation(l_JObject, 'films', Enum::"SW Ressouce Types"::people, l_ID);
                FillRessourceAssosiation(l_JObject, 'species', Enum::"SW Ressouce Types"::people, l_ID);
                FillRessourceAssosiation(l_JObject, 'starships', Enum::"SW Ressouce Types"::people, l_ID);
                FillRessourceAssosiation(l_JObject, 'vehicles', Enum::"SW Ressouce Types"::people, l_ID);
            end;
            Commit();
        end;
        exit(true);
    end;

    procedure FillSWPlanets(p_Url: Text): Boolean
    var
        l_Planets: Record "SW Planets";
        l_CurrCounter: Integer;
        l_ID: Integer;
        l_MaxCounter: Integer;
        l_JObject: JsonObject;
        l_Url: Text;
    begin
        l_MaxCounter := GetCategoryCount(p_Url);
        for l_CurrCounter := 1 to l_MaxCounter do begin
            l_Url := StrSubstNo('%1/%2', p_Url, l_CurrCounter);
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
                FillRessourceAssosiation(l_JObject, 'residents', Enum::"SW Ressouce Types"::planets, l_ID);
                FillRessourceAssosiation(l_JObject, 'films', Enum::"SW Ressouce Types"::planets, l_ID);
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

    procedure GetEnumFromText(p_Text: Text): Enum "SW Ressouce Types"
    begin
        case p_Text of
            'films':
                exit(Enum::"SW Ressouce Types"::films);
            'people', 'characters', 'residents', 'pilots':
                exit(Enum::"SW Ressouce Types"::people);
            'planets':
                exit(Enum::"SW Ressouce Types"::planets);
            'species':
                exit(Enum::"SW Ressouce Types"::species);
            'starships':
                exit(Enum::"SW Ressouce Types"::starships);
            'vehicles':
                exit(Enum::"SW Ressouce Types"::vehicles);
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
        if p_JObject.Get(p_Member, l_Result) then
            exit(l_Result.AsValue().AsText());
    end;

    procedure GetUrlFromEnum(p_RessourceType: Enum "SW Ressouce Types"): Text
    var
        l_SWAPISetup: Record SWAPISetup;
    begin
        exit(StrSubstNo('%1%2/', l_SWAPISetup.Endpoint, p_RessourceType))
    end;

    procedure PingAPIConnection()
    var
        l_SWAPISetup: Record SWAPISetup;
        l_Client: HttpClient;
        l_Response: HttpResponseMessage;
    begin
        if not l_Client.Get(l_SWAPISetup.Endpoint, l_Response) then
            Error('Connection failed, %1', l_Response.HttpStatusCode);

        if not l_Response.IsSuccessStatusCode then
            Error('Status code result %1', l_Response.IsSuccessStatusCode);

        Message('Pong');
    end;
}
