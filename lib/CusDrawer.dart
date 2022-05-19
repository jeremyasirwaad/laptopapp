import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/Approvedrequestes.dart';
import './screens/trackprogress.dart';
import './screens/Laptoprequest.dart';
import 'package:laptopapp/screens/dashboard.dart';
import 'package:page_transition/page_transition.dart';

class Customdrawer extends StatefulWidget {
  Customdrawer({Key? key}) : super(key: key);

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.indigo,
        child: ListView(children: [
          const SizedBox(
            height: 46,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Laptop App",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          buildmenu(
              text: "Dashboard",
              icon: const FaIcon(
                FontAwesomeIcons.chartLine,
                color: Colors.white,
              ),
              onClicked: () => selecteditem(context, 0)),
          const SizedBox(
            height: 24,
          ),
          buildmenu(
              text: "Laptop Requests",
              icon: const FaIcon(
                FontAwesomeIcons.laptop,
                color: Colors.white,
              ),
              onClicked: () => selecteditem(context, 1)),
          const SizedBox(
            height: 24,
          ),
          buildmenu(
              text: "Approved Requests",
              icon: const FaIcon(
                FontAwesomeIcons.check,
                color: Colors.white,
              ),
              onClicked: () => selecteditem(context, 2)),
          const SizedBox(
            height: 24,
          ),
          buildmenu(
              text: "Track Progress",
              icon: const FaIcon(
                FontAwesomeIcons.noteSticky,
                color: Colors.white,
              ),
              onClicked: () => selecteditem(context, 3)),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: Colors.white,
            ),
          )
        ]),
      ),
    );
  }
}

Widget buildmenu(
    {required String text, required FaIcon icon, VoidCallback? onClicked}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: ListTile(
      leading: icon,
      title: Text(
        text,
        // style: GoogleFonts.rubik(color: Colors.white, fontSize: 14),
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      hoverColor: Colors.white10,
      onTap: onClicked,
    ),
  );
}

void selecteditem(BuildContext context, index) {
  switch (index) {
    case 0:
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: dashboard()));
      break;

    case 1:
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: laptoprequest()));
      break;

    case 2:
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: approvedrequest()));
      break;

    case 3:
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: trackprogress()));
      break;
  }
}
