// class TinInfoModel {
//   String? message;
//   Data? data;
//   bool? status;

//   TinInfoModel({this.message, this.data, this.status});

//   TinInfoModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['status'] = this.status;
//     return data;
//   }
// }

// class Data {
//   String? oRGCD;
//   String? oRGCDNM;
//   String? tIN;
//   String? cONM;
//   String? tELNO;
//   String? eTPSFORMKINDTPNM;
//   String? mOICETPSID;
//   String? eRCNO;
//   String? eRCISSUDD;
//   String? bUSNTPNM;
//   String? mAINBUSNSECTTPNM;
//   String? mAINLSICCD;
//   String? bASICADDRNM;
//   String? oPRSTDD;
//   String? bUSNOPRSTATTP;
//   String? fILINGYN;
//   String? pAYYN;
//   String? aDDRLOCATION;
//   String? aDDRIMG;

//   Data(
//       {this.oRGCD,
//       this.oRGCDNM,
//       this.tIN,
//       this.cONM,
//       this.tELNO,
//       this.eTPSFORMKINDTPNM,
//       this.mOICETPSID,
//       this.eRCNO,
//       this.eRCISSUDD,
//       this.bUSNTPNM,
//       this.mAINBUSNSECTTPNM,
//       this.mAINLSICCD,
//       this.bASICADDRNM,
//       this.oPRSTDD,
//       this.bUSNOPRSTATTP,
//       this.fILINGYN,
//       this.pAYYN,
//       this.aDDRLOCATION,
//       this.aDDRIMG});

//   Data.fromJson(Map<String, dynamic> json) {
//     oRGCD = json['ORG_CD'];
//     oRGCDNM = json['ORG_CD_NM'];
//     tIN = json['TIN'];
//     cONM = json['CO_NM'];
//     tELNO = json['TEL_NO'];
//     eTPSFORMKINDTPNM = json['ETPS_FORM_KIND_TP_NM'];
//     mOICETPSID = json['MOIC_ETPS_ID'];
//     eRCNO = json['ERC_NO'];
//     eRCISSUDD = json['ERC_ISSU_DD'];
//     bUSNTPNM = json['BUSN_TP_NM'];
//     mAINBUSNSECTTPNM = json['MAIN_BUSN_SECT_TP_NM'];
//     mAINLSICCD = json['MAIN_LSIC_CD'];
//     bASICADDRNM = json['BASIC_ADDR_NM'];
//     oPRSTDD = json['OPR_ST_DD'];
//     bUSNOPRSTATTP = json['BUSN_OPR_STAT_TP'];
//     fILINGYN = json['FILING_YN'];
//     pAYYN = json['PAY_YN'];
//     aDDRLOCATION = json['ADDR_LOCATION'];
//     aDDRIMG = json['ADDR_IMG'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ORG_CD'] = this.oRGCD;
//     data['ORG_CD_NM'] = this.oRGCDNM;
//     data['TIN'] = this.tIN;
//     data['CO_NM'] = this.cONM;
//     data['TEL_NO'] = this.tELNO;
//     data['ETPS_FORM_KIND_TP_NM'] = this.eTPSFORMKINDTPNM;
//     data['MOIC_ETPS_ID'] = this.mOICETPSID;
//     data['ERC_NO'] = this.eRCNO;
//     data['ERC_ISSU_DD'] = this.eRCISSUDD;
//     data['BUSN_TP_NM'] = this.bUSNTPNM;
//     data['MAIN_BUSN_SECT_TP_NM'] = this.mAINBUSNSECTTPNM;
//     data['MAIN_LSIC_CD'] = this.mAINLSICCD;
//     data['BASIC_ADDR_NM'] = this.bASICADDRNM;
//     data['OPR_ST_DD'] = this.oPRSTDD;
//     data['BUSN_OPR_STAT_TP'] = this.bUSNOPRSTATTP;
//     data['FILING_YN'] = this.fILINGYN;
//     data['PAY_YN'] = this.pAYYN;
//     data['ADDR_LOCATION'] = this.aDDRLOCATION;
//     data['ADDR_IMG'] = this.aDDRIMG;
//     return data;
//   }
// }
class TinInfoModel {
  String? message;
  Data? data;
  bool? status;

  TinInfoModel({this.message, this.data, this.status});

  TinInfoModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? oRGCD;
  String? oRGCDNM;
  String? tIN;
  String? cONM;
  String? bASICADDRNM;
  String? fILINGYN;
  String? pAYYN;
  String? aDDRLOCATION;
  String? aDDRIMG;

  Data(
      {this.oRGCD,
      this.oRGCDNM,
      this.tIN,
      this.cONM,
      this.bASICADDRNM,
      this.fILINGYN,
      this.pAYYN,
      this.aDDRLOCATION,
      this.aDDRIMG});

  Data.fromJson(Map<String, dynamic> json) {
    oRGCD = json['ORG_CD'];
    oRGCDNM = json['ORG_CD_NM'];
    tIN = json['TIN'];
    cONM = json['CO_NM'];
    bASICADDRNM = json['BASIC_ADDR_NM'];
    fILINGYN = json['FILING_YN'];
    pAYYN = json['PAY_YN'];
    aDDRLOCATION = json['ADDR_LOCATION'];
    aDDRIMG = json['ADDR_IMG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ORG_CD'] = this.oRGCD;
    data['ORG_CD_NM'] = this.oRGCDNM;
    data['TIN'] = this.tIN;
    data['CO_NM'] = this.cONM;
    data['BASIC_ADDR_NM'] = this.bASICADDRNM;
    data['FILING_YN'] = this.fILINGYN;
    data['PAY_YN'] = this.pAYYN;
    data['ADDR_LOCATION'] = this.aDDRLOCATION;
    data['ADDR_IMG'] = this.aDDRIMG;
    return data;
  }
}
