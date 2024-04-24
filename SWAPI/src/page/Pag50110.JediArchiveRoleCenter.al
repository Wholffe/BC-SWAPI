namespace SWAPI.SWAPI;

page 50110 JediArchiveRoleCenter
{
    ApplicationArea = All;
    Caption = 'Jedi Archive Role Center';
    PageType = RoleCenter;
    RefreshOnActivate = true;

    layout
    {
        area(RoleCenter)
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
            group(Chart)
            {
                Caption = 'Statistic';
                part(Part3; ResourceEntriesChart)
                {
                    ApplicationArea = All;
                    Caption = 'Distribution of resources';
                }
                part(Part4; FilmDistributionChart)
                {
                    ApplicationArea = All;
                    Caption = 'Distribution of resources by movie';
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
            action(ResourceAssociation)
            {
                ApplicationArea = All;
                Caption = 'Resource Association';
                RunObject = page "SW Resource Association List";
            }
        }
        area(Processing)
        {
            action(ManageArchive)
            {
                ApplicationArea = All;
                Caption = 'Manage Archive';
                RunObject = page SWAPISetup;
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