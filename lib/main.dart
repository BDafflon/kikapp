import 'dart:async';

import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Kikourou CPLA'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> sortieList = List<String>.generate(10, (i) => "$i/03/2021 - 12 Km validés (14Km)");
  bool playing = false;
  double km=0.0;
  double vitesse = 0.0;

  final _formKey = GlobalKey<FormState>();


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_run)),
                Tab(icon: Icon(Icons.watch_later_outlined)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
            title: Text('Kikourou solidaire'),
          ),
          body: TabBarView (
            children: [
              Center(child:
              Column(

                children: [
                  Container(
                      alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(3.0),
                    width: double.infinity,

                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text("Challenge : Courir pour les autres 2021",style: TextStyle(fontSize: 100.0)),
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new LinearPercentIndicator(

                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 40.0,
                      percent: 0.2,
                      center: Text("20.0% | 11000Kms"),
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: Colors.green,
                    ),
                  ),

                  Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(3.0),
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 30.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text("blablabla challenge asso..."),
                      )
                  )
                  ,
                  Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(3.0),
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 100.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text("Km : $km", style: TextStyle(fontSize: 100.0)),
                      )
                  )
                  ,
                  Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.all(3.0),
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 100.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text("Vitesse moyenne : $vitesse" ,style: TextStyle(fontSize: 25.0)),
                      )
                  )


                ],
              ),
              ),

              Center(child:
              ListView.separated(
                itemCount: sortieList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(' ${sortieList[index]}'),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
              ),
              Center(child:
              Form(
                key: _formKey,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(

                      // The validator receives the text that the user has entered.
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Pseudo'
                ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 50),
                    TextFormField(
                      obscureText: true,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            hintText: 'Mots de passe'
                        ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Processing Data')));
                          }
                        },

                        child: Text('Connexion'),
                      ),
                    ),
                  ],
                ),
              )
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: ()  {
                print('tap');


                if(playing) {

                  showAlertDialog(context);
                  setState((){
                    playing = false;
                  });

                } else if (!playing){
                  setState((){
                    playing = true;
                  });

                }
              },
              tooltip: 'Play Music',
              child: playing?new Icon(Icons.pause):new Icon(Icons.play_arrow)
          ),
        )
    );
  }

  showAlertDialog(BuildContext context) {  // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Annuler"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("OK"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );  // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Terminer l'activité ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );  // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
