import 'package:controle_lote/helper/TerrenoHelper.dart';

class Terreno{

  int id;
  String titulo;
  String cidade;
  String descricao;
  String vlTotal;
  String vlEntrada;
  String vlParcela;
  String dataPrimeiraParcela;
  String dataUltimaParcela;
  String apresentarRegistro;


  Terreno(this.titulo, this.cidade, this.descricao, this.vlTotal, this.vlEntrada,
      this.vlParcela, this.dataPrimeiraParcela, this.dataUltimaParcela, this.apresentarRegistro);

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
}