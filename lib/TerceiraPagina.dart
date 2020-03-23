import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_lote/SegundaPagina.dart';
import 'package:controle_lote/model/Terreno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

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


  int mandar_push(data_do_pagamento){
    var now = new DateTime.now();
    List<String> dia_pagamento = data_do_pagamento.split("/");
    //String dia_atual = now.day.toString();
    if(int.parse(dia_pagamento[0]) - now.day == 1){
      return 1;
    }
    else{
      return 99;
    }
  }

  //===============================NOTIFICAÇÃO==========================//
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;

  void _showNotification() async{
    await _demoNotification();
  }
  Future<void> _demoNotification() async{
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID', 'channel name', 'channel description',
      importance:  Importance.Max,
      priority: Priority.High,
      ticker: 'test ticker');

    var IOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, IOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, 'Vai dar o caLOTE?',
    'O dia do pagamento do seu lote está proximo', platformChannelSpecifics,
    payload: 'test oayload');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializationSettingsAndroid = new AndroidInitializationSettings('icone_app');
    initializationSettingsIOS = new IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onSelectNotification: onSelectNotification);
  }
  Future onSelectNotification(String payload) async{
    if(payload != null){
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(context,
    new MaterialPageRoute(builder: (context) => new SegundaPagina()));
  }


  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async{
    await showDialog(
      context: context,
      builder: (BuildContext context)=>CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async{
          Navigator.of(context, rootNavigator:true).pop();
          await Navigator.push(context,
           MaterialPageRoute(builder: (context)=>SegundaPagina()));
            },
          )
        ],
      )
    );
  }


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
                    Divider(),
                    RaisedButton(
                      child: Text('notificação'),
                      onPressed: _showNotification,
                    ),

                      ],
                    ),

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
