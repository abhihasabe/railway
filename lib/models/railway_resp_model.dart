class RailwayResp {
  int? success;
  String? message;
  List<RailwayData>? data;

  RailwayResp({this.success, this.message, this.data});

  RailwayResp.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RailwayData>[];
      json['data'].forEach((v) {
        data!.add(new RailwayData.fromJson(v));
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

class RailwayData {
  int? rId;
  String? rname;

  RailwayData({this.rId, this.rname});

  RailwayData.fromJson(Map<String, dynamic> json) {
    rId = json['rId'];
    rname = json['rname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rId'] = this.rId;
    data['rname'] = this.rname;
    return data;
  }
}