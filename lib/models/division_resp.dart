class DivisionResp {
  int? success;
  String? message;
  List<DivisionData>? data;

  DivisionResp({this.success, this.message, this.data});

  DivisionResp.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DivisionData>[];
      json['data'].forEach((v) {
        data!.add(new DivisionData.fromJson(v));
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

class DivisionData {
  int? dId;
  String? dname;
  int? zid;

  DivisionData({this.dId, this.dname, this.zid});

  DivisionData.fromJson(Map<String, dynamic> json) {
    dId = json['dId'];
    dname = json['dname'];
    zid = json['zid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dId'] = this.dId;
    data['dname'] = this.dname;
    data['zid'] = this.zid;
    return data;
  }
}