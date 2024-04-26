namespace SWAPI.SWAPI;

page 50112 ResourceEntriesChart
{
    ApplicationArea = All;
    Caption = 'ResourceEntriesChart';
    PageType = CardPart;
    RefreshOnActivate = true;

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
                    l_Data := g_DataStatisticsMng.GetResourceEntriesChartParam();
                    CurrPage.Chart.DrawBarChart(l_Data);
                end;
            }
        }
    }
    var
        g_DataStatisticsMng: Codeunit "SW Data Statistics Mng";
}
