namespace SWAPI.SWAPI;

page 50100 SWAPISetup
{
    ApplicationArea = All;
    Caption = 'SW API Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = SWAPISetup;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Setup';

                field(endpoint; Rec.Endpoint)
                {
                }
            }
        }
        area(FactBoxes)
        {
            part(SWResourceFactbox; SWResourceEntriesPart)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(RefFillAllResources; FillAllResources)
            {
            }
        }
        area(Processing)
        {
            group(Check)
            {
                Caption = 'Check';
                action(PingConnection)
                {
                    ApplicationArea = All;
                    Caption = 'Ping Connection';
                    Image = Web;

                    trigger OnAction()
                    begin
                        g_APISetupMng.PingAPIConnection();
                    end;
                }
                action(ShowNumberOfRequestEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Show Number Of Request Entries';
                    Image = ShowList;

                    trigger OnAction()
                    begin
                        g_APISetupMng.ShowNumberOfRequestEntries();
                    end;
                }
            }
            group(GetData)
            {
                Caption = 'Get Data';
                action(FillAllResources)
                {
                    ApplicationArea = All;
                    Caption = 'Fill All Resources';
                    Image = Insert;

                    trigger OnAction()
                    begin
                        g_APISetupMng.FillAllResources();
                    end;
                }
            }
            group(Delete)
            {
                Caption = 'Delete';
                action(ClearAllSWData)
                {
                    ApplicationArea = All;
                    Caption = 'Clear All SW Data';
                    Image = Delete;

                    trigger OnAction()
                    var
                        l_ConfirmMsg: Label 'Delete all SW Data?';
                    begin
                        if Confirm(l_ConfirmMsg) then
                            g_APISetupMng.ClearAllSWData();
                    end;
                }
                action(DeleteSingleResource)
                {
                    ApplicationArea = All;
                    Caption = 'Delete Single Resource';
                    Image = Delete;

                    trigger OnAction()
                    begin
                        g_APISetupMng.DeleteSingleResource();
                    end;
                }
            }
        }
        area(Navigation)
        {
            action(Films)
            {
                ApplicationArea = All;
                Caption = 'Films';
                Image = Navigate;

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Films List");
                end;
            }
            action(People)
            {
                ApplicationArea = All;
                Caption = 'People';
                Image = Navigate;

                trigger OnAction()
                begin
                    Page.Run(Page::"SW People List");
                end;
            }
            action(Planets)
            {
                ApplicationArea = All;
                Caption = 'Planets';
                Image = Navigate;

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Planets List");
                end;
            }
            action(Species)
            {
                ApplicationArea = All;
                Caption = 'Species';
                Image = Navigate;

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Species List");
                end;
            }
            action(Starships)
            {
                ApplicationArea = All;
                Caption = 'Starships';
                Image = Navigate;

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Starships List");
                end;
            }
            action(Vehicles)
            {
                ApplicationArea = All;
                Caption = 'Vehicles';
                Image = Navigate;

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Vehicles List");
                end;
            }
        }
    }

    var
        g_APISetupMng: Codeunit "SWAPI Setup Mng";
        g_ResourceTypeDialog: Label 'Select a Resource type';

    trigger OnInit()
    begin
        if Rec.IsEmpty then
            Rec.Insert();
    end;
}
