import 'dart:convert';

class users {
  List<DataUser>? data;

  users({this.data});

  users.fromJson(List json) {
    if (json != null) {
      data = <DataUser>[];
      json.forEach((v) {
        data!.add(new DataUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataUser {
  int? id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  String? createdAt;
  String? updatedAt;
  String? laptopStatus;
  String? rollNo;
  int? batch;
  String? department;
  String? dob;
  String? collegeEssay;
  String? cgpa;
  String? native;
  String? marks10th;
  String? marks12th;
  String? report12th;
  String? report10th;
  String? otherreport;
  String? receipt;
  String? address;
  String? interest;
  String? laptopdateReceived;
  String? laptopDateApproved;
  String? laptopCost;
  bool? laptopReceivedByStudent;
  String? phno;
  String? imgsrc;
  List<Paymentstate>? paymentstate;

  DataUser(
      {this.id,
      this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.createdAt,
      this.updatedAt,
      this.laptopStatus,
      this.rollNo,
      this.batch,
      this.department,
      this.dob,
      this.collegeEssay,
      this.cgpa,
      this.native,
      this.marks10th,
      this.marks12th,
      this.report12th,
      this.report10th,
      this.otherreport,
      this.receipt,
      this.address,
      this.interest,
      this.laptopdateReceived,
      this.laptopDateApproved,
      this.laptopCost,
      required this.laptopReceivedByStudent,
      this.imgsrc,
      this.phno,
      this.paymentstate});

  DataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    laptopStatus = json['LaptopStatus'];
    rollNo = json['RollNo'];
    batch = json['batch'];
    department = json['department'];
    dob = json['dob'];
    collegeEssay = json['CollegeEssay'];
    cgpa = json['cgpa'];
    native = json['Native'];
    marks10th = json['Marks_10th'];
    marks12th = json['Marks_12th'];
    report12th = json['Report_12th'];
    report10th = json['Report_10th'];
    otherreport = json['otherDocument'];
    receipt = json['recipt'];
    address = json['address'];
    interest = json['interest'];
    laptopdateReceived = json['LaptopdateReceived'];
    laptopDateApproved = json['LaptopDateApproved'];
    laptopCost = json['LaptopCost'];
    laptopReceivedByStudent = json['LaptopReceivedByStudent'];
    phno = json['phno'];
    imgsrc = json['imgsrc'];
    if (json['paymentstate'] != null) {
      paymentstate = <Paymentstate>[];
      json['paymentstate'].forEach((v) {
        paymentstate!.add(new Paymentstate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['LaptopStatus'] = this.laptopStatus;
    data['RollNo'] = this.rollNo;
    data['batch'] = this.batch;
    data['department'] = this.department;
    data['dob'] = this.dob;
    data['CollegeEssay'] = this.collegeEssay;
    data['cgpa'] = this.cgpa;
    data['Native'] = this.native;
    data['Marks_10th'] = this.marks10th;
    data['Marks_12th'] = this.marks12th;
    data['Report_12th'] = this.report12th;
    data['Report_10th'] = this.report10th;
    data['otherDocument'] = this.otherreport;
    data['recipt'] = this.receipt;
    data['address'] = this.address;
    data['interest'] = this.interest;
    data['LaptopdateReceived'] = this.laptopdateReceived;
    data['LaptopDateApproved'] = this.laptopDateApproved;
    data['LaptopCost'] = this.laptopCost;
    data['LaptopReceivedByStudent'] = this.laptopReceivedByStudent;
    data['imgsrc'] = this.imgsrc;
    data['phno'] = this.phno;
    if (this.paymentstate != null) {
      data['paymentstate'] = this.paymentstate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paymentstate {
  int? id;
  String? date;
  String? amount;
  String? content;
  String? status;

  Paymentstate({this.id, this.date, this.amount, this.content, this.status});

  Paymentstate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    amount = json['amount'];
    content = json['content'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['content'] = this.content;
    data['status'] = this.status;
    return data;
  }


}
