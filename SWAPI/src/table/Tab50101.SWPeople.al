table 50101 "SW People"
{
    Caption = 'SW People';
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
        field(3; BirthYear; Text[100])
        {
            Caption = 'Birth year';
        }
        field(4; EyeColor; Text[100])
        {
            Caption = 'Eye color';
        }
        field(5; Gender; Text[100])
        {
            Caption = 'Gender';
        }
        field(6; HairColor; Text[100])
        {
            Caption = 'Hair color';
        }
        field(7; Height; Integer)
        {
            BlankZero = true;
            Caption = 'Height';
        }
        field(8; Mass; Integer)
        {
            BlankZero = true;
            Caption = 'Mass';
        }
        field(9; SkinColor; Text[100])
        {
            Caption = 'Skin color ';
        }
        field(10; Homeworld; Text[100])
        {
            Caption = 'Homeworld';
            trigger OnValidate()
            var
                l_Planets: Record "SW Planets";
            begin
                l_Planets.SetRange(Url, Rec.Homeworld);
                if l_Planets.FindFirst() then
                    Homeworld := l_Planets.Name;
            end;
        }
        field(11; Films; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Species; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(species)));
            Caption = 'Species';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Starships; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(starships)));
            Caption = 'Starships';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; Vehicles; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(vehicles)));
            Caption = 'Vehicles';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; Url; Text[100])
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
