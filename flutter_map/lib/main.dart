import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      // AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('en'), // English
      Locale('ru'),
    ],
    home: MyApp(

    ),

  ));
}
class MyApp extends StatefulWidget {



  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  PanelController _pc = new PanelController();
  PanelController _pc_one = new PanelController();
  PanelController _pc_two = new PanelController();
  bool click = true;
  bool click_bm = true;







  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var markers = <Marker>[];


    markers = [


      Marker(

        point:LatLng(-41.28664,174.77557),
        // builder: (ctx) => Icon(Icons.pin_drop,color: Colors.green,
    builder: (ctx) => Container(
          child: IconButton(


            onPressed: () {
              setState(() {
                _pc.open();
              });
            },
            icon: Icon(
    Icons.pin_drop,color: Colors.green),
    ),

        ),
      ),


      Marker(point:LatLng(-37.78333,175.28333),
        builder: (ctx) =>
        Container(
          child: IconButton(


            onPressed: () {
              setState(() {
                _pc_one.open();
              });
            },
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


            onPressed: () {
              setState(() {
                _pc.open();
              });
            },
            icon: Icon(
                Icons.pin_drop,color: Colors.deepPurpleAccent),
          ),

        ),

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
              //
              // defaultPanelState:PanelState.CLOSED,
              minHeight: size.height * 0,
              maxHeight: size.height * 0.5,


              controller: _pc,
              // collapsed: Container(
              // decoration: BoxDecoration(
              // color: Colors.blueGrey,
              // borderRadius: BorderRadius.only(
              // topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
              // ),
              //
              //
              //   child:  Row(
              //     // mainAxisAlignment:  MainAxisAlignment.spaceAround,
              //     children: const <Widget>[
              //
              //       SizedBox(height: 20),
              //
              //
              //       Icon(
              //         Icons.account_box_outlined,
              //         size: 26.0,
              //       ),
              //       SizedBox(width: 10),
              //
              //       Text('great_instagram_account',
              //           style: TextStyle(color: Colors.black,
              //               fontSize: 16,
              //               fontWeight:FontWeight.bold)
              //       ),
              //       SizedBox(width: 80),
              //       Icon(
              //           Icons.star_rounded,
              //           size: 26.0,
              //           color: Colors.deepPurple
              //       ),
              //       Icon(
              //           Icons.star_rounded,
              //           size: 26.0,
              //           color: Colors.deepPurple
              //       ),
              //       Icon(
              //           Icons.star_rounded,
              //           size: 26.0,
              //           color: Colors.deepPurple
              //       ),
              //
              //     ],
              //
              //   ),
              //   ),




              panel:


    Column (



                  children: <Widget>[
                  Row(

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
                    children: [
                    Container(
                      child: IconButton(


                        onPressed: () {
                          setState(() {
                            click = !click;
                          });
                        },
                        icon: Icon(
                            size: 26.0,

                            click?  Icons.favorite_border :  Icons.favorite),
                        color: click? Colors.red : Colors.red,
                      ),

                    ),
                    // mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    // children: const <Widget>[

                      Text('В избранное',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black,
                            fontSize: 16,)
                      ),
                      SizedBox(width: 80),
                      Container(
                        child: IconButton(


                          onPressed: () {
                            setState(() {
                              click_bm = !click_bm;
                            });
                          },
                          icon: Icon(
                              size: 26.0,

                              click_bm?  Icons.bookmark_add_outlined :  Icons.bookmark_add),
                          color: click_bm? Colors.red : Colors.red,
                        ),

                      ),



                  Text('В закладки',
                      style: TextStyle(color: Colors.black,
                        fontSize: 16,))
                ],
              ),
                  ],

    ),
            ),
            SlidingUpPanel(
              //
              // defaultPanelState:PanelState.CLOSED,
              minHeight: size.height * 0,


              controller: _pc_one,
              // collapsed: Container(
              // decoration: BoxDecoration(
              // color: Colors.blueGrey,
              // borderRadius: BorderRadius.only(
              // topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
              // ),
              //
              //
              //   child:  Row(
              //     // mainAxisAlignment:  MainAxisAlignment.spaceAround,
              //     children: const <Widget>[
              //
              //       SizedBox(height: 20),
              //
              //
              //       Icon(
              //         Icons.account_box_outlined,
              //         size: 26.0,
              //       ),
              //       SizedBox(width: 10),
              //
              //       Text('great_instagram_account',
              //           style: TextStyle(color: Colors.black,
              //               fontSize: 16,
              //               fontWeight:FontWeight.bold)
              //       ),
              //       SizedBox(width: 80),
              //       Icon(
              //           Icons.star_rounded,
              //           size: 26.0,
              //           color: Colors.deepPurple
              //       ),
              //       Icon(
              //           Icons.star_rounded,
              //           size: 26.0,
              //           color: Colors.deepPurple
              //       ),
              //       Icon(
              //           Icons.star_rounded,
              //           size: 26.0,
              //           color: Colors.deepPurple
              //       ),
              //
              //     ],
              //
              //   ),
              //   ),




              panel:


              Column (


                children: <Widget>[
                  Row(

                    children: const <Widget>[

                      SizedBox(height: 20),


                      Icon(
                        Icons.account_box_outlined,
                        size: 26.0,
                      ),
                      SizedBox(width: 10),

                      Text('great_instagram_account2',
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
                    children: [
                      Container(
                        child: IconButton(


                          onPressed: () {
                            setState(() {
                              click = !click;
                            });
                          },
                          icon: Icon(
                              size: 26.0,

                              click?  Icons.favorite_border :  Icons.favorite),
                          color: click? Colors.red : Colors.red,
                        ),

                      ),


                      Text('В избранное',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black,
                            fontSize: 16,)
                      ),
                      SizedBox(width: 80),
                      Container(
                        child: IconButton(


                          onPressed: () {
                            setState(() {
                              click_bm = !click_bm;
                            });
                          },
                          icon: Icon(
                              size: 26.0,

                              click_bm?  Icons.bookmark_add_outlined :  Icons.bookmark_add),
                          color: click_bm? Colors.red : Colors.red,
                        ),

                      ),


                      Text('В закладки',
                          style: TextStyle(color: Colors.black,
                            fontSize: 16,))
                    ],
                  ),
                ],

              ),
            ),

          ],
              ),

           ),



        ),
       );

  }
}


