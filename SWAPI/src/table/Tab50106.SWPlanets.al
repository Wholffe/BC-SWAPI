table 50106 "SW Planets"
{
    Caption = 'SW Planets';
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
        field(3; Diameter; Text[100])
        {
            Caption = 'Diameter';
        }
        field(4; RotationPeriod; Text[100])
        {
            Caption = 'Rotation period';
        }
        field(5; OrbitalPeriod; Text[100])
        {
            Caption = 'Orbital period';
        }
        field(6; Gravity; Text[100])
        {
            Caption = 'Gravity';
        }
        field(7; Population; Text[100])
        {
            Caption = 'Population';
        }
        field(8; Climate; Text[100])
        {
            Caption = 'Climate';
        }
        field(9; Terrain; Text[100])
        {
            Caption = 'Terrain';
        }
        field(10; SurfaceWater; Text[100])
        {
            Caption = 'Surface water';
        }
        field(11; Residents; Integer)
        {
            CalcFormula = count("SW Resource Assosiation" where(ResourceType = const(planets), ResourceID = field(ID), AssociatedResourceType = const(people)));
            Caption = 'Residents';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Films; Integer)
        {
            CalcFormula = count("SW Resource Assosiation" where(ResourceType = const(planets), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Url; Text[100])
        {
            Caption = 'Url';
        }
        field(14; Created; DateTime)
        {
            Caption = 'Created';
        }
        field(15; Edited; DateTime)
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
