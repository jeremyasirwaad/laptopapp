import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CusDrawer.dart';
import '../models/receiveddata.dart';
import 'package:google_fonts/google_fonts.dart';

class studentdata extends StatelessWidget {
  final Datar data;

  studentdata(this.data);

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.xmark,
                  color: Colors.white,
                )),
            IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.check,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(data.displayName as String),
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
                  height: 400,
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
                            NetworkImage(data.profilePicture as String),
                      ),
                    ),
                    Container(
                        height: 120,
                        margin: EdgeInsets.only(top: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name : " + data.displayName.toString(),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Batch : " +
                                      data.academicDetail!.batch.toString(),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Interest : Fullstack",
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
                                  "Age : 18",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Native : " +
                                      data.academicDetail!.native.toString(),
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Ph no: " + data.phoneNumber.toString(),
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
                      child: Text(data.academicDetail!.collegeEssay as String),
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
                        padding: EdgeInsets.all(15),
                      )
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
