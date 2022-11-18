import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Fourthpage extends StatefulWidget {
  Fourthpage({required this.sn,required this.id});

  String sn='';
 String id='';

  @override
  State<Fourthpage> createState() => _FourthpageState();
}

class _FourthpageState extends State<Fourthpage> {
  String str = '';

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


              "Episodes"),
        ),
        body: SingleChildScrollView(child:
        Column(
            children: [ FutureBuilder(future: api(widget.id.toString(),widget.sn.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Column(children: [
                      for(var i in snapshot.data) if(i['season']==int.parse(widget.sn)) Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [  Image.network(
                            i['image']['original']
                            ,height: 200,width: 200,),Container(width: 20,),Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [Text("Season : "+i['season'].toString(),style: TextStyle(color: Colors.white),),Text(style: TextStyle(color: Colors.white),"Episode : "+i['number'].toString()),
 Container(height: 20,),                             Text("Title : "+i['name'],style: TextStyle(color: Colors.white),),Container(height: 20,),SizedBox(width: 1300,child:Text("Summary : "+i['summary'].replaceAll('<p',"").replaceAll(r'</p',"").replaceAll('<b>',"").replaceAll('</b',"").replaceAll('<p>',"").replaceAll('>',""),style: TextStyle(color: Colors.white))
                            )                          ],)
                          ]
                      )
                    ]
                    );

                  else
                    return Container();
                })
            ]
        )
        )
    );
  }
}

    Future api(String tv,String sn)async {
      final url = Uri.parse(
          "https://api.tvmaze.com/shows/$tv/episodes");
      final response = await http.get(url);

      var json =jsonDecode(response.body);


      return json;
    }
