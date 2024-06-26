import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualités'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('News Article 1'),
            onTap: () {
              // Navigation vers les détails de l'article
            },
          ),
          // Ajoutez d'autres ListTile pour les autres articles
        ],
      ),
    );
  }
}
