class AuthModel {
  String? username;
  String? oRGCD;
  String? oRGName;
  String? token;
  String? message;
  bool? status;
  String? expiresIn;

  AuthModel(
      {this.username,
      this.oRGCD,
      this.oRGName,
      this.token,
      this.message,
      this.status,
      this.expiresIn});

  AuthModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    oRGCD = json['ORG_CD'];
    oRGName = json['ORG_Name'];
    token = json['token'];
    message = json['message'];
    status = json['status'];
    expiresIn = json['expiresIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['ORG_CD'] = this.oRGCD;
    data['ORG_Name'] = this.oRGName;
    data['token'] = this.token;
    data['message'] = this.message;
    data['status'] = this.status;
    data['expiresIn'] = this.expiresIn;
    return data;
  }
}
