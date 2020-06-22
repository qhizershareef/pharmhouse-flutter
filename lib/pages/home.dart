import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(0),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Carousel(
              images: [
                NetworkImage('https://pharmhouse.in/img/slider/b2-web.jpg'),
                NetworkImage('https://pharmhouse.in/img/slider/f.jpg'),
                NetworkImage('https://pharmhouse.in/img/slider/b3-web.jpg')
              ],
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.black,
              indicatorBgPadding: 5.0,
              dotBgColor: Colors.red[800],
              borderRadius: false,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.fromLTRB(60, 0, 20, 0),
            child: Text("FLAT 20% OFF ON ALL MEDICINES.",
                style: TextStyle(
                    letterSpacing: 2.0,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 20),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(
                    'Aim',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  subtitle: Text(
                    'To save Hard earned money of every individual by giving best possible discount in medical expense.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    'Service',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  subtitle: Text(
                    'We offer home delivery service within 24 to 36 hrs, after the order has been confirmed in Hyderabad/ Secunderabad',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.people),
                  title: Text(
                    'Refer and Earn',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  subtitle: Text(
                    'Refer your friends/ relatives to save their money in medical expenses and get 1% Extra off on next bill.\n(Referral no- Mobile number of previous customer)',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
