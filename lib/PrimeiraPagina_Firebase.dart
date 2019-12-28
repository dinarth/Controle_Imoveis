import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/Terreno.dart';

class PrimeiraPagina_Firebase extends StatefulWidget {
  @override
  _PrimeiraPagina_FirebaseState createState() => _PrimeiraPagina_FirebaseState();
}

class _PrimeiraPagina_FirebaseState extends State<PrimeiraPagina_Firebase> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  String _textoResultado = "";

  TextEditingController _controllerTitulo = TextEditingController(text: "Terreno em Brss");
  TextEditingController _controllerCidade = TextEditingController(text: "Barreiras");
  TextEditingController _controllerDescricao = TextEditingController(text: "Descrição");
/*
  _validarCampos() {
    String titulo = _tituloController.text;
    String cidade = _cidadeController.text;
    String descricao = _descricaoController.text;

    Terreno_Firebase terreno_firebase = Terreno_Firebase();
    terreno_firebase.titulo = titulo;
    terreno_firebase.cidade = cidade;
    terreno_firebase.descricao = descricao;

    _cadastrarTerreno(terreno_firebase);
  }

  _cadastrarTerreno( Terreno_Firebase terreno){

    //Salvar terreno
    Firestore db = Firestore.instance;

    db.collection("terrenos")
        .document("LniQVMDb1bRvDVetHaHt5c5VhiB2")
        .collection("terreno")
        .document("001")
        .setData(terreno.toMap());


  }

 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //Padding(
              // padding: EdgeInsets.only(bottom: 32),
              // child: Image.asset("imagens/imagem_cheque.jpg"),
              // ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Cadastrar Terreno",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Título"),
                style: TextStyle(fontSize: 22),
                controller: _tituloController,
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Cidade"),
                style: TextStyle(fontSize: 22),
                controller: _cidadeController,
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Descrição do lote"),
                style: TextStyle(fontSize: 22),
                controller: _descricaoController,
              ),

              Padding(
                padding: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
//                    _validarCampos();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _textoResultado,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }




}
