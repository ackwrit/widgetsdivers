import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:widgetsdivers/fonction/firestoreHelper.dart';

import 'model/Utilisateur.dart';


class profilPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profilPageState();
  }

}

class profilPageState extends State<profilPage>{
  late Utilisateur user;
  late String identifiant;


  void initUser()async {
    identifiant = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot documentSnapshot= await FirebaseFirestore.instance.collection("utilisateur").doc(identifiant).get();
    user = Utilisateur(documentSnapshot);

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Information User'),
      ),
      body: bodyPage(),
    );
  }


  Widget bodyPage(){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle

          ),
          child: (user.image==null)?Image.asset("assets/ynov_logo.jpg",fit: BoxFit.fill,):Image.network(user.image,fit: BoxFit.fill,),
        ),
        Text("${user.nom}  ${user.prenom}"),
        Text(user.pseudo),
        Text(user.nom),
        Text(user.nom),
        Text(user.nom),
        Text(user.nom),
      ],
    );
  }


}