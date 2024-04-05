table 50104 "SW Vehicles"
{
    Caption = 'SW Vehicles';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; Model; Text[50])
        {
            Caption = 'Model';
        }
        field(4; VehicleClass; Text[50])
        {
            Caption = 'Vehicle class';
        }
        field(5; Manufacturer; Text[50])
        {
            Caption = 'Manufacturer';
        }
        field(6; Lenght; Integer)
        {
            Caption = 'Lenght';
        }
        field(7; CostInCredits; Integer)
        {
            Caption = 'Cost in credits';
        }
        field(8; Crew; Text[50])
        {
            Caption = 'Crew';
        }
        field(9; Passengers; Text[50])
        {
            Caption = 'Passengers';
        }
        field(10; MaxAtmospheringSpeed; Integer)
        {
            Caption = 'Max atmosphering speed';
        }
        field(11; CargoCapacity; Integer)
        {
            Caption = 'CargoCapacity';
        }
        field(12; Consumables; Text[50])
        {
            Caption = 'Consumables';
        }
        field(13; Film; Integer)
        {
            Caption = 'Film';
            FieldClass = FlowField;
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(vehicles), RessourceID = field(ID), AssociatedRessourceType = const(films)));
        }
        field(14; Pilots; Integer)
        {
            Caption = 'Pilots';
            FieldClass = FlowField;
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(vehicles), RessourceID = field(ID), AssociatedRessourceType = const(people)));
        }
        field(15; Url; Text[50])
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
