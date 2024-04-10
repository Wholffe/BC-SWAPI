table 50103 "SW Starships"
{
    Caption = 'SW Starships';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
        }
        field(2; Model; Text[50])
        {
            Caption = 'Model';
        }
        field(3; StarshipClass; Text[50])
        {
            Caption = 'Starship Class';
        }
        field(4; Manufacturer; Text[50])
        {
            Caption = 'Manufacturer';
        }
        field(5; CostInCredits; Integer)
        {
            Caption = 'Cost in credits';
        }
        field(6; Length; Integer)
        {
            Caption = 'Length';
        }
        field(7; Crew; Integer)
        {
            Caption = 'Crew';
        }
        field(8; Passengers; Integer)
        {
            Caption = 'Passengers';
        }
        field(9; MaxAtmospheringSpeed; Text[50])
        {
            Caption = 'Max atmosphering speed';
        }
        field(10; "HyperdriveRating "; Decimal)
        {
            Caption = 'Hyperdrive rating ';
        }
        field(11; MGLT; Integer)
        {
            Caption = 'MGLT';
        }
        field(12; CargoCapacity; Integer)
        {
            Caption = 'Cargo capacity';
        }
        field(13; Consumables; Text[50])
        {
            Caption = 'Consumables';
        }
        field(14; Films; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(starships), RessourceID = field(ID), AssociatedRessourceType = const(films)));
            Caption = 'Films';
            FieldClass = FlowField;
        }
        field(15; Pilots; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(starships), RessourceID = field(ID), AssociatedRessourceType = const(people)));
            Caption = 'Pilots';
            FieldClass = FlowField;
        }
        field(16; Url; Text[50])
        {
            Caption = 'Url';
        }
        field(17; Created; DateTime)
        {
            Caption = 'Created';
        }
        field(18; Edited; DateTime)
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
