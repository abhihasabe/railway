class LoginResp {
  int? success;
  String? message;
  Data? data;

  LoginResp({this.success, this.message, this.data});

  LoginResp.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? deptId;
  String? password;
  int? userType;
  int? activation;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.deptId,
        this.password,
        this.userType,
        this.activation});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = this.id;
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