import 'package:flutter/material.dart';
import './screens/dashboard.dart';
import './screens/Laptoprequest.dart';
import './screens/trackprogress.dart';
import './screens/Approvedrequestes.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using
  // await FlutterDownloader.initialize(
  //     debug:
  //         true, // optional: set to false to disable printing logs to console (default: true)
  //     ignoreSsl:
  //         true // option: set to false to disable working with http links (default: false)
  //     );
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
