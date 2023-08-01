import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  late String _mapStyle;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition beninPlace =
      CameraPosition(target: LatLng(9.3073556, 2.3093777), zoom: 7.6, tilt: 10);

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Marker> markers = {};
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;


  getCurrentLocation(){

  }

  @override
  void initState() {
  // addCustomIcon();
   rootBundle.loadString('assets/style/map_style.json').then((string) {
     _mapStyle = string;
   });
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/1.png")
        .then(
          (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracer order"),
      ),
      body: SafeArea(
        child: GoogleMap(
         padding: const EdgeInsets.all(10),
          mapType: MapType.normal,
          initialCameraPosition: beninPlace,
          trafficEnabled: true,
          markers: markers,
         myLocationEnabled: true,
       mapToolbarEnabled: true,
          compassEnabled: true,
          myLocationButtonEnabled: true,


         /* polygons: {
            Polygon(
              polygonId: PolygonId("AAA"),
              strokeColor: Colors.green,
              points: markers.map((e) => e.position).toList(),
              fillColor: Colors.green,
              strokeWidth: 1,
              geodesic: true,

            ),
          },*/
          polylines: {
            Polyline(polylineId: const PolylineId("AA"),
            points: markers.map((e) => e.position).toList(),
              color: Colors.teal,
              width: 3,
              onTap: (){
              print("Route taped");
              }
            )
          },
          circles: {
            const Circle(
                circleId: CircleId("AM"),
                center: LatLng(7.8878330168253745, 2.1909620985388756),
                fillColor: Colors.teal,
                strokeColor: Colors.teal,
                strokeWidth: 10),

          },
          onMapCreated: (GoogleMapController controller) {


            controller.setMapStyle(_mapStyle);
            _controller.complete(controller);
          },
          onTap: (position) {
            String AIS = "AAA${position.latitude * 3}";

            setState(() {
              markers.add(Marker(
                markerId: MarkerId(AIS),
                position: position,
                draggable: true,
                onDragEnd: (position){
                  print(position);
                },
                icon: markerIcon,
              ));
            });
          },
        ),
      ),
      bottomNavigationBar:const BottomAppBar(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/casual-life-3d-young-doctor-man.png",),
          ),
          title: Text("Mike"),
          subtitle: Text("1000Km :9 min"),
          trailing: CircleAvatar(
            child: Icon(Icons.message),
          ),
        ),
      ) ,

    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
