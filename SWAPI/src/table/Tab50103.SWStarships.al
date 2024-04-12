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
        field(6; CostInCredits; Text[100])
        {
            Caption = 'Cost in credits';
        }
        field(7; Length; Text[100])
        {
            Caption = 'Length';
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
        field(11; "HyperdriveRating "; Text[100])
        {
            Caption = 'Hyperdrive rating ';
        }
        field(12; MGLT; Text[100])
        {
            Caption = 'MGLT';
        }
        field(13; CargoCapacity; Text[100])
        {
            Caption = 'Cargo capacity';
        }
        field(14; Consumables; Text[100])
        {
            Caption = 'Consumables';
        }
        field(15; Films; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(starships), RessourceID = field(ID), AssociatedRessourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; Pilots; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(starships), RessourceID = field(ID), AssociatedRessourceType = const(people)));
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
