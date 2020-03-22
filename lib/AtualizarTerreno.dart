import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_lote/model/Terreno.dart';
import 'package:controle_lote/model/Usuario.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';

class AtualizarTerreno extends StatefulWidget {
  final Terreno terreno;
  final String idTerreno;
  final String idUsuarioLogado;

  AtualizarTerreno(this.terreno, this.idTerreno, this.idUsuarioLogado);

  @override
  State <AtualizarTerreno> createState() {
    return _AtualizarTerrenoState(this.terreno, this.idTerreno, this.idUsuarioLogado);
  }
}

class _AtualizarTerrenoState extends State<AtualizarTerreno> {
  final Terreno terreno;
  String idTerreno;
  String idUsuarioLogado;
  Firestore db = Firestore.instance;
  int anoAtual = DateTime.now().year;

  _AtualizarTerrenoState(this.terreno, this.idTerreno, this.idUsuarioLogado): super();

  TextEditingController _tituloController                = TextEditingController();
  TextEditingController _cidadeController                = TextEditingController();
  TextEditingController _descricaoController             = TextEditingController();
  TextEditingController _vlTotalTerrenoController        = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.',leftSymbol: 'R\$');
  TextEditingController _vlEntradaTerrenoController      = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.',leftSymbol: 'R\$');
  TextEditingController _vlParcelaTerrenoController      = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.',leftSymbol: 'R\$');
  TextEditingController _dataPrimeiraParcelaController   = TextEditingController();
  TextEditingController _dataUltimaParcelaController     = TextEditingController();
  TextEditingController _dataDiaDoPagamentoController    = TextEditingController();



  void _carregarCampos(){

    _tituloController.text              = terreno.titulo;
    _cidadeController.text              = terreno.cidade;
    _descricaoController.text           = terreno.descricao;
    _vlTotalTerrenoController.text      = currencyConverse(terreno.vlTotal);
    _vlEntradaTerrenoController.text    = currencyConverse(terreno.vlEntrada);
    _vlParcelaTerrenoController.text    = currencyConverse(terreno.vlParcela);
    _dataPrimeiraParcelaController.text = terreno.dataPrimeiraParcela;
    _dataUltimaParcelaController.text   = terreno.dataUltimaParcela;
    _dataDiaDoPagamentoController.text  = terreno.dataDiaDoPagamento;

  }

  String currencyConverse(String valorMoeda){
    if (valorMoeda.length >4){
      valorMoeda = valorMoeda.replaceAll('.', '');
    }
    valorMoeda = valorMoeda.replaceAll(',', '.');
    return valorMoeda;
  }




  @override
  void initState() {
    super.initState();

      _carregarCampos();
  }

  final format = DateFormat("dd/MM/yyyy");

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
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text("Atualizar Terreno",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),

                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                          labelText: "Título",


                      ),
                      style: TextStyle(
                          fontSize: 22
                      ),

                      controller: _tituloController,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                          labelText: "Cidade"
                      ),
                      style: TextStyle(
                          fontSize: 22
                      ),
                      controller: _cidadeController,
                    ),

                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Valor total do terreno, ex: 80.000,00"
                      ),
                      style: TextStyle(
                          fontSize: 22
                      ),
                      controller: _vlTotalTerrenoController,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Valor da entrada, ex: 5.000,00"
                      ),
                      style: TextStyle(
                          fontSize: 22
                      ),
                      controller: _vlEntradaTerrenoController,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Valor da parcela, ex: 500,00"
                      ),
                      style: TextStyle(
                          fontSize: 22
                      ),
                      controller: _vlParcelaTerrenoController,
                    ),

                    DateTimeField(
                      format: format,
                      onShowPicker: (context, currentValue){
                        return showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(anoAtual),
                            lastDate: DateTime(anoAtual + 6));
                      },
                      controller: _dataPrimeiraParcelaController,
                      style: TextStyle(
                          fontSize: 22
                      ),
                      decoration: InputDecoration(
                          labelText: "Data da primeira parcela"
                      ),

                    ),
                    DateTimeField(
                      format: format,
                      onShowPicker: (context, currentValue){
                        return showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(anoAtual),
                            lastDate: DateTime(anoAtual + 15));
                      },
                      controller: _dataUltimaParcelaController,
                      style: TextStyle(
                          fontSize: 22
                      ),
                      decoration: InputDecoration(
                          labelText: "Data da última parcela"
                      ),

                    ),
                    DateTimeField(
                      format: format,
                      onShowPicker: (context, currentValue){
                        return showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(anoAtual),
                            lastDate: DateTime(anoAtual + 20));
                      },
                      controller: _dataDiaDoPagamentoController,
                      style: TextStyle(
                          fontSize: 22
                      ),
                      decoration: InputDecoration(
                          labelText: "Dia do pagamento"
                      ),

                    ),



                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Salvar",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                        onPressed: (){
                          _atualizarTerreno(this.idTerreno, this.idUsuarioLogado);

                        },
                      ),
                    ),

                  ],

                ),
              ),
            )

    );
  }


  void _atualizarTerreno(String idTerreno, String idUsuarioLogado) {
    String titulo                 = _tituloController.text;
    String cidade                 = _cidadeController.text;
    String descricao              = _descricaoController.text;
    String vlTotal                = _vlTotalTerrenoController.text.substring(2);
    String vlEntrada              = _vlEntradaTerrenoController.text.substring(2);
    String vlParcela              = _vlParcelaTerrenoController.text.substring(2);
    String dataPrimeiraParcela    = _dataPrimeiraParcelaController.text;
    String dataUltimaParcela      = _dataUltimaParcelaController.text;
    String dataDiaDoPagamento     = _dataDiaDoPagamentoController.text;
    String apresentarRegistro     = '1';
//    String idUsuarioLogado        = uid;

    //criando objeto Terreno
    Terreno terreno               =  Terreno(cidade, descricao,titulo, vlParcela, vlTotal, vlEntrada, dataPrimeiraParcela, dataUltimaParcela, dataDiaDoPagamento, apresentarRegistro);

    terreno.alterarTerreno(terreno, idUsuarioLogado, idTerreno);

  }
}
