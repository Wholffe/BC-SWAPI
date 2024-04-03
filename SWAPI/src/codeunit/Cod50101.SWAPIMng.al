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

    procedure GetCategoryCount(p_Url: Text): Integer
    var
        l_SWAPISetup: Record SWAPISetup;
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
        exit(GetJsonIntegerField(l_JObject, 'count'))
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
            exit(l_Result.AsValue().AsText())
    end;
}
