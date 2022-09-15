class DistrictModel {
  String? message;
  List<Data>? data;
  bool? status;

  DistrictModel({this.message, this.data, this.status});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? aDDRLVLTP;
  String? aDDRCD;
  String? aDDRCDNM;

  Data({this.aDDRLVLTP, this.aDDRCD, this.aDDRCDNM});

  Data.fromJson(Map<String, dynamic> json) {
    aDDRLVLTP = json['ADDR_LVL_TP'];
    aDDRCD = json['ADDR_CD'];
    aDDRCDNM = json['ADDR_CD_NM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ADDR_LVL_TP'] = this.aDDRLVLTP;
    data['ADDR_CD'] = this.aDDRCD;
    data['ADDR_CD_NM'] = this.aDDRCDNM;
    return data;
  }
}
