namespace SWAPI.SWAPI;
using System.Environment.Configuration;
using System.Media;

codeunit 50100 "SWAPI Setup Mng"
{
    var
        g_Films: Record "SW Films";
        g_People: Record "SW People";
        g_Planets: Record "SW Planets";
        g_ResourceAss: Record "SW Resource Association";
        g_Species: Record "SW Species";
        g_Starships: Record "SW Starships";
        g_Vehicles: Record "SW Vehicles";
        g_APIMng: Codeunit "SWAPI Mng";

    procedure ClearAllSWData()
    var
        l_Notification: Notification;
        l_NotificationL: Label 'Sector is Clear.';
    begin
        g_Films.DeleteAll();
        g_People.DeleteAll();
        g_Planets.DeleteAll();
        g_Species.DeleteAll();
        g_Starships.DeleteAll();
        g_Vehicles.DeleteAll();
        g_ResourceAss.DeleteAll();
        l_Notification.Message(l_NotificationL);
        l_Notification.Send();
    end;

    procedure DeleteSingleResource()
    var
        l_ResourceDialog: Page "SW Resource StandardDialog";
        l_Notification: Notification;
        l_Resource: Enum "SW Resource Types";
        l_Count: Integer;
        l_NotificationL: Label '%1 deleted.';
    begin
        l_ResourceDialog.Setup(Enum::"SW Resource Types"::films);
        if l_ResourceDialog.RunModal() = Action::OK then begin
            l_Resource := l_ResourceDialog.GetResourceType();
            case l_Resource of
                "SW Resource Types"::films:
                    g_Films.DeleteAll();
                "SW Resource Types"::people:
                    g_People.DeleteAll();
                "SW Resource Types"::planets:
                    g_Planets.DeleteAll();
                "SW Resource Types"::species:
                    g_Species.DeleteAll();
                "SW Resource Types"::vehicles:
                    g_Vehicles.DeleteAll();
                "SW Resource Types"::starships:
                    g_Starships.DeleteAll();
            end;
            g_ResourceAss.SetRange(ResourceType, l_Resource);
            g_ResourceAss.DeleteAll();
            g_APIMng.ValidateAllResourcesAss();
            l_Notification.Message(StrSubstNo(l_NotificationL, l_Resource));
            l_Notification.Send();
        end;
    end;

    procedure FillAllResources()
    begin
        g_APIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::films);
        g_APIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::planets); //planets before people bec of people Homeworld Validate trigger
        g_APIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::people);
        g_APIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::species);
        g_APIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::starships);
        g_APIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::vehicles);
        g_APIMng.ValidateAllResourcesAss();
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
        l_JObject := g_APIMng.GetJObjectFromUrl(l_Url);
        l_ContentTxt := StrSubstNo('%1', l_JObject);
        for l_ElementNo := 1 to 6 do begin
            l_ExpectedRootElement := GetExpectedRootContent(p_Rec, l_ElementNo);
            if not l_ContentTxt.Contains(l_ExpectedRootElement) then
                exit(false);
        end;
        exit(true);
    end;

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

    procedure ShowNumberOfRequestEntries()
    var
        l_ResourceDialog: Page "SW Resource StandardDialog";
        l_Count: Integer;
        l_Url: Text;
    begin
        l_ResourceDialog.Setup(Enum::"SW Resource Types"::films);
        if l_ResourceDialog.RunModal() = Action::OK then begin
            l_Url := g_APIMng.GetUrlFromEnum(l_ResourceDialog.GetResourceType());
            l_Count := g_APIMng.GetCategoryCount(l_Url);
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
            'Use the SWAPI to search for Star Wars Planets, Spaceships, Vehicles, People, Films and Species in Business Central',
            1,
            ObjectType::Page,
            Page::SWAPISetup,
            Enum::"Assisted Setup Group"::Connect,
            'https://github.com/Wholffe/BC-SWAPI',
            Enum::"Video Category"::Connect,
            'https://github.com/Wholffe/BC-SWAPI')
    end;
}
