table 50102 "SW Films"
{
    Caption = 'SW Films';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
        }
        field(2; Title; Text[50])
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
        field(5; Director; Text[50])
        {
            Caption = 'Director';
        }
        field(6; Producer; Text[50])
        {
            Caption = 'Producer';
        }
        field(7; ReleaseDate; Date)
        {
            Caption = 'Release date';
        }
        field(8; Species; Integer)
        {
            Caption = 'Species';
            FieldClass = FlowField;
            CalcFormula = count("SWAPI Ressource Assosiation" where(RessourceType = const(films), RessourceID = field(ID), AssociatedRessourceType = const(species)));
        }
        field(9; Starships; Integer)
        {
            Caption = 'Starships';
            FieldClass = FlowField;
            CalcFormula = count("SWAPI Ressource Assosiation" where(RessourceType = const(films), RessourceID = field(ID), AssociatedRessourceType = const(starships)));
        }
        field(10; Vehicles; Integer)
        {
            Caption = 'Vehicles';
            FieldClass = FlowField;
            CalcFormula = count("SWAPI Ressource Assosiation" where(RessourceType = const(films), RessourceID = field(ID), AssociatedRessourceType = const(vehicles)));
        }
        field(11; Characters; Integer)
        {
            Caption = 'Characters';
            FieldClass = FlowField;
            CalcFormula = count("SWAPI Ressource Assosiation" where(RessourceType = const(films), RessourceID = field(ID), AssociatedRessourceType = const(people)));
        }
        field(12; Planets; Integer)
        {
            Caption = 'Planets';
            FieldClass = FlowField;
            CalcFormula = count("SWAPI Ressource Assosiation" where(RessourceType = const(films), RessourceID = field(ID), AssociatedRessourceType = const(planets)));
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
