table 50107 "SW Resource Association"
{
    Caption = 'SW Resource Association';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ResourceType; Enum "SW Resource Types")
        {
            Caption = 'Resource Type';
        }
        field(2; ResourceID; Integer)
        {
            Caption = 'Resource ID';
        }
        field(3; AssociatedResourceType; Enum "SW Resource Types")
        {
            Caption = 'Associated Resource Type';
        }
        field(4; AssociatedResourceUrl; Text[100])
        {
            Caption = 'Associated Resource Url';
            trigger OnValidate()
            var
                l_FieldList: Record Field;
                l_APIMng: Codeunit "SWAPI Mng";
                l_RecRef: RecordRef;
                l_UrlRef: FieldRef;
                l_FieldNo: Integer;
                l_TableNo: Integer;
            begin
                l_TableNo := l_APIMng.GetRecRefTableNoFromResourceEnum(Rec.AssociatedResourceType);
                l_FieldList.SetRange(TableNo, l_TableNo);
                l_FieldList.SetRange(FieldName, 'Url');
                l_FieldList.FindFirst();
                l_FieldNo := l_FieldList."No.";
                l_RecRef.Open(l_TableNo);
                l_UrlRef := l_RecRef.Field(l_FieldNo);
                l_UrlRef.SetRange(Rec.AssociatedResourceUrl);
                if l_RecRef.FindFirst() then begin
                    AssRessourceID := l_RecRef.Field(1).Value;
                    AssRessourceName := l_RecRef.Field(2).Value;
                    AssRessourceValue := l_RecRef.Field(3).Value;
                end;
                l_RecRef.Close();
            end;
        }
        field(5; AssRessourceID; Integer)
        {
            Caption = 'Associated Ressource ID';
        }
        field(6; AssRessourceName; Text[100])
        {
            Caption = 'Associated Ressource Name';
        }
        field(7; AssRessourceValue; Text[100])
        {
            Caption = 'Associated Ressource Value';
        }
    }
    keys
    {
        key(PK; ResourceType, ResourceID, AssociatedResourceType, AssociatedResourceUrl)
        {
            Clustered = true;
        }
    }
}
