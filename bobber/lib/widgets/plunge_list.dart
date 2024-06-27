import 'package:bobber/controllers/plunge_controller.dart';
import 'package:bobber/models/plunge.dart';
import 'package:bobber/widgets/new_plunge_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlungeList extends StatefulWidget {
  const PlungeList({super.key});

  @override
  State<PlungeList> createState() => _PlungeListState();
}

class _PlungeListState extends State<PlungeList> {
  final Stream<QuerySnapshot> _plungesStream =
      FirebaseFirestore.instance.collection('plungetest').snapshots();

  void _addItem() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewPlunge()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _plungesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return Column(
            children: [
              const SizedBox(height: 20),
              const Text('Plunges'),
              const SizedBox(height: 20),
              Expanded(
                flex: 1,
                child: ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                            

                    
                   
                        return SizedBox(
                          height: 200,
                          width: 400,
                          child: Card(
                            margin: const EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            clipBehavior: Clip.hardEdge,
                            elevation: 3,
                            child: InkWell(
                           
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 20,
                                    left: 20,
                                    right: 20,
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text(
                                            "Plunge on ${formatter.format(data['dateTimeCompleted'].toDate())}",
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 102, 102, 102),
                                            ),
                                          ),
                                        ],
                                      ),
                                      leading: Column(
                                        children: [
                                          const Icon(
                                            Icons.severe_cold_rounded,
                                            color: Colors.lightBlue,
                                          ),
                                          Text(
                                              data['temperature'].toString()),
                                        ],
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${data['duration'].toString()} min"),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              PlungeController()
                                                  .deletePlunge(document.reference.id);
                                            },
                                            child: const Icon(Icons.delete,
                                                color: Colors.orangeAccent),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                      .toList()
                      .cast(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
