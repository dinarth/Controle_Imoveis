import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_lote/AtualizarTerreno.dart';
import 'package:controle_lote/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import 'PrimeiraPagina.dart';
import 'helper/TerrenoHelper.dart';
import 'model/Terreno.dart';
import 'TerceiraPagina.dart';

class SegundaPagina extends StatefulWidget {
  @override
  _SegundaPaginaState createState() => _SegundaPaginaState();
}

class _SegundaPaginaState extends State<SegundaPagina> {
  Usuario usuario = new Usuario();
  List<Terreno> _terrenos = List();
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  Future<String> idUsuario;
  String idUsuarioLogado;


  FirebaseUser firebaseUser;
  FirebaseAuth _auth = FirebaseAuth.instance;





  _formatarData(String data) {
    initializeDateFormatting('pt_BR');

    var formatador = DateFormat('d/M/y');

    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format(dataConvertida);

    return dataFormatada;
  }




  Stream<QuerySnapshot> _recuperarListenerTerrenos() {
    final stream = db
        .collection("terrenos")
        .document(idUsuarioLogado)
        .collection("terreno")
        .where("apresentarRegistro", isEqualTo: '1')
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

  @override
  void initState() {
    super.initState();

    idUsuario = usuario.retornarUid();
    idUsuario.then((id){
      print(id);
      this.idUsuarioLogado = id;

      _recuperarListenerTerrenos();
    });

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando terrenos"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text("Erro ao carregar terrenos.");
            } else {
              QuerySnapshot querySnapshot = snapshot.data;
              if (querySnapshot.documents.length == 0) {
                return Center(
                  child: Text(
                    "Você não possui terreno(s) cadastrado(s).",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              } //chave do IF

              return  ListView.builder(
                      itemCount: querySnapshot.documents.length,
                      itemBuilder: (context, index) {
                        List<DocumentSnapshot> terrenos =
                            querySnapshot.documents.toList();
                        DocumentSnapshot item = terrenos[index];



                        String cidade                         = item['cidade'];
                        String descricao                      = item['descricao'];
                        String titulo                         = item['titulo'];
                        String vlParcela                      = item['vlParcela'];
                        String vlTotal                        = item['vlTotal'];
                        String vlEntrada                      = item['vlEntrada'];
                        String dataPrimeiraParcela            = item['dataPrimeiraParcela'];
                        String dataUltimaParcela              = item['dataUltimaParcela'];
                        String dataDiaDoPagamento             = item['dataDiaDoPagamento'];
                        String apresentarRegistro             = item['apresentarRegistro'];
                        String idTerreno                      = item.documentID;

                        Terreno terreno = new Terreno(
                            cidade,
                            descricao,
                            titulo,
                            vlParcela,
                            vlTotal,
                            vlEntrada,
                            dataPrimeiraParcela,
                            dataUltimaParcela,
                            dataDiaDoPagamento,
                            apresentarRegistro);

                        return  Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      TerceiraPagina(terreno)));
                            },
                            title: Text(terreno.titulo),
                            subtitle: Text(
                                '${(terreno.vlParcela)} - ${terreno.descricao}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            AtualizarTerreno(terreno, idTerreno, idUsuarioLogado)));
                                    //  _atualizarTerreno(terreno: terreno);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 0),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showDialog(idUsuarioLogado, idTerreno);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 0),
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });


            }
        }
      },
    );

  }


  void _showDialog(idUsuarioLogado, idTerreno) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Deseja realmente excluir o lote?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Sim"),
              onPressed: (){
                _removerTerreno(idUsuarioLogado, idTerreno);
                Navigator.of(context).pop();
              },

            ),
            new FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },

            ),
          ],
        );
      },
    );
  }

  void _removerTerreno(String idUsuarioLogado, String idTerreno) {

    String titulo                 = "";
    String cidade                 = "";
    String descricao              = "";
    String vlTotal                = "";
    String vlEntrada              = "";
    String vlParcela              = "";
    String dataPrimeiraParcela    = "";
    String dataUltimaParcela      = "";
    String dataDiaDoPagamento     = "";
    String apresentarRegistro     = "";
    Terreno terreno = new Terreno(cidade, descricao,titulo, vlParcela, vlTotal,
        vlEntrada, dataPrimeiraParcela, dataUltimaParcela, dataDiaDoPagamento, apresentarRegistro);

    terreno.excluirTerreno(idUsuarioLogado, idTerreno);


  }

  void _atualizarTerreno({Terreno terreno}) {

    String titulo                 = "";
    String cidade                 = "";
    String descricao              = "";
    String vlTotal                = "";
    String vlEntrada              = "";
    String vlParcela              = "";
    String dataPrimeiraParcela    = "";
    String dataUltimaParcela      = "";
    String dataDiaDoPagamento     = "";
    String apresentarRegistro     = "";
    Terreno terreno = new Terreno(cidade, descricao,titulo, vlParcela, vlTotal,
        vlEntrada, dataPrimeiraParcela, dataUltimaParcela, dataDiaDoPagamento, apresentarRegistro);

  //  terreno.excluirTerreno(idUsuarioLogado, idTerreno);
  }
}
