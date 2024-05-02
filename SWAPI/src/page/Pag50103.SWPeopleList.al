namespace SWAPI.SWAPI;

page 50103 "SW Character List"
{
    ApplicationArea = All;
    Caption = 'SW Character List';
    CardPageId = 50115;
    Editable = false;
    PageType = List;
    SourceTable = "SW Character";
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
                        l_Planet: Record "SW Planet";
                    begin
                        if l_Planet.Get(Rec.HomeworldID) then begin
                            l_Planet.SetRecFilter();
                            Page.Run(Page::"SW Planet List", l_Planet);
                        end;
                    end;
                }
                field(SpeciesID; Rec.SpeciesID)
                {
                    Visible = false;
                }
                field(SpeciesName; Rec.SpeciesName)
                {
                    trigger OnDrillDown()
                    var
                        l_Species: Record "SW Species";
                    begin
                        if l_Species.Get(Rec.SpeciesID) then begin
                            l_Species.SetRecFilter();
                            Page.Run(Page::"SW Species List", l_Species);
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
