import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/allusers2.dart';
import '../CusDrawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../models/githubdata.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Trackprogressuser extends StatefulWidget {
  final DataUser rdata;

  Trackprogressuser(this.rdata);

  @override
  State<Trackprogressuser> createState() => _TrackprogressuserState();
}

class _TrackprogressuserState extends State<Trackprogressuser> {
  int weekly = -1;
  int daily = -1;

  Future<dynamic> allusers() async {
    final response = await http.get(Uri.parse(
        'http://3.237.103.4/api/github-data/' +
            (widget.rdata.githubUsername as String)));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final data2 = githubdata.fromJson(data);

      setState(() {
        weekly = data2.weeklyContributionsSum as int;
        daily = data2.dailyContributions as int;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello");
    allusers();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double ctheight = height - MediaQuery.of(context).padding.top - 30;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.rdata.username as String),
        ),
        drawer: Customdrawer(),
        body: ListView(children: [
          SizedBox(
            height: 30,
          ),
          Row(children: [
            Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "GitHub Data",
                  style: GoogleFonts.rubik(fontSize: 20),
                )),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 30,
                  width: 30,
                  color: Colors.indigo,
                  child: Center(
                    child: Image.network(
                        "http://3.237.103.4/images/modules/logos_page/GitHub-Mark.png"),
                  ),
                ),
              ),
            )
          ]),
          Container(
            // height: ctheight,
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 8, top: 20),
                      child: Card(
                        // color: Color.fromARGB(255, 148, 118, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 6,
                        // color: Colors.black,
                        child: Container(
                          height: ctheight / 4 - 10,
                          child: Stack(children: [
                            Positioned(
                              top: 20,
                              left: 15,
                              right: 15,
                              child: Container(
                                width: 150,
                                child: Container(
                                  width: 150,
                                  child: Text(
                                    "Weekly Contribution",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: weekly == -1
                                          ? SpinKitThreeBounce(
                                              color: Colors.indigo,
                                              size: 30,
                                            )
                                          : Text(
                                              weekly.toString(),
                                              style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 60,
                                                  color: Colors.indigo),
                                            ),
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
                      padding: EdgeInsets.only(left: 8, right: 16, top: 20),
                      child: Card(
                        // color: Color.fromARGB(255, 148, 118, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 6,
                        // color: Colors.black,
                        child: Container(
                          height: ctheight / 4 - 10,
                          child: Stack(children: [
                            Positioned(
                              top: 20,
                              left: 15,
                              right: 15,
                              child: Container(
                                width: 150,
                                child: Container(
                                  width: 150,
                                  child: Text(
                                    "Today's Contribution",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: daily == -1
                                          ? SpinKitThreeBounce(
                                              color: Colors.indigo,
                                              size: 30,
                                            )
                                          : Text(
                                              daily.toString(),
                                              style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 60,
                                                  color: Colors.indigo),
                                            ),
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
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 8, top: 20, bottom: 20),
                      child: Card(
                        // color: Color.fromARGB(255, 148, 118, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 6,
                        // color: Colors.black,
                        child: Container(
                          height: ctheight / 4 - 40,
                          child: Stack(children: [
                            Positioned(
                              top: 20,
                              left: 15,
                              right: 15,
                              child: Container(
                                width: 150,
                                child: Container(
                                  width: 150,
                                  child: Text(
                                    "Git Activity",
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  // margin: EdgeInsets.only(top: 20),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 15, right: 15, left: 15),
                                    child: SvgPicture.network(
                                        'https://ghchart.rshah.org/' +
                                            (widget.rdata.githubUsername
                                                as String)),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                endIndent: 40,
                indent: 40,
                thickness: 1.5,
              ),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      "Progress Data",
                      style: GoogleFonts.rubik(fontSize: 20),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                        height: 30,
                        width: 30,
                        // color: Colors.indigo,
                        child: Center(child: Icon(Icons.arrow_circle_up))),
                  ),
                )
              ]),
              SizedBox(
                height: 50,
              ),
              widget.rdata.statusUpdate == null ?
              Text(""):
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Date",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(
                      "Content",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ))
                ],
              ),
              widget.rdata.statusUpdate == null ? 
              Text("nothing to display"):
              Column(
                children: [
                  ...List.generate(
                      widget.rdata.statusUpdate!.length,
                      (index) => Container(
                            margin: EdgeInsets.only(
                              top: 20,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      widget.rdata.statusUpdate![index].date
                                          as String,
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 40),
                                      child: Text(
                                        widget.rdata.statusUpdate![index]
                                            .content as String,
                                        textAlign: TextAlign.center,
                                      ),
                                    ))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Divider(
                                  color: Colors.grey,
                                  endIndent: 40,
                                  indent: 40,
                                  thickness: 0.5,
                                ),
                              ],
                            ),
                          ))
                ],
              )
            ]),
          ),
        ]));
  }
}
