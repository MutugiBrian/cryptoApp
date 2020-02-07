import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List currencies;
  final List<MaterialColor> _colors = [Colors.blue,Colors.red,Colors.green];

 

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Crypto App"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 4.0
      ),
      body:  _cryptoWidget(),

      
    );
  }

  Widget _cryptoWidget(){

    return new Container(
      child: Column(
        children: <Widget>[
          new Flexible(
                      child: new ListView.builder(
              itemCount:widget.currencies.length,
              itemBuilder: (BuildContext context, int index){
                final Map currency = widget.currencies[index];
                final MaterialColor color = _colors[index%_colors.length];


                return _getListItemUi(currency,color);

            }
    ),
          ),
        ],
      )
    );

  }

  Widget _getListItemUi(Map currency , MaterialColor color){
    return ClipRRect(
          borderRadius: BorderRadius.circular(18.0),
          child: Card(
            elevation: 1.5,
            child: new Container(
            //  margin:new EdgeInsets.only(top:7.0,bottom:7.0,right:5.0,left:5.0),
             decoration: new BoxDecoration(
               //borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              gradient: new LinearGradient(colors: [Colors.yellow[800], color],
              begin: Alignment.centerLeft, end: Alignment.centerRight, tileMode: TileMode.clamp)),
              child: new ListTile(

                
            
             leading: new CircleAvatar(
               backgroundColor: color,
               child:new Text(currency['name'][0]),
             ),
             title: new Text(currency['name'],
               style: new TextStyle(fontWeight:FontWeight.bold)
             ),
             subtitle: _getSubtitleText(currency['price_usd'],currency['percent_change_1h']),
             isThreeLine: true,
             trailing: new FloatingActionButton(
                 child: new Icon(FontAwesomeIcons.chartLine,color: color,),
                 onPressed: (){

                 },
                 backgroundColor: Colors.white,
                 splashColor: Colors.blue,
               )
             
            //  trailing: new Icon(FontAwesomeIcons.chartArea)
          ),
        ),
      ),
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange){
    TextSpan priceTextWidget = new TextSpan(text:"\$$priceUSD\n",style: new TextStyle(color: Colors.black));
    String percentageChangeText = "1 Hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;
     if(double.parse(percentageChange) > 0){
       percentageChangeTextWidget = new TextSpan(
         text: percentageChangeText,
         style: new TextStyle(
           color:Colors.green,
           fontWeight: FontWeight.bold
         )
       );
     }else{
       percentageChangeTextWidget = new TextSpan(
         text: percentageChangeText,
         style: new TextStyle(
           color:Colors.red,
           fontWeight: FontWeight.bold
         )
       );
     }


     return new RichText(
       text:new TextSpan(
         children: [
           priceTextWidget,
           percentageChangeTextWidget
         ])
       );







  }
}