namespace SWAPI.SWAPI;

page 50106 "SW Species List"
{
    ApplicationArea = All;
    Caption = 'SW Species List';
    PageType = List;
    SourceTable = "SW Species";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Classification; Rec.Classification)
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field(AverageHeight; Rec.AverageHeight)
                {
                }
                field(AverageLifeSpan; Rec.AverageLifeSpan)
                {
                }
                field(EyeColor; Rec.EyeColor)
                {
                }
                field(HairColors; Rec.HairColors)
                {
                }
                field(SkinColors; Rec.SkinColors)
                {
                }
                field(Language; Rec.Language)
                {
                }
                field(Homeworld; Rec.Homeworld)
                {
                    trigger OnDrillDown()
                    var
                        l_Planets: Record "SW Planets";
                    begin
                        l_Planets.SetRange(Name, Rec.Homeworld);
                        if l_Planets.FindSet() then
                            Page.Run(Page::"SW Planets List", l_Planets);
                    end;
                }
                field(People; Rec.People)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::species, Rec.ID, Enum::"SW Resource Types"::people);
                    end;
                }
                field(Films; Rec.Films)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::species, Rec.ID, Enum::"SW Resource Types"::films);
                    end;
                }
                field(Url; Rec.Url)
                {
                }
                field(Created; Rec.Created)
                {
                }
                field(Edited; Rec.Edited)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(FillSWSpecies)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Species';

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    l_SWAPIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::species);
                end;
            }
        }
    }
    var
        g_APIMng: Codeunit "SWAPI Mng";
}
