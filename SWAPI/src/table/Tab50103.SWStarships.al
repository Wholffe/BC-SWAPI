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
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; Model; Text[50])
        {
            Caption = 'Model';
        }
        field(4; StarshipClass; Text[50])
        {
            Caption = 'Starship Class';
        }
        field(5; Manufacturer; Text[50])
        {
            Caption = 'Manufacturer';
        }
        field(6; CostInCredits; Text[50])
        {
            Caption = 'Cost in credits';
        }
        field(7; Length; Text[50])
        {
            Caption = 'Length';
        }
        field(8; Crew; Text[50])
        {
            Caption = 'Crew';
        }
        field(9; Passengers; Text[50])
        {
            Caption = 'Passengers';
        }
        field(10; MaxAtmospheringSpeed; Text[50])
        {
            Caption = 'Max atmosphering speed';
        }
        field(11; "HyperdriveRating "; Text[50])
        {
            Caption = 'Hyperdrive rating ';
        }
        field(12; MGLT; Text[50])
        {
            Caption = 'MGLT';
        }
        field(13; CargoCapacity; Text[50])
        {
            Caption = 'Cargo capacity';
        }
        field(14; Consumables; Text[50])
        {
            Caption = 'Consumables';
        }
        field(15; Films; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(starships), RessourceID = field(ID), AssociatedRessourceType = const(films)));
            Caption = 'Films';
            FieldClass = FlowField;
        }
        field(16; Pilots; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(starships), RessourceID = field(ID), AssociatedRessourceType = const(people)));
            Caption = 'Pilots';
            FieldClass = FlowField;
        }
        field(17; Url; Text[50])
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
