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
                part(Part2; SWRessourceEntriesPart)
                {
                    ApplicationArea = All;
                    Caption = 'Ressources';
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
            action(RessourceAssosiation)
            {
                ApplicationArea = All;
                Caption = 'Ressource Assosiation';
                RunObject = page "SW Ressource Assosiation List";
            }
        }
    }
    var

}

profile JediProfile
{
    Caption = 'Jedi';
    ProfileDescription = 'Unlock all knowledge of the Jedi Archives.';
    RoleCenter = JediArchiveRoleCenter;
}