class StationLocationByIdResp {
  int? success;
  String? message;
  List<StationLocationData>? data;

  StationLocationByIdResp({this.success, this.message, this.data});

  StationLocationByIdResp.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StationLocationData>[];
      json['data'].forEach((v) {
        data!.add(new StationLocationData.fromJson(v));
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

class StationLocationData {
  int? id;
  String? name;
  String? deptLocationLat;
  String? deptLocationLong;
  int? dId;

  StationLocationData(
      {this.id, this.name, this.deptLocationLat, this.deptLocationLong});

  StationLocationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    deptLocationLat = json['dept_location_lat'];
    deptLocationLong = json['dept_location_long'];
    dId = json['dId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dept_location_lat'] = this.deptLocationLat;
    data['dept_location_long'] = this.deptLocationLong;
    data['dId'] = this.dId;
    return data;
  }
}
