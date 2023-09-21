import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _loadingUrl = false;
  String _preco = "0";

  void _PegarBitcoinDeGraca2023() async {

    setState(() => _loadingUrl = true);

    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = jsonDecode(response.body);
    
    setState(() {
      _preco = retorno["BRL"]["buy"].toString();
      _loadingUrl = false;
    });

    print("Resultado: " + retorno["BRL"]["buy"].toString() + " PILA VS " + _preco + " PILA"); // lol
  }

  @override
  void initState() {
    super.initState();
    _PegarBitcoinDeGraca2023();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Consumo de API"),
      backgroundColor: Colors.orange,),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/800px-Bitcoin.svg.png",
                  height: 180,
                  width: 180,
                  ),
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: _loadingUrl ? CircularProgressIndicator() : Text("R\$ $_preco", style: TextStyle(fontSize: 40)),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: _PegarBitcoinDeGraca2023,
                  child: Text("ATUALIZAR"),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}