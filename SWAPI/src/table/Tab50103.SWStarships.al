table 50103 "SW Starships"
{
    Caption = 'SW Starships';
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
        field(4; StarshipClass; Text[100])
        {
            Caption = 'Starship Class';
        }
        field(5; Manufacturer; Text[100])
        {
            Caption = 'Manufacturer';
        }
        field(6; CostInCredits; Integer)
        {
            BlankZero = true;
            Caption = 'Cost in credits';
        }
        field(7; Length; Integer)
        {
            BlankZero = true;
            Caption = 'Length';
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
            BlankZero = true;
            Caption = 'Max atmosphering speed';
        }
        field(11; HyperdriveRating; Decimal)
        {
            BlankZero = true;
            Caption = 'Hyperdrive rating ';
        }
        field(12; MGLT; Integer)
        {
            BlankZero = true;
            Caption = 'MGLT';
        }
        field(13; CargoCapacity; Integer)
        {
            BlankZero = true;
            Caption = 'Cargo capacity';
        }
        field(14; Consumables; Text[100])
        {
            Caption = 'Consumables';
        }
        field(15; Films; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(starships), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; Pilots; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(starships), ResourceID = field(ID), AssociatedResourceType = const(people)));
            Caption = 'Pilots';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; Url; Text[100])
        {
            Caption = 'Url';
        }
        field(18; Created; DateTime)
        {
            Caption = 'Created';
        }
        field(19; Edited; DateTime)
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
