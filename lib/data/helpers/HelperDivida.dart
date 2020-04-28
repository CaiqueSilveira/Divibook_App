import 'dart:async';

import 'package:divbook/data/helpers/HelperBase.dart';
import 'package:divbook/data/helpers/HelperCliente.dart';
import 'package:divbook/model/Divida.dart';
import 'package:sqflite/sqflite.dart';

class HelperDivida extends HelperBase<Divida> {
  static final String dividaTable = "tb_divida";
  static final String idColumn = "id";
  static final String descricaoColumn = "descricao";
  static final String valorColumn = "valor";
  static final String dataColumn = "data_compra";
  static final String quantidadeColumn = "quantidade";
  static final String idClienteColumn = "id_cliente";
  static final HelperDivida _instance = HelperDivida.getInstance();

  factory HelperDivida() => _instance;

  HelperDivida.getInstance();

  @override
  Future<int> delete(int id) async {
    return db.then((database) async {
      return await database
          .delete(dividaTable, where: "$idColumn = ?", whereArgs: [id]);
    });
  }

  Future<int> deleteDividaFromCliente(int idCliente) async {
    return db.then((database) async{
      return await database.delete(dividaTable, where: "$idClienteColumn = ?", whereArgs: [idCliente]);

    });

  }

Future<List> getDividas() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT DISTINCT d.${HelperDivida.descricaoColumn}, d.${HelperDivida.valorColumn}, d.${HelperDivida.dataColumn}, d.${HelperDivida.valorColumn}, c.${HelperCliente.nomeColumn} FROM $dividaTable AS d "
                                                "INNER JOIN ${HelperCliente.clienteTable} AS c ON c.${HelperCliente.idColumn} = d.${HelperDivida.idClienteColumn}");
        List<Divida> lista = List();
        for (Map m in listMap) {
          lista.add(Divida.fromMap(m));
        }
        return lista;
      });


@override
Future<List> getAll() async => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM  $dividaTable");
        List<Divida> lista = List();
        for (Map m in listMap) {
          lista.add(Divida.fromMap(m));
        }
        return lista;
      });

  Future<List> getAllCliente(int id) async =>
      db.then((database) async {
        List listMap = await database.query(
            dividaTable, where: "$idClienteColumn = ?", whereArgs: [id]);
        List<Divida> lista = List();
        for (Map m in listMap) {
          
          lista.add(Divida.fromMap(m));
        }
        return lista;
      });

  @override
  Future<Divida> getFirst(int id) async =>
      db.then((database) async {
        List<Map> maps = await database.query(dividaTable,
            columns: [
              idColumn,
              descricaoColumn,
              valorColumn,
              dataColumn,
              quantidadeColumn
            ],
            where: "$idColumn = ?",
            whereArgs: [id]);

        if (maps.length > 0) {
          return Divida.fromMap(maps.first);
        } else {
          return null;
        }
      });

  @override
  Future<int> getNumber() async {
    return Sqflite.firstIntValue(await db.then((database) {
      return database.rawQuery("SELECT COUNT(*) FROM $dividaTable");
    }));
  }

  @override
  Future<Divida> save(Divida divida) async {
    db.then((database) async {
      await database.insert(dividaTable, divida.toMap());
    });
    return divida;
  }

  @override
  Future<int> update(Divida data) async =>
      await db.then((database) {
        return database.update(dividaTable, data.toMap(),
            where: "$idColumn = ?", whereArgs: [data.id]);
      });

  
}
