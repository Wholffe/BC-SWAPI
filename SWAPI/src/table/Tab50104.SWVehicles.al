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
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; Model; Text[100])
        {
            Caption = 'Model';
        }
        field(4; VehicleClass; Text[100])
        {
            Caption = 'Vehicle class';
        }
        field(5; Manufacturer; Text[100])
        {
            Caption = 'Manufacturer';
        }
        field(6; Lenght; Decimal)
        {
            BlankZero = true;
            Caption = 'Lenght';
        }
        field(7; CostInCredits; Integer)
        {
            BlankZero = true;
            Caption = 'Cost in credits';
        }
        field(8; Crew; Integer)
        {
            BlankZero = true;
            Caption = 'Crew';
        }
        field(9; Passengers; Integer)
        {
            BlankZero = true;
            Caption = 'Passengers';
        }
        field(10; MaxAtmospheringSpeed; Integer)
        {
            Caption = 'Max atmosphering speed';
        }
        field(11; CargoCapacity; Integer)
        {
            BlankZero = true;
            Caption = 'CargoCapacity';
        }
        field(12; Consumables; Text[100])
        {
            Caption = 'Consumables';
        }
        field(13; Film; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(vehicles), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Film';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; Pilots; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(vehicles), ResourceID = field(ID), AssociatedResourceType = const(people)));
            Caption = 'Pilots';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; Url; Text[100])
        {
            Caption = 'Url';
        }
        field(16; Created; DateTime)
        {
            Caption = 'Created';
        }
        field(17; Edited; DateTime)
        {
            Caption = 'Edited';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
