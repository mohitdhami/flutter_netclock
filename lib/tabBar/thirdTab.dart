import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class ThirdTab extends StatefulWidget {
  ThirdTab({Key key}) : super(key: key);

  @override
  _ThirdTabState createState() => _ThirdTabState();
}

class _ThirdTabState extends State<ThirdTab> {
  
  //Json Variables
  var mydata;
  var yyyy;
  var mm;
  var mname;
  var dd;
  var hh;
  var ampm;
  var mn;
  var ss;
  var dayname;
  //JSON VARS

  //JSON Functions
  void daynum2dayname() {
    var daynum = mydata['day_of_week'];
    switch (daynum) {
      case 0:
        dayname = 'Sunday';
        break;
      case 1:
        dayname = 'Monday';
        break;
      case 2:
        dayname = 'Tuesday';
        break;
      case 3:
        dayname = 'Wednesday';
        break;
      case 4:
        dayname = 'Thrusday';
        break;
      case 5:
        dayname = 'Friday';
        break;
      case 6:
        dayname = 'Saturday';
        break;
    }
  }

  void ddmmyyyy() {
    yyyy = mydata['datetime'].substring(0, 4);
    //datetime-mm
    if (mydata['datetime'].substring(5, 6) == '0')
      mm = mydata['datetime'].substring(6, 7);
    else
      mm = mydata['datetime'].substring(5, 7);
    //...
    //datetime-dd
    if (mydata['datetime'].substring(8, 9) == '0')
      dd = mydata['datetime'].substring(9, 10);
    else
      dd = mydata['datetime'].substring(8, 10);
    //....
    //month number to name
    switch (mm) {
      case '1':
        mname = 'January';
        break;
      case '2':
        mname = 'February';
        break;
      case '3':
        mname = 'March';
        break;
      case '4':
        mname = 'April';
        break;
      case '5':
        mname = 'May';
        break;
      case '6':
        mname = 'June';
        break;
      case '7':
        mname = 'July';
        break;
      case '8':
        mname = 'August';
        break;
      case '9':
        mname = 'September';
        break;
      case '10':
        mname = 'October';
        break;
      case '11':
        mname = 'November';
        break;
      case '12':
        mname = 'December';
        break;
    } //...
  }

  void hhmnss() {
    //datetime-hh
    if (mydata['datetime'].substring(11, 12) == '0') {
      ampm = 'AM';
      if (mydata['datetime'].substring(12, 13) == '0')
        hh = 12;
      else
        hh = (mydata['datetime'].substring(12, 13));
    } else {
      // matching 13-23 below
      for (int i = 0; i < 11; i++) {
        if (int.parse(mydata['datetime'].substring(11, 13)) == 13+i) hh = i + 1;
        if (i == 0) ampm = 'PM';
      }
      // matching 10-12 below
      for (int i = 0; i < 3; i++) {
        if (int.parse(mydata['datetime'].substring(11, 13)) == 10+i) {
          if (i == 2) ampm = 'PM';
          if (i == 0 || i == 1) ampm = 'AM';
          hh = mydata['datetime'].substring(11, 13);
        }
      }
    }

    //...
    //datetime-mn
    if (mydata['datetime'].substring(14, 15) == '0')
      mn = mydata['datetime'].substring(15, 16);
    else
      mn = mydata['datetime'].substring(14, 16);
    //.....
  }

  //..JSON FN

  var url = 'http://worldtimeapi.org/api/ip';
  var jsonBody;

  Future datetimejson() async {
    var resp = await http.get(url);

    if (resp.statusCode == 200)
      jsonBody = convert.jsonDecode(resp.body.toString());
    return jsonBody;
  }

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    return Container(
      color: Colors.red[200],
      child: FutureBuilder(
          future: datetimejson(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
               mydata = snapshot.data;
              daynum2dayname();
              ddmmyyyy();
              hhmnss();
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 50, right: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Text(
                            '$dd $mname $yyyy',
                            style: TextStyle(
                              color: Colors.pink[600],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          ' $hh:$mn $ampm',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$dayname',
                          style: TextStyle(
                            color: Colors.pink[700],
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              
                    SizedBox(height: devicesize.height * 0.35),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: Text('<Zone> ${mydata['timezone']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white70,
                        ),
                      ),
                      ),
                  ],
                ),
              );
            } else {
              return Flexible(
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 6),
                ),
              );
            }
          }),
    );
}
}
