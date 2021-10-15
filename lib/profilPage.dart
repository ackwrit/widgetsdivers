import 'package:flutter/material.dart';


class profilPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profilPageState();
  }

}

class profilPageState extends State<profilPage>{
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
        Text("Je vais affaicher les informations de la base de donnée")
      ],
    );
  }

}