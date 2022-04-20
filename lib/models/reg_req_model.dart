class RegReqModel {
  String? name;
  String? email;
  String? phone;
  int? deptId;
  String? password;
  int? userType;
  int? activation;

  RegReqModel(
      {this.name,
      this.email,
      this.phone,
      this.deptId,
      this.password,
      this.userType,
      this.activation});

  RegReqModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    deptId = json['dept_id'];
    password = json['password'];
    userType = json['user_type'];
    activation = json['activation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dept_id'] = this.deptId;
    data['password'] = this.password;
    data['user_type'] = this.userType;
    data['activation'] = this.activation;
    return data;
  }
}
