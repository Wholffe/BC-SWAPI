namespace SWAPI.SWAPI;

codeunit 50105 "SW Resource Type Helper"
{
    procedure GetEnumFromText(p_Text: Text): Enum "SW Resource Types"
    begin
        case p_Text of
            'films':
                exit(Enum::"SW Resource Types"::films);
            'people', 'characters', 'residents', 'pilots':
                exit(Enum::"SW Resource Types"::people);
            'planets', 'homeworld':
                exit(Enum::"SW Resource Types"::planets);
            'species':
                exit(Enum::"SW Resource Types"::species);
            'starships':
                exit(Enum::"SW Resource Types"::starships);
            'vehicles':
                exit(Enum::"SW Resource Types"::vehicles);
            else
                Error('%1 is not an Enum', p_Text);
        end;
    end;

    procedure GetRecRefTableNoFromResourceEnum(p_Resource: Enum "SW Resource Types"): Integer
    begin
        case p_Resource of
            Enum::"SW Resource Types"::films:
                exit(Database::"SW Films");
            Enum::"SW Resource Types"::people:
                exit(Database::"SW People");
            Enum::"SW Resource Types"::planets:
                exit(Database::"SW Planets");
            Enum::"SW Resource Types"::species:
                exit(Database::"SW Species");
            Enum::"SW Resource Types"::starships:
                exit(Database::"SW Starships");
            Enum::"SW Resource Types"::vehicles:
                exit(Database::"SW Vehicles");
        end;
    end;

    procedure GetUrlFromEnum(p_ResourceType: Enum "SW Resource Types"): Text
    var
        l_APISetup: Record SWAPISetup;
    begin
        l_APISetup.FindFirst();
        exit(StrSubstNo('%1/%2/', l_APISetup.Endpoint, p_ResourceType))
    end;
}
