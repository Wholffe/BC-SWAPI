namespace SWAPI.SWAPI;

page 50111 SWHeadlineRCJedi
{
    ApplicationArea = All;
    Caption = 'Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field(GreetingText; l_GreetingTxt)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(JocastaTxt; l_JocastaTxt)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    var
        l_GreetingTxt: Label 'Welcome to the Jedi Temple Archives';
        l_JocastaTxt: Label 'If an item does not appear in our records, then it does not exist!';
}