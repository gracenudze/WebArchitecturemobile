// ignore: import_of_legacy_library_into_null_safe
import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);

  signOut() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Signing Out'),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ]),
      backgroundColor: Theme.of(context).primaryColorLight,
      duration: Duration(seconds: 2),
    ));
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('\home');
    });
    return _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weaver',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              icon: FaIcon(FontAwesomeIcons.signOutAlt), onPressed: signOut),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(itemBuilder: /*1*/ (context, i) {
      if (i.isOdd) return Divider(); /*2*/

      final index = i ~/ 2;
      if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10)); /*4*/
      }
      return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here ...
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Save Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
