import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calc());
}

class Calc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calcuater",
      theme: ThemeData(primaryColor: Colors.blue),
      home: Calcuater(),
    );
  }
}

class Calcuater extends StatefulWidget {
  @override
  _CalcuaterState createState() => _CalcuaterState();
}

class _CalcuaterState extends State<Calcuater> {
  String eq = "0" ;
  String res = "0" ;
  double eqsize = 38.0 ;
  String expression = "" ;
  double ressize = 48.0 ;
  Buttonpressed(String s){
    setState(() {
      if (s == "C"){
        eq = "0";
        res = "0";
        eqsize = 38.0 ;
        ressize = 48.0 ;
      }else if (s == "bk"){
        eq = eq.substring(0,eq.length - 1 );
        eqsize = 48.0 ;
        ressize = 38.0 ;
        if (eq == "")
        {
          eq = "0" ;
        }

      }else if (s == "="){
        eqsize = 38.0 ;
        ressize = 48.0 ;
        expression = eq ;
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel() ;
          res = '${exp.evaluate(EvaluationType.REAL, cm)}' ;
        }catch(e){
          res = "error";
        }

      }else{
        eqsize = 48.0 ;
        ressize = 38.0 ;
        if (eq == "0"){
          eq = s ;
        }else{
          eq = eq + s ;}
      }
    });

  }
  Widget buildbuttSon (Color color , String s , double h ){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * h,
      color: color,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0),side: BorderSide(
          width: 1 ,
          style: BorderStyle.solid,
          color: Colors.white ,
        )),
        padding: EdgeInsets.all(16.0),
        onPressed: () => Buttonpressed(s),
        child: Text(
          s,
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.normal , color: Colors.white),
        ),),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcuater'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              eq,
              style: TextStyle(fontSize: eqsize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              res,
              style: TextStyle(fontSize: ressize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Container(

                width: MediaQuery.of(context).size.width * .75,
                child: Table(children: [
                  TableRow(children: [
                    buildbuttSon(Colors.redAccent, 'C', 1 ),
                    buildbuttSon(Colors.blue, 'bk', 1 ),
                    buildbuttSon(Colors.blue, '/', 1 ),
                  ]),
                  TableRow(children: [
                    buildbuttSon(Colors.black54, '7', 1 ),
                    buildbuttSon(Colors.black54, '8', 1 ),
                    buildbuttSon(Colors.black54, '9', 1 ),
                  ]),
                  TableRow(children: [
                    buildbuttSon(Colors.black54, '4', 1 ),
                    buildbuttSon(Colors.black54, '5', 1 ),
                    buildbuttSon(Colors.black54, '6', 1 ),
                  ]),
                  TableRow(children: [
                    buildbuttSon(Colors.black54, '1', 1 ),
                    buildbuttSon(Colors.black54, '2', 1 ),
                    buildbuttSon(Colors.black54, '3', 1 ),
                  ]),
                  TableRow(children: [
                    buildbuttSon(Colors.black54, '.', 1 ),
                    buildbuttSon(Colors.black54, '0', 1 ),
                    buildbuttSon(Colors.black54, '00', 1 ),
                  ]),
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25 ,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildbuttSon(Colors.blue, '*', 1 ),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildbuttSon(Colors.blue, '-', 1 ),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbuttSon(Colors.blue, '+', 1 ),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildbuttSon(Colors.redAccent, '=', 2 ),
                        ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
