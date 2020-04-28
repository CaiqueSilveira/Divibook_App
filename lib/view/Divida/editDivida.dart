import 'package:divbook/data/helpers/HelperCliente.dart';
import 'package:divbook/model/Cliente.dart';
import 'package:divbook/model/Divida.dart';
import 'package:divbook/view/Cliente/homeCliente.dart';
import 'package:divbook/view/Divida/homeDivida.dart';
import 'package:divbook/view/Menu/menu.dart';
import 'package:flutter/material.dart';

class EditDivida extends StatefulWidget {
  final Divida divida;

  EditDivida(dividaEdited, {this.divida});

  @override
  _EditDividaState createState() => _EditDividaState();
}

class _EditDividaState extends State<EditDivida> {
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _dataCompraController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _idClienteController = TextEditingController();
  List<Cliente> clientes = List();
  bool _userEdited = false;

  final _nameFocus = FocusNode();
  Divida _editDivida;
  String dropdown = "Atribua a Dívida a um Cliente";

  @override
  void initState() {
    super.initState();
    HelperCliente.getInstance().getAll().then((list) {
      setState(() {
        clientes = list;
      });
    });
    if (widget.divida == null) {
      _editDivida = Divida();
    } else {
      _editDivida = Divida.fromMap(widget.divida.toMap());
      _descricaoController.text = _editDivida.descricao.toString();
      _valorController.text = _editDivida.valor.toString();
      _dataCompraController.text = _editDivida.dataCompra.toString();
      _quantidadeController.text = _editDivida.quantidade.toString();
      _idClienteController.text = _editDivida.idCliente.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cadastrar Dívida"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_editDivida.descricao != null &&
                _editDivida.descricao.isNotEmpty) {
              Navigator.pop(context, _editDivida);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          label: Text('Salvar'),
          icon: Icon(Icons.save),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              FutureBuilder<List>(
                future: HelperCliente.getInstance().getAll(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton<Cliente>(
                      isExpanded: false,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      underline: Container(
                        height: 2,
                        color: Colors.blueAccent,
                      ),
                      items: snapshot.data
                          .map((cliente) => DropdownMenuItem<Cliente>(
                                child: Text(cliente.nomeCliente),
                                value: cliente,
                              ))
                          .toList(),
                      onChanged: (Cliente value) {
                        setState(() {
                          _editDivida.idCliente = value.id;
                          dropdown = value.nomeCliente;
                        });
                      },
                      hint: Text(dropdown),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(height: 25.0),
              TextFormField(
                controller: _descricaoController,
                maxLength: 22,
                decoration: new InputDecoration(
                  icon: Icon(
                    Icons.book,
                    color: Colors.blue,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  hintText: 'Produto',
                ),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editDivida.descricao = text;
                  });
                },
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                controller: _valorController,
                maxLength: 10,
                decoration: new InputDecoration(
                  icon: Icon(
                    Icons.monetization_on,
                    color: Colors.blue,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  hintText: 'Valor',
                ),
                onChanged: (text) {
                  _userEdited = true;

                  _editDivida.valor = double.parse(text);
                },
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _dataCompraController,
                maxLength: 10,
                decoration: new InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  hintText: 'Data',
                ),
                onChanged: (text) {
                  _userEdited = true;
                  _editDivida.dataCompra = text;
                },
                keyboardType: TextInputType.datetime,
              ),
              TextFormField(
                controller: _quantidadeController,
                maxLength: 5,
                decoration: new InputDecoration(
                  icon: Icon(
                    Icons.category,
                    color: Colors.blue,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  hintText: 'Quantidade',
                ),
                onChanged: (text) {
                  _userEdited = true;
                  _editDivida.quantidade = int.parse(text);
                },
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
