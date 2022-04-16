class RegReqModel {
  String? name;
  String? email;
  String? phone;
  String? deptId;
  String? password;
  String? user_type;

  RegReqModel(
      {this.name,
      this.email,
      this.phone,
      this.deptId,
      this.password,
      this.user_type});

  RegReqModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    deptId = json['dept_id'];
    password = json['password'];
    user_type = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dept_id'] = this.deptId;
    data['password'] = this.password;
    data['user_type'] = this.user_type;
    return data;
  }
}
