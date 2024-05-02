namespace SWAPI.SWAPI;

codeunit 50105 "SW Resource Type Helper"
{
    var
        g_CharacterL: Label 'Characters';
        g_FilmL: Label 'Films';
        g_PlanetL: Label 'Planets';
        g_SpeciesL: Label 'Species';
        g_StarshipL: Label 'Starships';
        g_VehicleL: Label 'Vehicles';

    /// <summary>
    /// Get the enum of the SW resource type based on the specified text.
    /// </summary>
    /// <exception cref="Error">Thrown when no matching enumeration value is found for the provided text.</exception>
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

    /// <summary>
    /// Get the list page number associated with the specified SW resource type enumeration.
    /// </summary>
    /// <exception cref="Error">Thrown when no matching l_PageNo is found for the provided enum.</exception>
    procedure GetListPageNoFromResourceEnum(p_Resource: Enum "SW Resource Types"): Integer
    var
        l_PageNo: Integer;
    begin
        case p_Resource of
            "SW Resource Types"::films:
                l_PageNo := Page::"SW Film List";
            "SW Resource Types"::people:
                l_PageNo := Page::"SW Character List";
            "SW Resource Types"::planets:
                l_PageNo := Page::"SW Planet List";
            "SW Resource Types"::species:
                l_PageNo := Page::"SW Species List";
            "SW Resource Types"::starships:
                l_PageNo := Page::"SW Starship List";
            "SW Resource Types"::vehicles:
                l_PageNo := Page::"SW Vehicle List";
            else
                Error('No ListPage for %1.', p_Resource);
        end;
        exit(l_PageNo);
    end;

    /// <summary>
    /// Get the table number corresponding to the specified SW resource type.
    /// </summary>
    /// <exception cref="Error">Thrown when no matching TableNo is found for the provided enum.</exception>
    procedure GetRecRefTableNoFromResourceEnum(p_Resource: Enum "SW Resource Types"): Integer
    begin
        case p_Resource of
            "SW Resource Types"::films:
                exit(Database::"SW Film");
            "SW Resource Types"::people:
                exit(Database::"SW Character");
            "SW Resource Types"::planets:
                exit(Database::"SW Planet");
            "SW Resource Types"::species:
                exit(Database::"SW Species");
            "SW Resource Types"::starships:
                exit(Database::"SW Starship");
            "SW Resource Types"::vehicles:
                exit(Database::"SW Vehicle");
            else
                Error('No table for %1.', p_Resource);
        end;
    end;

    /// <summary>
    /// Get the corresponding resource enum from a given table number.
    /// </summary>
    /// <exception cref="Error">Thrown when no matching TableNo is found for the provided enum.</exception>
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
                exit(g_FilmL);
            "SW Resource Types"::people:
                exit(g_CharacterL);
            "SW Resource Types"::planets:
                exit(g_PlanetL);
            "SW Resource Types"::species:
                exit(g_SpeciesL);
            "SW Resource Types"::starships:
                exit(g_StarshipL);
            "SW Resource Types"::vehicles:
                exit(g_VehicleL);
            else
                Error('No label for %1.', p_Resource);
        end;
    end;

    /// <summary>
    /// Get the table name corresponding to the specified SW resource type.
    /// </summary>
    procedure GetTableNameFromResourceEnum(p_Resource: Enum "SW Resource Types"): Text
    var
        l_RecRef: RecordRef;
        l_TableNo: Integer;
        l_TableName: Text;
    begin
        l_TableNo := GetRecRefTableNoFromResourceEnum(p_Resource);
        l_RecRef.Open(l_TableNo);
        l_TableName := l_RecRef.Name();
        l_RecRef.Close();
        exit(l_TableName);
    end;

    /// <summary>
    /// Get the URL corresponding to the specified SW resource type enum.
    /// </summary>
    procedure GetUrlFromEnum(p_ResourceType: Enum "SW Resource Types"): Text
    var
        l_APISetup: Record SWAPISetup;
    begin
        l_APISetup.FindFirst();
        exit(StrSubstNo('%1/%2/', l_APISetup.Endpoint, p_ResourceType))
    end;
}
