namespace SWAPI.SWAPI;

codeunit 50107 "SW Status Notification Mng"
{
    var
        g_AllResourcesDeletedL: Label 'Sector is Clear. All resources deleted.';
        g_AlreadyImportedL: Label 'You have already imported %1. Take a seat.';
        g_ImportSuccessfullL: Label '%1 imported successfully.';
        g_SingleResourceDeletedL: Label '%1 deleted.';
        g_SWResourceHelper: Codeunit "SW Resource Type Helper";

    procedure GetAlreadyImportedL(p_Resource: Enum "SW Resource Types"): Text
    begin
        exit(StrSubstNo(g_AlreadyImportedL, p_Resource))
    end;

    procedure GetImportSuccessfullL(p_Resource: Enum "SW Resource Types"): Text
    begin
        exit(StrSubstNo(g_ImportSuccessfullL, g_SWResourceHelper.GetResourceL(p_Resource)))
    end;

    procedure GetResourcesClearedL(): Text
    begin
        exit(g_AllResourcesDeletedL);
    end;

    procedure GetSingleResourceDeletedL(p_Resource: Enum "SW Resource Types"): Text
    begin
        exit(StrSubstNo(g_SingleResourceDeletedL, g_SWResourceHelper.GetResourceL(p_Resource)))
    end;

    local procedure SendStatusNotification(p_StatusL: Text)
    var
        l_StatusNotification: Notification;
        l_CurrentStatus: Text;
    begin
        if (not GuiAllowed) or (p_StatusL = '') then
            exit;
        l_StatusNotification.Message(p_StatusL);
        l_StatusNotification.Send();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SWAPI Data Import Mng", 'OnAfterDataAlreadyImported', '', false, false)]
    local procedure SendAlreadyImportedNotification(p_Resource: Enum "SW Resource Types")
    begin
        SendStatusNotification(GetAlreadyImportedL((p_Resource)));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SWAPI Data Import Mng", 'OnAfterFillAllResourcesOfAKind', '', false, false)]
    local procedure SendImportSucessfulNotification(p_Resource: Enum "SW Resource Types")
    begin
        SendStatusNotification(GetImportSuccessfullL(p_Resource));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SWAPI Setup Mng", 'OnAfterClearAllSWData', '', false, false)]
    local procedure SendResourceClearedNotification()
    begin
        SendStatusNotification(GetResourcesClearedL());
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SWAPI Setup Mng", 'OnAfterDeleteSingleResource', '', false, false)]
    local procedure SendSingleResourceDeletedNotification(p_Resource: Enum "SW Resource Types")
    begin
        SendStatusNotification(GetSingleResourceDeletedL(p_Resource));
    end;
}
