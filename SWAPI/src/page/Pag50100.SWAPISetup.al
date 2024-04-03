namespace SWAPI.SWAPI;

page 50100 SWAPISetup
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'SW API Setup';
    PageType = Card;
    SourceTable = SWAPISetup;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Setup';

                field(endpoint; Rec.Endpoint)
                {
                    Caption = 'endpoint';
                    ToolTip = 'Specifies the value of the endpoint URL field.';
                }
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

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    l_SWAPIMng.PingAPIConnection();
                end;
            }
        }
    }


    trigger OnInit()
    begin
        if Rec.IsEmpty then
            Rec.Insert();
    end;
}