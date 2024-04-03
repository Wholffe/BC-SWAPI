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
            Caption = 'Species';//array
        }
        field(9; Starships; Integer)
        {
            Caption = 'Starships';//array
        }
        field(10; Vehicles; Integer)
        {
            Caption = 'Vehicles';//array
        }
        field(11; Characters; Integer)
        {
            Caption = 'Characters';//array
        }
        field(12; Planets; Integer)
        {
            Caption = 'Planets';//array
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
