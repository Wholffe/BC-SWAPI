namespace SWAPI.SWAPI;

codeunit 50101 "SW Utility Mng"
{
    var
        g_JMng: Codeunit "SW Json Mng";

    procedure GetCategoryCountFromUrl(p_Url: Text): Integer
    var
        l_Count: Integer;
        l_JObject: JsonObject;
        l_TotalCountIdentifier: List of [Text];
        l_Element: Text;
    begin
        l_TotalCountIdentifier.Add('count');
        l_TotalCountIdentifier.Add('total_records');
        l_JObject := g_JMng.GetJObjectFromUrl(p_Url);
        foreach l_Element in l_TotalCountIdentifier do begin
            l_Count := g_JMng.GetJsonIntegerField(l_JObject, l_Element);
            if l_Count <> 0 then
                exit(l_Count);
        end;
    end;

    procedure ValidateAllResourcesAss()
    var
        l_ResourceAss: Record "SW Resource Association";
        l_Counter: Integer;
    begin
        l_ResourceAss.Reset();
        if l_ResourceAss.FindSet() then
            repeat
                l_ResourceAss.Validate(AssResourceID);
                l_ResourceAss.Modify();
            until l_ResourceAss.Next() = 0;
    end;
}
