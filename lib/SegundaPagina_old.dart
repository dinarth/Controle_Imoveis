import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'PrimeiraPagina.dart';
import 'helper/TerrenoHelper.dart';
import 'model/Terreno_old.dart';

class SegundaPagina extends StatefulWidget {
  @override
  _SegundaPaginaState createState() => _SegundaPaginaState();

}

class _SegundaPaginaState extends State<SegundaPagina> {


  TextEditingController _controllerProprietario = TextEditingController();
  TextEditingController _controllerValor        = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');
  TextEditingController _controllerTaxa         = TextEditingController();
  TextEditingController _controllerDataDeposito = TextEditingController();
  TextEditingController _controllerValorPago    = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  var _db = TerrenoHelper();
  List<Terreno> _terrenos = List<Terreno>();
  
  _formatarData(String data){
    initializeDateFormatting('pt_BR');

    //Year -> y | Month -> M | Day -> d
    var formatador = DateFormat('d/M/y');

    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatada = formatador.format( dataConvertida );

    return dataFormatada;
  }

  _recuperarTerrenos()async{

    List terrenosRecuperados = await _db.recuperarTerrenos();

    List<Terreno> listaTemporaria = List<Terreno>();
    for ( var item in terrenosRecuperados){

      Terreno terreno = Terreno.fromMap(item);
      listaTemporaria.add(terreno);
    }

    setState((){
      _terrenos = listaTemporaria;
    });
    listaTemporaria = null;

    print('Lista terrenos: '+ terrenosRecuperados.toString());

  }

  @override
  void initState() {
    super.initState();
    _recuperarTerrenos();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus terrenos"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
          children:<Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: _terrenos.length,
                    itemBuilder: (context, index){
                      final terreno = _terrenos[index];

                      return Card(
                        child: ListTile(
                          title: Text(terreno.titulo),
                          subtitle: Text('${(terreno.dataUltimaParcela)} - ${terreno.descricao}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  _atualizarTerreno(terreno: terreno);
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
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                )
            )
          ]
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: (){
         //   _exibirTelaCadastro()  ;
          }
      ),
    );
  }

   _atualizarTerreno({Terreno terreno}) {}
   PrimeiraPagina _primeiraPagina = new PrimeiraPagina();



}
