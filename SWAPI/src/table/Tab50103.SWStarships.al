table 50103 "SW Starship"
{
    Caption = 'SW Starship';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
            Editable = false;
            ToolTip = 'The ID and PK from this resource';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            ToolTip = 'The name of this starship. The common name, such as "Death Star".';
        }
        field(3; Model; Text[100])
        {
            Caption = 'Model';
            ToolTip = 'The model or official name of this starship. Such as "T-65 X-wing" or "DS-1 Orbital Battle Station".';
        }
        field(4; StarshipClass; Text[100])
        {
            Caption = 'Starship Class';
            ToolTip = 'The class of this starship, such as "Starfighter" or "Deep Space Mobile Battlestation"';
        }
        field(5; Manufacturer; Text[100])
        {
            Caption = 'Manufacturer';
            ToolTip = 'The manufacturer of this starship. Comma separated if more than one.';
        }
        field(6; CostInCredits; Integer)
        {
            BlankZero = true;
            Caption = 'Cost in credits';
            ToolTip = 'The cost of this starship new, in galactic credits.';
        }
        field(7; Length; Integer)
        {
            BlankZero = true;
            Caption = 'Length';
            ToolTip = 'The length of this starship in meters.';
        }
        field(8; Crew; Integer)
        {
            BlankZero = true;
            Caption = 'Crew';
            ToolTip = 'The number of personnel needed to run or pilot this starship.';
        }
        field(9; Passengers; Integer)
        {
            BlankZero = true;
            Caption = 'Passengers';
            ToolTip = 'The number of non-essential people this starship can transport.';
        }
        field(10; MaxAtmospheringSpeed; Integer)
        {
            BlankZero = true;
            Caption = 'Max atmosphering speed';
            ToolTip = 'The maximum speed of this starship in the atmosphere. "n/a" if this starship is incapable of atmospheric flight.';
        }
        field(11; HyperdriveRating; Decimal)
        {
            BlankZero = true;
            Caption = 'Hyperdrive rating ';
            ToolTip = 'The class of this starships hyperdrive.';
        }
        field(12; MGLT; Integer)
        {
            BlankZero = true;
            Caption = 'MGLT';
            ToolTip = 'The Maximum number of Megalights this starship can travel in a standard hour. A "Megalight" is a standard unit of distance and has never been defined before within the Star Wars universe. This figure is only really useful for measuring the difference in speed of starships. We can assume it is similar to AU, the distance between our Sun (Sol) and Earth.';
        }
        field(13; CargoCapacity; Integer)
        {
            BlankZero = true;
            Caption = 'Cargo capacity';
            ToolTip = 'The maximum number of kilograms that this starship can transport.';
        }
        field(14; Consumables; Text[100])
        {
            Caption = 'Consumables';
            ToolTip = 'The maximum length of time that this starship can provide consumables for its entire crew without having to resupply.';
        }
        field(15; Url; Text[100])
        {
            Caption = 'Url';
            Editable = false;
            ToolTip = 'The hypermedia URL of this resource.';
        }
        field(16; Created; DateTime)
        {
            Caption = 'Created';
            Editable = false;
            ToolTip = 'The ISO 8601 date format of the time that this resource was created.';
        }
        field(17; Edited; DateTime)
        {
            Caption = 'Edited';
            Editable = false;
            ToolTip = 'The ISO 8601 date format of the time that this resource was edited.';
        }
        field(100; Films; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(starships), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of films that this starship has appeared in.';
        }
        field(101; Pilots; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(starships), ResourceID = field(ID), AssociatedResourceType = const(people)));
            Caption = 'Pilots';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of people that this starship has piloted by.';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    var
        g_SWUtilityMng: Codeunit "SW Utility Mng";

    trigger OnModify()
    begin
        Rec.Edited := CurrentDateTime;
    end;

    trigger OnDelete()
    begin
        g_SWUtilityMng.DeleteAssRecords(Rec);
    end;
}
