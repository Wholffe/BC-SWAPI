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
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; Classification; Text[100])
        {
            Caption = 'Classification';
        }
        field(4; Designation; Text[100])
        {
            Caption = 'Designation';
        }
        field(5; AverageHeight; Text[100])
        {
            Caption = 'Average height';
        }
        field(6; AverageLifeSpan; Text[100])
        {
            Caption = 'Average life span';
        }
        field(7; EyeColor; Text[100])
        {
            Caption = 'Eye color';
        }
        field(8; HairColors; Text[100])
        {
            Caption = 'Hair colors';
        }
        field(9; SkinColors; Text[100])
        {
            Caption = 'Skin colors';
        }
        field(10; Language; Text[100])
        {
            Caption = 'Language';
        }
        field(11; Homeworld; Text[100])
        {
            Caption = 'Homeworld';
        }
        field(12; People; Integer)
        {
            CalcFormula = count("SW Resource Assosiation" where(ResourceType = const(species), ResourceID = field(ID), AssociatedResourceType = const(people)));
            Caption = 'People';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Films; Integer)
        {
            CalcFormula = count("SW Resource Assosiation" where(ResourceType = const(species), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; Url; Text[100])
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
