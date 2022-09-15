import 'dart:async';
import 'dart:io';

import 'package:easytax/pages/submit_form.dart';
import 'package:easytax/provider/LocationProvider.dart';
import 'package:easytax/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class MarkLocationFormPage extends StatefulWidget {
  final String? tinID;
  const MarkLocationFormPage({Key? key, this.tinID}) : super(key: key);

  @override
  _MarkLocationFormPageState createState() => _MarkLocationFormPageState();
}

class _MarkLocationFormPageState extends State<MarkLocationFormPage> {
  GlobalKey<ScaffoldState> scafoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapCOntrooler;
  double bottomPaddingOfMap = 0;
  Set<Marker> _markers = Set();
  LatLng? newLocation;
  void _onAddMarkerButtonPressed(LatLng latlang) {
    Provider.of<LocationProvider>(context, listen: false)
        .setLatLngMaker(latlang);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("id"),
        position: latlang,
        infoWindow: InfoWindow(
          title: latlang.toString(),
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

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
      key: scafoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Stack(
                children: [
                  GoogleMap(
                    markers: _markers,
                    onTap: (latlang) {
                      if (_markers.length >= 1) {
                        _markers.clear();
                      }
                      _onAddMarkerButtonPressed(latlang);
                    },
                    padding:
                        EdgeInsets.only(bottom: bottomPaddingOfMap, top: 30),
                    mapType: MapType.satellite,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(locationProvider.latLngPosition!.latitude,
                          locationProvider.latLngPosition!.longitude),
                      zoom: 16,
                    ),
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _onAddMarkerButtonPressed(LatLng(
                          locationProvider.latLngPosition!.latitude,
                          locationProvider.latLngPosition!.longitude));
                      _controllerGoogleMap.complete(controller);
                      newGoogleMapCOntrooler = controller;
                      setState(() {
                        bottomPaddingOfMap = 10;
                      });
                    },
                    onCameraIdle: () {
                      // GoogleMapService.searchCoordinateAddress(
                      //     newLocation!, context, args.choosePickUp); ຕອນຢຸດ
                    },
                    onCameraMove: (position) {
                      setState(() {
                        newLocation = position.target;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Your location marker is",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        locationProvider.latLngMarker == null
                            ? "${locationProvider.latLngPosition!.latitude}, ${locationProvider.latLngPosition!.longitude}"
                            : "${locationProvider.latLngMarker!.latitude}, ${locationProvider.latLngMarker!.longitude}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: MaterialButton(
                              color: Colors.white,
                              onPressed: () {
                                mainProvider.setValue().whenComplete(() {
                                  Provider.of<MainProvider>(context,
                                          listen: false)
                                      .fetchProvince()
                                      .whenComplete(() {
                                    showCupertinoModalBottomSheet(
                                      isDismissible: false,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) =>
                                          SubmitForm(tinID: widget.tinID!),
                                    );
                                  });
                                });
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                            ),
                          ),
                        ],
                      )
                      // Divider(color: Colors.white),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //         child: Column(
                      //       children: [
                      //         MaterialButton(
                      //           onPressed: () {
                      //             getImage();
                      //           },
                      //           child: Text(
                      //             "Take Picture",
                      //             style: TextStyle(
                      //               fontSize: 18,
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(right: 8),
                      //           child: MaterialButton(
                      //             onPressed: () {
                      //               if (img == null) {
                      //                 CoolAlert.show(
                      //                     backgroundColor: Colors.blue,
                      //                     context: context,
                      //                     type: CoolAlertType.warning,
                      //                     title: 'Waring',
                      //                     text: "Please Take a Picture",
                      //                     loopAnimation: false,
                      //                     barrierDismissible: false,
                      //                     confirmBtnText: "ຕົກລົງ",
                      //                     confirmBtnColor: Colors.red,
                      //                     confirmBtnTextStyle: TextStyle(
                      //                       fontSize: 15,
                      //                       color: Colors.white,
                      //                     ));
                      //               } else {
                      //                 Waiting.show(context);
                      //                 List<int> imageBytes =
                      //                     img!.readAsBytesSync();
                      //                 String base64Image =
                      //                     base64Encode(imageBytes);

                      //                 var body = {
                      //                   "tin": widget.tinID,
                      //                   "locations": locationProvider
                      //                               .latLngMarker ==
                      //                           null
                      //                       ? "${locationProvider.latLngPosition!.latitude}, ${locationProvider.latLngPosition!.longitude}"
                      //                       : "${locationProvider.latLngMarker!.latitude}, ${locationProvider.latLngMarker!.longitude}",
                      //                   "images": base64Image
                      //                 };
                      //                 DioService.createDioToken(
                      //                         body: body,
                      //                         path: "easyTax_updateLocation",
                      //                         token: mainProvider
                      //                             .authModel!.token!)
                      //                     .then((value) {
                      //                   // log("Data: " + value.toString());
                      //                   Waiting.hide(context);
                      //                   if (value['resultCode'] == "200") {
                      //                     CoolAlert.show(
                      //                         backgroundColor: Colors.blue,
                      //                         context: context,
                      //                         type: CoolAlertType.success,
                      //                         title: 'Success',
                      //                         text: "Operation Success.",
                      //                         loopAnimation: false,
                      //                         barrierDismissible: false,
                      //                         confirmBtnText: "ຕົກລົງ",
                      //                         onConfirmBtnTap: () {
                      //                           mainProvider
                      //                               .getTinInfo(widget.tinID!)
                      //                               .whenComplete(() {
                      //                             Navigator.pop(context);
                      //                             Navigator.pop(context);
                      //                           });
                      //                         },
                      //                         confirmBtnColor: Colors.green,
                      //                         confirmBtnTextStyle: TextStyle(
                      //                           fontSize: 15,
                      //                           color: Colors.white,
                      //                         ));
                      //                   } else {
                      //                     CoolAlert.show(
                      //                         backgroundColor: Colors.blue,
                      //                         context: context,
                      //                         type: CoolAlertType.error,
                      //                         title: 'Error',
                      //                         text: "Operation Error.",
                      //                         loopAnimation: false,
                      //                         barrierDismissible: false,
                      //                         confirmBtnText: "ຕົກລົງ",
                      //                         confirmBtnColor: Colors.red,
                      //                         confirmBtnTextStyle: TextStyle(
                      //                           fontSize: 15,
                      //                           color: Colors.white,
                      //                         ));
                      //                   }
                      //                 });
                      //               }
                      //             },
                      //             color: Colors.blue,
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(5.0),
                      //             ),
                      //             child: Container(
                      //                 width: double.infinity,
                      //                 alignment: Alignment.center,
                      //                 height: 45,
                      //                 child: Text(
                      //                   "Save",
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 18,
                      //                   ),
                      //                 )),
                      //           ),
                      //         )
                      //       ],
                      //     )),
                      //     img == null
                      //         ? Container(
                      //             height: 80,
                      //             width: 80,
                      //             decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.circular(5)),
                      //             child: Icon(
                      //               Icons.image,
                      //               size: 50,
                      //             ),
                      //           )
                      //         : Container(
                      //             height: 100,
                      //             width: 80,
                      //             decoration: BoxDecoration(
                      //                 image: DecorationImage(
                      //                     image: FileImage(img!),
                      //                     fit: BoxFit.fill),
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.circular(5)),
                      //           )
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
