class received {
  List<Datar>? datar;

  received({this.datar});

  received.fromJson(List json) {
    if (json != null) {
      datar = <Datar>[];
      json.forEach((v) {
        datar!.add(new Datar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datar != null) {
      data['datar'] = this.datar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datar {
  int? id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  String? createdAt;
  String? updatedAt;
  String? phoneNumber;
  String? displayName;
  String? profilePicture;
  String? githubUsername;
  LaptopStatus? laptopStatus;
  UpdateProgress? updateProgress;
  SkillProgress? skillProgress;
  AcademicDetail? academicDetail;

  Datar(
      {this.id,
      this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.createdAt,
      this.updatedAt,
      this.phoneNumber,
      this.displayName,
      this.profilePicture,
      this.githubUsername,
      this.laptopStatus,
      this.updateProgress,
      this.skillProgress,
      this.academicDetail});

  Datar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    phoneNumber = json['phoneNumber'];
    displayName = json['displayName'];
    profilePicture = json['profilePicture'];
    githubUsername = json['githubUsername'];
    laptopStatus = json['laptopStatus'] != null
        ? new LaptopStatus.fromJson(json['laptopStatus'])
        : null;
    updateProgress = json['updateProgress'] != null
        ? new UpdateProgress.fromJson(json['updateProgress'])
        : null;
    skillProgress = json['skillProgress'] != null
        ? new SkillProgress.fromJson(json['skillProgress'])
        : null;
    academicDetail = json['academicDetail'] != null
        ? new AcademicDetail.fromJson(json['academicDetail'])
        : null;
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
    data['phoneNumber'] = this.phoneNumber;
    data['displayName'] = this.displayName;
    data['profilePicture'] = this.profilePicture;
    data['githubUsername'] = this.githubUsername;
    if (this.laptopStatus != null) {
      data['laptopStatus'] = this.laptopStatus!.toJson();
    }
    if (this.updateProgress != null) {
      data['updateProgress'] = this.updateProgress!.toJson();
    }
    if (this.skillProgress != null) {
      data['skillProgress'] = this.skillProgress!.toJson();
    }
    if (this.academicDetail != null) {
      data['academicDetail'] = this.academicDetail!.toJson();
    }
    return data;
  }
}

class LaptopStatus {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? status;

  LaptopStatus(
      {this.id, this.createdAt, this.updatedAt, this.publishedAt, this.status});

  LaptopStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['status'] = this.status;
    return data;
  }
}

class UpdateProgress {
  int? id;
  String? updateProgress;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  UpdateProgress(
      {this.id,
      this.updateProgress,
      this.createdAt,
      this.updatedAt,
      this.publishedAt});

  UpdateProgress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updateProgress = json['updateProgress'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['updateProgress'] = this.updateProgress;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}

class SkillProgress {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? skillProgress;

  SkillProgress(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.skillProgress});

  SkillProgress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    skillProgress = json['skillProgress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['skillProgress'] = this.skillProgress;
    return data;
  }
}

class AcademicDetail {
  int? id;
  String? rollNumber;
  String? batch;
  String? department;
  String? dob;
  String? cgpa;
  String? collegeEssay;
  String? native;
  String? marks10th;
  String? marks12th;
  String? marksheet10th;
  String? marksheet12th;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  AcademicDetail(
      {this.id,
      this.rollNumber,
      this.batch,
      this.department,
      this.dob,
      this.cgpa,
      this.collegeEssay,
      this.native,
      this.marks10th,
      this.marks12th,
      this.marksheet10th,
      this.marksheet12th,
      this.createdAt,
      this.updatedAt,
      this.publishedAt});

  AcademicDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rollNumber = json['rollNumber'];
    batch = json['batch'];
    department = json['department'];
    dob = json['dob'];
    cgpa = json['cgpa'];
    collegeEssay = json['collegeEssay'];
    native = json['native'];
    marks10th = json['marks_10th'];
    marks12th = json['marks_12th'];
    marksheet10th = json['marksheet_10th'];
    marksheet12th = json['marksheet_12th'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rollNumber'] = this.rollNumber;
    data['batch'] = this.batch;
    data['department'] = this.department;
    data['dob'] = this.dob;
    data['cgpa'] = this.cgpa;
    data['collegeEssay'] = this.collegeEssay;
    data['native'] = this.native;
    data['marks_10th'] = this.marks10th;
    data['marks_12th'] = this.marks12th;
    data['marksheet_10th'] = this.marksheet10th;
    data['marksheet_12th'] = this.marksheet12th;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}
