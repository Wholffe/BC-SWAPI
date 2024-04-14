controladdin GoogleCharts
{
    StartupScript = 'src\charts\startup.js';
    Scripts = 'src\charts\scripts.js', 'https://www.gstatic.com/charts/loader.js';
    HorizontalStretch = true;
    VerticalStretch = true;

    event ControlReady();
    procedure DrawBarChart(p_Data: JsonArray);
}