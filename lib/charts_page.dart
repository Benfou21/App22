import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app22/repositeries.dart/repository.dart';
import 'package:app22/utils/constants.dart';
import 'package:app22/utils/functions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app22/utils/lines.dart';
import 'package:app22/utils/styleButton.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<String> titleList = <String>[
  "Migraine",
  "Fatigue",
  "Mal de ventre",
  "Equilibre",
  "Quantité",
  "Eau",
  "Café",
  "Cours",
  "Repos",
  "Révision",
  "Sport",
];

class Charts_page extends StatefulWidget {
  Charts_page({super.key});

  @override
  State<Charts_page> createState() => _Charts_pageState();
}

class _Charts_pageState extends State<Charts_page> {
  List<FlSpot> list = [];
  String dropDownValue = titleList.first;

  @override
  void initState() {
    super.initState();

    //setCustomMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
              color: kOrange_main4,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0, 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                    child: Text(
                      "Historique",
                      style: GoogleFonts.raleway(textStyle: kHeadline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const LineDivider(),
        addVerticalSpace(20),
        Consumer(
          builder: (context, ref, child) {
            String dataName = ref.watch(DataNameProvider);
            return Expanded(
                flex: 3,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          DropdownButton<String>(
                            value: dataName,
                            items: titleList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              print(value);
                              ref
                                  .read(DataNameProvider.notifier)
                                  .change(value!); // change le dataname
                              getData(ref, value); //Bloque tous les processus
                            },
                          ),
                          LineChartSample2(dataName: dataName),
                        ],
                      ),
                    ),
                  ],
                ));
          },
        )
      ]),
    );
  }
}

// final listDate = _firestore
//                   .collection("users")
//                   .doc(user!.uid)
//                   .collection("data")
//                   .doc("{2022-12-11}")
//                   .snapshots()
//                   .forEach((element) {
//                 print(element["Migraine"]);
//                 print(element["Cours"]);
//               });

// final listDate = _firestore
//                   .collection("users")
//                   .doc(user!.uid)
//                   .collection("data")
//                   .snapshots()
//                   .forEach((element) {
//                 element.docs.forEach((e) {
//                   print(e["Migraine"]);
//                   print(e["Cours"]);
//                 });
//               });

class LineChartSample2 extends StatefulWidget {
  LineChartSample2({super.key, required this.dataName});

  String dataName;

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    kOrange_main,
    kOrange_main2,
  ];

  bool showAvg = false;
  bool show_me = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Color(0xff232d37),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              child: Consumer(
                builder: ((context, ref, child) {
                  List<FlSpot> spot = ref.watch(HistoriqueProvider);
                  print(spot);
                  return LineChart(
                    showAvg ? avgData(spot) : mainData(spot),
                  );
                }),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 10:
        text = const Text('j0', style: style);
        break;
      case 9:
        text = const Text('j-1', style: style);
        break;
      case 8:
        text = const Text('j-2', style: style);
        break;
      case 7:
        text = const Text('j-3', style: style);
        break;
      case 6:
        text = const Text('j-4', style: style);
        break;
      case 5:
        text = const Text('j-5', style: style);
        break;
      case 4:
        text = const Text('j-6', style: style);
        break;
      case 3:
        text = const Text('j-7', style: style);
        break;
      case 2:
        text = const Text('j-8', style: style);
        break;
      case 1:
        text = const Text('j-9', style: style);
        break;
      case 0:
        text = const Text('j-10', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'rien';
        break;
      case 1:
        text = 'peu';
        break;
      case 2:
        text = 'fort';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  //TO DO

  LineChartData mainData(List<FlSpot> spot) {
    //List<FlSpot> spot = ref.watch(HistoriqueProvider);
    //print(spot);
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 3,
      lineBarsData: [
        LineChartBarData(
          spots: spot,
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
  //
  //
  //
  //

  LineChartData avgData(List<FlSpot> spot) {
    print(spot);
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          //show: show_me,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

getData(WidgetRef ref, String dataname) async {
  // do stateNotifer
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = _auth.currentUser;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double indice = 10;

  try {
    ref.read(HistoriqueProvider.notifier).cleanList();
    var elements = await _firestore
        .collection("users")
        .doc(user!.uid)
        .collection("data")
        .orderBy("date", descending: false) // Du plus récent au moins récent
        .snapshots()
        .elementAt(
            0); // récupère les valeurs pour chaque catégorie, indice 0 sinon rien

    for (var element in elements.docs.reversed) {
      int value = element[dataname];
      double value_double = value.toDouble();
      List<FlSpot> list = ref.watch(HistoriqueProvider);

      if (list.length < 11) {
        // On parcour les valeurs qu'on ajoute à la liste jusqu'à atteindre 11 (nb de val affichées)

        ref.read(HistoriqueProvider.notifier).add(FlSpot(indice, value_double));
        indice = indice - 1;
      }
    }
  } catch (e) {
    print(e);
  }
}
