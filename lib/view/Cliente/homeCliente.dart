import 'package:divbook/data/helpers/HelperCliente.dart';
import 'package:divbook/data/helpers/HelperDivida.dart';
import 'package:divbook/model/Cliente.dart';
import 'package:divbook/view/Cliente/editCliente.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions { orderaz, orderza }

class HomeCliente extends StatefulWidget {
  @override
  _HomeClienteState createState() => _HomeClienteState();
}

class _HomeClienteState extends State<HomeCliente> {
  HelperCliente helper = HelperCliente();
  HelperDivida helperDivida = HelperDivida();
  List<Cliente> clientes = List();

  @override
  void initState() {
    super.initState();
    _getAllClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(
          
        title: Text("Clientes", style: TextStyle(
              fontSize: 20.0,
              color: Colors.white) ,
      
        ),
          backgroundColor: Colors.blue,
          
          
        
          actions: <Widget>[
            PopupMenuButton<OrderOptions>(
              itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                const PopupMenuItem<OrderOptions>(
                  child: Text("Ordenar de A-Z"),
                  value: OrderOptions.orderaz,
                ),
                const PopupMenuItem<OrderOptions>(
                  child: Text("Ordenar de Z-A"),
                  value: OrderOptions.orderza,
                ),
              ],
              onSelected: _orderList,
            )
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showHomeCliente();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                child: _ClientesCard(context, index),
                key: UniqueKey(),
                onDismissed: (direction) {
                  HelperCliente.getInstance().delete(clientes[index].id);

                  //snackbar
                  final snackbar = SnackBar(
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                    content: Text("Cliente removido com Sucesso!"),
                  );

                  Scaffold.of(context).showSnackBar(snackbar);
                },
              );
            }));
  }

  //função que retorna um widget

  Widget _ClientesCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: clientes[index].img != null
                          ? FileImage(File(clientes[index].img))
                          : AssetImage("assets/personq.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(" "+
                      clientes[index].nomeCliente.toUpperCase(),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " Endereço: " + clientes[index].endereco.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      " Telefone: " + clientes[index].telefone.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        clientes.sort((a, b) {
          return a.nomeCliente
              .toLowerCase()
              .compareTo(b.nomeCliente.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        clientes.sort((a, b) {
          return b.nomeCliente
              .toLowerCase()
              .compareTo(a.nomeCliente.toLowerCase());
        });
        break;
    }
    setState(() {});
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Ligar",
                          style: TextStyle(color: Colors.blue, fontSize: 20.0),
                        ),
                        onPressed: () {
                          launch("tel:${clientes[index].telefone}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Editar",
                          style: TextStyle(color: Colors.blue, fontSize: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showHomeCliente(cliente: clientes[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Excluir",
                          style: TextStyle(color: Colors.blue, fontSize: 20.0),
                        ),
                        onPressed: () {
                          helperDivida.deleteDividaFromCliente(clientes[index].id);
                          helper.delete(clientes[index].id);
                          setState(() {
                            clientes.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void _showHomeCliente({Cliente cliente}) async {
    final recCliente = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditCliente(true, cliente: cliente)));
    if (recCliente != null) {
      if (cliente != null) {
        await helper.update(recCliente);
        _getAllClientes();
      } else {
        await helper.save(recCliente);
      }
      _getAllClientes();
    }
  }

  void _getAllClientes() {
    helper.getAll().then((list) {
      setState(() {
        clientes = list;
      });
    });
  }
}
