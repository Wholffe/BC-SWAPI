table 50105 "SW Species"
{
    Caption = 'SW Species';
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
        field(3; Classification; Text[50])
        {
            Caption = 'Classification';
        }
        field(4; Designation; Text[50])
        {
            Caption = 'Designation';
        }
        field(5; AverageHeight; Integer)
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
        }
        field(12; People; Integer)
        {
            Caption = 'People';
            FieldClass = FlowField;
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(species), RessourceID = field(ID), AssociatedRessourceType = const(people)));
        }
        field(13; Films; Integer)
        {
            Caption = 'Films';
            FieldClass = FlowField;
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(species), RessourceID = field(ID), AssociatedRessourceType = const(films)));
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
