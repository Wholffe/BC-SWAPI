namespace SWAPI.SWAPI;

codeunit 50102 "SW Json Mng"
{
    procedure GetInnerJsonToken(p_JObject: JsonObject; p_Member: Text): JsonToken
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

    procedure GetJsonDateField(p_JObject: JsonObject; p_Member: Text): Date
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

    procedure GetJsonDateTimeField(p_JObject: JsonObject; p_Member: Text): DateTime
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

    procedure GetJsonDecimalField(p_JObject: JsonObject; p_Member: Text): Decimal
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

    procedure GetJsonIntegerField(p_JObject: JsonObject; p_Member: Text): Integer
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

    procedure GetJsonTextField(p_JObject: JsonObject; p_Member: Text): Text
    var
        l_JToken: JsonToken;
        l_Result: Text;
    begin
        if not p_JObject.Get(p_Member, l_JToken) then
            exit('');
        if l_JToken.AsValue().IsNull() then
            exit('');
        l_Result := l_JToken.AsValue().AsText();
        if l_Result in ['unknown'] then
            exit('');
        exit(l_Result);
    end;
}
