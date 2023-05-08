import 'package:flutter/material.dart';
import 'package:mask_app/SecondScreen.dart';
import 'package:mask_app/splash.dart';
import 'package:alan_voice/alan_voice.dart';


void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Navigation Basics',
    home: Splash(),
  ));
}

class FirstRoute extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    var child;
    var getImageFromCamera;
    return Scaffold(
      
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 11, 11),
        title: Center(child: const Text('TRINETRA')),
      
      ),
      body: Column(
        children: 
        [DecoratedBox(
    decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent, 
              Colors.redAccent,
              Colors.purpleAccent
              //add more colors
            ]),
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 5) //blur radius of shadow
          ]
      ),
    child:ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onSurface: Colors.transparent,
          shadowColor: Colors.transparent,
          //make color or elevated button transparent
      ),
      
      onPressed: getImageFromCamera
      , 
      child: Padding(
        padding:EdgeInsets.only(
          top: 18,
          bottom: 18,
        ),
        child:Text("Press This Button"),
      )
    )  
)
      ],
      
      
    )
    );
  }
}

