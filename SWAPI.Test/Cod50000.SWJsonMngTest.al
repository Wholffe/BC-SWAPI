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

    [Test]
    procedure GetJsonDateTimeFieldTestTestInvalidJObject()
    var
        l_DateTime: DateTime;
        l_ExpectedDateTime: DateTime;
        l_JObject: JsonObject;
        l_DateTimeTxt: Text;
    begin
        // [GIVEN] is a JsonObject that doesn't contain a DateTime member
        l_JObject.ReadFrom('{}');
        // [WHEN] the procedure GetJsonDateTimeField is run
        l_DateTime := g_JsonMng.GetJsonDateTimeField(l_JObject, 'edited');
        // [THEN] the returned DateTime should be the default DateTime (January 1, 0001, 00:00:00)
        g_Assert.AreEqual(0DT, l_DateTime, '');
    end;

    [Test]
    procedure GetJsonDateTimeFieldTestTestValidJObject()
    var
        l_DateTime: DateTime;
        l_ExpectedDateTime: DateTime;
        l_JObject: JsonObject;
        l_DateTimeTxt: Text;
    begin
        l_DateTimeTxt := '2014-12-20T21:17:56.891000Z';
        // [GIVEN] is a JsonObject that contains a DateTime member
        l_JObject.Add('edited', l_DateTimeTxt);
        // [WHEN] the procedure GetJsonDateTimeField is run
        l_DateTime := g_JsonMng.GetJsonDateTimeField(l_JObject, 'edited');
        // [THEN] the returned DateTime should be valid
        Evaluate(l_ExpectedDateTime, l_DateTimeTxt);
        g_Assert.AreEqual(l_ExpectedDateTime, l_DateTime, '');
    end;

    [Test]
    procedure GetJsonDecimalFieldTestInvalidJObject()
    var
        l_Decimal: Decimal;
        l_ExpectedDecimal: Decimal;
        l_JObject: JsonObject;
    begin
        // [GIVEN] is a JsonObject that doesn't contain a Decimal member
        l_JObject.ReadFrom('{}');
        // [WHEN] the procedure GetJsonDecimalField is run
        l_Decimal := g_JsonMng.GetJsonDecimalField(l_JObject, 'hyperdrive_rating');
        // [THEN] the returned Decimal should be the default decimal value (0)
        g_Assert.AreEqual(0, l_Decimal, '');
    end;

    [Test]
    procedure GetJsonDecimalFieldTestValidJObject()
    var
        l_Decimal: Decimal;
        l_ExpectedDecimal: Decimal;
        l_JObject: JsonObject;
        l_DecimalTxt: Text;
    begin
        l_DecimalTxt := '20.00';
        // [GIVEN] is a JsonObject that contains a Decimal member
        l_JObject.Add('hyperdrive_rating', l_DecimalTxt);
        // [WHEN] the procedure GetJsonDecimalField is run
        l_Decimal := g_JsonMng.GetJsonDecimalField(l_JObject, 'hyperdrive_rating');
        // [THEN] the returned Decimal should be valid
        Evaluate(l_ExpectedDecimal, l_DecimalTxt);
        g_Assert.AreEqual(l_ExpectedDecimal, l_Decimal, '');
    end;

    [Test]
    procedure GetJsonIntegerFieldTestInvalidJObject()
    var
        l_ExpectedInteger: Integer;
        l_Integer: Integer;
        l_JObject: JsonObject;
    begin
        // [GIVEN] is a JsonObject that doesn't contain a Integer member
        l_JObject.ReadFrom('{}');
        // [WHEN] the procedure GetJsonIntegerField is run
        l_Integer := g_JsonMng.GetJsonIntegerField(l_JObject, 'height');
        // [THEN] the returned Integer should be the default integer value (0)
        g_Assert.AreEqual(0, l_Integer, '');
    end;

    [Test]
    procedure GetJsonIntegerFieldTestValidJObject()
    var
        l_ExpectedInteger: Integer;
        l_Integer: Integer;
        l_JObject: JsonObject;
        l_IntegerTxt: Text;
    begin
        l_IntegerTxt := '172';
        // [GIVEN] is a JsonObject that contains a Integer member
        l_JObject.Add('height', l_IntegerTxt);
        // [WHEN] the procedure GetJsonIntegerField is run
        l_Integer := g_JsonMng.GetJsonIntegerField(l_JObject, 'height');
        // [THEN] the returned Integer should be valid
        Evaluate(l_ExpectedInteger, l_IntegerTxt);
        g_Assert.AreEqual(l_ExpectedInteger, l_Integer, '');
    end;

    [Test]
    procedure GetJsonTextFieldTestInvalidJObject()
    var
        l_JObject: JsonObject;
        l_ExpectedText: Text;
        l_Text: Text;
    begin
        // [GIVEN] is a JsonObject that doesn't contain a Text member
        l_JObject.ReadFrom('{}');
        // [WHEN] the procedure GetJsonTextField is run
        l_Text := g_JsonMng.GetJsonTextField(l_JObject, 'edited');
        // [THEN] the returned Text should be an empty string
        g_Assert.AreEqual('', l_Text, '');
    end;

    [Test]
    procedure GetJsonTextFieldTestValidJObject()
    var
        l_JObject: JsonObject;
        l_ActualText: Text;
        l_ExpectedText: Text;
        l_JTxt: Text;
    begin
        l_JTxt := 'Luke Skywalker';
        // [GIVEN] is a JsonObject that contains a Text member
        l_JObject.Add('name', l_JTxt);
        // [WHEN] the procedure GetJsonTextField is run
        l_ActualText := g_JsonMng.GetJsonTextField(l_JObject, 'name');
        // [THEN] the returned Text should be valid
        Evaluate(l_ExpectedText, l_JTxt);
        g_Assert.AreEqual(l_JTxt, l_ActualText, '');
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