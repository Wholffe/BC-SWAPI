namespace SWAPI.SWAPI;
using System.Environment.Configuration;
using System.Media;

codeunit 50100 "SWAPI Setup Mng"
{
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
