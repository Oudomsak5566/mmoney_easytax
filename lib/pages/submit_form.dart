import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easytax/helper/DioService.dart';
import 'package:easytax/helper/WaitingProcess.dart';
import 'package:easytax/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/LocationProvider.dart';

class SubmitForm extends StatefulWidget {
  final String tinID;
  const SubmitForm({Key? key, required this.tinID}) : super(key: key);

  @override
  State<SubmitForm> createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  File? img;
  // DateTime? birtday;
  final picker = ImagePicker();
  Future getImage() async {
    try {
      final pickedFile =
          await picker.getImage(source: ImageSource.camera, imageQuality: 10);
      if (pickedFile!.path.isEmpty) {
        print("NO Image");
      } else {
        setState(() {
          img = File(pickedFile.path);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Tax Info"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MaterialButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Text(
                    "Take Picture",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                img == null
                    ? Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(Icons.image, size: 50, color: Colors.white),
                      )
                    : Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(img!), fit: BoxFit.fill),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                      ),
              ],
            ),
            Text(
              'Provinces',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Text(
                      'Select Provinces',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: mainProvider.provinceModel!.data!
                        .map((item) => DropdownMenuItem<String>(
                              value: item.aDDRCD,
                              child: Text(
                                item.aDDRCDNM!,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList(),
                    value: mainProvider.selectedValuePro,
                    onChanged: (value) {
                      mainProvider.selectedPro(value.toString(), context);
                    },
                    buttonHeight: 40,
                    buttonWidth: double.infinity,
                    itemHeight: 40,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Visibility(
              visible: mainProvider.districtsModel != null,
              child: Text(
                'District',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            mainProvider.districtsModel == null
                ? Container()
                : Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            'Select District',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: mainProvider.districtsModel!.data!
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.aDDRCD,
                                    child: Text(
                                      item.aDDRCDNM!,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                              .toList(),
                          value: mainProvider.selectedValueDis,
                          onChanged: (value) {
                            mainProvider.selectedDis(value.toString(), context);
                          },
                          buttonHeight: 40,
                          buttonWidth: double.infinity,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 8),
            Visibility(
              visible: mainProvider.villageModel != null,
              child: Text(
                'Village',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            mainProvider.villageModel == null
                ? Container()
                : Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            'Select Village',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: mainProvider.villageModel!.data!
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.aDDRCD,
                                    child: Text(
                                      item.aDDRCDNM!,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                              .toList(),
                          value: mainProvider.selectedValueVil,
                          onChanged: (value) {
                            mainProvider.selectedVil(value.toString());
                          },
                          buttonHeight: 40,
                          buttonWidth: double.infinity,
                          itemHeight: 40,
                        ),
                      ),
                    ),
                  ),
            mainProvider.selectedValueVil == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8),
                    child: MaterialButton(
                      onPressed: () async {
                        if (img == null) {
                          CoolAlert.show(
                              backgroundColor: Colors.blue,
                              context: context,
                              type: CoolAlertType.warning,
                              title: 'Waring',
                              text: "Please Take a Picture",
                              loopAnimation: false,
                              barrierDismissible: false,
                              confirmBtnText: "ຕົກລົງ",
                              confirmBtnColor: Colors.red,
                              confirmBtnTextStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ));
                        } else {
                          Waiting.show(context);
                          List<int> imageBytes = img!.readAsBytesSync();
                          String base64Image = base64Encode(imageBytes);

                          // var data = {
                          //   "tin": widget.tinID,
                          //   "username": mainProvider.authModel!.username!,
                          //   "locations": locationProvider.latLngMarker == null
                          //       ? "${locationProvider.latLngPosition!.latitude}, ${locationProvider.latLngPosition!.longitude}"
                          //       : "${locationProvider.latLngMarker!.latitude}, ${locationProvider.latLngMarker!.longitude}",
                          //   "ADDR_CD_VILLAGE": mainProvider.selectedValueVil,
                          // };

                          //form data ----
                          String fileName = img!.path.split('/').last;
                          print(img!.path);
                          print(fileName);

                          // FormData formData = new FormData.fromMap({
                          //   "tin": widget.tinID,
                          //   "username": mainProvider.authModel!.username!,
                          //   "locations": locationProvider.latLngMarker == null
                          //       ? "${locationProvider.latLngPosition!.latitude}, ${locationProvider.latLngPosition!.longitude}"
                          //       : "${locationProvider.latLngMarker!.latitude}, ${locationProvider.latLngMarker!.longitude}",
                          //   "ADDR_CD_VILLAGE": mainProvider.selectedValueVil,
                          //   'image': [
                          //     MultipartFile.fromString('.${img!.path}',
                          //         filename: fileName),
                          //   ],
                          // });
                          var formData = FormData.fromMap({
                            "tin": widget.tinID,
                            "username": mainProvider.authModel!.username!,
                            "locations": locationProvider.latLngMarker == null
                                ? "${locationProvider.latLngPosition!.latitude}, ${locationProvider.latLngPosition!.longitude}"
                                : "${locationProvider.latLngMarker!.latitude}, ${locationProvider.latLngMarker!.longitude}",
                            "ADDR_CD_VILLAGE": mainProvider.selectedValueVil,
                            'image': await MultipartFile.fromFile(
                                '.${img!.path}',
                                filename: fileName),
                          });
                          print('### formData ====> $formData');

                          DioService.createDioToken(
                                  body: formData,
                                  path: "easyTax_updateLocation",
                                  token: mainProvider.authModel!.token!)
                              .then((value) {
                            print("Data: " + value.toString());
                            Waiting.hide(context);
                            if (value['resultCode'] == "200") {
                              CoolAlert.show(
                                  backgroundColor: Colors.blue,
                                  context: context,
                                  type: CoolAlertType.success,
                                  title: 'Success',
                                  text: "Operation Success.",
                                  loopAnimation: false,
                                  barrierDismissible: false,
                                  confirmBtnText: "ຕົກລົງ",
                                  onConfirmBtnTap: () {
                                    mainProvider
                                        .getTinInfo(widget.tinID)
                                        .whenComplete(() {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    });
                                  },
                                  confirmBtnColor: Colors.green,
                                  confirmBtnTextStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ));
                            } else {
                              CoolAlert.show(
                                  backgroundColor: Colors.blue,
                                  context: context,
                                  type: CoolAlertType.error,
                                  title: 'Error',
                                  text: "Operation Error.",
                                  loopAnimation: false,
                                  barrierDismissible: false,
                                  confirmBtnText: "ຕົກລົງ",
                                  confirmBtnColor: Colors.red,
                                  confirmBtnTextStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ));
                            }
                          });
                        }
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 45,
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
