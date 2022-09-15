import 'dart:convert';

import 'package:easytax/helper/PermissionHnadle.dart';
import 'package:easytax/helper/WaitingProcess.dart';
import 'package:easytax/pages/MarkLocationFormPage.dart';
import 'package:easytax/provider/LocationProvider.dart';
import 'package:easytax/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/TileWidget.dart';

class HomPage extends StatefulWidget {
  const HomPage({Key? key}) : super(key: key);

  @override
  _HomPageState createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  final searchTextController = new TextEditingController();
  @override
  void initState() {
    // Location Permission
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    PermissionService.requestPermission().whenComplete(() {
      locationProvider.getCurentLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);

    return Scaffold(
      floatingActionButton: mainProvider.tinInfoModel == null
          ? null
          : mainProvider.tinInfoModel!.data == null
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MarkLocationFormPage(
                                  tinID: mainProvider.tinInfoModel!.data!.tIN,
                                )));
                  },
                  child: Icon(
                    Icons.location_on_rounded,
                    size: 35,
                  ),
                ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "EasyTax Record",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.white),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchTextController,
                          autofocus: false,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              // filled: true,
                              hintText: "TIN ID",
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade200, fontSize: 15),
                              // border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 14)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Waiting.show(context);
                          mainProvider
                              .getTinInfo(searchTextController.text)
                              .whenComplete(() => Waiting.hide(context));

                          // mainProvider
                          //     .searchTIN(searchTextController.text)
                          //     .whenComplete(() => Waiting.hide(context));
                        },
                        child: Card(
                          color: Colors.blue,
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 14),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Search",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "ລາຍລະອຽດ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          mainProvider.tinInfoModel == null
              ? Container()
              : mainProvider.tinInfoModel!.data == null
                  ? Center(
                      child: Column(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 50,
                        ),
                        Text(
                          "ບໍ່ພົບຂໍ້ມູນ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ))
                  : Expanded(
                      child: Container(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          physics: BouncingScrollPhysics(),
                          children: [
                            mainProvider.tinInfoModel!.data!.aDDRIMG == "NA"
                                ? Container()
                                : Card(
                                    elevation: 0,
                                    child: Column(
                                      children: [
                                        Text("Picture"),
                                        Container(
                                          height: 300,
                                          width: double.infinity,
                                          child: Image.network(mainProvider
                                              .tinInfoModel!.data!.aDDRIMG!),
                                        )
                                      ],
                                    ),
                                  ),
                            mainProvider.tinInfoModel!.data!.aDDRLOCATION ==
                                    "NA"
                                ? Container()
                                :
                                // Card(
                                //     elevation: 0,
                                //     child: ListTile(
                                //       title: Text("LOCATION"),
                                //       subtitle: Column(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.start,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             mainProvider.tinInfoModel!.data!
                                //                 .aDDRLOCATION
                                //                 .toString(),
                                //             style: TextStyle(
                                //                 color: Colors.black,
                                //                 fontWeight: FontWeight.bold,
                                //                 fontSize: 15),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                TileWidget(
                                    title: "LOCATION:",
                                    subtitle: mainProvider
                                        .tinInfoModel!.data!.aDDRLOCATION,
                                  ),
                            TileWidget(
                              title: "ORG_CD:",
                              subtitle: mainProvider.tinInfoModel!.data!.oRGCD,
                            ),
                            TileWidget(
                              title: "ORG_CD_NM:",
                              subtitle:
                                  mainProvider.tinInfoModel!.data!.oRGCDNM,
                            ),
                            TileWidget(
                              title: "TIN:",
                              subtitle: mainProvider.tinInfoModel!.data!.tIN,
                            ),
                            TileWidget(
                              title: "CO_NM:",
                              subtitle: mainProvider.tinInfoModel!.data!.cONM,
                            ),
                            TileWidget(
                              title: "BASIC_ADDR_NM:",
                              subtitle:
                                  mainProvider.tinInfoModel!.data!.bASICADDRNM,
                            ),
                            TileWidget(
                                title: "FILING_YN:",
                                subtitle:
                                    mainProvider.tinInfoModel!.data!.fILINGYN),
                            TileWidget(
                                title: "PAY_YN:",
                                subtitle:
                                    mainProvider.tinInfoModel!.data!.pAYYN),
                          ],
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}
