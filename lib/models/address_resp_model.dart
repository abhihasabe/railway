class AddressResp {
  int? success;
  String? message;
  List<AddressData>? data;

  AddressResp({this.success, this.message, this.data});

  AddressResp.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(new AddressData.fromJson(v));
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

class AddressData {
  int? id;
  String? latitude;
  String? longitude;
  String? time;
  int? eId;

  AddressData({this.id, this.latitude, this.longitude, this.time, this.eId});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    time = json['time'];
    eId = json['eId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['time'] = this.time;
    data['eId'] = this.eId;
    return data;
  }
}