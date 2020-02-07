import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List currencies;

  @override
  void initState() async{
   super.initState();
   currencies = await getCurrencies(); 
  }

  Future<List> getCurrencies() async {
    String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
    http.Response response = await http.get(cryptoUrl);
    return jsonDecode(response.body);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Crypto App")
      ),
      body:  _cryptoWidget(),

      
    );
  }

  Widget _cryptoWidget(){

    return new Container(
      child: new ListView.builder(
        itemCount:0,
        itemBuilder:(BuildContext context, int index){

      }
    )
    );

  }
}