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
            ToolTip = 'The ID and PK from this resource';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            ToolTip = 'The name of this species.';
        }
        field(3; Classification; Text[100])
        {
            Caption = 'Classification';
            ToolTip = 'The classification of this species, such as "mammal" or "reptile".';
        }
        field(4; Designation; Text[100])
        {
            Caption = 'Designation';
            ToolTip = 'The designation of this species, such as "sentient".';
        }
        field(5; AverageHeight; Integer)
        {
            BlankZero = true;
            Caption = 'Average height';
            ToolTip = 'The average height of this species in centimeters.';
        }
        field(6; AverageLifeSpan; Integer)
        {
            BlankZero = true;
            Caption = 'Average life span';
            ToolTip = 'The average lifespan of this species in years.';
        }
        field(7; EyeColor; Text[100])
        {
            Caption = 'Eye color';
            ToolTip = 'A comma-separated string of common eye colors for this species, empty if this species does not typically have eyes.';
        }
        field(8; HairColors; Text[100])
        {
            Caption = 'Hair colors';
            ToolTip = 'A comma-separated string of common hair colors for this species, "none" if this species does not typically have hair.';
        }
        field(9; SkinColors; Text[100])
        {
            Caption = 'Skin colors';
            ToolTip = 'A comma-separated string of common skin colors for this species, "none" if this species does not typically have skin.';
        }
        field(10; Language; Text[100])
        {
            Caption = 'Language';
            ToolTip = 'The language commonly spoken by this species.';
        }
        field(11; HomeworldID; Integer)
        {
            BlankZero = true;
            Caption = 'Homeworld ID';
            TableRelation = "SW Planet".ID;
        }
        field(12; Url; Text[100])
        {
            Caption = 'Url';
            Editable = false;
            ToolTip = 'The hypermedia URL of this resource.';
        }
        field(13; Created; DateTime)
        {
            Caption = 'Created';
            Editable = false;
            ToolTip = 'The ISO 8601 date format of the time that this resource was created.';
        }
        field(14; Edited; DateTime)
        {
            Caption = 'Edited';
            Editable = false;
            ToolTip = 'The ISO 8601 date format of the time that this resource was edited.';
        }
        field(100; HomeworldName; Text[100])
        {
            CalcFormula = lookup("SW Planet".Name where(ID = field(HomeworldID)));
            Caption = 'Homeworld';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The homeworld this person comes from.';
        }
        field(101; Characters; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(species), ResourceID = field(ID), AssociatedResourceType = const(people)));
            Caption = 'Characters';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of characters that are a part of this species.';
        }
        field(102; Films; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(species), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of films that this species has appeared in.';
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
