namespace SWAPI.SWAPI;

codeunit 50105 "SW Resource Type Helper"
{
    var
        g_FilmsL: Label 'Films';
        g_PeopleL: Label 'People';
        g_PlanetsL: Label 'Planets';
        g_SpeciesL: Label 'Species';
        g_StarshipsL: Label 'Starships';
        g_VehiclesL: Label 'Vehicles';

    procedure GetEnumFromText(p_Text: Text): Enum "SW Resource Types"
    begin
        case p_Text of
            'films':
                exit("SW Resource Types"::films);
            'people', 'characters', 'residents', 'pilots':
                exit("SW Resource Types"::people);
            'planets', 'homeworld':
                exit("SW Resource Types"::planets);
            'species':
                exit("SW Resource Types"::species);
            'starships':
                exit("SW Resource Types"::starships);
            'vehicles':
                exit("SW Resource Types"::vehicles);
            else
                Error('%1 is not an enum from SW Resource Types.', p_Text);
        end;
    end;

    procedure GetListPageNoFromResourceEnum(p_Resource: Enum "SW Resource Types"): Integer
    var
        l_PageNo: Integer;
    begin
        case p_Resource of
            "SW Resource Types"::films:
                l_PageNo := Page::"SW Films List";
            "SW Resource Types"::people:
                l_PageNo := Page::"SW People List";
            "SW Resource Types"::planets:
                l_PageNo := Page::"SW Planets List";
            "SW Resource Types"::species:
                l_PageNo := Page::"SW Species List";
            "SW Resource Types"::starships:
                l_PageNo := Page::"SW Starships List";
            "SW Resource Types"::vehicles:
                l_PageNo := Page::"SW Vehicles List";
            else
                Error('No ListPage for %1.', p_Resource);
        end;
        exit(l_PageNo);
    end;

    procedure GetRecRefTableNoFromResourceEnum(p_Resource: Enum "SW Resource Types"): Integer
    begin
        case p_Resource of
            "SW Resource Types"::films:
                exit(Database::"SW Films");
            "SW Resource Types"::people:
                exit(Database::"SW People");
            "SW Resource Types"::planets:
                exit(Database::"SW Planets");
            "SW Resource Types"::species:
                exit(Database::"SW Species");
            "SW Resource Types"::starships:
                exit(Database::"SW Starships");
            "SW Resource Types"::vehicles:
                exit(Database::"SW Vehicles");
            else
                Error('No table for %1.', p_Resource);
        end;
    end;

    procedure GetResourceEnumFromRecRefTableNo(p_TableNo: Integer): Enum "SW Resource Types"
    begin
        case p_TableNo of
            GetRecRefTableNoFromResourceEnum("SW Resource Types"::films):
                exit("SW Resource Types"::films);
            GetRecRefTableNoFromResourceEnum("SW Resource Types"::people):
                exit("SW Resource Types"::people);
            GetRecRefTableNoFromResourceEnum("SW Resource Types"::planets):
                exit("SW Resource Types"::planets);
            GetRecRefTableNoFromResourceEnum("SW Resource Types"::species):
                exit("SW Resource Types"::species);
            GetRecRefTableNoFromResourceEnum("SW Resource Types"::starships):
                exit("SW Resource Types"::starships);
            GetRecRefTableNoFromResourceEnum("SW Resource Types"::vehicles):
                exit("SW Resource Types"::vehicles);
            else
                Error('No Enum for TableNo %1.', p_TableNo);
        end;
    end;

    procedure GetResourceL(p_Resource: Enum "SW Resource Types"): Text
    begin
        case p_Resource of
            "SW Resource Types"::films:
                exit(g_FilmsL);
            "SW Resource Types"::people:
                exit(g_PeopleL);
            "SW Resource Types"::planets:
                exit(g_PlanetsL);
            "SW Resource Types"::species:
                exit(g_SpeciesL);
            "SW Resource Types"::starships:
                exit(g_StarshipsL);
            "SW Resource Types"::vehicles:
                exit(g_VehiclesL);
            else
                Error('No label for %1.', p_Resource);
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
