import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:map_controller/map_controller.dart';

class GPS extends StatefulWidget {
  String _title;
  GPS(this._title);

  @override
  _GPSState createState() => _GPSState();
}

class _GPSState extends State<GPS> {
  MapController mapController;
  LatLng currentLocation = LatLng(51.4285, 14.5590);
  void findMe() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    var ourLocation = await location.getLocation();
    setState(() {
      currentLocation = LatLng(ourLocation.latitude, ourLocation.longitude);
      mapController.move(currentLocation, mapController.zoom);
    });

    location.onLocationChanged.listen((LocationData ourLocation) {
      setState(() {
        currentLocation = LatLng(ourLocation.latitude, ourLocation.longitude);
        mapController.move(currentLocation, mapController.zoom);
      });
    });
  }

  void initState() {
    mapController = MapController();
    findMe();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._title),
        ),
        body: FlutterMap(
          mapController: mapController,
          options: new MapOptions(
            center: currentLocation,
            zoom: 13.0,
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
                  point: currentLocation,
                  builder: (ctx) => new Container(
                    child: Image.network(
                        'https://unpkg.com/leaflet@1.7.1/dist/images/marker-icon-2x.png'),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
