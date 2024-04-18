namespace SWAPI.SWAPI;
using System.Environment.Configuration;
using System.Media;

codeunit 50100 "SWAPI Setup Mng"
{

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
        l_SWAPISetup: Record SWAPISetup;
        l_APIMng: Codeunit "SWAPI Mng";
        l_JObject: JsonObject;
        l_ContentTxt: Text;
        l_Url: Text;
    begin
        l_Url := StrSubstNo('%1', p_Rec.Endpoint);
        l_JObject := l_APIMng.GetJObjectFromUrl(l_Url);
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
