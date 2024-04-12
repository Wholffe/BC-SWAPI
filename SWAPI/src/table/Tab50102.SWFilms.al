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
        }
        field(2; Title; Text[100])
        {
            Caption = 'Title';
        }
        field(3; EpisodeID; Integer)
        {
            Caption = 'Episode ID';
        }
        field(4; OpeningCrawl; Text[1024])
        {
            Caption = 'Opening crawl';
        }
        field(5; Director; Text[100])
        {
            Caption = 'Director';
        }
        field(6; Producer; Text[100])
        {
            Caption = 'Producer';
        }
        field(7; ReleaseDate; Date)
        {
            Caption = 'Release date';
        }
        field(8; Species; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(films), RessourceID = field(ID), AssociatedRessourceType = const(species)));
            Caption = 'Species';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; Starships; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(films), RessourceID = field(ID), AssociatedRessourceType = const(starships)));
            Caption = 'Starships';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; Vehicles; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(films), RessourceID = field(ID), AssociatedRessourceType = const(vehicles)));
            Caption = 'Vehicles';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Characters; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(films), RessourceID = field(ID), AssociatedRessourceType = const(people)));
            Caption = 'Characters';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Planets; Integer)
        {
            CalcFormula = count("SW Ressource Assosiation" where(RessourceType = const(films), RessourceID = field(ID), AssociatedRessourceType = const(planets)));
            Caption = 'Planets';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Url; Text[500])
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
