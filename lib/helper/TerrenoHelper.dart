import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:controle_lote/model/Terreno_old.dart';

class TerrenoHelper {
  static final String nomeTabela                = 'terrenos';
  static final String colunaId                  = 'id';
  //static final String colunaPessoa              = 'cd_pss';
  static final String colunaTitulo              = 'titulo';
  static final String colunaCidade              = 'cidade';
  static final String colunaDescricao           = 'descricao';
  static final String colunaVlTotal             = 'vl_total';
  static final String colunaVlEntrada           = 'vl_entrada';
  static final String colunaVlParcela           = 'vl_parcela';
  static final String colunaDataPrimeiraParcela = 'data_primeira_parcela';
  static final String colunaDataUltimaParcela   = 'data_ultima_parcela';
  static final String colunaApresentarRegistro  = 'apresentar';

  static final TerrenoHelper _terrenoHelper = TerrenoHelper._internal();
  Database _db;

  factory TerrenoHelper(){
    return _terrenoHelper;
  }

  TerrenoHelper._internal();

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql = 'CREATE TABLE $nomeTabela (id INTEGER PRIMARY KEY AUTOINCREMENT,'
    //    ' cd_pss integer,'
        ' titulo VARCHAR,'
        ' cidade VARCHAR,'
        ' descricao TEXT,'
        ' vl_total VARCHAR,'
        ' vl_entrada VARCHAR,'
        ' vl_parcela VARCHAR,'
        ' data_primeira_parcela DATETIME,'
        ' data_ultima_parcela DATETIME)';
    await db.execute(sql);
  }


  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, 'banco_terrenos_01.db');

    var db = await openDatabase(
        localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<int> salvarTerreno(Terreno terreno) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, terreno.toMap());
    return resultado;
  }

  recuperarTerrenos()async{

    var bancoDados = await db;
    String sql = 'SELECT * FROM $nomeTabela ORDER BY id DESC';
    List terrenos = await bancoDados.rawQuery(sql);
    return terrenos;
  }

  Future<int> atualizarTerreno(Terreno terreno)async{

    var bancoDados = await db;
    await bancoDados.update(
        nomeTabela,
        terreno.toMap(),
        where: 'id = ?',
        whereArgs: [terreno.id]
    );
  }

  Future<int> removerTerreno(int id)async{

    var bancoDados = await db;
    bancoDados.delete(
        nomeTabela,
        where: 'id = ?',
        whereArgs: [id]


    );

  }



}