import 'dart:convert';
import 'dart:math';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CusDrawer.dart';
import 'package:fl_chart/fl_chart.dart';
import '../dashbarchat.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import '../models/gitwidgetmodel.dart';
import '../models/totalamount.dart';
import '../models/totallent.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/lapspanding.dart';
import '../models//allusers.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class dashboard extends StatefulWidget {
  dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int wsum = 0;
  int ttotal = 0;
  List wcontribution = [];
  int totalamountspent = 0;
  int totallapslent = -1;
  int totalpendinglaps = -1;
  bool gits = true;
  bool totalreqs = true;
  bool pendingreqs = true;
  bool amountspents = true;
  List<DataUser> dataofusers = [];

  AppBar appBar = AppBar(
    title: Text("Dashboard"),
  );

  Future<dynamic> allusers() async {
    final response = await http.get(Uri.parse('https://manage-laptopapp.itzapril.tech/api/users'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final data2 = users.fromJson(data);

      setState(() {
        dataofusers = data2.data as List<DataUser>;
        totalpendinglaps = data2.data
            ?.where((element) => element.laptopStatus == "Pending")
            .toList()
            .length as int;
        totallapslent = data2.data
            ?.where((element) => element.laptopStatus == "Approved")
            .toList()
            .length as int;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> fetchAlbum() async {
    final response =
        await http.get(Uri.parse('https://manage-laptopapp.itzapril.tech/api/github-data'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final data2 = Autogenerated.fromJson(data);
      setState(() {
        wsum = data2.weeklyContributionsSum as int;
        ttotal = data2.totalContributions as int;
        wcontribution = data2.weeklyContributions as List;
        gits = false;
      });

      // print(data2.weeklyContributions);
      // print(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> fetchtamount() async {
    final response = await http.get(Uri.parse('https://manage-laptopapp.itzapril.tech/api/amount'));

    if (response.statusCode == 200) {
      print("hello");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      final totalamt = totalamount.fromJson(data);
      setState(() {
        totalamountspent = totalamt.data!.attributes?.totalAmount as int;
        amountspents = false;
      });

      // print(data2.weeklyContributions);
      print(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> fetchtreceived() async {
    final response = await http.get(Uri.parse(
        "https://manage-laptopapp.itzapril.tech/api/laptop-statuses?filters[status][\$contains]=laptopReceived&populate[1]=users.updateProgress&populate[2]=users.skillProgress"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      final totalamt = totallent.fromJson(data);
      setState(() {
        totallapslent = totalamt.meta!.pagination!.total as int;
        totalreqs = false;
      });

      print(totalamt.meta!.pagination!.total);

      // print(data2.weeklyContributions);
      // print(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> fetchpending() async {
    final response = await http.get(Uri.parse(
        "https://manage-laptopapp.itzapril.tech/api/laptop-statuses?filters[status][\$contains]=laptopPending&populate[0]=users&populate[1]=users.updateProgress&populate[2]=users.skillProgress"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      final pendinglaps = lapspending.fromJson(data);
      setState(() {
        totalpendinglaps = pendinglaps.meta!.pagination!.total as int;
        pendingreqs = false;
      });

      print(pendinglaps.meta!.pagination!.total);

      // print(data2.weeklyContributions);
      // print(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    fetchAlbum();
    fetchtamount();
    // fetchtreceived();
    // fetchpending();
    allusers();
    // print("hi"); // TODO: implement initState
    super.initState();
  }

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
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: totallapslent == -1
                              ? SpinKitThreeBounce(
                                  size: 25,
                                  color: Colors.indigo,
                                )
                              : Text(
                                  totallapslent.toString(),
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 60,
                                      color: Colors.indigo),
                                ),
                        ),
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
                                    child: totalpendinglaps == -1
                                        ? SpinKitThreeBounce(
                                            size: 25,
                                            color: Colors.indigo,
                                          )
                                        : Text(
                                            totalpendinglaps.toString(),
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
                                      child: amountspents
                                          ? SpinKitThreeBounce(
                                              size: 25,
                                              color: Colors.white,
                                            )
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Text(
                                                totalamountspent.toString() +
                                                    "₹",
                                                style: GoogleFonts.rubik(
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 60,
                                                    color: Colors.white),
                                              ),
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
                        child: gits
                            ? SpinKitThreeBounce(
                                color: Colors.white,
                                size: 35,
                              )
                            : dashbarchat(wcontribution),
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
                                      wsum.toString(),
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
                                      ttotal.toString(),
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
    // : Scaffold(
    //     body: Container(child: Center(child: Text("Loading"))),
    //   );
  }
}
