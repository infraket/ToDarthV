import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';
import 'dart:math';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';




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
  PanelController _pc = new PanelController();

  @override
  Widget build(BuildContext context) {


    var markers = <Marker>[];

    markers = [


      Marker(

        point:LatLng(-41.28664,174.77557),
        builder: (ctx) => Icon(Icons.pin_drop,color: Colors.green,

        ),

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
                   markers: markers,

              ),


            ],
        )

            ),
            SlidingUpPanel(
              controller: _pc,


              panel:

                  Column (

                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Row(
                  // mainAxisAlignment:  MainAxisAlignment.spaceAround,
                    children: const <Widget>[

                      SizedBox(height: 20),

                      Icon(
                        Icons.account_box_outlined,
                        size: 26.0,
                      ),
                      SizedBox(width: 10),

                      Text('great_instagram_account',
                          style: TextStyle(color: Colors.black,
                            fontSize: 16,
                              fontWeight:FontWeight.bold)
                      ),
                      SizedBox(width: 80),
                      Icon(
                        Icons.star_rounded,
                        size: 26.0,
                        color: Colors.deepPurple
                      ),
                      Icon(
                          Icons.star_rounded,
                          size: 26.0,
                          color: Colors.deepPurple
                      ),
                      Icon(
                          Icons.star_rounded,
                          size: 26.0,
                          color: Colors.deepPurple
                      ),

                   ],

                  ),
                    SizedBox(height: 30),
                    Text('# test #test',
                        style: TextStyle(color: Colors.black,
                            fontSize: 14,
                        )
                    ),
                    SizedBox(height: 30),
                     Row(
                mainAxisAlignment:  MainAxisAlignment.spaceAround,
              children: const <Widget>[
              Icon(
              Icons.calendar_month_rounded,
              size: 26.0,

              ),
              Text('Записаться',
                style: TextStyle(color: Colors.black,
                  fontSize: 16,

                    )
    ),
              Icon(
              Icons.message,
              size: 26.0,
              ),
                Text('Спросить',
                    style: TextStyle(color: Colors.black,
                      fontSize: 16,
                      )
                ),
                Icon(
                  Icons.phone,
                  size: 26.0,
                  color: Colors.grey
                ),
                Text('пн-пт 9.00 - 21.00',
                style: TextStyle(color: Colors.grey,
                fontSize: 16,))
              ],
              ),

                    SizedBox(height: 30),
                  Row(
                    // mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: const <Widget>[

                  Icon(
                    Icons.favorite_border,
                    size: 26.0,

                  ),
                  Text('В избранное',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black,
                        fontSize: 16,)
                  ),
                      SizedBox(width: 150),
                  Icon(
                      Icons.bookmark_add_outlined,
                      size: 26.0,

                  ),

                  Text('В закладки',
                      style: TextStyle(color: Colors.black,
                        fontSize: 16,))
                ],
              ),
                  ],
                  ),

              borderRadius:  BorderRadius.vertical(top: Radius.circular(25)),
            ),
          ],
              ),
           ),



        ),
       );

  }
}

