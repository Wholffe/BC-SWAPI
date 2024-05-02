namespace SWAPI.SWAPI;

page 50115 "SW Character Card"
{
    ApplicationArea = All;
    Caption = 'SW Character Card';
    PageType = Card;
    SourceTable = "SW Character";
    UsageCategory = Lists;

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
                field(BirthYear; Rec.BirthYear)
                {
                }
                field(Gender; Rec.Gender)
                {
                }
            }
            group(Details)
            {
                Caption = 'Details';

                field(EyeColor; Rec.EyeColor)
                {
                }
                field(HairColor; Rec.HairColor)
                {
                }
                field(Height; Rec.Height)
                {
                }
                field(Mass; Rec.Mass)
                {
                }
                field(SkinColor; Rec.SkinColor)
                {
                }
                field(HomeworldID; Rec.HomeworldID)
                {
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
            }
            part(FilmsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Films';
                SubPageLink = ResourceType = const("SW Resource Types"::people), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::films);
            }
            part(StarshipsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Starships';
                SubPageLink = ResourceType = const("SW Resource Types"::people), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::starships);
            }
            part(VehiclesResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Vehicles';
                SubPageLink = ResourceType = const("SW Resource Types"::people), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::vehicles);
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