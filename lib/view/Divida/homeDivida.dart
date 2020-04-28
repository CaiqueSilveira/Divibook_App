

import 'package:divbook/data/helpers/HelperDivida.dart';
import 'package:divbook/model/Cliente.dart';
import 'package:divbook/model/Divida.dart';
import 'package:divbook/view/Divida/editDivida.dart';
import 'package:flutter/material.dart';

enum OrderOptions { orderaz, orderza }

class HomeDivida extends StatefulWidget {
  @override
  _HomeDividaState createState() => _HomeDividaState();
}

class _HomeDividaState extends State<HomeDivida> {
  HelperDivida helper = HelperDivida();
  List<Divida> dividas = List();


  @override
  void initState() {
    super.initState();

    _getAllDividas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           title: Text("Dívidas", style: TextStyle(
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
            _showHomeDivida();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: dividas.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                direction: DismissDirection.endToStart,
                child: _alunosCard(context, index),
                onDismissed: (direction) {
                  HelperDivida.getInstance().delete(dividas[index].id);

                  setState(() {
                    dividas.removeAt(index);
                  });
                  //snackbar
                  final snackbar = SnackBar(
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                    content: Text("Dívida removida com Sucesso!"),
                  );

                  Scaffold.of(context).showSnackBar(snackbar);
                },
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
              );
            }));
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderaz:
        dividas.sort((a, b) {
          return a.descricao.toLowerCase().compareTo(b.descricao.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        dividas.sort((a, b) {
          return b.descricao.toLowerCase().compareTo(a.descricao.toLowerCase());
        });
        break;
    }
    setState(() {});
  }

  //função que retorna um widget

  Widget _alunosCard(BuildContext context, int index) {
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
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: AssetImage("assets/produto.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Expanded(

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                   Text(

                     " Cliente: " +
                      dividas[index].cliente.nomeCliente.toString(),
                     style: TextStyle(
                         fontSize: 20.0, fontWeight: FontWeight.bold),

                    ),
                    Text(
                      " Produto: " + dividas[index].descricao.toString(),
                      style: TextStyle(
                          fontSize: 18.0),
                    ),
                    Text(
                      " Valor: R\$ " + dividas[index].valor.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      " Data da Compra: " + dividas[index].dataCompra,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      " Quantidade: " +
                          dividas[index].quantidade.toString() +
                          " unidade(s)",
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
                          "Editar",
                          style: TextStyle(color: Colors.blue, fontSize: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showHomeDivida(divida: dividas[index]);
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
                          helper.delete(dividas[index].id);
                          setState(() {
                            dividas.removeAt(index);
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

  void _showHomeDivida({Divida divida}) async {
    final recDivida = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditDivida(true, divida: divida)));
    if (recDivida != null) {
      if (divida != null) {
        await helper.update(recDivida);
        _getAllDividas();
      } else {
        await helper.save(recDivida);
      }
      _getAllDividas();
    }
  }

  void _getAllDividas() {
    helper.getDividas().then((list) {
      setState(() {
        dividas = list;
        print(dividas);
      });
    });
  }
}
