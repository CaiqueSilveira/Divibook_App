import 'dart:async';
import 'package:divbook/data/helpers/HelperBase.dart';
import 'package:divbook/model/Cliente.dart';
import 'package:sqflite/sqflite.dart';

class HelperCliente extends HelperBase<Cliente> {
  static final String clienteTable = "tb_cliente";
  static final String idColumn = "id";
  static final String nomeColumn = "nome";
  static final String enderecoColumn = "endereco";
  static final String telefoneColumn = "telefone";
  static final String imgColumn = "imgColumn";
  static final HelperCliente _instance = HelperCliente.getInstance();

  factory HelperCliente() => _instance;

  HelperCliente.getInstance();

  @override
  Future<int> delete(int id) async {
    return db.then((database) async {
      return await database
          .delete(clienteTable, where: "$idColumn = ?", whereArgs: [id]);
    });
  }

  @override
  Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM  $clienteTable");
        List<Cliente> lista = List();
        for (Map m in listMap) {
          lista.add(Cliente.fromMap(m));
        }
        return lista;
      });

  @override
  Future<Cliente> getFirst(int id) async => db.then((database) async {
        List<Map> maps = await database.query(clienteTable,
            columns: [idColumn, nomeColumn, enderecoColumn, telefoneColumn, imgColumn],
            where: "$idColumn = ?",
            whereArgs: [id]);

        if (maps.length > 0) {
          return Cliente.fromMap(maps.first);
        } else {
          return null;
        }
      });

  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $clienteTable");
    }));
  }

  @override
  Future<Cliente> save(Cliente cliente) async {
    db.then((database) async {
      await database.insert(clienteTable, cliente.toMap());
    });
    return cliente;
  }

  @override
  Future<int> update(Cliente data) async => await db.then((database) {
        return database.update(clienteTable, data.toMap(),
            where: "$idColumn = ?", whereArgs: [data.id]);
      });
}
