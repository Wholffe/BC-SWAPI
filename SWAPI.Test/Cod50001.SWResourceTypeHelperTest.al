codeunit 50001 SWResourceTypeHelperTest
{
    Subtype = Test;

    ///GetEnumFromText
    [Test]
    procedure TestGetEnumFromTextReturnsFilms()
    var
        l_Text: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text for the SW Resource Enum films
        l_Text := 'films';
        // [WHEN] the procedure GetEnumFromText is run
        l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_Text);
        // [THEN] the result should be the corrosponding SW Enum
        g_Assert.AreEqual("SW Resource Types"::films, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetEnumFromTextReturnsPeople()
    var
        l_Text: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text for the SW Resource Enum people
        l_Text := 'people';
        // [WHEN] the procedure GetEnumFromText is run
        l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_Text);
        // [THEN] the result should be the corrosponding SW Enum
        g_Assert.AreEqual("SW Resource Types"::people, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetEnumFromTextReturnsPeople2()
    var
        l_Text: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text for the SW Resource Enum people
        l_Text := 'characters';
        // [WHEN] the procedure GetEnumFromText is run
        l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_Text);
        // [THEN] the result should be the corrosponding SW Enum
        g_Assert.AreEqual("SW Resource Types"::people, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetEnumFromTextReturnsPeople3()
    var
        l_Text: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text for the SW Resource Enum people
        l_Text := 'residents';
        // [WHEN] the procedure GetEnumFromText is run
        l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_Text);
        // [THEN] the result should be the corrosponding SW Enum
        g_Assert.AreEqual("SW Resource Types"::people, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetEnumFromTextReturnsPeople4()
    var
        l_Text: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text for the SW Resource Enum people
        l_Text := 'pilots';
        // [WHEN] the procedure GetEnumFromText is run
        l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_Text);
        // [THEN] the result should be the corrosponding SW Enum
        g_Assert.AreEqual("SW Resource Types"::people, l_ResourceType, '');
    end;

    [Test]
    procedure TestTestGetEnumFromTextReturnsSpeciesPlanets()
    var
        l_Text: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text for the SW Resource Enum planets
        l_Text := 'planets'; //'planets', 'homeworld':
        // [WHEN] the procedure GetEnumFromText is run
        l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_Text);
        // [THEN] the result should be the corrosponding SW Enum
        g_Assert.AreEqual("SW Resource Types"::planets, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetEnumFromTextReturnsSpeciesPlanets2()
    var
        l_Text: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text for the SW Resource Enum planets
        l_Text := 'homeworld';
        // [WHEN] the procedure GetEnumFromText is run
        l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_Text);
        // [THEN] the result should be the corrosponding SW Enum
        g_Assert.AreEqual("SW Resource Types"::planets, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetEnumFromTextReturnsSpeciesVehicles()
    var
        l_Text: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text for the SW Resource Enum vehicles
        l_Text := 'vehicles';
        // [WHEN] the procedure GetEnumFromText is run
        l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_Text);
        // [THEN] the result should be the corrosponding SW Enum
        g_Assert.AreEqual("SW Resource Types"::vehicles, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetEnumFromTextReturnsSpeciesStarships()
    var
        l_Text: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text for the SW Resource Enum starships
        l_Text := 'starships';
        // [WHEN] the procedure GetEnumFromText is run
        l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_Text);
        // [THEN] the result should be the corrosponding SW Enum
        g_Assert.AreEqual("SW Resource Types"::starships, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetEnumFromTextReturnsSpecies()
    var
        l_Text: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text for the SW Resource Enum species
        l_Text := 'species';
        // [WHEN] the procedure GetEnumFromText is run
        l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_Text);
        // [THEN] the result should be the corrosponding SW Enum
        g_Assert.AreEqual("SW Resource Types"::species, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetEnumFromTextReturnsErrorOnInvalidText()
    var
        l_InvalidText: Text;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is a Text that cannot be translated into an SW Resource Enum
        l_InvalidText := 'invalidEnumTextExample';
        // [WHEN] the procedure GetEnumFromText is run
        // [THEN] the procedure should throw an error
        asserterror l_ResourceType := g_SWResourceHelper.GetEnumFromText(l_InvalidText);
    end;

    ///GetListPageNoFromResourceEnum
    [Test]
    procedure TestGetListPageNoFromResourceEnumReturnsCorrectPageForFilms()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_PageNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum films 
        l_ResourceType := "SW Resource Types"::films;
        // [WHEN] the GetListPageNoFromResourceEnum function is invoked
        l_PageNo := g_SWResourceHelper.GetListPageNoFromResourceEnum(l_ResourceType);
        // [THEN] the result page number matches the expected "SW Film List" page
        g_Assert.AreEqual(Page::"SW Film List", l_PageNo, '');
    end;


    [Test]
    procedure TestGetListPageNoFromResourceEnumReturnsCorrectPageForPeople()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_PageNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum people 
        l_ResourceType := "SW Resource Types"::people;
        // [WHEN] Invoking the GetListPageNoFromResourceEnum function
        l_PageNo := g_SWResourceHelper.GetListPageNoFromResourceEnum(l_ResourceType);
        // [THEN] the result page number matches the expected "SW People List" page
        g_Assert.AreEqual(Page::"SW Character List", l_PageNo, '');
    end;

    [Test]
    procedure TestGetListPageNoFromResourceEnumReturnsCorrectPageForSpecies()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_PageNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum species 
        l_ResourceType := "SW Resource Types"::species;
        // [WHEN] Invoking the GetListPageNoFromResourceEnum function
        l_PageNo := g_SWResourceHelper.GetListPageNoFromResourceEnum(l_ResourceType);
        // [THEN] the result page number matches the expected "SW Species List" page
        g_Assert.AreEqual(Page::"SW Species List", l_PageNo, '');
    end;

    [Test]
    procedure TestGetListPageNoFromResourceEnumReturnsCorrectPageForPlanets()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_PageNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum planets 
        l_ResourceType := "SW Resource Types"::planets;
        // [WHEN] Invoking the GetListPageNoFromResourceEnum function
        l_PageNo := g_SWResourceHelper.GetListPageNoFromResourceEnum(l_ResourceType);
        // [THEN] the result page number matches the expected "SW Planets List" page
        g_Assert.AreEqual(Page::"SW Planet List", l_PageNo, '');
    end;

    [Test]
    procedure TestGetListPageNoFromResourceEnumReturnsCorrectPageForStarships()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_PageNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum starships 
        l_ResourceType := "SW Resource Types"::starships;
        // [WHEN] Invoking the GetListPageNoFromResourceEnum function
        l_PageNo := g_SWResourceHelper.GetListPageNoFromResourceEnum(l_ResourceType);
        // [THEN] the result page number matches the expected "SW Starships List" page
        g_Assert.AreEqual(Page::"SW Starship List", l_PageNo, '');
    end;

    [Test]
    procedure TestGetListPageNoFromResourceEnumReturnsCorrectPageForVehicles()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_PageNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum vehicles
        l_ResourceType := "SW Resource Types"::vehicles;
        // [WHEN] Invoking the GetListPageNoFromResourceEnum function
        l_PageNo := g_SWResourceHelper.GetListPageNoFromResourceEnum(l_ResourceType);
        // [THEN] the result page number matches the expected "SW Vehicles List" page
        g_Assert.AreEqual(Page::"SW Vehicle List", l_PageNo, '');
    end;

    ///GetRecRefTableNoFromResourceEnum
    [Test]
    procedure TestGetRecRefTableNoFromResourceEnumReturnsCorrectTableForFilms()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum films 
        l_ResourceType := "SW Resource Types"::films;
        // [WHEN] the procedure GetRecRefTableNoFromResourceEnum is run
        l_TableNo := g_SWResourceHelper.GetRecRefTableNoFromResourceEnum(l_ResourceType);
        // [THEN] the result table number matches the expected "SW Film" table
        g_Assert.AreEqual(Database::"SW Film", l_TableNo, '');
    end;

    [Test]
    procedure TestGetRecRefTableNoFromResourceEnumReturnsCorrectTableForPeople()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum people 
        l_ResourceType := "SW Resource Types"::people;
        // [WHEN] the procedure GetRecRefTableNoFromResourceEnum is run
        l_TableNo := g_SWResourceHelper.GetRecRefTableNoFromResourceEnum(l_ResourceType);
        // [THEN] the result table number matches the expected "SW Character" table
        g_Assert.AreEqual(Database::"SW Character", l_TableNo, '');
    end;

    [Test]
    procedure TestGetRecRefTableNoFromResourceEnumReturnsCorrectTableForPlanets()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum planets 
        l_ResourceType := "SW Resource Types"::planets;
        // [WHEN] the procedure GetRecRefTableNoFromResourceEnum is run
        l_TableNo := g_SWResourceHelper.GetRecRefTableNoFromResourceEnum(l_ResourceType);
        // [THEN] the result table number matches the expected "SW Planet" table
        g_Assert.AreEqual(Database::"SW Planet", l_TableNo, '');
    end;

    [Test]
    procedure TestGetRecRefTableNoFromResourceEnumReturnsCorrectTableForSpecies()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum species 
        l_ResourceType := "SW Resource Types"::species;
        // [WHEN] the procedure GetRecRefTableNoFromResourceEnum is run
        l_TableNo := g_SWResourceHelper.GetRecRefTableNoFromResourceEnum(l_ResourceType);
        // [THEN] the result table number matches the expected "SW Species" table
        g_Assert.AreEqual(Database::"SW Species", l_TableNo, '');
    end;

    [Test]
    procedure TestGetRecRefTableNoFromResourceEnumReturnsCorrectTableForStarships()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum starships 
        l_ResourceType := "SW Resource Types"::starships;
        // [WHEN] the procedure GetRecRefTableNoFromResourceEnum is run
        l_TableNo := g_SWResourceHelper.GetRecRefTableNoFromResourceEnum(l_ResourceType);
        // [THEN] the result table number matches the expected "SW Starship" table
        g_Assert.AreEqual(Database::"SW Starship", l_TableNo, '');
    end;

    [Test]
    procedure TestGetRecRefTableNoFromResourceEnumReturnsCorrectTableForVehicles()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableNo: Integer;
    begin
        // [GIVEN] is SW Resource Enum vehicles 
        l_ResourceType := "SW Resource Types"::vehicles;
        // [WHEN] the procedure GetRecRefTableNoFromResourceEnum is run
        l_TableNo := g_SWResourceHelper.GetRecRefTableNoFromResourceEnum(l_ResourceType);
        // [THEN] the result table number matches the expected "SW Vehicle" table
        g_Assert.AreEqual(Database::"SW Vehicle", l_TableNo, '');
    end;

    ///GetResourceEnumFromRecRefTableNo
    [Test]
    procedure TestGetResourceEnumFromRecRefTableNoReturnsEnumForFilms()
    var
        l_TableNo: Integer;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is the table number corresponding to the "SW Film" table
        l_TableNo := Database::"SW Film";
        // [WHEN] the procedure GetResourceEnumFromRecRefTableNo is run
        l_ResourceType := g_SWResourceHelper.GetResourceEnumFromRecRefTableNo(l_TableNo);
        // [THEN] the returned SW Resource Enum matches "films"
        g_Assert.AreEqual("SW Resource Types"::films, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetResourceEnumFromRecRefTableNoReturnsEnumForPeople()
    var
        l_TableNo: Integer;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is the table number corresponding to the "SW Character" table
        l_TableNo := Database::"SW Character";
        // [WHEN] the procedure GetResourceEnumFromRecRefTableNo is run
        l_ResourceType := g_SWResourceHelper.GetResourceEnumFromRecRefTableNo(l_TableNo);
        // [THEN] the returned SW Resource Enum matches "people"
        g_Assert.AreEqual("SW Resource Types"::people, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetResourceEnumFromRecRefTableNoReturnsEnumForPlanets()
    var
        l_TableNo: Integer;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is the table number corresponding to the "SW Planet" table
        l_TableNo := Database::"SW Planet";
        // [WHEN] the procedure GetResourceEnumFromRecRefTableNo is run
        l_ResourceType := g_SWResourceHelper.GetResourceEnumFromRecRefTableNo(l_TableNo);
        // [THEN] the returned SW Resource Enum matches "planets"
        g_Assert.AreEqual("SW Resource Types"::planets, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetResourceEnumFromRecRefTableNoReturnsEnumForSpecies()
    var
        l_TableNo: Integer;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is the table number corresponding to the "SW Species" table
        l_TableNo := Database::"SW Species";
        // [WHEN] the procedure GetResourceEnumFromRecRefTableNo is run
        l_ResourceType := g_SWResourceHelper.GetResourceEnumFromRecRefTableNo(l_TableNo);
        // [THEN] the returned SW Resource Enum matches "species"
        g_Assert.AreEqual("SW Resource Types"::species, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetResourceEnumFromRecRefTableNoReturnsEnumForStarships()
    var
        l_TableNo: Integer;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is the table number corresponding to the "SW Starship" table
        l_TableNo := Database::"SW Starship";
        // [WHEN] the procedure GetResourceEnumFromRecRefTableNo is run
        l_ResourceType := g_SWResourceHelper.GetResourceEnumFromRecRefTableNo(l_TableNo);
        // [THEN] the returned SW Resource Enum matches "starships"
        g_Assert.AreEqual("SW Resource Types"::starships, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetResourceEnumFromRecRefTableNoReturnsEnumForVehicles()
    var
        l_TableNo: Integer;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is the table number corresponding to the "SW Vehicle" table
        l_TableNo := Database::"SW Vehicle";
        // [WHEN] the procedure GetResourceEnumFromRecRefTableNo is run
        l_ResourceType := g_SWResourceHelper.GetResourceEnumFromRecRefTableNo(l_TableNo);
        // [THEN] the returned SW Resource Enum matches "vehicles"
        g_Assert.AreEqual("SW Resource Types"::vehicles, l_ResourceType, '');
    end;

    [Test]
    procedure TestGetResourceEnumFromRecRefTableNoReturnsErrorIfSWTableNoDoesNotExist()
    var
        l_TableNo: Integer;
        l_ResourceType: Enum "SW Resource Types";
    begin
        // [GIVEN] is the table number corresponding to the "SW Vehicle" table
        l_TableNo := 0;
        // [WHEN] the procedure GetResourceEnumFromRecRefTableNo is run
        // [THEN] the procedure should throw an error
        asserterror l_ResourceType := g_SWResourceHelper.GetResourceEnumFromRecRefTableNo(l_TableNo);
    end;

    ///GetTableNameFromResourceEnum
    [Test]
    procedure TestGetTableNameFromResourceEnumReturnsTableNameForFilms()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableName: Text;
    begin
        // [GIVEN] is SW Resource Enum films 
        l_ResourceType := "SW Resource Types"::films;
        // [WHEN] the procedure GetTableNameFromResourceEnum is run
        l_TableName := g_SWResourceHelper.GetTableNameFromResourceEnum(l_ResourceType);
        // [THEN] Verifying that the returned table name matches "SW Film"
        g_Assert.AreEqual('SW Film', l_TableName, '');
    end;

    [Test]
    procedure TestGetTableNameFromResourceEnumReturnsTableNameForPeople()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableName: Text;
    begin
        // [GIVEN] is SW Resource Enum people 
        l_ResourceType := "SW Resource Types"::people;
        // [WHEN] the procedure GetTableNameFromResourceEnum is run
        l_TableName := g_SWResourceHelper.GetTableNameFromResourceEnum(l_ResourceType);
        // [THEN] Verifying that the returned table name matches "SW Character"
        g_Assert.AreEqual('SW Character', l_TableName, '');
    end;

    [Test]
    procedure TestGetTableNameFromResourceEnumReturnsTableNameForPlanets()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableName: Text;
    begin
        // [GIVEN] is SW Resource Enum planets 
        l_ResourceType := "SW Resource Types"::planets;
        // [WHEN] the procedure GetTableNameFromResourceEnum is run
        l_TableName := g_SWResourceHelper.GetTableNameFromResourceEnum(l_ResourceType);
        // [THEN] Verifying that the returned table name matches "SW Planet"
        g_Assert.AreEqual('SW Planet', l_TableName, '');
    end;

    [Test]
    procedure TestGetTableNameFromResourceEnumReturnsTableNameForSpecies()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableName: Text;
    begin
        // [GIVEN] is SW Resource Enum species 
        l_ResourceType := "SW Resource Types"::species;
        // [WHEN] the procedure GetTableNameFromResourceEnum is run
        l_TableName := g_SWResourceHelper.GetTableNameFromResourceEnum(l_ResourceType);
        // [THEN] Verifying that the returned table name matches "SW Species"
        g_Assert.AreEqual('SW Species', l_TableName, '');
    end;

    [Test]
    procedure TestGetTableNameFromResourceEnumReturnsTableNameForStarships()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableName: Text;
    begin
        // [GIVEN] is SW Resource Enum starships 
        l_ResourceType := "SW Resource Types"::starships;
        // [WHEN] the procedure GetTableNameFromResourceEnum is run
        l_TableName := g_SWResourceHelper.GetTableNameFromResourceEnum(l_ResourceType);
        // [THEN] Verifying that the returned table name matches "SW Starship"
        g_Assert.AreEqual('SW Starship', l_TableName, '');
    end;

    [Test]
    procedure TestGetTableNameFromResourceEnumReturnsTableNameForVehicles()
    var
        l_ResourceType: Enum "SW Resource Types";
        l_TableName: Text;
    begin
        // [GIVEN] is SW Resource Enum vehicles 
        l_ResourceType := "SW Resource Types"::vehicles;
        // [WHEN] the procedure GetTableNameFromResourceEnum is run
        l_TableName := g_SWResourceHelper.GetTableNameFromResourceEnum(l_ResourceType);
        // [THEN] Verifying that the returned table name matches "SW Vehicle"
        g_Assert.AreEqual('SW Vehicle', l_TableName, '');
    end;

    var
        g_Assert: Codeunit "Library Assert";
        g_SWResourceHelper: Codeunit "SW Resource Type Helper";
}