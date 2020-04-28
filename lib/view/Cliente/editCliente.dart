import 'package:divbook/model/Cliente.dart';
import 'package:divbook/view/Cliente/homeCliente.dart';
import 'package:divbook/view/Menu/menu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class EditCliente extends StatefulWidget {
  final Cliente cliente;

  EditCliente(clienteEdited, {this.cliente});

  @override
  _EditClienteState createState() => _EditClienteState();
}

class _EditClienteState extends State<EditCliente> {
  final _nomeClienteController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _imgController = TextEditingController();
  bool _userEdited = false;
  final _nameFocus = FocusNode();
  Cliente _editCliente;

  @override
  void initState() {
    super.initState();
    if (widget.cliente == null) {
      _editCliente = Cliente();
    } else {
      _editCliente = Cliente.fromMap(widget.cliente.toMap());
      _nomeClienteController.text = _editCliente.nomeCliente;
      _enderecoController.text = _editCliente.endereco.toString();
      _telefoneController.text = _editCliente.telefone.toString();
      _imgController.text = _editCliente.img.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Cadastrar Cliente"),
            backgroundColor: Colors.blue,
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (_editCliente.nomeCliente != null &&
                  _editCliente.nomeCliente.isNotEmpty) {
                Navigator.pop(context, _editCliente);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            label: Text('Cadastrar'),
            icon: Icon(Icons.save),
            backgroundColor: Colors.blue,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _editCliente.img != null
                              ? FileImage(File(_editCliente.img))
                              : AssetImage("assets/personq.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {
                    ImagePicker.pickImage(source: ImageSource.camera)
                        .then((file) {
                      if (file == null) return;
                      setState(() {
                        _editCliente.img = file.path;
                      });
                    });
                  },
                ),
                SizedBox(height: 25.0),
                TextFormField(
                  controller: _nomeClienteController,
                  maxLength: 25,
                  focusNode: _nameFocus,
                  decoration: new InputDecoration(
                    icon: Icon(
                      Icons.person_add,
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
                    hintText: 'Nome do Cliente',
                  ),
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editCliente.nomeCliente = text;
                    });
                  },
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  controller: _enderecoController,
                  maxLength: 20,
                  decoration: new InputDecoration(
                    icon: Icon(
                      Icons.location_on,
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
                    hintText: 'Endereço',
                  ),
                  onChanged: (text) {
                    _userEdited = true;
                    _editCliente.endereco = text;
                  },
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  controller: _telefoneController,
                  maxLength: 11,
                  decoration: new InputDecoration(
                    icon: Icon(
                      Icons.phone,
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
                    hintText: 'Telefone',
                  ),
                  onChanged: (text) {
                    _userEdited = true;
                    _editCliente.telefone = int.parse(text);
                  },
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ));
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
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeCliente()),
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
