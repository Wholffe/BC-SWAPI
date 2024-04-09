table 50101 "SW People"
{
    Caption = 'SW People';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            Editable = false;
            AutoIncrement = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; BirthYear; Text[50])
        {
            Caption = 'Birth year ';
        }
        field(4; EyeColor; Text[50])
        {
            Caption = 'Eye color';
        }
        field(5; Gender; Text[50])
        {
            Caption = 'Gender';
        }
        field(6; HairColor; Text[50])
        {
            Caption = 'Hair color ';
        }
        field(7; Height; Text[50])
        {
            Caption = 'Height';
        }
        field(8; Mass; Text[50])
        {
            Caption = 'Mass';
        }
        field(9; SkinColor; Text[50])
        {
            Caption = 'Skin color ';
        }
        field(10; Homeworld; Text[50])
        {
            Caption = 'Homeworld';
        }
        field(11; Films; Integer)
        {
            Caption = 'Films';
            FieldClass = FlowField;
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(people), RessourceID = field(ID), AssociatedRessourceType = const(films)));
            Editable = false;
        }
        field(12; Species; Integer)
        {
            Caption = 'Species';
            FieldClass = FlowField;
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(people), RessourceID = field(ID), AssociatedRessourceType = const(species)));
            Editable = false;
        }
        field(13; Starships; Integer)
        {
            Caption = 'Starships';
            FieldClass = FlowField;
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(people), RessourceID = field(ID), AssociatedRessourceType = const(starships)));
            Editable = false;
        }
        field(14; Vehicles; Integer)
        {
            Caption = 'Vehicles';
            FieldClass = FlowField;
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(people), RessourceID = field(ID), AssociatedRessourceType = const(vehicles)));
            Editable = false;
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
