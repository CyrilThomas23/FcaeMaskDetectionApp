import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;
  File? file;
  var output;
  var label;
  var fine;
  ImagePicker image = ImagePicker();
  var gfg = {
    'with_mask': 'Entry_Allowed',
    'without_mask': 'Entry_Denied',
  };

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  detectimage(File l) async {
    var prediction = await Tflite.runModelOnImage(
      path: l.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      output = prediction;
      label = (output![0]['label']).toString().substring(2);
      fine = gfg[label];
      loading = false;
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  getImageFromCamera() async {
    var img = await image.pickImage(source: ImageSource.camera);

    setState(() {
      file = File(img!.path);
    });
    detectimage(file!);
  }

  getImageFromGallery() async {
    var img = await image.pickImage(source: ImageSource.gallery);

    setState(() {
      file = File(img!.path);
    });
    detectimage(file!);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        
         backgroundColor: Color.fromARGB(255, 19, 19, 19),
        title: Center(
          child: Text(
            'TRINETRA',
          ),
        ),
        
      ),
      body: Container(
        height: h,
        width: w,
        child: Column(
          children: [
            loading == true
                ? Container()
                : Container(
                    color: Colors.red,
                    child: Column(
                      children: [
                        Container(
                          height: 220,
                          padding: EdgeInsets.all(15),
                          child: Image.file(file!),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (output![0]['label']).toString().substring(2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Confidence: ' +
                                (output![0]['confidence']).toString(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(fine),
                        ),
                      ],
                    ),
                  ),
           
            
             Column(
               children: [
                 SizedBox( 
                    height:(h/2)-28, 
                     width:double.infinity,
            child: ElevatedButton(
                  child: const Text('OBJECT DETECTION'),
                  onPressed: 
                  getImageFromCamera,
                  style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 0, 0, 0),)
            ),
            ),
               ],
             ),
            SizedBox( 
                height:(h/2)-28, 
                 width:double.infinity,
            child: ElevatedButton(
              child: const Text('CURRENCY DETECTION'),
              onPressed: getImageFromCamera,
              style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 7, 7, 7),)
            ),
            ),
          
            
            

                
      
          ],
        ),
      ),
    );
  }
}