import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
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

  bool click = true;
  bool click_bm = true;
  // bool selected = false;
  // double size_panel =  0;
  // double size_panel_active = 0;
  void togglePanel() => _pc.isPanelOpen ? _pc.close() : _pc.open();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double size_panel_active =  size.height *  0.02 ;

    var markers = <Marker>[];


    markers = [


      Marker(

        point:LatLng(-41.28664,174.77557),

    builder: (ctx) => Container(
          child: IconButton(


          onPressed: (){
              setState(() {
                _pc.show();

               size_panel_active =  size.height * 10;
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
                _pc.open();


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
      appBar: AppBar(
         backgroundColor: Colors.white,
          leading:
              Icon(Icons.menu,color: Colors.black, size: 30),


      ),
       body:
      // Center(
      //
      //   child: Container(
      //
      //   child: Column(
      //     children:[


        //     Flexible(
        //       child: FlutterMap(
        //
        //          options: MapOptions(
        //             center: LatLng(-41.28664,174.77557),
        //               zoom: 5
        //           ),
        //               children: [
        //               TileLayer(
        //             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        //             subdomains: ['a','b','c'],
        //               ),
        //
        //              MarkerLayer(
        //            markers: markers,
        //
        //       ),
        //
        //
        //     ],
        // )
        //
        //     ),
            SlidingUpPanel(
              backdropEnabled: true,
              controller: _pc,
              // minHeight: selected ?  size_panel_active : size_panel,
              defaultPanelState: PanelState.CLOSED,
              minHeight: size_panel_active,
              // minHeight: size_panel_active ,
              // maxHeight: size.height * 0.4,
              // maxHeight: size.height * 0.1,





              // collapsed:  Container(
              //
              //
              // decoration: BoxDecoration(
              //
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
              //       Text('test_account',
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
              //
              //   ),

              panelBuilder: (controller){
                return SingleChildScrollView(

                  controller: controller,
                 child: Column (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                 onTap: togglePanel,
                    child:
                    Center(
                      child:
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 10,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300 ),
                        ),
                      ),
                    ),

                  // Container(
                  //
                  //     child: <Widget>[
                  //       SizedBox(height: 30),
                  //       Row(
                  //         children: [
                  //           SizedBox(width: 20),
                  //           Icon(
                  //             Icons.account_box_sharp,
                  //             size: 26.0,
                  //           ),
                  //           SizedBox(width: 10),
                  //
                  //           Text('account',
                  //               style: TextStyle(color: Colors.black,
                  //                   fontSize: 16,
                  //                   fontWeight:FontWeight.bold)
                  //           ),
                  //
                  //           SizedBox(width: 40),
                  //           Icon(
                  //               Icons.star_rounded,
                  //               size: 26.0,
                  //               color: Colors.deepPurple
                  //           ),
                  //
                  //
                  //           Icon(
                  //               Icons.star_rounded,
                  //               size: 26.0,
                  //               color: Colors.deepPurple
                  //           ),
                  //           Icon(
                  //               Icons.star_rounded,
                  //               size: 26.0,
                  //               color: Colors.deepPurple
                  //           ),
                  //
                  //         ],
                  //       ),
                  //
                  //
                  //       SizedBox(height: 30),
                  //       Row(
                  //         children: const <Widget> [
                  //           SizedBox(width: 13),
                  //           Text('# lorem # ipsum', style: TextStyle(color: Colors.black,
                  //             fontSize: 14,
                  //           )
                  //           ),
                  //           SizedBox(width: 180),
                  //           Icon(
                  //             Icons.whatsapp_sharp,
                  //             size: 26.0,
                  //             // color: Colors.green,
                  //
                  //           ),
                  //           SizedBox(width: 13),
                  //           Icon(
                  //             Icons.telegram_sharp,
                  //             size: 26.0,
                  //             // color: Colors.blue,
                  //
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 30),
                  //       Row(
                  //         mainAxisAlignment:  MainAxisAlignment.spaceAround,
                  //         children: [
                  //
                  //           IconButton(
                  //
                  //             onPressed: () {
                  //               showDatePicker(
                  //
                  //                 context: context,
                  //                 initialDate: DateTime.now(),
                  //                 firstDate: DateTime(2015, 8),
                  //                 lastDate: DateTime(2101),
                  //
                  //
                  //               );
                  //             },
                  //             icon: Icon(
                  //               Icons.calendar_month_rounded,
                  //               size: 26.0,
                  //
                  //             ),
                  //           ),
                  //           Text('Записаться',
                  //               style: TextStyle(color: Colors.black,
                  //                 fontSize: 16,
                  //
                  //               )
                  //           ),
                  //           Icon(
                  //             Icons.message,
                  //             size: 26.0,
                  //           ),
                  //           Text('Спросить',
                  //               style: TextStyle(color: Colors.black,
                  //                 fontSize: 16,
                  //               )
                  //           ),
                  //           Icon(
                  //               Icons.phone,
                  //               size: 26.0,
                  //               color: Colors.black
                  //           ),
                  //           Text('пн-пт 9.00 - 21.00',
                  //               style: TextStyle(color: Colors.grey,
                  //                 fontSize: 16,))
                  //         ],
                  //       ),
                  //
                  //       SizedBox(height: 30),
                  //       Row(
                  //         children: [
                  //
                  //           IconButton(
                  //               onPressed: () {
                  //                 setState(() {
                  //                   click = !click;
                  //                 });
                  //               },
                  //               icon: Icon(
                  //                   size: 26.0,
                  //
                  //                   click?  Icons.favorite_border :  Icons.favorite),
                  //               color: click? Colors.black : Colors.red,
                  //               splashRadius: 50,
                  //               splashColor: Colors.lightGreenAccent
                  //           ),
                  //
                  //           Text('В избранное',
                  //               textAlign: TextAlign.left,
                  //               style: TextStyle(color: Colors.black,
                  //                 fontSize: 16,)
                  //           ),
                  //           SizedBox(width: 80),
                  //
                  //           IconButton(
                  //
                  //             onPressed: () {
                  //               setState(() {
                  //                 click_bm = !click_bm;
                  //               });
                  //             },
                  //             icon: Icon(
                  //                 size: 26.0,
                  //
                  //                 click_bm?  Icons.bookmark_add_outlined :  Icons.bookmark_add),
                  //             color: click_bm? Colors.black : Colors.red,
                  //
                  //           ),
                  //           Text('В закладки',
                  //               style: TextStyle(color: Colors.black,
                  //                 fontSize: 16,))
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  ],),


                 );
              },
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



              panel:
                     Column (
                  children: <Widget>[
                    SizedBox(height: 30),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(
                        Icons.account_box_sharp,
                        size: 26.0,
                      ),
                      SizedBox(width: 10),

                      Text('account',
                          style: TextStyle(color: Colors.black,
                            fontSize: 16,
                              fontWeight:FontWeight.bold)
                      ),

                      SizedBox(width: 40),
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
              Row(
                  children: const <Widget> [
                    SizedBox(width: 13),
                    Text('# lorem # ipsum', style: TextStyle(color: Colors.black,
                            fontSize: 14,
                        )
                    ),
                    SizedBox(width: 180),
                    Icon(
                      Icons.whatsapp_sharp,
                      size: 26.0,
                      // color: Colors.green,

                    ),
                    SizedBox(width: 13),
                    Icon(
                      Icons.telegram_sharp,
                      size: 26.0,
                      // color: Colors.blue,

                    ),
                  ],
              ),
                    SizedBox(height: 30),
                     Row(
                mainAxisAlignment:  MainAxisAlignment.spaceAround,
              children: [

                IconButton(

                  onPressed: () {
                     showDatePicker(

                     context: context,
                     initialDate: DateTime.now(),
                     firstDate: DateTime(2015, 8),
                     lastDate: DateTime(2101),


                     );
                     },
                  icon: Icon(
                    Icons.calendar_month_rounded,
                    size: 26.0,

                ),
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
                  color: Colors.black
                ),
                Text('пн-пт 9.00 - 21.00',
                style: TextStyle(color: Colors.grey,
                fontSize: 16,))
              ],
              ),

                    SizedBox(height: 30),
                  Row(
                    children: [

                       IconButton(
                        onPressed: () {
                          setState(() {
                            click = !click;
                          });
                        },
                        icon: Icon(
                            size: 26.0,

                            click?  Icons.favorite_border :  Icons.favorite),
                        color: click? Colors.black : Colors.red,
                       splashRadius: 50,
                           splashColor: Colors.lightGreenAccent
                      ),

                      Text('В избранное',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black,
                            fontSize: 16,)
                      ),
                      SizedBox(width: 80),

                         IconButton(

                          onPressed: () {
                            setState(() {
                              click_bm = !click_bm;
                            });
                          },
                          icon: Icon(
                              size: 26.0,

                              click_bm?  Icons.bookmark_add_outlined :  Icons.bookmark_add),
                          color: click_bm? Colors.black : Colors.red,

                        ),
                  Text('В закладки',
                      style: TextStyle(color: Colors.black,
                        fontSize: 16,))
                ],
              ),
                  ],

    ),
           borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
    );


  }
}


