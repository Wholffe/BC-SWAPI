permissionset 50100 "Jedi Knight"
{
    Assignable = true;
    Caption = 'Jedi Knight';
    Permissions = table SWAPISetup = X,
        tabledata SWAPISetup = RIMD,
        table "SW Film" = X,
        tabledata "SW Film" = RIMD,
        table "SW Character" = X,
        tabledata "SW Character" = RIMD,
        table "SW Planet" = X,
        tabledata "SW Planet" = RIMD,
        table "SW Resource Association" = X,
        tabledata "SW Resource Association" = RIMD,
        table "SW Species" = X,
        tabledata "SW Species" = RIMD,
        table "SW Starship" = X,
        tabledata "SW Starship" = RIMD,
        table "SW Vehicle" = X,
        tabledata "SW Vehicle" = RIMD,
        codeunit "SWAPI Data Import Mng" = X,
        codeunit "SWAPI Setup Mng" = X,
        codeunit "SW Data Statistics Mng" = X,
        codeunit "SW Json Mng" = X,
        codeunit "SW Page Mng" = X,
        codeunit "SW Resource Type Helper" = X,
        codeunit "SW Status Notification Mng" = X,
        codeunit "SW Utility Mng" = X,
        page FilmDistributionChart = X,
        page JediArchiveRoleCenter = X,
        page ResourceEntriesChart = X,
        page SWAPISetup = X,
        page "SW Film Card" = X,
        page "SW Film List" = X,
        page SWHeadlineRCJedi = X,
        page "SW Character Card" = X,
        page "SW Character List" = X,
        page "SW Planet Card" = X,
        page "SW Planet List" = X,
        page SWResourceAssListPart = X,
        page "SW Resource Association List" = X,
        page SWResourceEntriesPart = X,
        page "SW Resource StandardDialog" = X,
        page "SW Species Card" = X,
        page "SW Species List" = X,
        page "SW Starship Card" = X,
        page "SW Starship List" = X,
        page "SW Vehicle Card" = X,
        page "SW Vehicle List" = X;
}