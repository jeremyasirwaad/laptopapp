import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:laptopapp/models/lapspanding.dart';
import 'package:laptopapp/models/receiveddata.dart';
import '../CusDrawer.dart';
import './studentdata2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../models/receiveddata.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class approvedrequest extends StatefulWidget {
  approvedrequest({Key? key}) : super(key: key);

  @override
  State<approvedrequest> createState() => _approvedrequestState();
}

class _approvedrequestState extends State<approvedrequest> {
  List<Datar> rdata = [];

  Future<dynamic> fetchapproveddata() async {
    final response = await http.get(Uri.parse(
        'http://54.160.132.147/api/users?populate[0]=laptopStatus&populate[1]=updateProgress&populate[2]=skillProgress&populate[3]=academicDetail'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      final receivedcodedata = received.fromJson(data);

      setState(() {
        rdata = receivedcodedata.datar!
            .where(
                (element) => element.laptopStatus!.status == "laptopReceived")
            .toList();

        // rdata = receivedcodedata.datar as List<Datar>;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchapproveddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Approved Requests"),
      ),
      drawer: Customdrawer(),
      body: rdata.length == 0
          ? Center(
              child: SpinKitThreeBounce(
                color: Colors.indigo,
                size: 50,
              ),
            )
          : ListView(children: [
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      "Approved",
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
                        child: Text(rdata.length.toString(),
                            style: GoogleFonts.rubik(
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                )
              ]),
              ...List.generate(
                  rdata.length,
                  (index) => Requestscards(
                      rdata[index].displayName as String,
                      int.parse(rdata[index].academicDetail?.batch as String),
                      rdata[index].academicDetail?.department as String,
                      rdata[index].academicDetail?.collegeEssay as String,
                      rdata[index])),

              // Requestscards(),
              // Requestscards(),
              // Requestscards(),
              // Requestscards(),
            ]),
    );
    ;
  }
}

class Requestscards extends StatelessWidget {
  @override
  final String fname;
  final int batch;
  final String Dept;
  final String shortstory;
  final Datar data;

  Requestscards(this.fname, this.batch, this.Dept, this.shortstory, this.data);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: studentdata2(data)));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          child: Container(
            child: Stack(children: [
              Positioned(
                child: Text(
                  fname,
                  style: GoogleFonts.rubik(fontSize: 19),
                ),
                top: 20,
                left: 20,
              ),
              Positioned(
                child: Text(
                  Dept + "-" + batch.toString(),
                  style: GoogleFonts.rubik(fontSize: 19),
                ),
                top: 20,
                right: 20,
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Container(
                  height: 80,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    shortstory,
                    style: GoogleFonts.rubik(fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  child: Center(child: Text("Decline")),
                  height: 30,
                  width: 80,
                  // color: Colors.red.shade300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red.shade300),
                ),
              )
            ]),
            height: 170,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
