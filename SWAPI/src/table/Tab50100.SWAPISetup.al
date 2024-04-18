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
            InitValue = 'https://swapi.dev/api';

            trigger OnValidate()
            begin
                Rec.Endpoint := Rec.Endpoint.TrimEnd('/');
                if not g_APISetupMng.IsValidEndpointRoot(Rec) then
                    Error(g_EndpointErrorMsg);
            end;
        }
    }
    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }

    var
        g_APISetupMng: Codeunit "SWAPI Setup Mng";
        g_EndpointErrorMsg: Label 'Not a valid Endpoint. Use the SWAPI Root';
}
