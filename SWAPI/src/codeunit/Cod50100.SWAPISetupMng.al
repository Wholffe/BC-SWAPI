namespace SWAPI.SWAPI;
using System.Environment.Configuration;
using System.Media;

codeunit 50100 "SWAPI Setup Mng"
{
    var
        g_DataImportMng: Codeunit "SWAPI Data Import Mng";
        g_JMng: Codeunit "SW Json Mng";
        g_SWResourceHelper: Codeunit "SW Resource Type Helper";
        g_SWUtilityMng: Codeunit "SW Utility Mng";

    procedure ClearAllSWData()
    var
        l_Character: Record "SW Character";
        l_Film: Record "SW Film";
        l_Planet: Record "SW Planet";
        l_ResourceAss: Record "SW Resource Association";
        l_Species: Record "SW Species";
        l_Starship: Record "SW Starship";
        l_Vehicle: Record "SW Vehicle";
    begin
        l_Film.DeleteAll();
        l_Character.DeleteAll();
        l_Planet.DeleteAll();
        l_Species.DeleteAll();
        l_Starship.DeleteAll();
        l_Vehicle.DeleteAll();
        l_ResourceAss.DeleteAll();
        OnAfterClearAllSWData();
    end;

    /// <summary>
    /// Initiates the process to delete all records of a specified resource type.
    /// </summary>
    /// <remarks>
    ///     This procedure prompts the user to select a resource type using a standard dialog.
    ///     Upon selecting a resource type and confirming, it deletes all records of that type from the database
    ///     along with their associated resource associations. After deletion, it validates all resource associations.
    /// </remarks>
    procedure DeleteSingleResource()
    var
        l_ResourceAss: Record "SW Resource Association";
        l_ResourceDialog: Page "SW Resource StandardDialog";
        l_RecRef: RecordRef;
        l_Resource: Enum "SW Resource Types";
        l_Count: Integer;
        l_TableNo: Integer;
    begin
        l_ResourceDialog.Setup("SW Resource Types"::films);
        if l_ResourceDialog.RunModal() = Action::OK then begin
            l_Resource := l_ResourceDialog.GetResourceType();
            l_TableNo := g_SWResourceHelper.GetRecRefTableNoFromResourceEnum(l_Resource);
            l_RecRef.Open(l_TableNo);
            l_RecRef.DeleteAll();
            l_RecRef.Close();
            l_ResourceAss.SetRange(ResourceType, l_Resource);
            l_ResourceAss.DeleteAll();
            g_SWUtilityMng.ValidateAllResourcesAss();
        end;
        OnAfterDeleteSingleResource(l_Resource);
    end;

    /// <summary>
    /// Fills all available SW resources in the database.
    /// </summary>
    /// <remarks>
    ///     This procedure fills the database with resources in the following order:
    ///     1. Film
    ///     2. Planet
    ///     3. Character
    ///     4. Species
    ///     5. Starship
    ///     6. Vehicle
    ///     After filling all resources, it validates all resource associations.
    /// </remarks>
    procedure FillAllResources()
    begin
        g_DataImportMng.FillAllResourcesOfAKind("SW Resource Types"::films);
        g_DataImportMng.FillAllResourcesOfAKind("SW Resource Types"::planets); //planets before people bec of people Homeworld Validate trigger
        g_DataImportMng.FillAllResourcesOfAKind("SW Resource Types"::people);
        g_DataImportMng.FillAllResourcesOfAKind("SW Resource Types"::species);
        g_DataImportMng.FillAllResourcesOfAKind("SW Resource Types"::starships);
        g_DataImportMng.FillAllResourcesOfAKind("SW Resource Types"::vehicles);
        g_SWUtilityMng.ValidateAllResourcesAss();
    end;

    /// <summary>
    /// Initiates the process to fill a single resource.
    /// </summary>
    /// <remarks>
    ///     This procedure prompts the user to select a resource type using a standard dialog.
    ///     Upon selecting a resource type and confirming, it triggers the process to fill all resources of that type.
    /// </remarks>
    procedure FillSingleResource()
    var
        l_SWUtilityMng: Codeunit "SW Utility Mng";
        l_ResourceDialog: Page "SW Resource StandardDialog";
        l_Resource: Enum "SW Resource Types";
    begin
        l_ResourceDialog.Setup("SW Resource Types"::films);
        if l_ResourceDialog.RunModal() = Action::OK then begin
            l_Resource := l_ResourceDialog.GetResourceType();
            g_DataImportMng.FillAllResourcesOfAKind(l_Resource);
            l_SWUtilityMng.ValidateAllResourcesAss();
        end;
    end;

    procedure IsValidEndpointRoot(p_Rec: Record SWAPISetup): Boolean
    var
        l_ElementNo: Integer;
        l_JObject: JsonObject;
        l_ContentTxt: Text;
        l_ExpectedRootElement: Text;
        l_Url: Text;
    begin
        l_Url := StrSubstNo('%1', p_Rec.Endpoint);
        l_JObject := g_JMng.GetJObjectFromUrl(l_Url);
        l_ContentTxt := StrSubstNo('%1', l_JObject);
        for l_ElementNo := 1 to 6 do begin
            l_ExpectedRootElement := GetExpectedRootContent(p_Rec, l_ElementNo);
            if not l_ContentTxt.Contains(l_ExpectedRootElement) then
                exit(false);
        end;
        exit(true);
    end;

    /// <summary>
    /// Tests the API connection by sending a ping request and then displays 'Pong' as a confirmation message.
    /// </summary>
    procedure PingAPIConnection()
    var
        l_SWAPISetup: Record SWAPISetup;
        l_Client: HttpClient;
        l_Response: HttpResponseMessage;
    begin
        l_SWAPISetup.FindFirst();
        if not l_Client.Get(l_SWAPISetup.Endpoint, l_Response) then
            Error('Connection failed, %1', l_Response.HttpStatusCode);

        if not l_Response.IsSuccessStatusCode then
            Error('Status code result %1', l_Response.IsSuccessStatusCode);

        Message('Pong');
    end;

    /// <summary>
    /// Displays the number of entries available for a selected resource type based on the associated URL as a confirmation message.
    /// </summary>
    procedure ShowNumberOfRequestEntries()
    var
        l_ResourceDialog: Page "SW Resource StandardDialog";
        l_Count: Integer;
        l_Url: Text;
    begin
        l_ResourceDialog.Setup("SW Resource Types"::films);
        if l_ResourceDialog.RunModal() = Action::OK then begin
            l_Url := g_SWResourceHelper.GetUrlFromEnum(l_ResourceDialog.GetResourceType());
            l_Count := g_SWUtilityMng.GetCategoryCountFromUrl(l_Url);
            Message('Url: %1, Count: %2', l_Url, l_Count);
        end;
    end;

    local procedure GetExpectedRootContent(p_Rec: Record SWAPISetup; p_ElementNo: Integer): Text
    var
        l_ExpectedContentArray: array[6] of Text;
        l_ExpectedRootElement: Text;
    begin
        l_ExpectedContentArray[1] := StrSubstNo('people":"%1/people', p_Rec.Endpoint);
        l_ExpectedContentArray[2] := StrSubstNo('films":"%1/films', p_Rec.Endpoint);
        l_ExpectedContentArray[3] := StrSubstNo('species":"%1/species', p_Rec.Endpoint);
        l_ExpectedContentArray[4] := StrSubstNo('vehicles":"%1/vehicles', p_Rec.Endpoint);
        l_ExpectedContentArray[5] := StrSubstNo('starships":"%1/starships', p_Rec.Endpoint);
        l_ExpectedContentArray[6] := StrSubstNo('planets":"%1/planets', p_Rec.Endpoint);
        l_ExpectedRootElement := l_ExpectedContentArray[p_ElementNo];
        exit(l_ExpectedContentArray[p_ElementNo]);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Guided Experience", 'OnRegisterAssistedSetup', '', true, true)]
    local procedure SWAPISetupRegister()
    var
        l_GuidedExperience: Codeunit "Guided Experience";
    begin
        l_GuidedExperience.InsertAssistedSetup(
            'SW API Setup',
            'Connect SWAPI to BC',
            'Use the SWAPI to search for Star Wars Planets, Spaceships, Vehicles, Characters, Films and Species in Business Central',
            1,
            ObjectType::Page,
            Page::SWAPISetup,
            "Assisted Setup Group"::Connect,
            'https://github.com/Wholffe/BC-SWAPI',
            "Video Category"::Connect,
            'https://github.com/Wholffe/BC-SWAPI')
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterClearAllSWData()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDeleteSingleResource(p_Resource: Enum "SW Resource Types")
    begin
    end;
}
