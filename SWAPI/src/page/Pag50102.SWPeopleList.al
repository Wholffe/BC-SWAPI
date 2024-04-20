namespace SWAPI.SWAPI;

page 50102 "SW People List"
{
    ApplicationArea = All;
    Caption = 'SW People List';
    PageType = List;
    SourceTable = "SW People";
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
                field("BirthYear "; Rec.BirthYear)
                {
                }
                field(EyeColor; Rec.EyeColor)
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("HairColor "; Rec.HairColor)
                {
                }
                field(Height; Rec.Height)
                {
                }
                field(Mass; Rec.Mass)
                {
                }
                field("SkinColor "; Rec.SkinColor)
                {
                }
                field("Homeworld "; Rec.Homeworld)
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
                field(Films; Rec.Films)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::people, Rec.ID, Enum::"SW Resource Types"::films);
                    end;
                }
                field(Species; Rec.Species)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::people, Rec.ID, Enum::"SW Resource Types"::species);
                    end;
                }
                field(Starships; Rec.Starships)
                {
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::people, Rec.ID, Enum::"SW Resource Types"::starships);
                    end;
                }
                field(Vehicles; Rec.Vehicles)
                {
                    DrillDownPageId = "SW Resource Association List";
                    trigger OnDrillDown()
                    begin
                        g_APIMng.DrilldownPage(Enum::"SW Resource Types"::people, Rec.ID, Enum::"SW Resource Types"::vehicles);
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
            action(FillSWPeople)
            {
                ApplicationArea = All;
                Caption = 'Fill SW People';

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    l_SWAPIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::people);
                end;
            }
        }
    }
    var
        g_APIMng: Codeunit "SWAPI Mng";
}
