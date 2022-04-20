class AddAddressReq {
  String? latitude;
  String? longitude;
  String? time;
  String? eId;

  AddAddressReq({this.latitude, this.longitude, this.time, this.eId});

  AddAddressReq.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    time = json['time'];
    eId = json['eId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['time'] = this.time;
    data['eId'] = this.eId;
    return data;
  }
}