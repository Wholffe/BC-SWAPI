table 50101 "SW People"
{
    Caption = 'SW People';
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
        field(3; "BirthYear "; Text[50])
        {
            Caption = 'Birth year ';
        }
        field(4; EyeColor; Text[50])
        {
            Caption = 'Eye color';
        }
        field(5; Gender; Option)
        {
            Caption = 'Gender';
            OptionMembers = "n/a",male,female;
        }
        field(6; "HairColor "; Text[50])
        {
            Caption = 'Hair color ';
        }
        field(7; Height; Integer)
        {
            Caption = 'Height';
        }
        field(8; Mass; Integer)
        {
            Caption = 'Mass';
        }
        field(9; "SkinColor "; Text[50])
        {
            Caption = 'Skin color ';
        }
        field(10; "Homeworld "; Text[50])
        {
            Caption = 'Homeworld';
        }
        field(11; Films; Integer)
        {
            Caption = 'Films';
            FieldClass = FlowField;
            CalcFormula = count("SWAPI Ressource Assosiation" where(RessourceType = const(people), RessourceID = field(ID), AssociatedRessourceType = const(films)));
        }
        field(12; Species; Integer)
        {
            Caption = 'Species';
            FieldClass = FlowField;
            CalcFormula = count("SWAPI Ressource Assosiation" where(RessourceType = const(people), RessourceID = field(ID), AssociatedRessourceType = const(species)));
        }
        field(13; Starships; Integer)
        {
            Caption = 'Starships';
            FieldClass = FlowField;
            CalcFormula = count("SWAPI Ressource Assosiation" where(RessourceType = const(people), RessourceID = field(ID), AssociatedRessourceType = const(starships)));
        }
        field(14; Vehicles; Integer)
        {
            Caption = 'Vehicles';
            FieldClass = FlowField;
            CalcFormula = count("SWAPI Ressource Assosiation" where(RessourceType = const(people), RessourceID = field(ID), AssociatedRessourceType = const(vehicles)));
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
