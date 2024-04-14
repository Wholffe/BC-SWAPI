namespace SWAPI.SWAPI;

page 50110 JediArchiveRoleCenter
{
    ApplicationArea = All;
    Caption = 'Jedi Archive Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            group(Group1)
            {
                part(Part1; SWHeadlineRCJedi)
                {
                    ApplicationArea = All;
                }
                part(Part2; SWResourceEntriesPart)
                {
                    ApplicationArea = All;
                    Caption = 'Resources';
                }
                part(Part3; ResourceEntriesChart)
                {
                    ApplicationArea = All;
                    Caption = 'Resource entry graph';
                }
            }
        }
    }
    actions
    {
        area(Embedding)
        {
            action(SWAPISetup)
            {
                ApplicationArea = All;
                Caption = 'API Setup';
                RunObject = page SWAPISetup;
            }
            action(ResourceAssosiation)
            {
                ApplicationArea = All;
                Caption = 'Resource Assosiation';
                RunObject = page "SW Resource Assosiation List";
            }
        }
    }
}

profile JediProfile
{
    Caption = 'Jedi';
    ProfileDescription = 'Unlock all knowledge of the Jedi Archives.';
    RoleCenter = JediArchiveRoleCenter;
}