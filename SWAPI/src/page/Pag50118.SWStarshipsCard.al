namespace SWAPI.SWAPI;

page 50118 "SW Starships Card"
{
    ApplicationArea = All;
    Caption = 'SW Starships Card';
    PageType = Card;
    SourceTable = "SW Starships";

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
                field(Model; Rec.Model)
                {
                }
                field(StarshipClass; Rec.StarshipClass)
                {
                }
            }
            group(Details)
            {
                Caption = 'Details';

                field(Manufacturer; Rec.Manufacturer)
                {
                    Importance = Promoted;
                }
                field(CostInCredits; Rec.CostInCredits)
                {
                }
                field(Length; Rec.Length)
                {
                }
                field(Crew; Rec.Crew)
                {
                }
                field(Passengers; Rec.Passengers)
                {
                }
                field(MaxAtmospheringSpeed; Rec.MaxAtmospheringSpeed)
                {
                }
                field(HyperdriveRating; Rec.HyperdriveRating)
                {
                }
                field(MGLT; Rec.MGLT)
                {
                }
                field(CargoCapacity; Rec.CargoCapacity)
                {
                }
                field(Consumables; Rec.Consumables)
                {
                }
            }
            part(FilmsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Films';
                SubPageLink = ResourceType = const("SW Resource Types"::starships), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::films);
            }
            part(PilotsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Pilots';
                SubPageLink = ResourceType = const("SW Resource Types"::starships), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::people);
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