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
        field(6; Lenght; Text[100])
        {
            Caption = 'Lenght';
        }
        field(7; CostInCredits; Text[100])
        {
            Caption = 'Cost in credits';
        }
        field(8; Crew; Text[100])
        {
            Caption = 'Crew';
        }
        field(9; Passengers; Text[100])
        {
            Caption = 'Passengers';
        }
        field(10; MaxAtmospheringSpeed; Text[100])
        {
            Caption = 'Max atmosphering speed';
        }
        field(11; CargoCapacity; Text[100])
        {
            Caption = 'CargoCapacity';
        }
        field(12; Consumables; Text[100])
        {
            Caption = 'Consumables';
        }
        field(13; Film; Integer)
        {
            CalcFormula = count("SW Resource Assosiation" where(ResourceType = const(vehicles), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Film';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; Pilots; Integer)
        {
            CalcFormula = count("SW Resource Assosiation" where(ResourceType = const(vehicles), ResourceID = field(ID), AssociatedResourceType = const(people)));
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
