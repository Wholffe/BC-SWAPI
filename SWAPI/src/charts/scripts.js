function DrawBarChart(json)
{
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawStuff);

    function drawStuff() {
      var data = new google.visualization.arrayToDataTable(json)

      var options = {
        legend: { position: 'none' },
        chart: {
          title: '',
          subtitle: '' },
        axes: {
          x: {
            0: { side: 'top', label: ''} // Top x-axis.
          }
        },
        bar: { groupWidth: "90%" }
      };

      var chart = new google.charts.Bar(document.getElementById('controlAddIn'));
      // Convert the Classic options to Material options.
      chart.draw(data, google.charts.Bar.convertOptions(options));
    };
}