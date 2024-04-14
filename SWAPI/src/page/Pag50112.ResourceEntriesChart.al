namespace SWAPI.SWAPI;

page 50112 ResourceEntriesChart
{
    ApplicationArea = All;
    Caption = 'ResourceEntriesChart';
    PageType = CardPart;

    layout
    {
        area(content)
        {
            usercontrol(Chart; GoogleCharts)
            {
                ApplicationArea = All;

                trigger ControlReady()
                var
                    l_Data: JsonArray;
                begin
                    l_Data := g_ChartsMng.GetResourceEntriesChartParam();
                    CurrPage.Chart.DrawBarChart(l_Data);
                end;
            }
        }
    }
    var
        g_ChartsMng: Codeunit SWChartsMng;
}
