namespace SWAPI.SWAPI;

page 50105 "SW Vehicles List"
{
    ApplicationArea = All;
    Caption = 'SW Vehicles List';
    PageType = List;
    SourceTable = "SW Vehicles";
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
                field(Film; Rec.Film)
                {
                    DrillDownPageId = "SW Resource Assosiation List";
                    ToolTip = 'Specifies the value of the Film field.';
                }
                field(Pilots; Rec.Pilots)
                {
                    DrillDownPageId = "SW Resource Assosiation List";
                    ToolTip = 'Specifies the value of the Pilots field.';
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
            action(FillSWVehicles)
            {
                ApplicationArea = All;
                Caption = 'Fill SW Vehicles';

                trigger OnAction()
                var
                    l_SWAPIMng: Codeunit "SWAPI Mng";
                begin
                    if l_SWAPIMng.FillAllResourcesOfAKind(Enum::"SW Resource Types"::vehicles) then
                        l_SWAPIMng.SendStatusNotification();
                end;
            }
        }
    }
}