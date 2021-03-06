import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CusDrawer.dart';
import '../models/receiveddata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:permission_handler/permission_handler.dart';

class studentdata2 extends StatelessWidget {
  final Datar data;

  studentdata2(this.data);

  Future<void> _launchUrl(String url) async {
    Uri data = Uri.parse(url);
    if (!await launchUrl(data)) {
      throw 'Could not launch $data';
    }
  }

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
                            NetworkImage(data.profilePicture as String),
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
                                  "Batch : " +
                                      data.academicDetail!.batch.toString(),
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
                                  "Native : " +
                                      data.academicDetail!.native.toString(),
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
                                "PhoneNo : " + data.phoneNumber.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Email : " + data.email.toString(),
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
                                    "CGPA : " +
                                        data.academicDetail!.cgpa.toString(),
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "10th-Score : " +
                                        data.academicDetail!.marks10th
                                            .toString() +
                                        "%",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final url = data.academicDetail!
                                          .marksheet10th as String;
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
                                        data.academicDetail!.marks12th
                                            .toString() +
                                        "%",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "DOB : " +
                                        data.academicDetail!.dob.toString(),
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final url = data.academicDetail!
                                          .marksheet12th as String;
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
                                  )
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
