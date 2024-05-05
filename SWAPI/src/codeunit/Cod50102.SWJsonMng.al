namespace SWAPI.SWAPI;

codeunit 50102 "SW Json Mng"
{

    /// <summary>
    /// Retrieves the inner JSON token (array) of the specified member from a JSON object.
    /// </summary>
    /// <param name="p_JObject">The JSON object to retrieve the inner JSON token from.</param>
    /// <param name="p_Member">The name of the member whose inner JSON token is to be retrieved.</param>
    /// <returns>
    ///     The inner JSON token (array) of the specified member from the JSON object.
    ///     If the member does not exist or is not an array, null is returned.
    /// </returns>
    procedure GetInnerJsonToken(p_JObject: JsonObject; p_Member: Text): JsonToken
    var
        l_Result: JsonToken;
    begin
        if p_JObject.Get(p_Member, l_Result) then
            exit(l_Result.AsArray().AsToken());
    end;

    /// <summary>
    /// Retrieves a JSON object from the specified URL.
    /// </summary>
    /// <param name="p_Url">The URL from which to retrieve the JSON object.</param>
    /// <returns>
    ///     The JSON object retrieved from the specified URL.
    ///     If the HTTP request fails or the response is not successful, null is returned.
    /// </returns>
    procedure GetJObjectFromUrl(p_Url: Text): JsonObject
    var
        l_Client: HttpClient;
        l_Content: HttpContent;
        l_Response: HttpResponseMessage;
        l_JObject: JsonObject;
        l_ResponseTxt: Text;
        l_Url: Text;
    begin
        if not (l_Client.Get(p_Url, l_Response) and l_Response.IsSuccessStatusCode) then
            exit;

        l_Content := l_Response.Content;
        l_Content.ReadAs(l_ResponseTxt);
        l_JObject.ReadFrom(l_ResponseTxt);
        exit(l_JObject)
    end;

    /// <summary>
    /// Retrieves the date value of the specified member from a JSON object.
    /// </summary>
    /// <param name="p_JObject">The JSON object to retrieve the date value from.</param>
    /// <param name="p_Member">The name of the member whose date value is to be retrieved.</param>
    /// <returns>
    ///     The date value of the specified member from the JSON object.
    ///     If the member does not exist or cannot be parsed as a date, the default date (January 1, 0001) is returned.
    /// </returns>
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

    /// <summary>
    /// Retrieves the date and time value of the specified member from a JSON object.
    /// </summary>
    /// <param name="p_JObject">The JSON object to retrieve the date and time value from.</param>
    /// <param name="p_Member">The name of the member whose date and time value is to be retrieved.</param>
    /// <returns>
    ///     The date and time value of the specified member from the JSON object.
    ///     If the member does not exist or cannot be parsed as a date and time, the default date and time (January 1, 0001, 00:00:00) is returned.
    /// </returns>
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

    /// <summary>
    /// Retrieves the decimal value of the specified member from a JSON object.
    /// </summary>
    /// <param name="p_JObject">The JSON object to retrieve the decimal value from.</param>
    /// <param name="p_Member">The name of the member whose decimal value is to be retrieved.</param>
    /// <returns>
    ///     The decimal value of the specified member from the JSON object.
    ///     If the member does not exist or cannot be parsed as a decimal, the default decimal value (0) is returned.
    /// </returns>
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

    /// <summary>
    /// Retrieves the integer value of the specified member from a JSON object.
    /// </summary>
    /// <param name="p_JObject">The JSON object to retrieve the integer value from.</param>
    /// <param name="p_Member">The name of the member whose integer value is to be retrieved.</param>
    /// <returns>
    ///     The integer value of the specified member from the JSON object.
    ///     If the member does not exist or cannot be parsed as an integer, the default integer value (0) is returned.
    /// </returns>
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

    /// <summary>
    /// Retrieves the text value of the specified member from a JSON object.
    /// </summary>
    /// <param name="p_JObject">The JSON object to retrieve the text value from.</param>
    /// <param name="p_Member">The name of the member whose text value is to be retrieved.</param>
    /// <returns>
    ///     The text value of the specified member from the JSON object.
    ///     If the member does not exist, is null, or is 'unknown', an empty string is returned.
    /// </returns>
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
