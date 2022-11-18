import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  SecondPage({required this.id});
  String id='';


  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String str='';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),



              "Cast"),
        ),
        body: SingleChildScrollView(child:
        Column(
          children: [
            FutureBuilder(
                future: api(widget.id.toString()),
                builder: (context, snapshot) {if (snapshot.hasData ) return Column(children:[ for(var i=0;i< (snapshot.data.length-1);i=i+2) Row(mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      if(snapshot.data[i]['person']['image']==null)
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                            child:Container(height: 150,width: 150,color: Colors.black,))
                      else
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                          child: Image.network(
                            snapshot.data[i]['person']['image']['original']
                            ,height: 150,width: 150,),
                        )
                      ,SizedBox(width: 300,child:Text(snapshot.data[i]['person']['name'].toString(),
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white),)),
                      if(snapshot.data[i+1]['person']['image']==null)
                        Padding(
                            padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                            child: Container(height: 150,width: 150,color: Colors.black,))
                      else
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                          child: Image.network(
                            snapshot.data[i+1]['person']['image']['original']
                            ,height: 150,width: 150,),
                        )
                      ,Text(snapshot.data[i+1]['person']['name'].toString(),
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white),)
                    ])]);
                else return Container();})
          ],
        )));
  }
}
//
Future api(String id)async {
  final url = Uri.parse(
      "https://api.tvmaze.com/shows/$id/cast");
  final response = await http.get(url);
  print(response.body);
  var json = jsonDecode(response.body);
  return json;
}