namespace SWAPI.SWAPI;

codeunit 50101 "SW Utility Mng"
{
    var
        g_JMng: Codeunit "SW Json Mng";
        g_SWResourceHelper: Codeunit "SW Resource Type Helper";

    /// <summary>
    /// Deletes associated records from a given resource record.
    /// </summary>
    ///<param name="p_Rec">The variant representing the record to delete. Records must have a valid result for the function GetResourceEnumFromRecRefTableNo///</param>
    procedure DeleteAssRecords(p_Rec: Variant)
    var
        l_ResourceAss: Record "SW Resource Association";
        l_RecordRef: RecordRef;
        l_ResourceType: Enum "SW Resource Types";
        l_ID: Integer;
        l_TableNo: Integer;
    begin
        if not p_Rec.IsRecord then
            exit;
        l_RecordRef.GetTable(p_Rec);
        l_TableNo := l_RecordRef.Number();
        l_ID := l_RecordRef.Field(1).Value;
        l_RecordRef.Close();
        l_ResourceType := g_SWResourceHelper.GetResourceEnumFromRecRefTableNo(l_TableNo);
        l_ResourceAss.SetRange(ResourceType, l_ResourceType);
        l_ResourceAss.SetRange(ResourceID, l_ID);
        if l_ResourceAss.FindSet() then
            repeat
                l_ResourceAss.Delete();
            until l_ResourceAss.Next() = 0;
    end;

    /// <summary>
    /// Retrieves the count of a category from the provided URL.
    /// </summary>
    /// <param name="p_Url">The URL to fetch data from.</param>
    /// <returns>The count of the category found in the JSON response.</returns>
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

    /// <summary>
    /// Validate the field "AssResourceID" of all records in "SW Resource Association"
    /// </summary>
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
