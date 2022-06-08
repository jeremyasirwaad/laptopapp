class totalreceived {
  List<Data> data;
  Meta meta;

  totalreceived({this.data, this.meta});

  totalreceived.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  Attributes attributes;

  Data({this.id, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    return data;
  }
}

class Attributes {
  String createdAt;
  String updatedAt;
  String publishedAt;
  String status;
  Users users;

  Attributes(
      {this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.status,
      this.users});

  Attributes.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    status = json['status'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['status'] = this.status;
    if (this.users != null) {
      data['users'] = this.users.toJson();
    }
    return data;
  }
}

class Users {
  List<Data> data;

  Users({this.data});

  Users.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  String username;
  String email;
  String provider;
  bool confirmed;
  bool blocked;
  String createdAt;
  String updatedAt;
  String githubUsername;
  SkillProgress skillProgress;
  SkillProgress updateProgress;

  Attributes(
      {this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.createdAt,
      this.updatedAt,
      this.githubUsername,
      this.skillProgress,
      this.updateProgress});

  Attributes.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    provider = json['provider'];
    confirmed = json['confirmed'];
    blocked = json['blocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    githubUsername = json['githubUsername'];
    skillProgress = json['skillProgress'] != null
        ? new SkillProgress.fromJson(json['skillProgress'])
        : null;
    updateProgress = json['updateProgress'] != null
        ? new SkillProgress.fromJson(json['updateProgress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['confirmed'] = this.confirmed;
    data['blocked'] = this.blocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['githubUsername'] = this.githubUsername;
    if (this.skillProgress != null) {
      data['skillProgress'] = this.skillProgress.toJson();
    }
    if (this.updateProgress != null) {
      data['updateProgress'] = this.updateProgress.toJson();
    }
    return data;
  }
}

class SkillProgress {
  Data data;

  SkillProgress({this.data});

  SkillProgress.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Attributes {
  String createdAt;
  String updatedAt;
  String publishedAt;
  String skillProgress;

  Attributes(
      {this.createdAt, this.updatedAt, this.publishedAt, this.skillProgress});

  Attributes.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    skillProgress = json['skillProgress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['skillProgress'] = this.skillProgress;
    return data;
  }
}

class Attributes {
  String updateProgress;
  String createdAt;
  String updatedAt;
  String publishedAt;

  Attributes(
      {this.updateProgress, this.createdAt, this.updatedAt, this.publishedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    updateProgress = json['updateProgress'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updateProgress'] = this.updateProgress;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}

class Meta {
  Pagination pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class Pagination {
  int page;
  int pageSize;
  int pageCount;
  int total;

  Pagination({this.page, this.pageSize, this.pageCount, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['pageCount'] = this.pageCount;
    data['total'] = this.total;
    return data;
  }
}