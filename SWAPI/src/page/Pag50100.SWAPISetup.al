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
                    Caption = 'Endpoint';
                    ToolTip = 'Specifies the value of the endpoint URL field.';
                }
            }
        }
        area(FactBoxes)
        {
            part(SWRessourceFactbox; SWRessourceFactbox)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PingConnection)
            {
                ApplicationArea = All;
                Image = Web;
                Promoted = true;

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    l_SWAPIMng.PingAPIConnection();
                end;
            }

            action(ShowNumberOfRequestEntries)
            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                    l_RessourceDialog: Page "SW Ressource StandardDialog";
                    l_Count: Integer;
                    l_Url: Text;
                begin
                    l_RessourceDialog.Setup(Enum::"SW Ressouce Types"::films);
                    if l_RessourceDialog.RunModal() = Action::OK then begin
                        l_Url := l_SWAPIMng.GetUrlFromEnum(l_RessourceDialog.GetRessourceType());
                        l_Count := l_SWAPIMng.GetCategoryCount(l_Url);
                        Message('Url: %1, Count: %2', l_Url, l_Count);
                    end;
                end;
            }
        }
        area(Navigation)
        {
            action(Films)
            {
                ApplicationArea = All;
                Caption = 'Films';

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Films List");
                end;
            }
            action(People)
            {
                ApplicationArea = All;
                Caption = 'People';

                trigger OnAction()
                begin
                    Page.Run(Page::"SW People List");
                end;
            }
            action(Planets)
            {
                ApplicationArea = All;
                Caption = 'Planets';

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Planets List");
                end;
            }
            action(Species)
            {
                ApplicationArea = All;
                Caption = 'Species';

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Species List");
                end;
            }
            action(Starships)
            {
                ApplicationArea = All;
                Caption = 'Starships';

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Starships List");
                end;
            }
            action(Vehicles)
            {
                ApplicationArea = All;
                Caption = 'Vehicles';

                trigger OnAction()
                begin
                    Page.Run(Page::"SW Vehicles List");
                end;
            }
        }
    }

    var
        g_RessourceTypeDialog: Label 'Select a ressource type';

    trigger OnInit()
    begin
        if Rec.IsEmpty then
            Rec.Insert();
    end;
}
