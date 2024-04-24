controladdin GoogleCharts
{
    HorizontalStretch = true;
    Scripts = 'src\charts\scripts.js', 'https://www.gstatic.com/charts/loader.js';
    StartupScript = 'src\charts\startup.js';
    VerticalStretch = true;

    event ControlReady();
    procedure DrawBarChart(p_Data: JsonArray);
    procedure DrawCircleChart(p_Data: JsonArray);
}