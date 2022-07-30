import 'package:flutter/material.dart';
import 'package:mask_app/SecondScreen.dart';

void main() {
  runApp( MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Color(0xff0096FF),
        title: Center(child: const Text('MASK DETECTOR')),
      ),
      body: Column(
        children: [Image.asset('assets/mask.png'),
          Center(
            
            child: 
             ElevatedButton(
              child: const Text('CLICK TO DETECT'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>MyApp())
                );
              },
            ),
            
          ),
        ],
      )
      
    );
  }
}


