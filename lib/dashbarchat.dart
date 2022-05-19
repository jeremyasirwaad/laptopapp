import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CusDrawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class dashbarchat extends StatelessWidget {
  const dashbarchat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    print(DateTime.daysPerWeek);
    String dateFormat7 = DateFormat('EEEE').format(date);
    return BarChart(BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
                axisNameWidget: Text("Git Commits")),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  reservedSize: 20,
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta hello) {
                    switch (value.toInt()) {
                      case 1:
                        return Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(DateFormat('EEEE').format(
                                (date.subtract(Duration(days: 6))))[0]));
                      case 2:
                        return Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(DateFormat('EEEE').format(
                                (date.subtract(Duration(days: 5))))[0]));
                      case 3:
                        return Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(DateFormat('EEEE').format(
                                (date.subtract(Duration(days: 4))))[0]));

                      case 4:
                        return Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(DateFormat('EEEE').format(
                                (date.subtract(Duration(days: 3))))[0]));

                      case 5:
                        return Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(DateFormat('EEEE').format(
                                (date.subtract(Duration(days: 2))))[0]));

                      case 6:
                        return Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(DateFormat('EEEE').format(
                                (date.subtract(Duration(days: 1))))[0]));

                      case 7:
                        return Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(dateFormat7[0]));

                      default:
                        return Padding(
                            padding: EdgeInsets.only(top: 4), child: Text(""));
                    }
                  }),
            )),
        barGroups: [
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(toY: 7, width: 10, color: Colors.white),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(toY: 10, width: 10, color: Colors.white),
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(toY: 2, width: 10, color: Colors.white),
          ]),
          BarChartGroupData(x: 4, barRods: [
            BarChartRodData(toY: 5, width: 10, color: Colors.white),
          ]),
          BarChartGroupData(x: 5, barRods: [
            BarChartRodData(toY: 9, width: 10, color: Colors.white),
          ]),
          BarChartGroupData(x: 6, barRods: [
            BarChartRodData(toY: 3, width: 10, color: Colors.white),
          ]),
          BarChartGroupData(x: 7, barRods: [
            BarChartRodData(toY: 8, width: 10, color: Colors.white),
          ]),
        ]));
  }
}
