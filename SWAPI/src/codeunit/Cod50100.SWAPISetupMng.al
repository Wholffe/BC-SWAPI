namespace SWAPI.SWAPI;
using System.Environment.Configuration;
using System.Media;

codeunit 50100 "SWAPI Setup Mng"
{
    var
        g_APIMng: Codeunit "SWAPI Mng";

    procedure ClearAllSWData()
    var
        l_Films: Record "SW Films";
        l_People: Record "SW People";
        l_Planets: Record "SW Planets";
        l_ResourceAss: Record "SW Resource Association";
        l_Species: Record "SW Species";
        l_Starships: Record "SW Starships";
        l_Vehicles: Record "SW Vehicles";
        l_Notification: Notification;
        l_NotificationL: Label 'Sector is Clear.';
    begin
        l_Films.DeleteAll();
        l_People.DeleteAll();
        l_Planets.DeleteAll();
        l_Species.DeleteAll();
        l_Starships.DeleteAll();
        l_Vehicles.DeleteAll();
        l_ResourceAss.DeleteAll();
        l_Notification.Message(l_NotificationL);
        l_Notification.Send();
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

    local procedure GetRootContentTxt(): Text
    var
        l_RootContentTxt: Text;
    begin
        l_RootContentTxt := '{"people":"https://swapi.dev/api/people/",' +
                            '"planets":"https://swapi.dev/api/planets/",' +
                            '"films":"https://swapi.dev/api/films/",' +
                            '"species":"https://swapi.dev/api/species/",' +
                            '"vehicles":"https://swapi.dev/api/vehicles/",' +
                            '"starships":"https://swapi.dev/api/starships/"}';
        exit(l_RootContentTxt);
    end;

    procedure IsValidEndpointRoot(p_Rec: Record SWAPISetup): Boolean
    var
        l_JObject: JsonObject;
        l_ContentTxt: Text;
        l_Url: Text;
    begin
        l_Url := StrSubstNo('%1', p_Rec.Endpoint);
        l_JObject := g_APIMng.GetJObjectFromUrl(l_Url);
        l_ContentTxt := StrSubstNo('%1', l_JObject);
        if l_ContentTxt = GetRootContentTxt() then
            exit(true)
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
