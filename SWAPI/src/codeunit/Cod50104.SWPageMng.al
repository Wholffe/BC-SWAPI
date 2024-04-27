namespace SWAPI.SWAPI;

codeunit 50104 "SW Page Mng"
{
    var
        g_SWResourceHelper: Codeunit "SW Resource Type Helper";

    procedure DrilldownPage(p_ResourceType: Enum "SW Resource Types"; p_ID: Integer; p_AssociatedResourceType: Enum "SW Resource Types")
    var
        l_ResourceAss: Record "SW Resource Association";
        l_RecRef: RecordRef;
        l_FieldRef: FieldRef;
        l_PageNo: Integer;
        l_RecRefTableNo: Integer;
        l_Filter: Text;
        l_VarRecRef: Variant;
    begin
        l_Filter := GetAssociationFilter(p_ResourceType, p_ID, p_AssociatedResourceType);
        if l_Filter = '' then
            exit;
        l_RecRefTableNo := g_SWResourceHelper.GetRecRefTableNoFromResourceEnum(p_AssociatedResourceType);
        l_RecRef.Open(g_SWResourceHelper.GetRecRefTableNoFromResourceEnum(p_AssociatedResourceType));
        l_FieldRef := l_RecRef.Field(1);
        l_FieldRef.SetFilter(l_Filter);
        l_VarRecRef := l_RecRef;
        l_RecRef.Close();
        case l_RecRefTableNo of
            Database::"SW Films":
                l_PageNo := Page::"SW Films List";
            Database::"SW People":
                l_PageNo := Page::"SW People List";
            Database::"SW Planets":
                l_PageNo := Page::"SW Planets List";
            Database::"SW Species":
                l_PageNo := Page::"SW Species List";
            Database::"SW Starships":
                l_PageNo := Page::"SW Starships List";
            Database::"SW Vehicles":
                l_PageNo := Page::"SW Vehicles List";
        end;
        Page.Run(l_PageNo, l_VarRecRef);
    end;

    local procedure GetAssociationFilter(p_ResourceType: Enum "SW Resource Types"; p_ID: Integer; p_AssociatedResourceType: Enum "SW Resource Types"): Text
    var
        l_ResourceAss: Record "SW Resource Association";
        l_Filter: Text;
    begin
        l_ResourceAss.Reset();
        l_ResourceAss.SetRange(ResourceType, p_ResourceType);
        l_ResourceAss.SetRange(ResourceID, p_ID);
        l_ResourceAss.SetRange(AssociatedResourceType, p_AssociatedResourceType);
        if not l_ResourceAss.FindSet() then
            exit;
        repeat
            l_Filter := StrSubstNo('%1|%2', l_ResourceAss.AssResourceID, l_Filter)
        until l_ResourceAss.Next() = 0;
        l_Filter := l_Filter.TrimEnd('|');
        exit(l_Filter)
    end;
}
