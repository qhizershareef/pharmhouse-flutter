import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 20, 30, 0),
        child: ListView(
          children: <Widget>[
            Image.network(
              'https://pharmhouse.in/img/Logo_test.png',
              height: 200,
            ),
            SizedBox(height: 80),
            Text(
              'Address :',
              style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '8-1-229/B/37 , Madhura Hills',
              style: TextStyle(letterSpacing: 2.0, fontSize: 25.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Phone :',
              style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '+91 7670913390',
              style: TextStyle(letterSpacing: 2.0, fontSize: 25.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'E-mail :',
              style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'pharmhouse99@gmail.com',
              style: TextStyle(letterSpacing: 2.0, fontSize: 25.0),
            ),
          ],
        ),
      ),
      bottomSheet: new Container(
        height: 20.0,
        width: double.infinity,
        color: Colors.red[800],
        child: GestureDetector(
            child: Center(
                child: Text("Developed by: www.brainsmade.me",
                    style: TextStyle(
                        color: Colors.white))),
            onTap: () {
              // do what you need to duo when "Click here" gets clicked
            }),
      ),
    );
  }
}
