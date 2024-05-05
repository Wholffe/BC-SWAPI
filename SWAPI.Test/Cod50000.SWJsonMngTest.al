codeunit 50000 "SWJsonMngTest"
{
    Subtype = Test;

    var
        g_Assert: Codeunit "Library Assert";
        g_JsonMng: Codeunit "SW Json Mng";

    [Test]
    procedure GetInnerJsonTokenTestInvalidJObject()
    var
        l_JObject: JsonObject;
        l_JToken: JsonToken;
        l_ExpectedJTokenContent: Text;
        l_JTokenContentTxt: Text;
    begin
        // [GIVEN] is a JsonObject that doesnt contain a inner JsonArray
        l_JObject.ReadFrom('{}');
        // [WHEN] the procedure GetInnerJsonToken is run
        l_JToken := g_JsonMng.GetInnerJsonToken(l_JObject, 'films');
        // [THEN] the returned JsonToken value is null
        g_Assert.IsTrue(l_JToken.AsValue().IsNull, '');
    end;

    [Test]
    procedure GetInnerJsonTokenTestValidJObject()
    var
        l_JObject: JsonObject;
        l_JToken: JsonToken;
        l_ExpectedJTokenContent: Text;
        l_JTokenContentTxt: Text;
    begin
        // [GIVEN] is a valid JsonObject that contains a inner JsonArray
        l_JObject := GetJsonObjectSWPeopleSample();
        // [WHEN] the procedure GetInnerJsonToken is run
        l_JToken := g_JsonMng.GetInnerJsonToken(l_JObject, 'films');
        // [THEN] the content of the returned JToken should be valid
        l_JToken.WriteTo(l_JTokenContentTxt);
        l_ExpectedJTokenContent := '["https://swapi.dev/api/films/2/","https://swapi.dev/api/films/6/","https://swapi.dev/api/films/3/","https://swapi.dev/api/films/1/","https://swapi.dev/api/films/7/"]';
        g_Assert.AreEqual(l_ExpectedJTokenContent, l_JTokenContentTxt, '');
    end;

    [Test]
    procedure GetJObjectFromUrlTestInvalidUrl()
    var
        l_JObject: JsonObject;
        l_JObjectTxt: Text;
        l_Url: Text;
    begin
        // [GIVEN] is a Url that is unreachable
        l_Url := 'https://swapi/example/is/unreachable';
        // [WHEN] the procedure GetJObjectFromUrl is run
        l_JObject := g_JsonMng.GetJObjectFromUrl(l_Url);
        // [THEN] the content of the returned JObject should be empty
        l_JObject.WriteTo(l_JObjectTxt);
        g_Assert.AreEqual('{}', l_JObjectTxt, '');
    end;

    [Test]
    procedure GetJObjectFromUrlTestValidUrl()
    var
        l_JObject: JsonObject;
        l_ExpectedJObjectTxt: Text;
        l_JObjectTxt: Text;
        l_Url: Text;
    begin
        // [GIVEN] is a valid Url
        l_Url := 'https://swapi.dev/api/';
        // [WHEN] the procedure GetJObjectFromUrl is run
        l_JObject := g_JsonMng.GetJObjectFromUrl(l_Url);
        // [THEN] the content of the returned JObject should be valid
        l_JObject.WriteTo(l_JObjectTxt);
        l_ExpectedJObjectTxt := '{"people":"https://swapi.dev/api/people/","planets":"https://swapi.dev/api/planets/","films":"https://swapi.dev/api/films/","species":"https://swapi.dev/api/species/","vehicles":"https://swapi.dev/api/vehicles/","starships":"https://swapi.dev/api/starships/"}';
        g_Assert.AreEqual(l_ExpectedJObjectTxt, l_JObjectTxt, '');
    end;

    [Test]
    procedure GetJsonDateFieldTestInValidJObject()
    var
        l_Date: Date;
        l_ExpectedDate: Date;
        l_JObject: JsonObject;
        l_DateTxt: Text;
    begin
        // [GIVEN] is a JsonObject that doesn't contain a date member
        l_JObject.ReadFrom('{}');
        // [WHEN] the procedure GetJsonDateField is run
        l_Date := g_JsonMng.GetJsonDateField(l_JObject, 'release_date');
        // [THEN] the returned Date should be the default date (January 1, 0001)
        g_Assert.AreEqual(0D, l_Date, '');
    end;

    [Test]
    procedure GetJsonDateFieldTestValidJObject()
    var
        l_Date: Date;
        l_ExpectedDate: Date;
        l_JObject: JsonObject;
        l_DateTxt: Text;
    begin
        l_DateTxt := '1977-05-25';
        // [GIVEN] is a JsonObject that contains a date member
        l_JObject.Add('release_date', l_DateTxt);
        // [WHEN] the procedure GetJsonDateField is run
        l_Date := g_JsonMng.GetJsonDateField(l_JObject, 'release_date');
        // [THEN] the returned Date should be valid
        Evaluate(l_ExpectedDate, l_DateTxt);
        g_Assert.AreEqual(l_ExpectedDate, l_Date, '');
    end;

    local procedure GetJsonObjectSWPeopleSample(): JsonObject
    var
        l_JObject: JsonObject;
        l_Content: Text;
    begin
        l_Content := '{"name": "Luke Skywalker",' +
                     '"height": "172",' +
                     '"mass": "77",' +
                     '"hair_color": "blond",' +
                     '"skin_color": "fair",' +
                     '"eye_color": "blue",' +
                     '"birth_year": "19BBY",' +
                     '"gender": "male",' +
                     '"homeworld": "https://swapi.dev/api/planets/1/",' +
                     '"films": [' +
                         '"https://swapi.dev/api/films/2/",' +
                         '"https://swapi.dev/api/films/6/",' +
                         '"https://swapi.dev/api/films/3/",' +
                         '"https://swapi.dev/api/films/1/",' +
                         '"https://swapi.dev/api/films/7/"' +
                     '],' +
                     '"species": [' +
                         '"https://swapi.dev/api/species/1/"' +
                     '],' +
                     '"vehicles": [' +
                         '"https://swapi.dev/api/vehicles/14/",' +
                         '"https://swapi.dev/api/vehicles/30/"' +
                     '],' +
                     '"starships": [' +
                         '"https://swapi.dev/api/starships/12/",' +
                         '"https://swapi.dev/api/starships/22/"' +
                     '],' +
                     '"created": "2014-12-09T13:50:51.644000Z",' +
                     '"edited": "2014-12-20T21:17:56.891000Z",' +
                     '"url": "https://swapi.dev/api/people/1/"}';
        l_JObject.ReadFrom(l_Content);
        exit(l_JObject);
    end;
}