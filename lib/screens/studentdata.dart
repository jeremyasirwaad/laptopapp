import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CusDrawer.dart';
import '../models/receiveddata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../models/totalamount.dart';
import './Approvedrequestes.dart';
import '../screens/Laptoprequest.dart';
import '../models/allusers.dart';
import 'package:intl/intl.dart';

// import 'package:permission_handler/permission_handler.dart';

class studentdata extends StatefulWidget {
  final DataUser data;
  studentdata(this.data);

  @override
  State<studentdata> createState() => _studentdataState();
}

class _studentdataState extends State<studentdata> {
  int totalamountspent = 0;
  Future<dynamic> fetchtamount() async {
    final response =
        await http.get(Uri.parse('https://manage-laptopapp.itzapril.tech/api/amount'));

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

    fetchtamount();
  }

  @override
  Widget build(BuildContext context) {
    String getdate() {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
      return formattedDate;
    }

    void approvereq(userid, amount) async {
      Map datafile = {
        'LaptopStatus': 'Approved',
        'LaptopCost': amount,
        'LaptopDateApproved': getdate().toString()
      };

      var dataformjson = json.encode(datafile);
      final response = await http.put(
          Uri.parse('https://manage-laptopapp.itzapril.tech/api/users/' + userid),
          headers: {"Content-Type": "application/json"},
          body: dataformjson);

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

    void rejectreq() async {
      final response = await http.put(
          Uri.parse('https://manage-laptopapp.itzapril.tech/api/users/' +
              widget.data.id.toString()),
          body: {"LaptopStatus": "Rejected"});

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

    void updatetotalamount(newamount) async {
      Map datafiles = {
        'data': {'totalAmount': totalamountspent + newamount}
      };

      var dedata = jsonEncode(datafiles);

      final response = await http.put(
          Uri.parse('https://manage-laptopapp.itzapril.tech/api/amount/'),
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
                FlatButton(
                    color: Colors.indigo,
                    textColor: Colors.white,
                    onPressed: () {
                      print(amountcontroller.text);
                      approvereq(userid, int.parse(amountcontroller.text));
                      updatetotalamount(int.parse(amountcontroller.text));
                      // print(userid);
                      // Navigator.of(context).pop();
                    },
                    child: Text("Submit"))
              ],
            ));

    Future rejopendialogue() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
                      rejectreq();
                      Navigator.of(context).pop();
                    },
                    child: Text("Yes"))
              ],
            ));

    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  rejopendialogue();
                },
                icon: FaIcon(
                  FontAwesomeIcons.xmark,
                  color: Colors.white,
                )),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  opendialogue(widget.data.id.toString());
                },
                icon: FaIcon(
                  FontAwesomeIcons.check,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.data.username as String),
      ),
      drawer: Customdrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Container(
            child: Column(children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 7,
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 350,
                  child: Column(children: [
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        width: double.infinity,
                        child: Text(
                          "Personal Info",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.start,
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.data.imgsrc as String),
                      ),
                    ),
                    Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Age : 18",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Batch : " + widget.data.batch.toString(),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600),
                                ),

                                // Text("Age : 18")
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text("Department : IT"),
                                // Text("CGPA : 9.0"),

                                Text(
                                  "Native : " + widget.data.native.toString(),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Interest : " +
                                      widget.data.interest.toString(),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        )),
                  ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 7,
                child: Container(
                  padding: EdgeInsets.all(15),
                  // height: 200,
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      width: double.infinity,
                      child: Text(
                        "Short Story",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(widget.data.collegeEssay as String),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 7,
                color: Colors.indigo,
                child: Container(
                  width: double.infinity,
                  // height: 100,
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(15),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            "Contact Info",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "PhoneNo : " + widget.data.phno.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Email : " + widget.data.email.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.indigo,
                    padding: EdgeInsets.all(15),
                    // height: 200,
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        width: double.infinity,
                        child: Text(
                          "Academic Info",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                          height: 120,
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "CGPA : " + widget.data.cgpa.toString(),
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "10th-Score : " +
                                        widget.data.marks10th.toString() +
                                        "%",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final url =
                                          widget.data.report10th as String;
                                      if (await canLaunch(url)) {
                                        await launch(url, forceSafariVC: false);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "10th-Marksheet",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.download,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: widget.data.otherreport != null
                                        ? GestureDetector(
                                            onTap: () async {
                                              final url = widget.data.report12th
                                                  as String;
                                              if (await canLaunch(url)) {
                                                await launch(url,
                                                    forceSafariVC: false);
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "12th-Marksheet",
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.download,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  )
                                  // Text("Age : 18")
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text("Department : IT"),
                                  // Text("CGPA : 9.0"),
                                  Text(
                                    "12th-Score : " +
                                        widget.data.marks12th.toString() +
                                        "%",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "DOB : " + widget.data.dob.toString(),
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final url =
                                          widget.data.report12th as String;
                                      if (await canLaunch(url)) {
                                        await launch(url, forceSafariVC: false);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "12th-Marksheet",
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.download,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container()
                                ],
                              )
                            ],
                          ))
                    ]),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
