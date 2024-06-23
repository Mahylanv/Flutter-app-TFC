// import 'package:flutter/material.dart';
// import '../player_model.dart'; // Assurez-vous d'importer correctement votre modèle de joueur

// class PlayerDetailsPage extends StatelessWidget {
//   final Player player;

//   const PlayerDetailsPage({Key? key, required this.player}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(player.name),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Center(
//               child: CircleAvatar(
//                 backgroundImage: NetworkImage(player.photoUrl),
//                 radius: 50,
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Position: ${player.position}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Nationalité: ${player.nationality}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Âge: ${player.age}',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Pied fort: ${player.strongFoot}',
//               style: TextStyle(fontSize: 18),
//             ),
//             // Ajoutez d'autres détails selon les besoins
//           ],
//         ),
//       ),
//     );
//   }
// }
