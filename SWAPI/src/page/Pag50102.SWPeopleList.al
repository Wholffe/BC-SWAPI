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
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("BirthYear "; Rec.BirthYear)
                {
                    ToolTip = 'Specifies the value of the Birth year  field.';
                }
                field(EyeColor; Rec.EyeColor)
                {
                    ToolTip = 'Specifies the value of the Eye color field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field("HairColor "; Rec.HairColor)
                {
                    ToolTip = 'Specifies the value of the Hair color  field.';
                }
                field(Height; Rec.Height)
                {
                    ToolTip = 'Specifies the value of the Height field.';
                }
                field(Mass; Rec.Mass)
                {
                    ToolTip = 'Specifies the value of the Mass field.';
                }
                field("SkinColor "; Rec.SkinColor)
                {
                    ToolTip = 'Specifies the value of the Skin color  field.';
                }
                field("Homeworld "; Rec.Homeworld)
                {
                    ToolTip = 'Specifies the value of the Homeworld field.';
                }
                field(Films; Rec.Films)
                {
                    ToolTip = 'Specifies the value of the Films field.';
                    DrillDownPageId = "SW Ressource Assosiation List";
                }
                field(Species; Rec.Species)
                {
                    ToolTip = 'Specifies the value of the Species field.';
                    DrillDownPageId = "SW Ressource Assosiation List";
                }
                field(Starships; Rec.Starships)
                {
                    ToolTip = 'Specifies the value of the Starships field.';
                    DrillDownPageId = "SW Ressource Assosiation List";
                }
                field(Vehicles; Rec.Vehicles)
                {
                    ToolTip = 'Specifies the value of the Vehicles field.';
                    DrillDownPageId = "SW Ressource Assosiation List";
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
            action(FillSWPeople)
            {
                ApplicationArea = All;
                Caption = 'Fill SW People';

                trigger OnAction()
                var
                    l_Url: Text;
                    l_SWAPISetup: Record SWAPISetup;
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    l_Url := StrSubstNo('%1/people', l_SWAPISetup.Endpoint);
                    if l_SWAPIMng.FillSWPeople(l_Url) then
                        Message(g_ImportSuccess);
                end;
            }
        }
    }
    var
        g_ImportSuccess: Label 'Data Imported Successfully';
}
