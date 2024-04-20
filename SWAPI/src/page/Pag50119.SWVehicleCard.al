namespace SWAPI.SWAPI;

page 50119 "SW Vehicle Card"
{
    ApplicationArea = All;
    Caption = 'SW Vehicle Card';
    PageType = Card;
    SourceTable = "SW Vehicles";

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

                field(Model; Rec.Model)
                {
                    ToolTip = 'Specifies the value of the Model field.';
                }
                field(VehicleClass; Rec.VehicleClass)
                {
                    ToolTip = 'Specifies the value of the Vehicle class field.';
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ToolTip = 'Specifies the value of the Manufacturer field.';
                }
                field(Lenght; Rec.Lenght)
                {
                    ToolTip = 'Specifies the value of the Lenght field.';
                }
                field(CostInCredits; Rec.CostInCredits)
                {
                    ToolTip = 'Specifies the value of the Cost in credits field.';
                }
                field(Crew; Rec.Crew)
                {
                    ToolTip = 'Specifies the value of the Crew field.';
                }
                field(Passengers; Rec.Passengers)
                {
                    ToolTip = 'Specifies the value of the Passengers field.';
                }
                field(MaxAtmospheringSpeed; Rec.MaxAtmospheringSpeed)
                {
                    ToolTip = 'Specifies the value of the Max atmosphering speed field.';
                }
                field(CargoCapacity; Rec.CargoCapacity)
                {
                    ToolTip = 'Specifies the value of the CargoCapacity field.';
                }
                field(Consumables; Rec.Consumables)
                {
                    ToolTip = 'Specifies the value of the Consumables field.';
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
