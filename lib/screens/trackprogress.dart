import 'package:flutter/material.dart';
import '../CusDrawer.dart';

class trackprogress extends StatefulWidget {
  trackprogress({Key? key}) : super(key: key);

  @override
  State<trackprogress> createState() => _trackprogressState();
}

class _trackprogressState extends State<trackprogress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Progress"),
      ),
      drawer: Customdrawer(),
      body: Center(child: Text("Track Progress")),
    );
    ;
  }
}
