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
                field(StarshipClass; Rec.StarshipClass)
                {
                    ToolTip = 'Specifies the value of the Starship Class field.';
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ToolTip = 'Specifies the value of the Manufacturer field.';
                }
                field(CostInCredits; Rec.CostInCredits)
                {
                    ToolTip = 'Specifies the value of the Cost in credits field.';
                }
                field(Length; Rec.Length)
                {
                    ToolTip = 'Specifies the value of the Length field.';
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
                field(HyperdriveRating; Rec.HyperdriveRating)
                {
                    ToolTip = 'Specifies the value of the Hyperdrive rating  field.';
                }
                field(MGLT; Rec.MGLT)
                {
                    ToolTip = 'Specifies the value of the MGLT field.';
                }
                field(CargoCapacity; Rec.CargoCapacity)
                {
                    ToolTip = 'Specifies the value of the Cargo capacity field.';
                }
                field(Consumables; Rec.Consumables)
                {
                    ToolTip = 'Specifies the value of the Consumables field.';
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