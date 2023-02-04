import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';


void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[];
    markers = [
      Marker(point:LatLng(-41.28664,174.77557),
        builder: (ctx) => Icon(Icons.pin_drop,color: Colors.green),
      ),
      Marker(point:LatLng(-37.78333,175.28333),
        builder: (ctx) => Icon(Icons.pin_drop,color: Colors.red),
      ),
      Marker(
        point: LatLng(-36.848461,174.763336),
        builder: (ctx) => Icon(Icons.pin_drop,color: Colors.deepPurpleAccent),

      ),

    ];
    return Scaffold(
      body: Center(
        child: Container(
        child: Column(
          children:[
            Flexible(
              child: FlutterMap(
                 options: MapOptions(
                    center: LatLng(-41.28664,174.77557),
                      zoom: 5


                  ),
                      children: [
                      TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a','b','c'],
                      ),

      MarkerLayer(
              markers: markers
              ),

            ],
        )

            )
          ],


              ),
           ),



        ),
       );

  }
}

