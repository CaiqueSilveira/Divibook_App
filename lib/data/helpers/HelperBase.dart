import 'package:divbook/data/helpers/HelperCliente.dart';
import 'package:divbook/data/helpers/HelperDivida.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class HelperBase<T> {
  static final String dataBaseName = "divibook.db";
  Database _database;

  Future<T> getFirst(int id);

  Future<T> save(T data);

  Future<int> delete(int id);

  Future<int> update(T data);

  Future<List> getAll();

  Future<int> getNumber();

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dataBaseName);

    return await openDatabase(path, version: 1, onCreate: _create);
  }

  Future _create(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperDivida.dividaTable}(${HelperDivida.idColumn} INTEGER PRIMARY KEY, ${HelperDivida.descricaoColumn} "
        "TEXT, ${HelperDivida.quantidadeColumn} INTEGER, ${HelperDivida.dataColumn} TEXT, ${HelperDivida.valorColumn} DOUBLE, ${HelperDivida.idClienteColumn} INTEGER,"
        "FOREIGN KEY(${HelperDivida.idClienteColumn}) REFERENCES ${HelperCliente.clienteTable}(${HelperCliente.idColumn}))");
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ${HelperCliente.clienteTable}(${HelperCliente.idColumn} INTEGER PRIMARY KEY, ${HelperCliente.nomeColumn} TEXT, ${HelperCliente.enderecoColumn} TEXT, ${HelperCliente.telefoneColumn} INTEGER, ${HelperCliente.imgColumn} TEXT)");
         
  }
}
