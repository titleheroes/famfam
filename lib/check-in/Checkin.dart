import 'package:another_flushbar/flushbar.dart';
import 'package:geocode/geocode.dart';
import 'package:famfam/check-in/tab_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:famfam/register_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location;

class CheckIn extends StatefulWidget {
  const CheckIn({Key? key}) : super(key: key);
  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  String nameForCheckin = "JaneJira";

  String address = "";
  late LocationData currentPosition;
  late GoogleMapController? mapController;

  Location location = Location();
  LatLng initialPosition = LatLng(13.361944, 100.979167);

  late Marker marker;
  List<Marker> markers = <Marker>[];

  String myLocation = "no";
  late BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;

  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(80),
                child: AppBar(
                    leading: Transform.translate(
                      offset: Offset(0, 12),
                      child: IconButton(
                        icon: Icon(
                          Icons.navigate_before_rounded,
                          color: Colors.black,
                          size: 40,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    title: Transform.translate(
                      offset: Offset(0, 12),
                      child: Text(
                        "Check-In",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ))),
            body: Stack(
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height / 2,

                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: initialPosition,
                      zoom: 15,
                    ),
                    markers: Set<Marker>.of(markers),
                    mapType: MapType.terrain,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              getLoc();
                              // Scaffold.of(context).showSnackBar(
                              //     SnackBar(content: Text("Heello")));
                            },
                            label: Text(
                              "Check In",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                            icon: Icon(
                              Icons.gps_fixed,
                              color: Colors.black,
                              size: 28,
                            ),
                            backgroundColor: Color(0xFFF9EE6D),
                          ),
                        )),
                    Container(
                      child: SlidingUpPanel(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)),
                        panelBuilder: (scrollController) => buildSlidingPanel(
                            scrollController: scrollController),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }

  void showTopSnackBar(BuildContext context) => Flushbar(
        icon: Icon(Icons.error),
        shouldIconPulse: false,
        title: 'Title',
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);

  Widget buildSlidingPanel({
    @required ScrollController? scrollController,
  }) =>
      TabWidget(
        scrollController: scrollController,
        nameForCheckin: nameForCheckin,
        addressCheckin: address,
      );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    print(
        "onCreated ${initialPosition.latitude} : ${initialPosition.longitude}");
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: initialPosition, zoom: 12),
    ));
  }

  createMarker(context) {
    if (myLocation == "yes") {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10, 10)),
              "assets/images/location.png")
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  Future<String> _getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";
    GeoCode geoCode = GeoCode();
    Address address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
    return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
  }

  setMarkers() {
    // createMarker(context);
    markers.add(Marker(
        markerId: MarkerId("Home"),
        position: initialPosition,
        icon: customIcon,
        infoWindow: InfoWindow(title: "My Location", snippet: '${address}')));
    setState(() {});
  }

  getLoc() async {
    myLocation = "yes";
    print("my location ${myLocation}");
    // Position convert;
    bool _serviceEnablied;
    PermissionStatus _permissionGranted;

    _serviceEnablied = await location.serviceEnabled();
    if (!_serviceEnablied) {
      _serviceEnablied = await location.requestService();
      if (!_serviceEnablied) {
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

    currentPosition = await location.getLocation();
    double? latitude = currentPosition.latitude;
    double? longitude = currentPosition.longitude;

    location.onLocationChanged.listen((LocationData currentLocation) {
      _getAddress(latitude, longitude).then((value) {
        setState(() {
          address = value;
        });
      });
      setState(() {
        print(
            "Current Loc ${currentPosition.latitude} : ${currentPosition.longitude}");
        initialPosition = LatLng(latitude!, longitude!);
        print("Current Address ${address}");
        mapController
            ?.moveCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));
        setMarkers();
      });
    });
  }
}
