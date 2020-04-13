import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/about_me.dart';
import './components/dashboard.dart';
import './components/product_lists.dart';
import './components/add_new_item.dart';
import './models/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Yuana Silver",
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.purpleAccent,
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/Halsatu' : (BuildContext context) => new Home(),
        '/Haldua' : (BuildContext context) => new MyProfil(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Cart> _carts = [
    Cart(id: 'DW1', title: 'Kalung Liontin', nama: 'Ajik Lisa', harga: 5000, qty: 70),
    Cart(id: 'DW2', title: 'Cincin Nama', nama: 'Pan Moning', harga: 7000, qty: 40),

  ];

  void _openModal(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_){
          return AddNewItem(_addNewItem);
        });

  }

  void _addNewItem(String title, String nama, double harga, int qty) {
    final newItem = Cart(id: DateTime.now().toString(), title: title, nama: nama, harga: harga, qty: qty);
    setState(() {
      _carts.add(newItem);
    });
  }

  void _resetCarts() {
    setState(() {
      _carts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: () => _openModal(context)
      ),
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(Icons.person_outline,color: Colors.white,),
          onPressed: (){
            Navigator.pushNamed(context, '/Haldua');
          },
        ),
        title: Text("Yuana Silver"),
        actions: <Widget>[
          FlatButton(child: Icon(Icons.clear, color: Colors.white,), onPressed: () => _resetCarts(),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Dashboard(_carts),
            ProductList(_carts),
          ],
        ),
      ),

    );
  }
}


