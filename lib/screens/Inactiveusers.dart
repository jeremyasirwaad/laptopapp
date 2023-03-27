import 'package:flutter/material.dart';
import '../CusDrawer.dart';
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
// import '../models/allusers.dart';
import '../screens/Laptoprequest.dart';
import './Trackprogressuser.dart';
import '../models/allusers2.dart';
import './Emailsendpage.dart';

class inactiveusers extends StatefulWidget {
  inactiveusers({Key? key}) : super(key: key);

  @override
  State<inactiveusers> createState() => _inactiveusersState();
}

class _inactiveusersState extends State<inactiveusers> {
  var isFetched = false;
  List<DataUser> rdata = [];

  Future<dynamic> fetchapproveddata() async {
    final response = await http.get(Uri.parse(
        'https://manage-laptopapp.itzapril.tech/api/users?filters[lastUpdate][\$lt]=1672816384125'));

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      final receivedcodedata = usertracking.fromJson(data);

      setState(() {
        rdata = receivedcodedata.dataUser
            ?.where((element) =>
                element.laptopStatus == "Approved" &&
                element.laptopReceivedByStudent == true)
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Inactive Beneficiaries"),
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
                          "Inactive Users",
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
                  SizedBox(
                    height: 30,
                  ),
                  ...List.generate(
                      rdata.length,
                      (index) => Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Card(
                              elevation: 6,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: double.infinity,
                                height: 70,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text((rdata[index].username as String) +
                                            " - " +
                                            (rdata[index].department
                                                as String) +
                                            " - " +
                                            (rdata[index].batch.toString()
                                                as String)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          ("Last Updated") +
                                              " - " +
                                              DateTime.fromMillisecondsSinceEpoch(
                                                      int.parse(rdata[index]
                                                          .lastUpdate
                                                          .toString()))
                                                  .toString()
                                                  .substring(0, 10),
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          // print("hello");
                                          Navigator.pushReplacement(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: Emailsendpage(
                                                      rdata[index])));
                                        },
                                        child: Text("Mail"))
                                  ],
                                ),
                              ),
                            ),
                          )),

                  // Requestscards(),
                  // Requestscards(),
                  // Requestscards(),
                  // Requestscards(),
                ]),
    );
    ;
  }
}
