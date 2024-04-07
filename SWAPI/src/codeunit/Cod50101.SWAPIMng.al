namespace SWAPI.SWAPI;

codeunit 50101 "SWAPI Mng"
{
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

    procedure GetJObjectFromUrl(p_Url: Text): JsonObject
    var
        l_Url: Text;
        l_Client: HttpClient;
        l_Response: HttpResponseMessage;
        l_Content: HttpContent;
        l_ResponseTxt: Text;
        l_JObject: JsonObject;
    begin
        if not l_Client.Get(p_Url, l_Response) then
            Error('Connection failed, %1', l_Response.HttpStatusCode);

        if not l_Response.IsSuccessStatusCode then
            Error('Status code result %1', l_Response.IsSuccessStatusCode);

        l_Content := l_Response.Content;
        l_Content.ReadAs(l_ResponseTxt);
        l_JObject.ReadFrom(l_ResponseTxt);
        exit(l_JObject)
    end;

    procedure GetCategoryCount(p_Url: Text): Integer
    var
        l_JObject: JsonObject;
    begin
        l_JObject := GetJObjectFromUrl(p_Url);
        exit(GetJsonIntegerField(l_JObject, 'count'))
    end;

    procedure FillSWFilms(p_Url: Text): Boolean
    var
        l_MaxCounter: Integer;
        l_CurrCounter: Integer;
        l_Url: Text;
        l_JObject: JsonObject;
        l_ID: Integer;
        l_Films: Record "SW Films";
    begin
        l_MaxCounter := GetCategoryCount(p_Url);
        for l_CurrCounter := 1 to l_MaxCounter do begin
            l_Url := StrSubstNo('%1/%2', p_Url, l_CurrCounter);
            l_JObject := GetJObjectFromUrl(l_Url);
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

                // l_Films.Species := GetJsonTextField(l_JObject, '');
                // l_Films.Starships := GetJsonTextField(l_JObject, '');
                // l_Films.Vehicles := GetJsonTextField(l_JObject, '');
                // l_Films.Characters := GetJsonTextField(l_JObject, '');
                // l_Films.Planets := GetJsonTextField(l_JObject, '');

                l_Films.Url := GetJsonTextField(l_JObject, 'url');
                l_Films.Created := GetJsonDateTimeField(l_JObject, 'created');
                l_Films.Edited := GetJsonDateTimeField(l_JObject, 'edited');
                l_Films.Insert();
            end;
            FillFilmRessourceAssosiation(l_JObject, 'species', l_ID);
        end;
        exit(true);
    end;

    local procedure FillFilmRessourceAssosiation(p_JObject: JsonObject; p_Member: Text; p_ID: Integer)
    var
        l_InnerJsonObject: JsonToken;
        l_JToken: JsonToken;
        l_AssValue: Text[50];
    begin
        l_InnerJsonObject := GetInnerJsonToken(p_JObject, p_Member);
        foreach l_JToken in l_InnerJsonObject.AsArray() do begin
            l_AssValue := l_JToken.AsValue().AsText();
            FillSingleRessourceAssosiation(Enum::"SW Ressouce Types"::films, p_ID, GetEnumFromText(p_Member), l_AssValue);
        end;
    end;

    local procedure FillSingleRessourceAssosiation(p_Type: Enum "SW Ressouce Types"; p_ID: Integer; p_AssType: Enum "SW Ressouce Types"; p_AssValue: Text[50]): Boolean
    var
        l_RessourceAssosiation: Record "SW Ressource Assosiation";
    begin
        l_RessourceAssosiation.Init();
        l_RessourceAssosiation.RessourceType := l_RessourceAssosiation.RessourceType::films;
        l_RessourceAssosiation.RessourceID := p_ID;
        l_RessourceAssosiation.AssociatedRessourceType := p_AssType;
        l_RessourceAssosiation.AssociatedRessourceValue := p_AssValue;
        l_RessourceAssosiation.Insert();
        exit(true)
    end;

    procedure GetUrlFromEnum(p_RessourceType: Enum "SW Ressouce Types"): Text
    var
        l_SWAPISetup: Record SWAPISetup;
    begin
        exit(StrSubstNo('%1%2/', l_SWAPISetup.Endpoint, p_RessourceType))
    end;

    local procedure GetJsonIntegerField(p_JObject: JsonObject; p_Member: Text): Integer
    var
        l_Result: JsonToken;
    begin
        if p_JObject.Get(p_Member, l_Result) then
            exit(l_Result.AsValue().AsInteger())
    end;

    local procedure GetJsonTextField(p_JObject: JsonObject; p_Member: Text): Text
    var
        l_Result: JsonToken;
    begin
        if p_JObject.Get(p_Member, l_Result) then
            exit(l_Result.AsValue().AsText());
    end;

    local procedure GetJsonDateField(p_JObject: JsonObject; p_Member: Text): Date
    var
        l_Result: JsonToken;
    begin
        if p_JObject.Get(p_Member, l_Result) then
            exit(l_Result.AsValue().AsDate());
    end;

    local procedure GetJsonDateTimeField(p_JObject: JsonObject; p_Member: Text): DateTime
    var
        l_Result: JsonToken;
    begin
        if p_JObject.Get(p_Member, l_Result) then
            exit(l_Result.AsValue().AsDateTime());
    end;

    local procedure GetInnerJsonToken(p_JObject: JsonObject; p_Member: Text): JsonToken
    var
        l_Result: JsonToken;
    begin
        if p_JObject.Get(p_Member, l_Result) then
            exit(l_Result.AsArray().AsToken());
    end;

    procedure GetEnumFromText(p_Text: Text): Enum "SW Ressouce Types"
    begin
        case p_Text of
            'films':
                exit(Enum::"SW Ressouce Types"::films);
            'people':
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
}
