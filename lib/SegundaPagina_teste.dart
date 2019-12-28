import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'PrimeiraPagina.dart';
import 'helper/TerrenoHelper.dart';
import 'model/Terreno.dart';
import 'TerceiraPagina.dart';

class SegundaPagina extends StatelessWidget {

//  final String type;
  final Terreno terreno;

  List<Terreno> _terrenos       = List();
  final _controller             = StreamController<QuerySnapshot>.broadcast();
  Firestore db                  = Firestore.instance;
  String idUsuarioLogado        = 'LniQVMDb1bRvDVetHaHt5c5VhiB2';


  SegundaPagina(this.terreno);



  _formatarData(String data){
    initializeDateFormatting('pt_BR');

    var formatador = DateFormat('d/M/y');

    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format( dataConvertida );

    return dataFormatada;
  }

  int cont = 0;

  Stream<QuerySnapshot> _recuperarListenerTerrenos() {
    final stream = db.collection("terrenos")
        .document(idUsuarioLogado)
        .collection("terreno")
        .where("apresentarRegistro", isEqualTo: '1')
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
      cont++;
    });

  }



  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
     stream: _controller.stream,
     builder: (context, snapshot){
       switch (snapshot.connectionState){
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
           if(snapshot.hasError){
             return Text("Erro ao carregar terrenos.");
           }else{
             QuerySnapshot querySnapshot = snapshot.data;
             if(querySnapshot.documents.length == 0){
               return Center(
                 child: Text(
                   "Você não possui terreno(s).",
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold
                   ),
                 ),
               );
             }//chave do IF
             return ListView.builder(
                 itemCount: querySnapshot.documents.length,
                 itemBuilder: (context, index){
                   List<DocumentSnapshot> terrenos = querySnapshot.documents.toList();
                   DocumentSnapshot item = terrenos[index];

                   //String cidade       = item['cidade'];
                   //String descricao    = item['descricao'];
                   //String titulo       = item['titulo'];
                   //String vlParcela    = item['vlParcela'];

                   print(terreno.titulo);

                   return Card(

                     child: ListTile(
                       onTap: (){
                         Navigator.of(context).push(
                           MaterialPageRoute(builder: (context)=>TerceiraPagina(terreno))
                         );
                       },
                       title: Text('Teste agora'),
                       subtitle: Text('${(terreno.vlParcela)} - ${terreno.descricao}'),
                       trailing: Row(
                         mainAxisSize: MainAxisSize.min,
                         children: <Widget>[
                           GestureDetector(
                             onTap: (){
                               //_atualizarTerreno(terreno: terreno);
                             },
                             child: Padding(
                               padding: EdgeInsets.only(right:0),
                               child:  Icon(
                                 Icons.edit,
                                 color: Colors.green,
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               // _removerTerreno(terreno.id);
                             },
                             child: Padding(
                               padding: EdgeInsets.only(right:0),
                               child:  Icon(
                                 Icons.delete_forever,
                                 color: Colors.red,
                               ),
                             ),
                           )
                         ],
                       ),
                     ),
                   );
                 }
             );
           }




       }
     },

    );

  }

   _atualizarTerreno({Terreno terreno}) {}
   PrimeiraPagina _primeiraPagina = new PrimeiraPagina();



}
