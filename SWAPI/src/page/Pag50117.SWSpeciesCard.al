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
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    Importance = Promoted;
                }
                field(Classification; Rec.Classification)
                {
                }
            }
            group(Details)
            {
                Caption = 'Details';

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
                    Importance = Promoted;
                }
                field(HomeworldID; Rec.HomeworldID)
                {
                }
                field(HomeworldName; Rec.HomeworldName)
                {
                    Importance = Promoted;
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
            }
            part(CharactersResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Characters';
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
                }
                field(Created; Rec.Created)
                {
                    Importance = Additional;
                }
                field(Edited; Rec.Edited)
                {
                    Importance = Additional;
                }
            }
        }
    }
}