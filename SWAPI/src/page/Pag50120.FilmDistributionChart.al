namespace SWAPI.SWAPI;

page 50120 FilmDistributionChart
{
    ApplicationArea = All;
    Caption = 'Film Circle Chart';
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
                    l_Data := g_ChartsMng.GetFilmCircleChartParam();
                    CurrPage.Chart.DrawCircleChart(l_Data);
                end;
            }
        }
    }
    var
        g_ChartsMng: Codeunit SWChartsMng;
}