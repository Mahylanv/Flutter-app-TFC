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
              // Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailPage(newsTitle: 'News Article 1')));
            },
          ),
          // Ajoutez d'autres ListTile pour les autres articles
        ],
      ),
    );
  }
}
