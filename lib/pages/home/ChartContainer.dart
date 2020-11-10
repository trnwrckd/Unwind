import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:therapy_zone/models/tag.dart';
import 'package:therapy_zone/models/user.dart';

class ChartContainer extends StatefulWidget {
  @override
  _ChartContainerState createState() => _ChartContainerState();
}

class _ChartContainerState extends State<ChartContainer> {
  int _tag1 = 0;

  int _tag2 = 0;

  int _tag3 = 0;

  int _tag4 = 0;

  int _tag5 = 0;

  int _tag6 = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final tags = Provider.of<List<Tag>>(context) ?? [];

    tags.forEach((tag) {
      if (tag.uid == user.uid) {
        _tag1 = tag.tag1;
        _tag2 = tag.tag2;
        _tag3 = tag.tag3;
        _tag4 = tag.tag4;
        _tag5 = tag.tag5;
        _tag6 = tag.tag6;
      }
    });
    return Container(
      color: Colors.lightBlueAccent.withOpacity(0.4),
      child: PieChart(
        dataMap: {
          "\u{1F616}": _tag1.toDouble(),
          "\u{1F62A}": _tag2.toDouble(),
          "\u{1F641}": _tag3.toDouble(),
          "\u{1F610}": _tag4.toDouble(),
          "\u{1F600}": _tag5.toDouble(),
          "\u{1F604}": _tag6.toDouble()
        },
        chartRadius: 400,
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: false,
          showChartValuesInPercentage: true,
        ),
        legendOptions: LegendOptions(
            legendPosition: LegendPosition.top,
            legendTextStyle: TextStyle(fontSize: 20)),
      ),
    );
  }
}
