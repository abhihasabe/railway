class ZoneResp {
  int? success;
  String? message;
  List<ZoneData>? data;

  ZoneResp({this.success, this.message, this.data});

  ZoneResp.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ZoneData>[];
      json['data'].forEach((v) {
        data!.add(new ZoneData.fromJson(v));
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

class ZoneData {
  int? zid;
  String? zname;
  int? rid;

  ZoneData({this.zid, this.zname, this.rid});

  ZoneData.fromJson(Map<String, dynamic> json) {
    zid = json['zid'];
    zname = json['zname'];
    rid = json['rid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zid'] = this.zid;
    data['zname'] = this.zname;
    data['rid'] = this.rid;
    return data;
  }
}
