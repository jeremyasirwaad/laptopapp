import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:laptopapp/models/lapspanding.dart';
import 'package:laptopapp/models/receiveddata.dart';
import '../CusDrawer.dart';
import './studentdata.dart';
import '../models/totalamount.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../models/receiveddata.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './Laptoprequest.dart';
import './Approvedrequestes.dart';

class laptoprequest extends StatefulWidget {
  laptoprequest({Key? key}) : super(key: key);

  @override
  State<laptoprequest> createState() => _laptoprequestState();
}

class _laptoprequestState extends State<laptoprequest> {
  List<Datar> rdata = [];
  int totalamountspent = 0;

  Future<dynamic> fetchrequestdata() async {
    final response = await http.get(Uri.parse(
        'http://54.160.132.147/api/users?populate[0]=laptopStatus&populate[1]=updateProgress&populate[2]=skillProgress&populate[3]=academicDetail'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      final receivedcodedata = received.fromJson(data);

      setState(() {
        rdata = receivedcodedata.datar!
            .where((element) => element.laptopStatus!.status == "laptopPending")
            .toList();

        // rdata = receivedcodedata.datar as List<Datar>;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> fetchtamount() async {
    final response =
        await http.get(Uri.parse('http://54.160.132.147/api/total-amount'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data = jsonDecode(response.body);
      final totalamt = totalamount.fromJson(data);
      setState(() {
        totalamountspent = totalamt.data!.attributes?.totalAmount as int;
        // amountspents = false;
      });

      // print(data2.weeklyContributions);
      print(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchrequestdata();
    fetchtamount();
  }

  @override
  Widget build(BuildContext context) {
    void rejectreq(id) async {
      final response = await http.put(
          Uri.parse('http://54.160.132.147/api/users/' + id.toString()),
          body: {"laptopStatus": "1"});

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => laptoprequest()),
        );
      } else {
        throw Exception('Failed to load album');
      }

      // print(userid);
    }

    void approvereq(userid) async {
      final response = await http.put(
          Uri.parse('http://54.160.132.147/api/users/' + userid),
          body: {"laptopStatus": "2"});

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

    void updatetotalamount(newamount) async {
      Map datafiles = {
        'data': {'totalAmount': totalamountspent + newamount}
      };

      var dedata = jsonEncode(datafiles);

      final response = await http.put(
          Uri.parse('http://54.160.132.147/api/total-amount/'),
          headers: {"Content-Type": "application/json"},
          body: dedata);

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

    TextEditingController amountcontroller = new TextEditingController();

    Future opendialogue(userid) => showDialog(
        context: context,
        builder: (Context) => AlertDialog(
              title: Text("Cost of the Laptop"),
              content: TextField(
                controller: amountcontroller,
                // onChanged: (value) => {print(value)},
                autofocus: true,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(hintText: "Enter Laptop Cost"),
              ),
              actions: [
                ElevatedButton(
                    // color: Colors.indigo,
                    // textColor: Colors.white,
                    onPressed: () {
                      print(amountcontroller.text);
                      approvereq(userid);
                      updatetotalamount(int.parse(amountcontroller.text));
                      // print(userid);
                      // Navigator.of(context).pop();
                    },
                    child: Text("Submit"))
              ],
            ));

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
        title: Text("Laptop Requests"),
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
                      "Requests",
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
                    rdata[index],
                    opendialogue,
                    rejopendialogue),
              ),

              // Requestscards(),
              // Requestscards(),
              // Requestscards(),
              // Requestscards(),
            ]),
    );
  }
}

class Requestscards extends StatelessWidget {
  @override
  final String fname;
  final int batch;
  final String Dept;
  final String shortstory;
  final Datar data;
  final Function opendialogue;
  final Function rejopendialogue;

  Requestscards(this.fname, this.batch, this.Dept, this.shortstory, this.data,
      this.opendialogue, this.rejopendialogue);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: studentdata(data)));
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
                child: GestureDetector(
                  onTap: () {
                    opendialogue(data.id.toString());
                  },
                  child: Container(
                    child: Center(child: Text("Accept")),
                    height: 30,
                    width: 80,
                    // color: Colors.green.shade300,
                    decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 110,
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
