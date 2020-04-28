import 'package:divbook/data/helpers/HelperDivida.dart';
import 'package:divbook/model/Cliente.dart';

class Divida {
  int _id;
  String _descricao;
  int _quantidade;
  String _dataCompra;
  double _valor;
  int _idCliente;
  Cliente _cliente;

  Divida(
      {int id,
      String descricao,
      int quantidade,
      String dataCompra,
      double valor,
      int idCliente}) {
    this._id = id;
    this._descricao = descricao;
    this._quantidade = quantidade;
    this._dataCompra = dataCompra;
    this._valor = valor;
    this._idCliente = idCliente;
  }

  int get id => _id;

  set id(int id) => this._id = id;

  String get descricao => _descricao;

  set descricao(String descricao) => this._descricao = descricao;

  int get quantidade => _quantidade;

  set quantidade(int quantidade) => this._quantidade = quantidade;

  String get dataCompra => this._dataCompra;

  set dataCompra(String dataCompra) => this._dataCompra = dataCompra;

  double get valor => _valor;

  set valor(double valor) => this._valor = valor;

  int get idCliente => this._idCliente;

  set idCliente(int idCliente) => this._idCliente = idCliente;

  Cliente get cliente => _cliente;

  set cliente(Cliente cliente) {
    this._cliente = cliente;
    this._idCliente = this._cliente.id;
  }

  Divida.fromMap(Map map) {
    _id = map[HelperDivida.idColumn];
    _descricao = map[HelperDivida.descricaoColumn];
    _valor = map[HelperDivida.valorColumn];
    _dataCompra = map[HelperDivida.dataColumn];
    _quantidade = map[HelperDivida.quantidadeColumn];
    _idCliente = map[HelperDivida.idClienteColumn];


  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperDivida.descricaoColumn: descricao,
      HelperDivida.valorColumn: valor,
      HelperDivida.dataColumn: dataCompra,
      HelperDivida.quantidadeColumn: quantidade,
      HelperDivida.idClienteColumn: idCliente,
    };

    if (id != null) {
      map[HelperDivida.idColumn] = id;
    }
    return map;
  }
}
