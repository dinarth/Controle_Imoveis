import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_lote/model/Terreno.dart';
import 'package:controle_lote/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:scoped_model/scoped_model.dart';


import 'model/Terreno.dart';

class PrimeiraPagina extends StatefulWidget {
  @override
  _PrimeiraPaginaState createState() => _PrimeiraPaginaState();
}

class _PrimeiraPaginaState extends State<PrimeiraPagina> {
  TextEditingController _tituloController              = TextEditingController();
  TextEditingController _cidadeController              = TextEditingController();
  TextEditingController _descricaoController           = TextEditingController();
  TextEditingController _vlTotalTerrenoController      = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.',leftSymbol: 'R\$');
  TextEditingController _vlEntradaTerrenoController    = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.',leftSymbol: 'R\$');
  TextEditingController _vlParcelaTerrenoController    = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.',leftSymbol: 'R\$');
  TextEditingController _dataPrimeiraParcelaController = TextEditingController();
  TextEditingController _dataUltimaParcelaController   = TextEditingController();
  TextEditingController _dataDiaDoPagamentoController  = TextEditingController();

  Usuario usuario = new Usuario();

//  var _db = TerrenoHelper();
  int anoAtual = DateTime.now().year;
  String _textoResultado = "";

  /*
  double valorPresente;
  String _textoResultado = "";

  //TextEditingController _controllerCheque      = TextEditingController();
  TextEditingController _controllerCheque      = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.',leftSymbol: 'R\$');
  TextEditingController _controllerPorcentagem = TextEditingController();
  TextEditingController _controllerData        = TextEditingController();
*/






//  calcularChequeObj();

  String currencyConverse(String valorMoeda){
    if (valorMoeda.length >4){
      valorMoeda = valorMoeda.replaceAll('.', '');
    }
    valorMoeda = valorMoeda.replaceAll(',', '.');
    return valorMoeda;
  }

/*
  void _calcular(){

    // _controllerCheque.text.

    double valorCheque = double.tryParse( currencyConverse(_controllerCheque.text.substring(2))) ;
    //double valorCheque = valorChequeOriginal
    double valorPorcentagem = double.tryParse( currencyConverse(_controllerPorcentagem.text )) ;
    String valorData = _controllerData.text;

    DateTime dataHoje = DateTime.now();

    int dia = int.parse(valorData.substring(0,2));
    int mes = int.parse(valorData.substring(3,5));
    int ano = int.parse(valorData.substring(6));

    //the birthday's date
    final compensacao = DateTime(ano, mes , dia);
    final difference = compensacao.difference(dataHoje).inDays;

    double n;
    n = difference / 30;

    if (valorCheque == null || valorPorcentagem == null || valorData == null){
      setState(() {
        _textoResultado = ("Valores inválidos. Digite números maiores que 0.");
      });

    }else{
      setState(() {

        valorPresente = valorCheque / pow( (1 + (valorPorcentagem/100)), n);
        // PV = FV / (1+i)n

        //_textoResultado = mes.toString();
        FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
            amount: valorPresente,
            settings: MoneyFormatterSettings(
              symbol: 'R\$',
              thousandSeparator: '.',
              decimalSeparator: ',',
              symbolAndNumberSeparator: ' ',
              fractionDigits: 2,
            )
        );


        _textoResultado = "A pagar:" + fmf.output.symbolOnLeft;
      });
    }

  }


*/
  final format = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:ScopedModelDescendant<Usuario>(
        builder: (context, child, model){
      return Container(

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
                child: Text("Cadastrar Terreno",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),

                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Título"
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
                    "Cadastrar",
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  onPressed: (){
                    _validarCampos(model.firebaseUser.uid.toString());
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:20),
                child: Text(
                  _textoResultado,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],

          ),
        ),
      );
          },
      )
    );
  }

// DateFormat(String s) {}


  _validarCampos(String idUsuarioLogado) {
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

    terreno.cadastrarTerreno(terreno, idUsuarioLogado);

    _tituloController.text              = "";
    _cidadeController.text              = "";
    _descricaoController.text           = "";
    _vlTotalTerrenoController.text      = "0.00";
    _vlEntradaTerrenoController.text    = "0.00";
    _vlParcelaTerrenoController.text    = "0.00";
    _dataPrimeiraParcelaController.text = "";
    _dataUltimaParcelaController.text   = "";
    _dataDiaDoPagamentoController.text  = "";

  }

  _cadastrarTerreno( Terreno terreno){
    //Salvar terreno
    Firestore db = Firestore.instance;

    db.collection("terrenos")
        .document("LniQVMDb1bRvDVetHaHt5c5VhiB2")
        .collection("terreno")
        .document()
        .setData(terreno.toMap());


  }


  /*
  _salvarAtualizarTerreno({Terreno terrenoSelecionado}) async{

  String titulo                 = _tituloController.text;
  String cidade                 = _cidadeController.text;
  String descricao              = _descricaoController.text;
  String vlTotal                = _vlTotalTerrenoController.text.substring(2);
  String vlEntrada              = _vlEntradaTerrenoController.text.substring(2);
  String vlParcela              = _vlParcelaTerrenoController.text.substring(2);
  String dataPrimeiraParcela    = _dataPrimeiraParcelaController.text;
  String dataUltimaParcela      = _dataUltimaParcelaController.text;
  String apresentarRegistro     = '1';

  if(terrenoSelecionado == null) { //salvando
    Terreno terreno = Terreno(titulo, cidade, descricao, vlTotal, vlEntrada, vlParcela, dataPrimeiraParcela,dataUltimaParcela, apresentarRegistro);
    int resultado = await _db.salvarTerreno(terreno);

    _textoResultado = "Terreno inserido com sucesso.";

  }else{//atualizar
    terrenoSelecionado.titulo                 = titulo;
    terrenoSelecionado.cidade                 = cidade;
    terrenoSelecionado.descricao              = descricao;
    terrenoSelecionado.vlTotal                = vlTotal;
    terrenoSelecionado.vlEntrada              = vlEntrada;
    terrenoSelecionado.vlParcela              = vlParcela;
    terrenoSelecionado.dataPrimeiraParcela    = dataPrimeiraParcela;
    terrenoSelecionado.dataUltimaParcela      = dataUltimaParcela;
    terrenoSelecionado.apresentarRegistro     = apresentarRegistro;

    int resultado = await _db.atualizarTerreno(terrenoSelecionado);
  }

  _tituloController.clear();
  _cidadeController.clear();
  _descricaoController.clear();
  _vlTotalTerrenoController.clear();
  _vlEntradaTerrenoController.clear();
  _vlParcelaTerrenoController.clear();
  _dataPrimeiraParcelaController.clear();
  _dataUltimaParcelaController.clear();

//  _recuperarTerrenos();
  //SegundaPagina();
}



 */


}