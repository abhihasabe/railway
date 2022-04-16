
class EmpResp {
  int? success;
  String? message;
  List<EmpData>? data;

  EmpResp({this.success, this.message, this.data});

  EmpResp.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EmpData>[];
      json['data'].forEach((v) {
        data!.add(new EmpData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmpData {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? deptId;
  String? password;
  int? userType;
  int? activation;

  EmpData(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.deptId,
        this.password,
        this.userType,
        this.activation});

  EmpData.fromJson(Map<String, dynamic> json) {
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