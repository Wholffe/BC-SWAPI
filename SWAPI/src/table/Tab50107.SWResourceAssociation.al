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
        field(4; AssResourceID; Integer)
        {
            Caption = 'Associated Resource ID';
            trigger OnValidate()
            var
                l_FieldList: Record Field;
                l_APIMng: Codeunit "SWAPI Mng";
                l_RecRef: RecordRef;
                l_IDRef: FieldRef;
                l_FieldNo: Integer;
                l_TableNo: Integer;
            begin
                l_TableNo := l_APIMng.GetRecRefTableNoFromResourceEnum(Rec.AssociatedResourceType);
                l_RecRef.Open(l_TableNo);
                l_IDRef := l_RecRef.Field(1);
                l_IDRef.SetRange(Rec.AssResourceID);
                if l_RecRef.FindFirst() then begin
                    AssResourceName := l_RecRef.Field(2).Value;
                    AssResourceValue := l_RecRef.Field(3).Value;
                end;
                l_RecRef.Close();
            end;
        }
        field(5; AssResourceName; Text[100])
        {
            Caption = 'Associated Resource Name';
        }
        field(6; AssResourceValue; Text[100])
        {
            Caption = 'Associated Resource Value';
        }
    }
    keys
    {
        key(PK; ResourceType, ResourceID, AssociatedResourceType, AssResourceID)
        {
            Clustered = true;
        }
    }
}
