import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../CusDrawer.dart';

class laptoprequest extends StatefulWidget {
  laptoprequest({Key? key}) : super(key: key);

  @override
  State<laptoprequest> createState() => _laptoprequestState();
}

class _laptoprequestState extends State<laptoprequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Laptop Requests"),
        ),
        drawer: Customdrawer(),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      child: Text("21",
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              )
            ]),
            Requestscards(),
            Requestscards(),
            Requestscards(),
            Requestscards(),
            Requestscards(),
            Requestscards(),
            Requestscards(),
          ]),
        ));
  }
}

class Requestscards extends StatelessWidget {
  const Requestscards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Container(
          child: Stack(children: [
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                child: Center(child: Text("Accept")),
                height: 30,
                width: 80,
                color: Colors.green.shade300,
              ),
            ),
            Positioned(
              bottom: 20,
              right: 110,
              child: Container(
                child: Center(child: Text("Decline")),
                height: 30,
                width: 80,
                color: Colors.red.shade300,
              ),
            )
          ]),
          height: 170,
          width: double.infinity,
        ),
      ),
    );
  }
}
