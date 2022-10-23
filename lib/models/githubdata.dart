class githubdata {
  String? username;
  int? totalContributions;
 
  int? weeklyContributionsSum;
  int? dailyContributions;

  githubdata(
      {this.username,
      this.totalContributions,
    
      this.weeklyContributionsSum,
      this.dailyContributions});

  githubdata.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    totalContributions = json['totalContributions'];
 
    weeklyContributionsSum = json['weeklyContributionsSum'];
    dailyContributions = json['dailyContributions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['totalContributions'] = this.totalContributions;
  
    data['weeklyContributionsSum'] = this.weeklyContributionsSum;
    data['dailyContributions'] = this.dailyContributions;
    return data;
  }
}