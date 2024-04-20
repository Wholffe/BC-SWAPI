namespace SWAPI.SWAPI;

page 50117 "SW Species Card"
{
    ApplicationArea = All;
    Caption = 'SW Species Card';
    PageType = Card;
    SourceTable = "SW Species";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
            group(Details)
            {
                Caption = 'Details';

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
            }
            part(PeopleResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'People';
                SubPageLink = ResourceType = const("SW Resource Types"::species), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::people);
            }
            part(FilmsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Films';
                SubPageLink = ResourceType = const("SW Resource Types"::species), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::films);
            }
            group(Meta)
            {
                Caption = 'Meta';

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