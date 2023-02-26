import 'package:flutter/material.dart';
import 'package:map_sliding/screens/content_in.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';

class MyHomePage extends StatelessWidget {

  const MyHomePage({Key ? key, required this.title }) : super(key: key);
  final String title;

  void _showModalBottomSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          )
        ),


        builder: (context) => DraggableScrollableSheet(
          expand: false,

            initialChildSize: 0.4,
            maxChildSize: 0.9,
            minChildSize: 0.32,
            builder: (context, scrollController) => const SingleChildScrollView(
              // controller: scrollController,
              child:  const MyApp(),

            ),

        ),
    );
  }




  @override
  Widget build(BuildContext context) {

    var markers = <Marker>[];


    markers = [


      Marker(

        point:LatLng(-41.28664,174.77557),

        builder: (ctx) => Container(
          child: IconButton(


            onPressed: () => _showModalBottomSheet(context),
            icon: Icon(
                Icons.pin_drop,color: Colors.green),
          ),

        ),
      ),


      Marker(point:LatLng(-37.78333,175.28333),
        builder: (ctx) =>
            Container(
              child: IconButton(


    onPressed: () => _showModalBottomSheet(context),
                icon: Icon(
                    Icons.pin_drop,color: Colors.red),
              ),

            ),


      ),
      Marker(

        point: LatLng(-36.848461,174.763336),
        builder: (ctx) =>
            Container(
              child: IconButton(


              onPressed: () => _showModalBottomSheet(context),
                icon: Icon(
                    Icons.pin_drop,color: Colors.deepPurpleAccent),
              ),

            ),

      ),

    ];


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading:
          Icon(Icons.menu,color: Colors.black, size: 30),
        ),
      body: Center(
        child:
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
                  markers: markers,

                ),


              ],
            )

        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _showModalBottomSheet(context),
      //   tooltip: 'Bottom Sheet',
      //   child: const Icon(Icons.add),
      // ),

    );
  }

}
