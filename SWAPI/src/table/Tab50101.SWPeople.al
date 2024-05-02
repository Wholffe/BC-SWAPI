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
            ToolTip = 'The ID and PK from this resource';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            ToolTip = 'The name of this person.';
        }
        field(3; BirthYear; Text[100])
        {
            Caption = 'Birth year';
            ToolTip = 'The birth year of the person, using the in-universe standard of BBY or ABY - Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is a battle that occurs at the end of Star Wars episode IV: A New Hope.';
        }
        field(4; EyeColor; Text[100])
        {
            Caption = 'Eye color';
            ToolTip = 'The eye color of this person. Will be empty if not known or "n/a" if the person does not have an eye.';
        }
        field(5; Gender; Text[100])
        {
            Caption = 'Gender';
            ToolTip = 'The gender of this person. Either "Male", "Female" or empty, "n/a" if the person does not have a gender.';
        }
        field(6; HairColor; Text[100])
        {
            Caption = 'Hair color';
            ToolTip = 'The hair color of this person. Will be empty if not known or "n/a" if the person does not have hair.';
        }
        field(7; Height; Integer)
        {
            BlankZero = true;
            Caption = 'Height';
            ToolTip = 'The height of the person in centimeters.';
        }
        field(8; Mass; Integer)
        {
            BlankZero = true;
            Caption = 'Mass';
            ToolTip = 'The mass of the person in kilograms.';
        }
        field(9; SkinColor; Text[100])
        {
            Caption = 'Skin color ';
            ToolTip = 'The skin color of this person.';
        }
        field(10; HomeworldID; Integer)
        {
            BlankZero = true;
            Caption = 'Homeworld ID';
            TableRelation = "SW Planets".ID;
        }
        field(11; SpeciesID; Integer)
        {
            BlankZero = true;
            Caption = 'Species ID';
            TableRelation = "SW Species".ID;
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
            CalcFormula = lookup("SW Planets".Name where(ID = field(HomeworldID)));
            Caption = 'Homeworld';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'he homeworld this person comes from.';
        }
        field(101; SpeciesName; Text[100])
        {
            CalcFormula = lookup("SW Species".Name where(ID = field(SpeciesID)));
            Caption = 'Species';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The species this person belongs to.';
        }
        field(102; Films; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of film resources that this person has been in.';
        }
        field(103; Starships; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(starships)));
            Caption = 'Starships';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of starship resources that this person has piloted.';
        }
        field(104; Vehicles; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(vehicles)));
            Caption = 'Vehicles';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of vehicle resources that this person has piloted.';
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
