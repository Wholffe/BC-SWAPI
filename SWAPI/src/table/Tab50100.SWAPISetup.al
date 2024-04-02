table 50100 SWAPISetup
{
    Caption = 'SWAPISetup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            Caption = 'PrimaryKey';
        }
        field(2; endpoint; Text[100])
        {
            Caption = 'RequestURL';
            InitValue = 'https://swapi.dev/api/';
            Editable = false;
        }
    }
    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }
}
