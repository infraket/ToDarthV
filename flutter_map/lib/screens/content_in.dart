import 'package:flutter/material.dart';




class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => ContentIn();


}


class ContentIn extends State<MyApp>{

  @override

  Widget build(BuildContext context) {
    bool click = true;
    bool click_bm = true;

   return Stack(
     alignment: AlignmentDirectional.topCenter,
     clipBehavior: Clip.none,
     children: [
       Positioned(
         top: -15,
         child: Container(

         width: 60,
         height: 7,

           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(5),
             color: Colors.white,
           ),

       ),
    ),



     Column(
      children: <Widget> [

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
    ),],);





  }

}



