permissionset 50100 "Jedi Knight"
{
    Assignable = true;
    Caption = 'Jedi Knight';
    Permissions = tabledata "SW Films" = RIMD,
        tabledata "SW People" = RIMD,
        tabledata "SW Planets" = RIMD,
        tabledata "SW Resource Assosiation" = RIMD,
        tabledata "SW Species" = RIMD,
        tabledata "SW Starships" = RIMD,
        tabledata "SW Vehicles" = RIMD,
        tabledata SWAPISetup = RIMD,
        table "SW Films" = X,
        table "SW People" = X,
        table "SW Planets" = X,
        table "SW Resource Assosiation" = X,
        table "SW Species" = X,
        table "SW Starships" = X,
        table "SW Vehicles" = X,
        table SWAPISetup = X,
        codeunit "SWAPI Mng" = X,
        codeunit "SWAPI Setup Mng" = X,
        page "SW Films List" = X,
        page "SW People List" = X,
        page "SW Planets List" = X,
        page "SW Resource StandardDialog" = X,
        page "SW Species List" = X,
        page "SW Starships List" = X,
        page "SW Vehicles List" = X,
        page SWAPISetup = X;
}