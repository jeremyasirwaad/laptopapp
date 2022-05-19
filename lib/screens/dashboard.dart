import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CusDrawer.dart';
import 'package:fl_chart/fl_chart.dart';
import '../dashbarchat.dart';
import 'package:carousel_slider/carousel_slider.dart';


// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class dashboard extends StatefulWidget {
  dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  AppBar appBar = AppBar(
    title: Text("Dashboard"),
  );
  @override
  Widget build(BuildContext context) {
   
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double ctheight = height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;
    return Scaffold(
        appBar: appBar,
        drawer: Customdrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: ctheight / 3 - 50,
                  width: double.infinity,
                  child: Stack(children: [
                    Positioned(
                      top: 20,
                      left: 15,
                      child: Text(
                        "Total Laptops Lent",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 40, top: 20),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "10",
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 60,
                                  color: Colors.indigo),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            margin: EdgeInsets.only(right: 25),
                            // color: Colors.black,
                            width: 120,
                            height: 120,
                            child: PieChart(
                              PieChartData(
                                  borderData: FlBorderData(show: false),
                                  sections: [
                                    PieChartSectionData(
                                        color: Colors.teal,
                                        value: 4,
                                        title: "IT",
                                        titleStyle: TextStyle(fontSize: 10)),
                                    PieChartSectionData(
                                        color: Colors.blue,
                                        value: 1,
                                        title: "CS",
                                        titleStyle: TextStyle(fontSize: 10)),
                                    PieChartSectionData(
                                        color: Colors.green,
                                        value: 1,
                                        title: "ECE",
                                        titleStyle: TextStyle(fontSize: 10)),
                                    PieChartSectionData(
                                        color: Colors.yellow,
                                        value: 0,
                                        title: "EEE",
                                        titleStyle: TextStyle(fontSize: 10)),
                                    PieChartSectionData(
                                        color: Colors.purple,
                                        value: 2,
                                        title: "Civil",
                                        titleStyle: TextStyle(fontSize: 10)),
                                    PieChartSectionData(
                                        color: Colors.orange,
                                        value: 1,
                                        title: "IBT",
                                        titleStyle: TextStyle(fontSize: 10)),
                                    PieChartSectionData(
                                        color: Colors.pink,
                                        value: 0,
                                        title: "EIE",
                                        titleStyle: TextStyle(fontSize: 10)),
                                    PieChartSectionData(
                                        color: Colors.red,
                                        value: 0,
                                        title: "Mech",
                                        titleStyle: TextStyle(fontSize: 10)),
                                    PieChartSectionData(
                                        color: Colors.cyan,
                                        value: 0,
                                        title: "Prod",
                                        titleStyle: TextStyle(fontSize: 10)),
                                  ]),
                            )),
                      ),
                    ),
                  ]),
                ),
                // color: Colors.black,
                elevation: 6,
              ),
            ),
            Container(
              height: ctheight / 3 - 50,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: Card(
                        // color: Color.fromARGB(255, 148, 118, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 6,
                        // color: Colors.black,
                        child: Container(
                          height: ctheight / 3 - 50,
                          child: Stack(children: [
                            Positioned(
                              top: 20,
                              left: 15,
                              child: Text(
                                "Pending Requests",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      "8",
                                      style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 60,
                                          color: Colors.indigo),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 16),
                      child: Card(
                          color: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 6,
                          // color: Colors.black,
                          child: Container(
                            height: ctheight / 3 - 50,
                            child: Stack(children: [
                              Positioned(
                                top: 20,
                                left: 15,
                                child: Text(
                                  "Amount spent",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "1.5L",
                                        style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.w100,
                                            fontSize: 60,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          )),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(16),
                child: CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.vertical,
                      viewportFraction: 1,
                      autoPlayInterval: Duration(seconds: 5)),
                  items: [
                    Card(
                      color: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 6,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
                        height: ctheight / 3 - 50,
                        child: dashbarchat(),
                      ),
                      // color: Colors.black,
                    ),
                    Card(
                      color: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 6,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        height: ctheight / 3 - 50,
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "Last week Git",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                Expanded(
                                    child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      "14",
                                      style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 60,
                                          color: Colors.white),
                                    ),
                                  ),
                                ))
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "Total Git Commits",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                Expanded(
                                    child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      "50",
                                      style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 60,
                                          color: Colors.white),
                                    ),
                                  ),
                                ))
                              ],
                            ))
                          ],
                        ),
                      ),
                      // color: Colors.black,
                    ),
                  ],
                )),
          ],
        ));
  }
}
