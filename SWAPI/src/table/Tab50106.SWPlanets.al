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
        field(3; Diameter; Integer)
        {
            BlankZero = true;
            Caption = 'Diameter';
        }
        field(4; RotationPeriod; Integer)
        {
            BlankZero = true;
            Caption = 'Rotation period';
        }
        field(5; OrbitalPeriod; Integer)
        {
            BlankZero = true;
            Caption = 'Orbital period';
        }
        field(6; Gravity; Integer)
        {
            BlankZero = true;
            Caption = 'Gravity';
        }
        field(7; Population; Integer)
        {
            BlankZero = true;
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
        field(10; SurfaceWater; Integer)
        {
            BlankZero = true;
            Caption = 'Surface water';
        }
        field(11; Residents; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(planets), ResourceID = field(ID), AssociatedResourceType = const(people)));
            Caption = 'Residents';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Films; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(planets), ResourceID = field(ID), AssociatedResourceType = const(films)));
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
