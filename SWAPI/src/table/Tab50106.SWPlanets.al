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
            ToolTip = 'The ID and PK from this resource';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            ToolTip = 'The name of this planet.';
        }
        field(3; Diameter; Integer)
        {
            BlankZero = true;
            Caption = 'Diameter';
            ToolTip = 'The diameter of this planet in kilometers.';
        }
        field(4; RotationPeriod; Integer)
        {
            BlankZero = true;
            Caption = 'Rotation period';
            ToolTip = 'The number of standard hours it takes for this planet to complete a single rotation on its axis.';
        }
        field(5; OrbitalPeriod; Integer)
        {
            BlankZero = true;
            Caption = 'Orbital period';
            ToolTip = 'The number of standard days it takes for this planet to complete a single orbit of its local star.';
        }
        field(6; Gravity; Integer)
        {
            BlankZero = true;
            Caption = 'Gravity';
            ToolTip = 'A number denoting the gravity of this planet, where "1" is normal or 1 standard G. "2" is twice or 2 standard Gs. "0.5" is half or 0.5 standard Gs.';
        }
        field(7; Population; Integer)
        {
            BlankZero = true;
            Caption = 'Population';
            ToolTip = 'The average population of sentient beings inhabiting this planet.';
        }
        field(8; Climate; Text[100])
        {
            Caption = 'Climate';
            ToolTip = 'The climate of this planet. Comma separated if diverse.';
        }
        field(9; Terrain; Text[100])
        {
            Caption = 'Terrain';
            ToolTip = 'The terrain of this planet. Comma separated if diverse.';
        }
        field(10; SurfaceWater; Integer)
        {
            BlankZero = true;
            Caption = 'Surface water';
            ToolTip = 'The percentage of the planet surface that is naturally occurring water or bodies of water.';
        }
        field(11; Residents; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(planets), ResourceID = field(ID), AssociatedResourceType = const(people)));
            Caption = 'Residents';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of people resources that live on this planet.';
        }
        field(12; Films; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(planets), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of film resources that this planet has appeared in.';
        }
        field(13; Url; Text[100])
        {
            Caption = 'Url';
            Editable = false;
            ToolTip = 'The hypermedia URL of this resource.';
        }
        field(14; Created; DateTime)
        {
            Caption = 'Created';
            Editable = false;
            ToolTip = 'The ISO 8601 date format of the time that this resource was created.';
        }
        field(15; Edited; DateTime)
        {
            Caption = 'Edited';
            Editable = false;
            ToolTip = 'The ISO 8601 date format of the time that this resource was edited.';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    var
        g_SWUtilityMng: Codeunit "SW Utility Mng";

    trigger OnModify()
    begin
        Rec.Edited := CurrentDateTime;
    end;

    trigger OnDelete()
    begin
        g_SWUtilityMng.DeleteAssRecords(Rec);
    end;
}
