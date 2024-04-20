table 50102 "SW Films"
{
    Caption = 'SW Films';
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
        field(2; Title; Text[100])
        {
            Caption = 'Title';
            ToolTip = 'The title of this film.';
        }
        field(3; EpisodeID; Integer)
        {
            Caption = 'Episode ID';
            ToolTip = 'The episode number of this film.';
        }
        field(4; OpeningCrawl; Text[1024])
        {
            Caption = 'Opening crawl';
            ToolTip = 'The opening paragraphs at the beginning of this film.';
        }
        field(5; Director; Text[100])
        {
            Caption = 'Director';
            ToolTip = 'The name of the director of this film.';
        }
        field(6; Producer; Text[100])
        {
            Caption = 'Producer';
            ToolTip = 'The name(s) of the producer(s) of this film. Comma separated.';
        }
        field(7; ReleaseDate; Date)
        {
            Caption = 'Release date';
            ToolTip = 'The ISO 8601 date format of film release at original creator country.';
        }
        field(8; Species; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(films), ResourceID = field(ID), AssociatedResourceType = const(species)));
            Caption = 'Species';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of species resources that are in this film.';
        }
        field(9; Starships; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(films), ResourceID = field(ID), AssociatedResourceType = const(starships)));
            Caption = 'Starships';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of starship resources that are in this film.';
        }
        field(10; Vehicles; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(films), ResourceID = field(ID), AssociatedResourceType = const(vehicles)));
            Caption = 'Vehicles';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of vehicles resources that are in this film.';
        }
        field(11; Characters; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(films), ResourceID = field(ID), AssociatedResourceType = const(people)));
            Caption = 'Characters';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of people resources that are in this film.';
        }
        field(12; Planets; Integer)
        {
            CalcFormula = count("SW Resource Association" where(ResourceType = const(films), ResourceID = field(ID), AssociatedResourceType = const(planets)));
            Caption = 'Planets';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'The number of planet resources that are in this film.';
        }
        field(13; Url; Text[500])
        {
            Caption = 'Url';
            ToolTip = 'The hypermedia URL of this resource.';
        }
        field(14; Created; DateTime)
        {
            Caption = 'Created';
            ToolTip = 'The ISO 8601 date format of the time that this resource was created.';
        }
        field(15; Edited; DateTime)
        {
            Caption = 'Edited';
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
    trigger OnModify()
    begin
        Rec.Edited := CurrentDateTime;
    end;
}
