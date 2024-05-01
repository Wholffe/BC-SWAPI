namespace SWAPI.SWAPI;

page 50105 "SW Species List"
{
    ApplicationArea = All;
    Caption = 'SW Species List';
    CardPageId = 50117;
    Editable = false;
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
                field(HomeworldID; Rec.HomeworldID)
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
                field(People; Rec.People)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::species, Rec.ID, "SW Resource Types"::people);
                    end;
                }
                field(Films; Rec.Films)
                {
                    trigger OnDrillDown()
                    begin
                        g_PageMng.DrillDownPage("SW Resource Types"::species, Rec.ID, "SW Resource Types"::films);
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
            action(FillSWSpecies)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Species';

                trigger OnAction()
                var
                    l_DataImporter: Codeunit "SWAPI Data Import Mng";
                    l_SWUtilityMng: Codeunit "SW Utility Mng";
                begin
                    l_DataImporter.FillAllResourcesOfAKind("SW Resource Types"::species);
                    l_SWUtilityMng.ValidateAllResourcesAss();
                end;
            }
        }
    }
    var
        g_PageMng: Codeunit "SW Page Mng";
}
