class TaxModel {
  List<Data>? data;

  TaxModel({this.data});

  TaxModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? nO;
  String? tINNAME;
  String? tIN;
  String? oFFICECODE;
  String? tINTYPE;
  String? tINTYPEGROUP;
  String? bTYPE;
  String? mBTYPE;
  String? vILLAGE;
  String? aDDRESS;
  String? fULLADDRESS;
  String? mOBILENO;
  String? fAX;
  String? bDESC;
  String? tOTALASSET;
  String? rEGISTERASSET;
  String? bDOCS;
  String? iNCOMEYEARLY;
  String? tOTALTAXES;
  String? tAX01;
  String? tAX02;
  String? tAX03;
  String? tAX04;
  String? tAX05;
  String? tAXOTHER;
  String? nATIONAL;
  String? sTARTDATE;
  String? sTATUS;
  String? iMAGE;
  String? lOCATION;

  Data(
      {this.nO,
      this.tINNAME,
      this.tIN,
      this.oFFICECODE,
      this.tINTYPE,
      this.tINTYPEGROUP,
      this.bTYPE,
      this.mBTYPE,
      this.vILLAGE,
      this.aDDRESS,
      this.fULLADDRESS,
      this.mOBILENO,
      this.fAX,
      this.bDESC,
      this.tOTALASSET,
      this.rEGISTERASSET,
      this.bDOCS,
      this.iNCOMEYEARLY,
      this.tOTALTAXES,
      this.tAX01,
      this.tAX02,
      this.tAX03,
      this.tAX04,
      this.tAX05,
      this.tAXOTHER,
      this.nATIONAL,
      this.sTARTDATE,
      this.sTATUS,
      this.iMAGE,
      this.lOCATION});

  Data.fromJson(dynamic json) {
    nO = json['NO'];
    tINNAME = json['TIN_NAME'];
    tIN = json['TIN'];
    oFFICECODE = json['OFFICE_CODE'];
    tINTYPE = json['TIN_TYPE'];
    tINTYPEGROUP = json['TIN_TYPE_GROUP'];
    bTYPE = json['B_TYPE'];
    mBTYPE = json['MB_TYPE'];
    vILLAGE = json['VILLAGE'];
    aDDRESS = json['ADDRESS'];
    fULLADDRESS = json['FULL_ADDRESS'];
    mOBILENO = json['MOBILE_NO'];
    fAX = json['FAX'];
    bDESC = json['B_DESC'];
    tOTALASSET = json['TOTAL_ASSET'];
    rEGISTERASSET = json['REGISTER_ASSET'];
    bDOCS = json['B_DOCS'];
    iNCOMEYEARLY = json['INCOME_YEARLY'];
    tOTALTAXES = json['TOTAL_TAXES'];
    tAX01 = json['TAX01'];
    tAX02 = json['TAX02'];
    tAX03 = json['TAX03'];
    tAX04 = json['TAX04'];
    tAX05 = json['TAX05'];
    tAXOTHER = json['TAX_OTHER'];
    nATIONAL = json['NATIONAL'];
    sTARTDATE = json['START_DATE'];
    sTATUS = json['STATUS'];
    iMAGE = json['IMAGE'];
    lOCATION = json['LOCATION'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NO'] = this.nO;
    data['TIN_NAME'] = this.tINNAME;
    data['TIN'] = this.tIN;
    data['OFFICE_CODE'] = this.oFFICECODE;
    data['TIN_TYPE'] = this.tINTYPE;
    data['TIN_TYPE_GROUP'] = this.tINTYPEGROUP;
    data['B_TYPE'] = this.bTYPE;
    data['MB_TYPE'] = this.mBTYPE;
    data['VILLAGE'] = this.vILLAGE;
    data['ADDRESS'] = this.aDDRESS;
    data['FULL_ADDRESS'] = this.fULLADDRESS;
    data['MOBILE_NO'] = this.mOBILENO;
    data['FAX'] = this.fAX;
    data['B_DESC'] = this.bDESC;
    data['TOTAL_ASSET'] = this.tOTALASSET;
    data['REGISTER_ASSET'] = this.rEGISTERASSET;
    data['B_DOCS'] = this.bDOCS;
    data['INCOME_YEARLY'] = this.iNCOMEYEARLY;
    data['TOTAL_TAXES'] = this.tOTALTAXES;
    data['TAX01'] = this.tAX01;
    data['TAX02'] = this.tAX02;
    data['TAX03'] = this.tAX03;
    data['TAX04'] = this.tAX04;
    data['TAX05'] = this.tAX05;
    data['TAX_OTHER'] = this.tAXOTHER;
    data['NATIONAL'] = this.nATIONAL;
    data['START_DATE'] = this.sTARTDATE;
    data['STATUS'] = this.sTATUS;
    data['IMAGE'] = this.iMAGE;
    data['LOCATION'] = this.lOCATION;
    return data;
  }
}
