table 50105 "SW Species"
{
    Caption = 'SW Species';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
            Editable = false;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; Classification; Text[50])
        {
            Caption = 'Classification';
        }
        field(4; Designation; Text[50])
        {
            Caption = 'Designation';
        }
        field(5; AverageHeight; Text[50])
        {
            Caption = 'Average height';
        }
        field(6; AverageLifeSpan; Text[50])
        {
            Caption = 'Average life span';
        }
        field(7; EyeColor; Text[50])
        {
            Caption = 'Eye color';
        }
        field(8; HairColors; Text[50])
        {
            Caption = 'Hair colors';
        }
        field(9; SkinColors; Text[50])
        {
            Caption = 'Skin colors';
        }
        field(10; Language; Text[50])
        {
            Caption = 'Language';
        }
        field(11; Homeworld; Text[50])
        {
            Caption = 'Homeworld';
            CalcFormula = lookup("SW Ressource Assosiation".AssociatedRessourceValue where(RessourceType = const(species), RessourceID = field(ID), AssociatedRessourceType = const(planets)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; People; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(species), RessourceID = field(ID), AssociatedRessourceType = const(people)));
            Caption = 'People';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Films; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(species), RessourceID = field(ID), AssociatedRessourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; Url; Text[50])
        {
            Caption = 'Url';
        }
        field(15; Created; DateTime)
        {
            Caption = 'Created';
        }
        field(16; Edited; DateTime)
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
