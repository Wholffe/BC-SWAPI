namespace SWAPI.SWAPI;

page 50119 "SW Vehicle Card"
{
    ApplicationArea = All;
    Caption = 'SW Vehicle Card';
    PageType = Card;
    SourceTable = "SW Vehicle";

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
                field(VehicleClass; Rec.VehicleClass)
                {
                }
            }
            group(Details)
            {
                Caption = 'Details';

                field(Manufacturer; Rec.Manufacturer)
                {
                }
                field(Lenght; Rec.Lenght)
                {
                }
                field(CostInCredits; Rec.CostInCredits)
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
                SubPageLink = ResourceType = const("SW Resource Types"::vehicles), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::films);
            }
            part(PilotsResourceAssPart; SWResourceAssListPart)
            {
                Caption = 'Pilots';
                SubPageLink = ResourceType = const("SW Resource Types"::vehicles), ResourceID = field(ID), AssociatedResourceType = const("SW Resource Types"::people);
            }
            group(Meta)
            {
                Caption = 'Meta';

                field(Url; Rec.Url)
                {
                }
                field(Created; Rec.Created)
                {
                }
                field(Edited; Rec.Edited)
                {
                }
            }
        }
    }
}
