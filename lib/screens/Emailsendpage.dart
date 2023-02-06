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
// import '../models//allusers.dart';
import '../screens/Laptoprequest.dart';
import './Trackprogressuser.dart';
import '../models/allusers2.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:delta_markdown/delta_markdown.dart' as deltam;
// import 'package:flutter_quill/models/quill_delta.dart';
import 'package:markdown/markdown.dart' as markdowndelta;
import 'package:mailer/mailer.dart';

import 'package:mailer/smtp_server.dart';

class Emailsendpage extends StatefulWidget {
  final DataUser data;
  const Emailsendpage(this.data);

  @override
  State<Emailsendpage> createState() => _EmailsendpageState();
}

class _EmailsendpageState extends State<Emailsendpage> {
  String bn = "Send mail";
  HtmlEscape htmlEscape = HtmlEscape();
  final quill.QuillController _controller = quill.QuillController(
      document: quill.Document()..insert(0, "This is the default message"),
      selection: const TextSelection.collapsed(offset: 0));

  String quillDeltaToHtml(quill.Delta delta) {
    final convertedValue = jsonEncode(delta.toJson());
    final markdown = deltam.deltaToMarkdown(convertedValue);
    final html = markdowndelta.markdownToHtml(markdown);

    return html;
  }

  sendmailusingsever(String email, String html) async {
    String username = 'joel.20fit18@gct.ac.in';
    String password = 'royalenfieldg2';
    String name = widget.data.username.toString();

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'GCT Alumni Association')
      ..recipients.add(email)
      ..subject = 'Remainder Message'
      ..html = "<p>Hi $name,</p>" +
          html +
          "<br/><span>GCT Alumni Association,<br/>Jose</span>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      showAlertDialog(context, name);
      setState(() {
        bn = "Mail Sent Successfully";
      });
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<dynamic> sendmail(String email, String html) async {
    final response = await http.get(Uri.parse(
        'https://laptopapp.onrender.com/api/send-reminder/' +
            email +
            '/' +
            html));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Email"),
      ),
      drawer: Customdrawer(),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  "Draft Email",
                  style: GoogleFonts.rubik(fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                FaIcon(
                  FontAwesomeIcons.envelope,
                  color: Colors.black,
                ),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding:
                  EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              child: TextField(
                controller: TextEditingController(text: widget.data.email),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Name Here',
                    enabled: false),
                autofocus: false,
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       print(quillDeltaToHtml(_controller.document.toDelta()));
            //     },
            //     child: Text("Print")),
            quill.QuillToolbar.basic(
              controller: _controller,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 246, 246, 246)),
                child: quill.QuillEditor.basic(
                  controller: _controller,
                  readOnly: false, // true for view only mode
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  final datastring =
                      quillDeltaToHtml(_controller.document.toDelta());

                  // sendmail(widget.data.phno.toString(), datastring);
                  // print(quillDeltaToHtml(_controller.document.toDelta()));
                  sendmailusingsever(widget.data.email.toString(), datastring);
                },
                child: Text(bn))
          ],
        ),
        padding: EdgeInsets.only(
          top: 20,
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String name) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Mail Sent!"),
    content: Text("Mail has been sent successfully to $name"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
