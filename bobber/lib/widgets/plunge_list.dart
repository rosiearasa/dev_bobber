import 'package:flutter/material.dart';
import 'package:bobber/data/dummydata.dart';


class PlungeList extends StatelessWidget {
  const PlungeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plunges"),
      ),
      body: 
      
      
      ListView.builder(
        itemCount: plungeItems.length,
        itemBuilder: (ctx, index) => 
        SizedBox(
      height: 200,
      width: 400,
        child:
        Card(
             margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        elevation: 3,
        child: InkWell(
          
          onTap: () {},
          child:  Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                right: 20,

          child: ListTile(
            title: Row(
              children: [
                Text("Plunge on ${plungeItems[index].FormattedDate}",
                  maxLines: 1,
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 102, 102, 102),),
                                  ),
                                     
                  
          
              ],
            ),
            leading: 
            Column(
              children: [
                      const Icon(
                          Icons.severe_cold_rounded,
                          color: Colors.lightBlue,
                        ),
                Text("${plungeItems[index].temperature}"),
              ],
            ),
            trailing: Text("${plungeItems[index].duration.toString()} min"),
          ),
        ),
            ],
    )
    ),
    )
     ) 
    ),
    );
  }
}
