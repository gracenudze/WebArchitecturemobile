import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.start,
          alignment: Alignment.topCenter,
          children: [
            Container(
              child: Stack(children: [
                Container(
                  height: 270, //MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image(
                      image: AssetImage('assets/images/pebbles.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    top: 50,
                    left: 50,
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: Colors.white),
                    )),
              ]),
            ),
            Positioned(
              top: 230,
              child: Container(
                height: MediaQuery.of(context).size.width + 205,
                width: 360,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      )
                    ]),
                child: SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [],
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
