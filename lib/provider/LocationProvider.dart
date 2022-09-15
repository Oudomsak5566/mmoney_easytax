import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  LatLng? latLngPosition;
  LatLng? latLngMarker;
  Future getCurentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latLngPosition = LatLng(position.latitude, position.longitude);
    notifyListeners();
  }

  void setLatLngMaker(LatLng data) {
    latLngMarker = data;
    notifyListeners();
  }
}
