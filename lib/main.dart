import 'package:flutter/material.dart';
import './screens/dashboard.dart';
import './screens/Laptoprequest.dart';
import './screens/trackprogress.dart';
import './screens/Approvedrequestes.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LaptopApp",
      // home: dashboard(),
      theme:
          ThemeData(primaryColor: Colors.indigo, primarySwatch: Colors.indigo),
      routes: {
        "/": (context) => dashboard(),
        "/lapreq": (context) => laptoprequest(),
        "/apprstatus": (context) => approvedrequest(),
        "/tcprogress": (context) => trackprogress(),
      },
    );
  }
}
