import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_lote/model/Usuario.dart';
import 'package:flutter/cupertino.dart';

class Terreno{

  String _id;
  String _titulo;
  String _cidade;
  String _descricao;
  String _vlTotal;
  String _vlEntrada;
  String _vlParcela;
  String _dataPrimeiraParcela;
  String _dataUltimaParcela;
  String _apresentarRegistro;


  Firestore db                  = Firestore.instance;
//  String idUsuarioLogado        = 'LniQVMDb1bRvDVetHaHt5c5VhiB2';
  Usuario usuario = new Usuario();

  final _controller             = StreamController<QuerySnapshot>.broadcast();



  Terreno(cidade, descricao,titulo, vlParcela, vlTotal, vlEntrada, dataPrimeiraParcela, dataUltimaParcela, apresentarRegistro){
    this.cidade                     = cidade;
    this.descricao                  = descricao;
    this.titulo                     = titulo;
    this.vlParcela                  = vlParcela;
    this.vlTotal                    = vlTotal;
    this.vlEntrada                  = vlEntrada;
    this.dataPrimeiraParcela        = dataPrimeiraParcela;
    this.dataUltimaParcela          = dataUltimaParcela;
    this.apresentarRegistro         = apresentarRegistro;
  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "titulo"              : this.titulo,
      "cidade"              : this.cidade,
      "descricao"           : this.descricao,
      "vlTotal"             : this.vlTotal,
      "vlEntrada"           : this.vlEntrada,
      "vlParcela"           : this.vlParcela,
      "dataPrimeiraParcela" : this.dataPrimeiraParcela,
      "dataUltimaParcela"   : this.dataUltimaParcela,
      "apresentarRegistro"  : this.apresentarRegistro
    };

    return map;
  }
/*

  Stream<QuerySnapshot> recuperarListenerTerrenos() {
    final stream = db.collection("terrenos")
        .document(idUsuarioLogado)
        .collection("terreno")
        .where("apresentarRegistro", isEqualTo: '1')
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);

    });
    _controller.stream;
  }
*/

  void cadastrarTerreno( Terreno terreno, idUsuarioLogado){
    //Salvar terreno
    Firestore db = Firestore.instance;

    db.collection("terrenos")
        .document(idUsuarioLogado)
        .collection("terreno")
        .document()
        .setData(terreno.toMap());
  }

  Future<String> retornarUidTerreno() async {
//    final Firebase user = await FirebaseAuth.instance.currentUser();
//    final String uid = user.uid.toString();
//    return uid;
  }

  void excluirTerreno(idUsuarioLogado, idTerreno){
    Firestore db = Firestore.instance;

    db.collection("terrenos")
        .document(idUsuarioLogado)
        .collection("terreno")
        .document(idTerreno)
        .updateData({
      "apresentarRegistro" : '0'
    });
  }


/*
  Terreno.fromDocument(DocumentSnapshot snapshot){

    this.id                 = snapshot.documentID;
    this.titulo             = snapshot.data['titulo'];
    this.descricao          = snapshot.data['descricao'];

  }


 */

/*

  Terreno.fromMap(Map map){

    this.id                 = map[TerrenoHelper.colunaId];
    this.titulo             = map[TerrenoHelper.colunaTitulo];
    this.cidade             = map[TerrenoHelper.colunaCidade];
    this.descricao          = map[TerrenoHelper.colunaDescricao];
    this.vlTotal            = map[TerrenoHelper.colunaVlTotal];
    this.vlEntrada          = map[TerrenoHelper.colunaVlEntrada];
    this.vlParcela          = map[TerrenoHelper.colunaVlParcela];
    this.dataPrimeiraParcela= map[TerrenoHelper.colunaDataPrimeiraParcela];
    this.dataUltimaParcela  = map[TerrenoHelper.colunaDataUltimaParcela];
  }
/*
  Map toMap() {
    Map<String, dynamic> map = {
      'titulo': this.titulo,
      'cidade': this.cidade,
      'descricao': this.descricao,
      'vl_Total': this.vlTotal,
      'vl_Entrada': this.vlEntrada,
      'vl_Parcela': this.vlParcela,
      'data_Primeira_Parcela': this.dataPrimeiraParcela,
      'data_Ultima_Parcela': this.dataUltimaParcela,
    };



    if(this.id != null){
      map['id'] = this.id;
    }
    return map;
  }


 */

 */

  String get id => _id;

  set id(String value) {
    _id = value;
  }


  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get vlTotal => _vlTotal;

  set vlTotal(String value) {
    _vlTotal = value;
  }

  String get vlEntrada => _vlEntrada;

  set vlEntrada(String value) {
    _vlEntrada = value;
  }

  String get vlParcela => _vlParcela;

  set vlParcela(String value) {
    _vlParcela = value;
  }

  String get dataPrimeiraParcela => _dataPrimeiraParcela;

  set dataPrimeiraParcela(String value) {
    _dataPrimeiraParcela = value;
  }

  String get dataUltimaParcela => _dataUltimaParcela;

  set dataUltimaParcela(String value) {
    _dataUltimaParcela = value;
  }

  String get apresentarRegistro => _apresentarRegistro;

  set apresentarRegistro(String value) {
    _apresentarRegistro = value;
  }
}