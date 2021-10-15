

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetsdivers/fonction/firestoreHelper.dart';
import 'package:widgetsdivers/informationUser.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  //
  WidgetsFlutterBinding.ensureInitialized();

  //attente de l'Initialisation de la connexion firebase
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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}





class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Declaration variable


  String password='';
  String adresseMail='';
  String prenom ="Djino";
  bool valeur = true;
  double nombreFois=10;
  List <Color> couleurs = [Colors.blue,Colors.black,Colors.red];



  //////


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
            // textfield afin que l'utilisateur entre l'adresse mail
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


            // textfield afin que l'utilisateur entre le mot de passe

            TextField(
              onChanged: (String value){
                setState(() {
                  password = value;

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
                  //Ajout du compte dans Firebase authentification


                  firestoreHelper().inscription(adresseMail, password).then((value){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context){
                          return informationUser(prenom: "djino");
                        }
                    ));


                  }).catchError((error){


                    //Fenetre Pop qui s'affiche lors d'uen saisie d'une erreur
                    // S'affiche en particulier lorsque l'adresse n'est pas au bon format
                    MyDialog();


                  });
                },
                child: Text("S'incrire")
            ),




            ElevatedButton(
                onPressed: (){

                  firestoreHelper().connexion(adresseMail, password).then((value){

                    //Envoyer sur la page informationUser lorsque l'utilisateur existe et entre le bon mot de passe


                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context)
                            {
                              return informationUser(prenom: "coucou");
                            }
                    ));

                  }).catchError((error){

                    //erreur de saisie du mot
                    // Affichage d'un snacbar pour afficher

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
  //Construction du SnaskBar
  MonSnackbar(){
    return SnackBar(
      duration: Duration(seconds: 20),
        backgroundColor: Colors.red,
        content: Text("Erreur de connexion !!!!")
    );
  }


  //Construction d'une fe,être Pop up

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
