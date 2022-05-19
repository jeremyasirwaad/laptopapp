import 'package:flutter/material.dart';
import '../CusDrawer.dart';

class approvedrequest extends StatefulWidget {
  approvedrequest({Key? key}) : super(key: key);

  @override
  State<approvedrequest> createState() => _approvedrequestState();
}

class _approvedrequestState extends State<approvedrequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Approved Requests"),
      ),
      drawer: Customdrawer(),
      body: Center(child: Text("Approved Requests")),
    );
    ;
  }
}
