import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import '../models//allusers.dart';
import '../screens/Laptoprequest.dart';

class approvedrequest extends StatefulWidget {
  approvedrequest({Key? key}) : super(key: key);

  @override
  State<approvedrequest> createState() => _approvedrequestState();
}

class _approvedrequestState extends State<approvedrequest> {
  var isFetched = false;
  List<DataUser> rdata = [];

  Future<dynamic> fetchapproveddata() async {
    final response = await http
        .get(Uri.parse('http://3.237.103.4/api/users?populate=paymentstate'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      var data = jsonDecode(response.body);
      final receivedcodedata = users.fromJson(data);

      setState(() {
        rdata = receivedcodedata.data
            ?.where((element) => element.laptopStatus == "Approved")
            .toList() as List<DataUser>;

        isFetched = true;
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
    void rejectreq(id) async {
      final response = await http.put(
          Uri.parse('http://3.237.103.4/api/users/' + id.toString()),
          body: {"LaptopStatus": "Rejected"});

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => approvedrequest()),
        );
      } else {
        throw Exception('Failed to load album');
      }

      // print(userid);
    }

    Future rejopendialogue(userid) => showDialog(
        context: context,
        builder: (Context) => AlertDialog(
              title: Text("Confirm !"),
              content:
                  Text("Are you sure that you want to decline this request"),
              actions: [
                TextButton(
                    // color: Colors.indigo,
                    // textColor: Colors.white,
                    onPressed: () {
                      // print(amountcontroller.text);
                      // approvereq(userid);
                      // updatetotalamount(int.parse(amountcontroller.text));
                      // print(userid);

                      Navigator.of(context).pop();
                    },
                    child: Text("No")),
                ElevatedButton(
                    // color: Colors.indigo,
                    // textColor: Colors.white,
                    onPressed: () {
                      // print(amountcontroller.text);
                      // approvereq(userid);
                      // updatetotalamount(int.parse(amountcontroller.text));
                      rejectreq(userid);
                      Navigator.of(context).pop();
                    },
                    child: Text("Yes"))
              ],
            ));

    return Scaffold(
      appBar: AppBar(
        title: Text("Approved Requests"),
      ),
      drawer: Customdrawer(),
      body: !isFetched
          ? Center(
              child: SpinKitThreeBounce(
                color: Colors.indigo,
                size: 50,
              ),
            )
          : rdata.isEmpty
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  // color: Colors.black,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "No ",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 28,
                              color: Colors.black),
                        ),
                        Text(
                          "Data !",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                              color: Colors.indigo),
                        )
                      ]))
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
                          rdata[index].username as String,
                          int.parse(rdata[index].batch.toString() as String),
                          rdata[index].department as String,
                          rdata[index].collegeEssay as String,
                          rdata[index],
                          rejopendialogue)),

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
  final DataUser data;
  final Function rejopendialogue;

  Requestscards(this.fname, this.batch, this.Dept, this.shortstory, this.data,
      this.rejopendialogue);

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.laptopReceivedByStudent == false
                          ? Row(
                              children: [
                                Text(
                                  "Laptop Status: ",
                                  style: GoogleFonts.rubik(fontSize: 12),
                                ),
                                Text(
                                    (data.laptopReceivedByStudent == false
                                        ? "Not yet received"
                                        : "Yes"),
                                    style: GoogleFonts.rubik(
                                        fontSize: 12,
                                        color: Colors.red.shade300,
                                        fontWeight: FontWeight.w500)),
                              ],
                            )
                          : Row(
                              children: [
                                Text(
                                  "Laptop Received date: ",
                                  style: GoogleFonts.rubik(fontSize: 12),
                                ),
                                Text(
                                  data.laptopdateReceived
                                      .toString()
                                      .substring(0, 10),
                                  style: GoogleFonts.rubik(
                                      fontSize: 12,
                                      color: Colors.green.shade300,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Date Approved: ",
                            style: GoogleFonts.rubik(fontSize: 12),
                          ),
                          Text(
                            data.laptopDateApproved.toString().substring(0, 10),
                            style: GoogleFonts.rubik(
                                fontSize: 12,
                                color: Colors.green.shade300,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    rejopendialogue(data.id.toString());
                  },
                  child: Container(
                    child: Center(child: Text("Decline")),
                    height: 30,
                    width: 80,
                    // color: Colors.red.shade300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red.shade300),
                  ),
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
