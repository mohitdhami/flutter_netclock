import 'dart:async';

import 'package:flutter/material.dart';

class SecTab extends StatefulWidget {
  SecTab({Key key}) : super(key: key);

  @override
  _SecTabState createState() => _SecTabState();
}

class _SecTabState extends State<SecTab> {
  var ctr = 0;
  var playpr = false;
  bool ctrIncrement;
  var pause2play = 0;
  
  void player(){
    setState(() {
      playpr = true;
      ctrIncrement = true;
    });
    Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        if(ctrIncrement)
          ctr++;
      });
      if(pause2play>0){
        timer.cancel();
        pause2play--;
        }
    },);
  }
  //fn--
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 220,
                height: 45,
                padding: EdgeInsets.only(left: 20, top: 10),
                child: (ctr == 0)
                    ? Text('')
                    : Text(
                        '${ctr.toString()}secs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink[400],
                ),
              ),
              FlatButton(
                  onPressed: (){
                    setState(() {
                      ctr = 0;
                    });
                  },
                  
                  child: Container(
                  width: 70,
                  height: 45,
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.only(left: 3, top: 3),
                  child: Icon(Icons.restore, color: Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[400],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 180),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                (playpr)?
              FlatButton(
                onPressed: (){
                  setState(() {
                    ctrIncrement = false;
                    playpr = false;
                    pause2play++;
                  });
                },
                child: Icon(
                  Icons.pause_circle_filled,
                  color: Colors.red[700],
                  size: 70,
                ),
              ):
              FlatButton(
                onPressed:player,
                child: Icon(
                  Icons.play_circle_filled,
                  color: Colors.green[500],
                  size: 70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
