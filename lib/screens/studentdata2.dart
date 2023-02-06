import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CusDrawer.dart';
import '../models/receiveddata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models//allusers.dart';
import '../screens/Approvedrequestes.dart';
import 'package:http/http.dart' as http;
import '../screens/Laptoprequest.dart';
// import 'package:permission_handler/permission_handler.dart';

class studentdata2 extends StatefulWidget {
  final DataUser data;

  studentdata2(this.data);

  @override
  State<studentdata2> createState() => _studentdata2State();
}

class _studentdata2State extends State<studentdata2> {
  Future<void> _launchUrl(String url) async {
    Uri data = Uri.parse(url);
    if (!await launchUrl(data)) {
      throw 'Could not launch $data';
    }
  }

  @override
  Widget build(BuildContext context) {
    void rejectreq() async {
      final response = await http.put(
          Uri.parse(
              'http://3.237.103.4/api/users/' + widget.data.id.toString()),
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

    List<Map<String, String?>> sendJson(List<Paymentstate>? data) {
      var paymentlist = data!
          .map((e) => {
                "date": e.date,
                "amount": e.amount,
                "content": e.content,
                "status": e.status
              })
          .toList();

      String paymentstatsasjson = json.encode(paymentlist);
      print(paymentstatsasjson);
      return paymentlist;
    }

    void acceptpayment(int? index) async {
      setState(() {
        widget.data.paymentstate![index as int].status = "approved";
      });

      final response = await http.put(
        Uri.parse('http://3.237.103.4/api/users/' + widget.data.id.toString()),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"paymentstate": sendJson(widget.data.paymentstate)}),
      );
    }

    void declinepayment(int? index) async {
      setState(() {
        widget.data.paymentstate![index as int].status = "declined";
      });

      final response = await http.put(
        Uri.parse('http://3.237.103.4/api/users/' + widget.data.id.toString()),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"paymentstate": sendJson(widget.data.paymentstate)}),
      );
    }

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
                                  "Interest : Fullstack",
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
                          "Laptop Info",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                          // height: 120,
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Laptop Price : " +
                                        "₹" +
                                        widget.data.laptopCost.toString(),
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Appv Date : " +
                                        widget.data.laptopDateApproved
                                            .toString()
                                            .substring(0, 10),
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final url = widget.data.receipt as String;
                                      if (await canLaunch(url)) {
                                        await launch(url, forceSafariVC: false);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Receipt Download",
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Text("Age : 18")
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // Text("Department : IT"),
                                  // Text("CGPA : 9.0"),
                                  Text(
                                    "Laptop Received : " +
                                        (widget.data.laptopReceivedByStudent ==
                                                false
                                            ? "No"
                                            : "Yes"),
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Date Rec : " +
                                        (widget.data.laptopdateReceived == null
                                            ? "  -----"
                                            : widget.data.laptopdateReceived
                                                .toString()
                                                .substring(0, 10)),
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              )
                            ],
                          )),
                    ]),
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
                                  GestureDetector(
                                    onTap: () async {
                                      final url =
                                          widget.data.otherreport as String;
                                      if (await canLaunch(url)) {
                                        await launch(url, forceSafariVC: false);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Other Documents",
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
                                        : null,
                                  )
                                ],
                              )
                            ],
                          )),
                    ]),
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
                    color: Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.all(15),
                    // height: 200,
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        width: double.infinity,
                        child: Text(
                          "PayBack History",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      ...List.generate(
                          widget.data.paymentstate!.length as int,
                          (index) => Container(
                                margin: EdgeInsets.all(20),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      widget.data.paymentstate![index].amount
                                              .toString() +
                                          "₹",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      widget.data.paymentstate![index].date
                                          .toString(),
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      widget.data.paymentstate![index].content
                                          .toString(),
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    widget.data.paymentstate![index].status ==
                                            "pending"
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  declinepayment(index);
                                                },
                                                child: Text("Decline"),
                                                // style: ElevatedButton.styleFrom(
                                                //     primary: Colors.white,
                                                //     onPrimary: Colors.indigo),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    acceptpayment(index);
                                                  },
                                                  // style: ElevatedButton.styleFrom(
                                                  //     primary: Colors.white,
                                                  //     onPrimary: Colors.indigo),
                                                  child: Text("Approve"))
                                            ],
                                          )
                                        : Container(),
                                    widget.data.paymentstate![index].status ==
                                            "approved"
                                        ? Row(
                                            children: [
                                              Text(
                                                "Approved",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    color: Colors.green),
                                              )
                                            ],
                                          )
                                        : Container(),
                                    widget.data.paymentstate![index].status ==
                                            "declined"
                                        ? Row(
                                            children: [
                                              Text(
                                                "Declined",
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25,
                                                    color: Colors.red),
                                              )
                                            ],
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Divider(
                                      height: 10,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    )
                                  ],
                                ),
                              )),
                    ]),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
