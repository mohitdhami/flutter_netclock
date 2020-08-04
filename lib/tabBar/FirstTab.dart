import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class FirstTab extends StatefulWidget {
  FirstTab({Key key}) : super(key: key);

  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  var hVal = 1;
  var mVal = 1;
  var sVal = 1;
  var ctr;
  bool startpr = false;
  bool lock = false;
  var ctr2hour;
  var ctr2min;
  var ctr2sec;
  var popAlert = false;
   
  //Here Goes the Timer Logic
    timerlog(){
      ctr = ((hVal*60*60)+(mVal*60)+sVal);
       Timer.periodic(Duration(seconds: 1),
       (timer){
         setState(() {
           if(ctr==null && lock== false){
                lock = true;
                timer.cancel();
              }
              if(ctr==0){
                setState(() {
                  startpr =false;
                  ctr = null;
                  popAlert = true;
                });
              }
                else ctr--;
                
           ctr2hour = (ctr~/3600);
           ctr2min = (ctr%3600)~/60;
           ctr2sec = (ctr%3600)%60;
           startpr = true;
           lock = false;
         });
      });
    }
    stopper(){
      setState(() {
       ctr = null;
        startpr = false;
      });
    }
  
  
  @override
  Widget build(BuildContext context) {
    return (popAlert)?
    Container(
      color:Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black87,
            ),
            child: Column(
              children: <Widget>[
           Container(
            padding: EdgeInsets.all(20) ,
            margin: EdgeInsets.only(left:30,right:30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              color: Colors.pink
            ),
            child: Text('Time Over',  
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          
          FlatButton(
            onPressed: (){
              setState(() {
                popAlert = false;
              });
            },
            child: Container(
              margin: EdgeInsets.all(40),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green[600]
              ),
              child: Text('  OK  ',  
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ),
              ],
            ),
          )
        ],
      ),
    ):
      Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
               Container(
              width: 320,
              height: 45,
              padding: EdgeInsets.only(left:20,top: 10),
              child: (ctr==null)?Text(''):
              (ctr2hour!=0)?
              Text('${ctr2hour}H ${ctr2min}M ${ctr2sec}S',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              ):
              (ctr2min!=0)?
              Text('${ctr2min}M ${ctr2sec}S',
               style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              ):
               Text('${ctr2sec}S',
               style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              ),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black87,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  'HOUR',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink[400],
                ),
              ),
              Container(
                child: Text(
                  'MIN',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red[500],
                ),
              ),
              Container(
                child: Text(
                  'SEC',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple[400],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: NumberPicker.integer(
                  initialValue: hVal,
                  minValue: 0,
                  maxValue: 24,
                  onChanged: (val) {
                    setState(() {
                      hVal = val;
                    });
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: NumberPicker.integer(
                    initialValue: mVal,
                    minValue: 0,
                    maxValue: 59,
                    onChanged: (val) {
                      setState(() {
                        mVal = val;
                      });
                    }),
              ),
              Container(
                color: Colors.white,
                child: NumberPicker.integer(
                    initialValue: sVal,
                    minValue: 0,
                    maxValue: 59,
                    onChanged: (val) {
                      setState(() {
                        sVal = val;
                      });
                    }),
              ),
            ],
          ),
          SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: (!startpr)?timerlog:null,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'START',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (!startpr)?
                    Colors.green[600]:
                    Colors.green[200],
                    ),
                ),
              ),
              FlatButton(
                onPressed: (startpr)?stopper:null,
                child: Container(
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                  child: Text(
                    'STOP',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (startpr)?
                    Colors.red[500]:
                    Colors.red[300],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
