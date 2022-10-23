class usertracking {
  List<DataUser>? dataUser;

  usertracking({this.dataUser});

  usertracking.fromJson(List json) {
    if (json != null) {
      dataUser = <DataUser>[];
      json.forEach((v) {
        dataUser!.add(new DataUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataUser != null) {
      data['dataUser'] = this.dataUser!.map((v) => v.toJson()).toList();
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
  String? rollNo;
  int? batch;
  String? department;
  String? collegeEssay;
  String? cgpa;
  String? native;
  String? marks10th;
  String? marks12th;
  String? report12th;
  String? report10th;
  String? address;
  String? interest;
  String? dob;
  String? laptopCost;
  bool? laptopReceivedByStudent;
  String? laptopStatus;
  String? phno;
  String? imgsrc;
  String? laptopDateApproved;
  String? laptopdateReceived;
  Null? lastUpdate;
  List<StatusUpdate>? statusUpdate;
  String? createdAt;
  String? updatedAt;
  String? githubUsername;

  DataUser(
      {this.id,
      this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.rollNo,
      this.batch,
      this.department,
      this.collegeEssay,
      this.cgpa,
      this.native,
      this.marks10th,
      this.marks12th,
      this.report12th,
      this.report10th,
      this.address,
      this.interest,
      this.dob,
      this.laptopCost,
      this.laptopReceivedByStudent,
      this.laptopStatus,
      this.phno,
      this.imgsrc,
      this.laptopDateApproved,
      this.laptopdateReceived,
      this.lastUpdate,
      this.statusUpdate,
      this.createdAt,
      this.updatedAt,
      this.githubUsername});

  DataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    rollNo = json['RollNo'];
    batch = json['batch'];
    department = json['department'];
    collegeEssay = json['CollegeEssay'];
    cgpa = json['cgpa'];
    native = json['Native'];
    marks10th = json['Marks_10th'];
    marks12th = json['Marks_12th'];
    report12th = json['Report_12th'];
    report10th = json['Report_10th'];
    address = json['address'];
    interest = json['interest'];
    dob = json['dob'];
    laptopCost = json['LaptopCost'];
    laptopReceivedByStudent = json['LaptopReceivedByStudent'];
    laptopStatus = json['LaptopStatus'];
    phno = json['phno'];
    imgsrc = json['imgsrc'];
    laptopDateApproved = json['LaptopDateApproved'];
    laptopdateReceived = json['LaptopdateReceived'];
    lastUpdate = json['lastUpdate'];
    if (json['statusUpdate'] != null) {
      statusUpdate = <StatusUpdate>[];
      json['statusUpdate'].forEach((v) {
        statusUpdate!.add(new StatusUpdate.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    githubUsername = json['githubUsername'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['RollNo'] = this.rollNo;
    data['batch'] = this.batch;
    data['department'] = this.department;
    data['CollegeEssay'] = this.collegeEssay;
    data['cgpa'] = this.cgpa;
    data['Native'] = this.native;
    data['Marks_10th'] = this.marks10th;
    data['Marks_12th'] = this.marks12th;
    data['Report_12th'] = this.report12th;
    data['Report_10th'] = this.report10th;
    data['address'] = this.address;
    data['interest'] = this.interest;
    data['dob'] = this.dob;
    data['LaptopCost'] = this.laptopCost;
    data['LaptopReceivedByStudent'] = this.laptopReceivedByStudent;
    data['LaptopStatus'] = this.laptopStatus;
    data['phno'] = this.phno;
    data['imgsrc'] = this.imgsrc;
    data['LaptopDateApproved'] = this.laptopDateApproved;
    data['LaptopdateReceived'] = this.laptopdateReceived;
    data['lastUpdate'] = this.lastUpdate;
    if (this.statusUpdate != null) {
      data['statusUpdate'] = this.statusUpdate!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['githubUsername'] = this.githubUsername;
    return data;
  }
}

class StatusUpdate {
  String? date;
  String? content;

  StatusUpdate({this.date, this.content});

  StatusUpdate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['content'] = this.content;
    return data;
  }
}
