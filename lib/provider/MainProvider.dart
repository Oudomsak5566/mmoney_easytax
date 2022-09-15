import 'dart:developer';

import 'package:easytax/helper/DioService.dart';
import 'package:easytax/helper/WaitingProcess.dart';
import 'package:easytax/model/TaxModel.dart';
import 'package:easytax/model/auth_model.dart';
import 'package:easytax/model/district_model.dart';
import 'package:easytax/model/province_model.dart';
import 'package:easytax/model/tin_info_model.dart';
import 'package:easytax/model/village_model.dart';
import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  TaxModel? taxModel1;
  AuthModel? authModel;
  TinInfoModel? tinInfoModel;
  ProvinceModel? provinceModel;
  DistrictModel? districtsModel;
  VillageModel? villageModel;
  String? selectedValuePro;
  String? selectedValueDis;
  String? selectedValueVil;

  Future setValue() async {
    selectedValuePro = null;
    selectedValueDis = null;
    provinceModel = null;
    districtsModel = null;
    villageModel = null;
    selectedValueVil = null;
    notifyListeners();
  }

  void selectedPro(String val, BuildContext context) {
    Waiting.show(context);
    selectedValuePro = val;
    selectedValueDis = null;
    districtsModel = null;
    villageModel = null;
    selectedValueVil = null;

    fetchDistricts(val).whenComplete(() {
      Waiting.hide(context);
    });

    notifyListeners();
  }

  void selectedDis(String val, BuildContext context) {
    Waiting.show(context);
    selectedValueDis = val;
    villageModel = null;
    selectedValueVil = null;
    fetchVillages(val).whenComplete(() => Waiting.hide(context));
    // log("ID: $val");
    notifyListeners();
  }

  void selectedVil(String val) {
    selectedValueVil = val;
    notifyListeners();
  }

  Future searchTIN(String? search) async {
    taxModel1 = TaxModel.fromJson(await DioService.createDio(
        body: {"TIN": search}, path: "easyTax_list"));
    notifyListeners();
  }

  Future login(String? user, String? pass) async {
    authModel = AuthModel.fromJson(await DioService.createDio(
        body: {"username": user, "password": pass}, path: "login"));
    notifyListeners();
  }

  Future getTinInfo(String searc) async {
    tinInfoModel = TinInfoModel.fromJson(await DioService.createDioToken(body: {
      "TIN": searc,
      // "ORG_CD": authModel!.oRGCD!,
      "USER_ID": authModel!.username!
    }, path: "tin_info_app", token: authModel!.token!));
    // }, path: "tin_info", token: authModel!.token!));

    print('token ===> ${authModel!.token!}');
    notifyListeners();
  }

  Future fetchProvince() async {
    provinceModel = ProvinceModel.fromJson(await DioService.createDioToken(
        path: "provinces", token: authModel!.token!));
    notifyListeners();
  }

  Future fetchDistricts(String disID) async {
    districtsModel = DistrictModel.fromJson(await DioService.createDioToken(
        path: "districts",
        body: {"ADDR_CD_PROVINCE": disID},
        token: authModel!.token!));
    // log(jsonEncode(districtsModel));
    notifyListeners();
  }

  Future fetchVillages(String vilID) async {
    villageModel = VillageModel.fromJson(await DioService.createDioToken(
        path: "villages",
        body: {"ADDR_CD_DISCTRICT": vilID},
        token: authModel!.token!));
    // log(jsonEncode(villageModel));
    notifyListeners();
  }
}
