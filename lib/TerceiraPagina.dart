import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_lote/model/Terreno.dart';
import 'package:flutter/material.dart';

class TerceiraPagina extends StatefulWidget {
  final Terreno terreno;

  TerceiraPagina(this.terreno);

  @override
  _TerceiraPaginaState createState() => _TerceiraPaginaState(terreno);
}

class _TerceiraPaginaState extends State<TerceiraPagina> {
  final Terreno terreno;
  Firestore db = Firestore.instance;
  String idUsuarioLogado = 'LniQVMDb1bRvDVetHaHt5c5VhiB2';
  //String terreno                = '003';

  _TerceiraPaginaState(this.terreno);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Controle de Terrenos"),
        ),
        body: Container(
            child: SingleChildScrollView(
                padding: EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Detalhamento do Terreno",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Título:"),
                        Text("${terreno.titulo}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Cidade: "),
                        Text("${terreno.cidade}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Valor da Parcela: "),
                        Text("${terreno.vlParcela}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Valor Total: "),
                        Text("${terreno.vlTotal}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Valor da Entrada: "),
                        Text("${terreno.vlEntrada}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Data da Primeira Parcela: "),
                        Text("${terreno.dataPrimeiraParcela}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Data da Última Parcela: "),
                        Text("${terreno.dataUltimaParcela}")
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Dia do Pagamento: "),
                        Text("${terreno.dataDiaDoPagamento}")
                      ],
                    ),
                  ],
                )
            )
        )
    );
  }

  String _buildTerrenoText(DocumentSnapshot snapshot) {
    String text = "Título: \n";
    for (DocumentSnapshot t in snapshot.data['titulo']) {
      text += "${t['titulo']}";
    }
    text += "Parcela: R\$ ${snapshot.data['vlParcela'].toStringAsFixed(2)}";
    return text;
  }

  String _buildTerrenoText2(DocumentSnapshot snapshot) {
    String text = "Título: \n";
    for (LinkedHashMap t in snapshot.data['terreno']) {
      text += "${t['titulo']}";
    }
    text += "Parcela: R\$ ${snapshot.data['vlParcela'].toStringAsFixed(2)}";
    return text;
  }
}
