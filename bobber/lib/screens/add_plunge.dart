// //a screen to manually add the plunge data.
// import 'package:bobber/data/dummydata.dart';
// import 'package:bobber/models/plunge.dart';
// import 'package:bobber/widgets/new_plunge_item.dart';
// import 'package:flutter/material.dart';

// class AddPlunge extends StatefulWidget {
//   const AddPlunge({super.key});
//   final String title = 'Add Data Manually';

//   @override
//   State<StatefulWidget> createState() {
//     return _PlungeState();
//   }
// }

// class _PlungeState extends State<AddPlunge> {
//   void _openAddPlungeOverlay() {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (ctx) =>const  NewPlunge());
//   }

//   void _addPlunge(Plunge plunge) {
//     setState(() {
//       plungeItems.add(plunge);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     //shows a list of the data collected from the user



//     return Scaffold(
//       appBar: AppBar(),
//       body: const NewPlunge()
   
//     );
//     //cards in a column widget
//   }
// }
