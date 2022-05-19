import 'package:flutter/material.dart';
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
      body: Center(child: Text("Laptop Requests")),
    );
  }
}
