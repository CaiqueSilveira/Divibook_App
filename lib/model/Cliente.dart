import 'package:divbook/data/helpers/HelperCliente.dart';

class Cliente {
  int _id;
  String _nomeCliente;
  String _endereco;
  int _telefone;
   String _img;

  Cliente({int id, String nomeCliente, String endereco, int telefone, String img}) {
    this._id = id;
    this._nomeCliente = nomeCliente;
    this._endereco = endereco;
    this._telefone = telefone;
    this._img = img;
  }

  int get id => _id;

  set id(int id) => this._id = id;

  String get nomeCliente => _nomeCliente;

  String get img => _img;

  set nomeCliente(String nomeCliente) => this._nomeCliente = nomeCliente;

  set img(String img) => this._img = img;

  String get endereco => _endereco;

  set endereco(String endereco) => this._endereco = endereco;

  int get telefone => this._telefone;

  set telefone(int telefone) => this._telefone = telefone;

  Cliente.fromMap(Map map) {
    _id = map[HelperCliente.idColumn];
    _nomeCliente = map[HelperCliente.nomeColumn];
    _telefone = map[HelperCliente.telefoneColumn];
    _endereco = map[HelperCliente.enderecoColumn];
    _img = map[HelperCliente.imgColumn];
  }
  Map toMap() {
    Map<String, dynamic> map = {
      HelperCliente.nomeColumn: nomeCliente,
      HelperCliente.telefoneColumn: telefone,
      HelperCliente.enderecoColumn: endereco,
      HelperCliente.imgColumn: img
    };

    if (id != null) {
      map[HelperCliente.idColumn] = id;
    }
    return map;
  }
}
