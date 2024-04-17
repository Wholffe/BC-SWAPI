namespace SWAPI.SWAPI;

page 50108 "SW Resource Assosiation List"
{
    ApplicationArea = All;
    Caption = 'SW Resource Assosiation List';
    PageType = List;
    SourceTable = "SW Resource Assosiation";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ResourceType; Rec.ResourceType)
                {
                    ToolTip = 'Specifies the value of the ResourceType field.';
                }
                field(ResourceID; Rec.ResourceID)
                {
                    ToolTip = 'Specifies the value of the ResourceID field.';
                }
                field(AssociatedResourceType; Rec.AssociatedResourceType)
                {
                    ToolTip = 'Specifies the value of the AssociatedResourceType field.';
                }
                field(AssociatedResourceValue; Rec.AssociatedResourceValue)
                {
                    ToolTip = 'Specifies the value of the AssociatedResourceValue field.';
                }
                field(AssRessourceID; Rec.AssRessourceID)
                {
                    ToolTip = 'Specifies the value of the Associated Ressource ID field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ValidateAllResources)
            {
                ApplicationArea = All;
                Caption = 'Validate All Resources';

                trigger OnAction()
                var
                    l_ResourceAss: Record "SW Resource Assosiation";
                    l_Dialog: Dialog;
                    l_Counter: Integer;
                    l_DialogL: Label 'Validating resources, please wait... \Validate #2## \Total #3##';
                begin
                    l_ResourceAss.Reset();
                    l_Dialog.Open(l_DialogL);
                    l_Dialog.Update(3, l_ResourceAss.Count);
                    l_Counter := 1;
                    if l_ResourceAss.FindSet() then
                        repeat
                            l_Dialog.Update(2, l_Counter);
                            l_ResourceAss.Validate(AssociatedResourceValue);
                            l_ResourceAss.Modify();
                            l_Counter := l_Counter + 1;
                        until l_ResourceAss.Next() = 0;
                    l_Dialog.Close();
                end;
            }
        }
    }
}
