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
        field(10; Homeworld; Text[100])
        {
            Caption = 'Homeworld';
            ToolTip = 'The name of a planet resource, a planet that this person was born on or inhabits.';
            trigger OnValidate()
            var
                l_Planets: Record "SW Planets";
            begin
                l_Planets.SetRange(Url, Rec.Homeworld);
                if l_Planets.FindFirst() then
                    Rec.Homeworld := l_Planets.Name;
            end;
        }
        field(11; Films; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(films)));
            Caption = 'Films';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of film resources that this person has been in.';
        }
        field(12; Species; Text[100])
        {
            CalcFormula = lookup("SW Resource Association".AssResourceName where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(species)));
            Caption = 'Species';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of species resources that this person belongs to.';
        }
        field(13; Starships; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(starships)));
            Caption = 'Starships';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of starship resources that this person has piloted.';
        }
        field(14; Vehicles; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(people), ResourceID = field(ID), AssociatedResourceType = const(vehicles)));
            Caption = 'Vehicles';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of vehicle resources that this person has piloted.';
        }
        field(15; Url; Text[100])
        {
            Caption = 'Url';
            Editable = false;
            ToolTip = 'The hypermedia URL of this resource.';
        }
        field(16; Created; DateTime)
        {
            Caption = 'Created';
            Editable = false;
            ToolTip = 'The ISO 8601 date format of the time that this resource was created.';
        }
        field(17; Edited; DateTime)
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
