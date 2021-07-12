import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroPage extends StatelessWidget {
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
                height: MediaQuery.of(context).size.height /
                    3, //MediaQuery.of(context).size.width,
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
                  left: MediaQuery.of(context).size.width / 4,
                  // +
                  //     (MediaQuery.of(context).size.width / 3) / 3,
                  child: Text(
                    'Weaver',
                    style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).accentColor,
                        decoration: TextDecoration.none),
                  )),
              Positioned(
                  right: 10,
                  bottom: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.instagram,
                        size: 35,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FaIcon(
                        FontAwesomeIcons.twitter,
                        size: 35,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FaIcon(
                        FontAwesomeIcons.linkedin,
                        size: 35,
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  )),
            ]),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3 - 20,
            child: Container(
              height: MediaQuery.of(context).size.height / 3 +
                  MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 200,
                    margin: EdgeInsets.only(bottom: 15.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: FlatButton(
                      child: Text('Join Us'),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('\signup');
                      },
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    margin: EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: FlatButton(
                      child: Text('Log In'),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('\signin');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
