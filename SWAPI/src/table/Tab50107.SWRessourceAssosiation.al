table 50107 "SW Resource Assosiation"
{
    Caption = 'SW Resource Assosiation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ResourceType; Enum "SW Resource Types")
        {
            Caption = 'ResourceType';
        }
        field(2; ResourceID; Integer)
        {
            Caption = 'ResourceID';
        }
        field(3; AssociatedResourceType; Enum "SW Resource Types")
        {
            Caption = 'AssociatedResourceType';
        }
        field(4; AssociatedResourceValue; Text[100])
        {
            Caption = 'AssociatedResourceValue';
        }
    }
    keys
    {
        key(PK; ResourceType, ResourceID, AssociatedResourceType, AssociatedResourceValue)
        {
            Clustered = true;
        }
    }
}
