import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:divbook/view/Cliente/homeCliente.dart';
import 'package:divbook/view/Divida/homeDivida.dart';
import 'package:divbook/view/Home/Home.dart';
import 'package:flutter/material.dart';


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _selectedTab = 0;
  final _pageOptions = [Screen(), HomeCliente(), HomeDivida()];
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          title: "DivBook",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Color.fromARGB(255, 4, 125, 141)),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: _pageOptions[_selectedTab],
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: _selectedTab,
               showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
              onItemSelected: (int index) {
                setState(() {
                  _selectedTab = index;
                });
              },
               items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text('Clientes'),
            activeColor: Colors.blueAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text(
              'Dívidas',
            ),
             activeColor: Colors.green,
            textAlign: TextAlign.center,
          ),
        /*  BottomNavyBarItem(
            icon: Icon(Icons.assignment_ind),
            title: Text('Perfil'),
            activeColor: Colors.orange,
            textAlign: TextAlign.center,
          ),*/
        ],
            ),
          ),
        );
  }
}
