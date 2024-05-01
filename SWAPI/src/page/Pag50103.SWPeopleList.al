namespace SWAPI.SWAPI;

page 50103 "SW People List"
{
    ApplicationArea = All;
    Caption = 'SW People List';
    CardPageId = 50115;
    Editable = false;
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
                field("HomeworldID"; Rec.HomeworldID)
                {
                    Visible = false;
                }
                field(HomeworldName; Rec.HomeworldName)
                {
                    trigger OnDrillDown()
                    var
                        l_Planets: Record "SW Planets";
                    begin
                        if l_Planets.Get(Rec.HomeworldID) then begin
                            l_Planets.SetRecFilter();
                            Page.Run(Page::"SW Planets List", l_Planets);
                        end;
                    end;
                }
                field(Films; Rec.Films)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::people, Rec.ID, "SW Resource Types"::films);
                    end;
                }
                field(Species; Rec.Species)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::people, Rec.ID, "SW Resource Types"::species);
                    end;
                }
                field(Starships; Rec.Starships)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::people, Rec.ID, "SW Resource Types"::starships);
                    end;
                }
                field(Vehicles; Rec.Vehicles)
                {
                    DrillDownPageId = "SW Resource Association List";
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::people, Rec.ID, "SW Resource Types"::vehicles);
                    end;
                }
                field(Url; Rec.Url)
                {
                    Visible = false;
                }
                field(Created; Rec.Created)
                {
                    Visible = false;
                }
                field(Edited; Rec.Edited)
                {
                    Visible = false;
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
                    l_DataImporter: Codeunit "SWAPI Data Import Mng";
                    l_SWUtilityMng: Codeunit "SW Utility Mng";
                begin
                    l_DataImporter.FillAllResourcesOfAKind("SW Resource Types"::people);
                    l_SWUtilityMng.ValidateAllResourcesAss();
                end;
            }
        }
    }
    var
        g_PageMng: Codeunit "SW Page Mng";
}
