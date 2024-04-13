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
                RunObject = page SWAPISetup;
                Caption = 'API Setup';
            }
            action(RessourceAssosiation)
            {
                ApplicationArea = All;
                RunObject = page "SW Ressource Assosiation List";
                Caption = 'Ressource Assosiation';
            }
        }
    }
    var

}

profile JediProfile
{
    ProfileDescription = 'Unlock all knowledge of the Jedi Archives.';
    RoleCenter = JediArchiveRoleCenter;
    Caption = 'Jedi';
}