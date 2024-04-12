table 50107 "SW Ressource Assosiation"
{
    Caption = 'SW Ressource Assosiation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; RessourceType; Enum "SW Ressouce Types")
        {
            Caption = 'RessourceType';
        }
        field(2; RessourceID; Integer)
        {
            Caption = 'RessourceID';
        }
        field(3; AssociatedRessourceType; Enum "SW Ressouce Types")
        {
            Caption = 'AssociatedRessourceType';
        }
        field(4; AssociatedRessourceValue; Text[100])
        {
            Caption = 'AssociatedRessourceValue';
        }
    }
    keys
    {
        key(PK; RessourceType, RessourceID, AssociatedRessourceType, AssociatedRessourceValue)
        {
            Clustered = true;
        }
    }
}
