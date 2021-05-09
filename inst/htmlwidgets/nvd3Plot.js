HTMLWidgets.widget({

  name: 'nvd3Plot',

  type: 'output',

  factory: function(el) {

    return {

      renderValue: function(x) {

        if(x.type === "barplot"){

          nv.addGraph(function() {
            var chart = nv.models.discreteBarChart()
            .x(function(d) { return d.label })
            .y(function(d) { return d.value })
            .staggerLabels(true)
            .showValues(true);


        // XAXIS
        chart.xAxis
             .axisLabel(x.xlab)
             .axisLabelDistance(-5);

        // YAXIS
        chart.yAxis
             .axisLabel(x.ylab)
             .axisLabelDistance(-5);



        d3.select(el).append('svg').datum([x.data]).call(chart);
        nv.utils.windowResize(chart.update);

        return chart;

    });
        }
        else if(x.type === "boxplot"){

          nv.addGraph(function() {
            var chart = nv.models.boxPlotChart()
            .x(function(d) { return d.label })
            .staggerLabels(true)
            .maxBoxWidth(75);


        // XAXIS
        chart.xAxis
             .axisLabel(x.xlab)
             .axisLabelDistance(-5);

        // YAXIS
        chart.yAxis
             .axisLabel(x.ylab)
             .axisLabelDistance(-5);


      d3.select(el).append('svg').datum(x.data).call(chart);
      nv.utils.windowResize(chart.update);

      return chart;

    });

        }
        else if(x.type === "piechart" || x.type === "donutchart"){

          nv.addGraph(function() {
            var chart = nv.models.pieChart()
            .x(function(d) { return d.key })
            .y(function(d) { return d.y })
            .donut(x.donut)
            .showTooltipPercent(true);


          d3.select(el).append('svg').datum(x.data).call(chart);
          nv.utils.windowResize(chart.update);
          return chart;
    });
        }
        else if(x.type === "multibarplotH"){

          nv.addGraph(function() {
            var chart = nv.models.multiBarHorizontalChart()
             .x(function(d) { return d.label })
             .y(function(d) { return d.value })
             .showValues(true);

          chart.yAxis
              .axisLabel(x.ylab);

          chart.xAxis
              .axisLabel(x.xlab);

        d3.select(el).append('svg').datum(x.data).call(chart);
        nv.utils.windowResize(chart.update);

        return chart;

          });

        }
        else if(x.type === "multibarplot"){

        nv.addGraph(function() {
          var chart = nv.models.multiBarChart()
             .groupSpacing(0.1);


        // XAXIS
        chart.xAxis
             .axisLabel(x.xlab)
             .axisLabelDistance(-5);


        // YAXIS
        chart.yAxis
             .axisLabel(x.ylab)
             .axisLabelDistance(-5);


        d3.select(el).append('svg').datum(x.data).call(chart);
        nv.utils.windowResize(chart.update);

        return chart;

          });
        }
        else if(x.type === "scatterplot"){

          nv.addGraph(function() {
            var chart = nv.models.scatterChart()
                .showDistX(true)
                .showDistY(true)
                .useVoronoi(true);

          // XAXIS
          chart.xAxis
               .axisLabel(x.xlab)
               .axisLabelDistance(-5);

          // YAXIS
          chart.yAxis
               .axisLabel(x.ylab)
               .axisLabelDistance(-5);


        d3.select(el).append('svg').datum(x.data).call(chart);
        nv.utils.windowResize(chart.update);

        return chart;

          });

        }
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
