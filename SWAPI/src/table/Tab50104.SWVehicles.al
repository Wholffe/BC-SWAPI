table 50104 "SW Vehicles"
{
    Caption = 'SW Vehicles';
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
            ToolTip = 'The name of this vehicle. The common name, such as "Sand Crawler" or "Speeder bike".';
        }
        field(3; Model; Text[100])
        {
            Caption = 'Model';
            ToolTip = 'The model or official name of this vehicle. Such as "All-Terrain Attack Transport".';
        }
        field(4; VehicleClass; Text[100])
        {
            Caption = 'Vehicle class';
            ToolTip = 'The class of this vehicle, such as "Wheeled" or "Repulsorcraft".';
        }
        field(5; Manufacturer; Text[100])
        {
            Caption = 'Manufacturer';
            ToolTip = 'The manufacturer of this vehicle. Comma separated if more than one.';
        }
        field(6; Lenght; Decimal)
        {
            BlankZero = true;
            Caption = 'Lenght';
            ToolTip = 'The length of this vehicle in meters.';
        }
        field(7; CostInCredits; Integer)
        {
            BlankZero = true;
            Caption = 'Cost in credits';
            ToolTip = 'The cost of this vehicle new, in Galactic Credits.';
        }
        field(8; Crew; Integer)
        {
            BlankZero = true;
            Caption = 'Crew';
            ToolTip = 'The number of personnel needed to run or pilot this vehicle.';
        }
        field(9; Passengers; Integer)
        {
            BlankZero = true;
            Caption = 'Passengers';
            ToolTip = 'The number of non-essential people this vehicle can transport.';
        }
        field(10; MaxAtmospheringSpeed; Integer)
        {
            Caption = 'Max atmosphering speed';
            ToolTip = 'The maximum speed of this vehicle in the atmosphere.';
        }
        field(11; CargoCapacity; Integer)
        {
            BlankZero = true;
            Caption = 'CargoCapacity';
            ToolTip = 'The maximum number of kilograms that this vehicle can transport.';
        }
        field(12; Consumables; Text[100])
        {
            Caption = 'Consumables';
            ToolTip = 'The maximum length of time that this vehicle can provide consumables for its entire crew without having to resupply.';
        }
        field(13; Film; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(vehicles), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Film';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of films that this vehicle has appeared in.';
        }
        field(14; Pilots; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(vehicles), ResourceID = field(ID), AssociatedResourceType = const(people)));
            Caption = 'Pilots';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of films that this people has been piloted by';
        }
        field(15; Url; Text[100])
        {
            Caption = 'Url';
            ToolTip = 'The hypermedia URL of this resource.';
        }
        field(16; Created; DateTime)
        {
            Caption = 'Created';
            ToolTip = 'The ISO 8601 date format of the time that this resource was created.';
        }
        field(17; Edited; DateTime)
        {
            Caption = 'Edited';
            ToolTip = 'The ISO 8601 date format of the time that this resource was edited.';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
    trigger OnModify()
    begin
        Rec.Edited := CurrentDateTime;
    end;
}
