table 50106 "SW Planets"
{
    Caption = 'SW Planets';
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
        field(3; Diameter; Integer)
        {
            Caption = 'Diameter';
        }
        field(4; RotationPeriod; Integer)
        {
            Caption = 'Rotation period';
        }
        field(5; OrbitalPeriod; Integer)
        {
            Caption = 'Orbital period';
        }
        field(6; Gravity; Text[50])
        {
            Caption = 'Gravity';
        }
        field(7; Population; Integer)
        {
            Caption = 'Population';
        }
        field(8; Climate; Text[50])
        {
            Caption = 'Climate';
        }
        field(9; Terrain; Text[50])
        {
            Caption = 'Terrain';
        }
        field(10; SurfaceWater; Text[50])
        {
            Caption = 'Surface water';
        }
        field(11; Residents; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(planets), RessourceID = field(ID), AssociatedRessourceType = const(people)));
            Caption = 'Residents';
            FieldClass = FlowField;
        }
        field(12; Films; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(planets), RessourceID = field(ID), AssociatedRessourceType = const(films)));
            Caption = 'Films';
            FieldClass = FlowField;
        }
        field(13; Url; Text[50])
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
