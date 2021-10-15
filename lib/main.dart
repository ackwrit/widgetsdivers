

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetsdivers/fonction/firestoreHelper.dart';
import 'package:widgetsdivers/informationUser.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}





class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // variable

  int _counter = 0;
  String password='';
  String adresseMail='';
  String prenom ="Djino";
  bool valeur = true;
  double nombreFois=10;
  List <Color> couleurs = [Colors.blue,Colors.black,Colors.red];



  //////
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              onChanged: (String value){
                setState(() {
                  adresseMail = value;

                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Adress mail"
              ),

            ),
            SizedBox(height: 20,),

            TextField(
              onChanged: (String value){
                setState(() {
                  adresseMail = value;

                });
              },
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Mot de passe"
              ),

            ),
            SizedBox(height: 20,),



            ElevatedButton(
                onPressed: (){
                  firestoreHelper().inscription(adresseMail, password).then((value){

                  }).catchError((error){
                    MyDialog();
                  });
                },
                child: Text("S'incrire")
            ),




            ElevatedButton(
                onPressed: (){
                  firestoreHelper().connexion(adresseMail, password).then((value){
                    //Envoyer sur la page
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)
                            {
                              return informationUser(prenom: "coucou");
                            }
                    ));

                  }).catchError((error){
                    ScaffoldMessenger.of(context).showSnackBar(MonSnackbar());
                  });
                },
                child: Text('connexion')
            ),
          ],
        ),
      )

    );

  }
  MonSnackbar(){
    return SnackBar(
      duration: Duration(seconds: 20),
        backgroundColor: Colors.red,
        content: Text("Erreur de connexion !!!!")
    );
  }

  MyDialog(){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            content: Text("Erreur lors de l'inscription"),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);

                  },
                  child: Text('OK')
              ),

            ],
          );
        }
    );
  }

}
