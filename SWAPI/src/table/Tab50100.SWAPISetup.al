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
        field(2; Endpoint; Text[100])
        {
            Caption = 'RequestURL';
            Editable = false;
            InitValue = 'https://swapi.dev/api/';
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
