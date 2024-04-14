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
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Classification; Rec.Classification)
                {
                    ToolTip = 'Specifies the value of the Classification field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(AverageHeight; Rec.AverageHeight)
                {
                    ToolTip = 'Specifies the value of the Average height field.';
                }
                field(AverageLifeSpan; Rec.AverageLifeSpan)
                {
                    ToolTip = 'Specifies the value of the Average life span field.';
                }
                field(EyeColor; Rec.EyeColor)
                {
                    ToolTip = 'Specifies the value of the Eye color field.';
                }
                field(HairColors; Rec.HairColors)
                {
                    ToolTip = 'Specifies the value of the Hair colors field.';
                }
                field(SkinColors; Rec.SkinColors)
                {
                    ToolTip = 'Specifies the value of the Skin colors field.';
                }
                field(Language; Rec.Language)
                {
                    ToolTip = 'Specifies the value of the Language field.';
                }
                field(Homeworld; Rec.Homeworld)
                {
                    ToolTip = 'Specifies the value of the Homeworld field.';
                }
                field(People; Rec.People)
                {
                    DrillDownPageId = "SW Resource Assosiation List";
                    ToolTip = 'Specifies the value of the People field.';
                }
                field(Films; Rec.Films)
                {
                    DrillDownPageId = "SW Resource Assosiation List";
                    ToolTip = 'Specifies the value of the Films field.';
                }
                field(Url; Rec.Url)
                {
                    ToolTip = 'Specifies the value of the Url field.';
                }
                field(Created; Rec.Created)
                {
                    ToolTip = 'Specifies the value of the Created field.';
                }
                field(Edited; Rec.Edited)
                {
                    ToolTip = 'Specifies the value of the Edited field.';
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
                    l_SWAPISetup: Record SWAPISetup;
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    if l_SWAPIMng.FillSWSpecies() then
                        Message(g_ImportSuccess);
                end;
            }
        }
    }
    var
        g_ImportSuccess: Label 'Data Imported Successfully';
}
