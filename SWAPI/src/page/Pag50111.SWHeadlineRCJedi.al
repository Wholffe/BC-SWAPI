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
                field(GreetingText; g_GreetingTxt)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(JocastaText; g_JocastaTxt)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(PlanetCounterText; GetRandomPlanetText)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    var
        g_GreetingTxt: Label 'Welcome to the Jedi Temple Archives.';
        g_JocastaTxt: Label 'If an item does not appear in our records, then it does not exist!';
        g_PlanetEntriesNotFoundText: Label 'There are currently no entries about planet population.';
        g_PlanetKnownCounterText: Label 'There are currently %1 people on %2.';
        g_PlanetUnknownCounterText: Label 'The population number of %1 is currently unknown.';

    local procedure GetRandomPlanetText(): Text
    var
        l_Planets: Record "SW Planets";
        l_ID: Integer;
        l_Text: Text;
    begin
        l_ID := 0;
        if l_Planets.Count = 0 then
            exit(g_PlanetEntriesNotFoundText);
        while not (l_Planets.Get(l_ID)) do
            l_ID := Random(l_Planets.Count);

        if l_Planets.Population = 0 then
            l_Text := StrSubstNo(g_PlanetUnknownCounterText, l_Planets.Name)
        else
            l_Text := StrSubstNo(g_PlanetKnownCounterText, l_Planets.Population, l_Planets.Name);
        exit(l_Text)
    end;
}