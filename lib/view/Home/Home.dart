import 'package:divbook/data/helpers/HelperDivida.dart';
import 'package:divbook/model/Divida.dart';
import 'package:divbook/view/Cliente/homeCliente.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            title: Text("Dashboard", style: TextStyle(color: Colors.white, fontSize: 20),),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage('assets/personq.png'),
                ),
              ),
              PopupMenuButton<OrderOptions>(
                itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                  const PopupMenuItem<OrderOptions>(
                    child: Text("Sair"),
                    value: OrderOptions.orderaz,
                  ),
                 /* const PopupMenuItem<OrderOptions>(
                    child: Text("Ordenar de Z-A"),
                    value: OrderOptions.orderza,
                  ),*/
                ],
               // onSelected: _orderList,
              )
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10,),
                  Text("Relação de Cadastros", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),),
                  SizedBox(height: 20,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.blue,
                                    Colors.blue.withOpacity(.7)
                                  ]
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Clientes", style: TextStyle(color: Colors.white, fontSize: 30),),
                                SizedBox(height: 20,),
                                Text("3.500", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w100),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.pink,
                                    Colors.red.withOpacity(.7)
                                  ]
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Dívidas", style: TextStyle(color: Colors.white, fontSize: 30),),
                                SizedBox(height: 20,),
                                Text("3.100", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w100),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Text("Relação de Dívidas", style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 20,),
                  Row(
                    children: <Widget>[
    
                      Expanded(
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.only(left: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.pink,
                                    Colors.red.withOpacity(.7)
                                  ]
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Receber", style: TextStyle(color: Colors.white, fontSize: 30),),
                                SizedBox(height: 20,),
                                Text(" R\$ 73.100", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w100),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    
}