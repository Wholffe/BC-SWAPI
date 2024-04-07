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
                field("BirthYear "; Rec."BirthYear ")
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
                field("HairColor "; Rec."HairColor ")
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
                field("SkinColor "; Rec."SkinColor ")
                {
                    ToolTip = 'Specifies the value of the Skin color  field.';
                }
                field("Homeworld "; Rec."Homeworld ")
                {
                    ToolTip = 'Specifies the value of the Homeworld field.';
                }
                field(Films; Rec.Films)
                {
                    ToolTip = 'Specifies the value of the Films field.';
                }
                field(Species; Rec.Species)
                {
                    ToolTip = 'Specifies the value of the Species field.';
                }
                field(Starships; Rec.Starships)
                {
                    ToolTip = 'Specifies the value of the Starships field.';
                }
                field(Vehicles; Rec.Vehicles)
                {
                    ToolTip = 'Specifies the value of the Vehicles field.';
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
}