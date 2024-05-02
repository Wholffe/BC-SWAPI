namespace SWAPI.SWAPI;
using System.Reflection;
using System.Environment.Configuration;

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
                action(FillSingleResource)
                {
                    ApplicationArea = All;
                    Caption = 'Fill Single Resources';
                    Image = Insert;

                    trigger OnAction()
                    begin
                        g_APISetupMng.FillSingleResource();
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
                    Page.Run(Page::"SW Film List");
                end;
            }
            action(Characters)
            {
                ApplicationArea = All;
                Caption = 'Characters';
                Image = Navigate;

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Character List");
                end;
            }
            action(Planets)
            {
                ApplicationArea = All;
                Caption = 'Planets';
                Image = Navigate;

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Planet List");
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
                    Page.Run(Page::"SW Starship List");
                end;
            }
            action(Vehicles)
            {
                ApplicationArea = All;
                Caption = 'Vehicles';
                Image = Navigate;

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Vehicle List");
                end;
            }
            action(JEDIPROFILE)
            {
                ApplicationArea = All;
                Caption = 'JEDI PROFILE';
                Image = Navigate;

                trigger OnAction()
                var
                    l_AllProfile: Record "All Profile";
                    l_ProfileID: Code[30];
                    l_AppID: Guid;
                    l_Scope: Option;
                begin
                    l_Scope := l_AllProfile.Scope::Tenant;
                    l_AppID := '19634c52-6192-4152-b77f-d46543ad13c3';
                    l_ProfileID := 'JEDIPROFILE';

                    l_AllProfile.Get(l_Scope, l_AppID, l_ProfileID);
                    Page.Run(Page::"Profile Card", l_AllProfile);
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
