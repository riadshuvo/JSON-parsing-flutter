import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJSON();

  runApp(new MaterialApp(
    home: new Scaffold(
        appBar: AppBar(
          title: Text("JSON parsing"),
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: _data.length,
            itemBuilder: (BuildContext contex, int position){
              return Column(
                children: <Widget>[
                  Divider(height: 3.30),
                  ListTile(
                    title: Text(" ${_data[position]["title"]}"),
                    subtitle: Text("${_data[position]["body"]}"),
                    leading: CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child: Text(_data[position]["title"][0].toUpperCase()),
                    ),
                    onTap: () => showText(contex,_data[position]["title"]),
                  )

                ],
              );
            }
        )
    ),
  ));
}

void showText(BuildContext context, String message){
  
  var alertDialouge = AlertDialog(
    title: Text(message),
    actions: <Widget>[
      FlatButton(onPressed: () => Navigator.of(context).pop(),
          child: Text('ok'))
    ],
  );

  showDialog(context: context, builder: (context){
    return alertDialouge;
  });
}


Future<List> getJSON() async {
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}
