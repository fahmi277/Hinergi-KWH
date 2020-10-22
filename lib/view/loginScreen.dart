import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  loginScreen();

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 48.0),
            // Padding(
              // padding: EdgeInsets.all(8.0),
                // child: 
                TextFormField(
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    initialValue: 'alucard@gmail.com',
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
              ),

            // ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              // child: Material(
              //   borderRadius: BorderRadius.circular(30.0),
              //   shadowColor: Colors.lightBlueAccent.shade100,
              //   elevation: 5.0,
                child: MaterialButton(
                  minWidth: 200.0,
                  shape: StadiumBorder(),
                  height: 42.0,
                  onPressed: () {
                    // Navigator.of(context).pushNamed(HomePage.tag);
                  },
                  color: Colors.lightBlueAccent,
                  child: Text('Log In', style: TextStyle(color: Colors.white)),
                ),
              // ),
            )
          ]
        )
      )
    );
  }
}