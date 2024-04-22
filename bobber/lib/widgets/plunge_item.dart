
import 'package:flutter/material.dart';

class PlungeItem extends StatelessWidget {
  const PlungeItem({super.key});
  // {super.key, required this.plunge, required this.onSelectPlunge});

  // final Plunge plunge;

  // final void Function(Plunge plunge) onSelectPlunge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 400,
      
      child: Card(
        
        
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        elevation: 3,
        child: InkWell(
          onTap: (){},
          child: const Stack(
        
            
            children: [
              Positioned(
                
                top: 20,
                left: 20,
                right: 20,
                
                  // child: Container(
                    
                    // color: Colors.black54,
                    // padding: EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                    child: Column(children: [
                      Row(
                        children: [
                          Text(
                            "Plunge",
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 102, 102, 102)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.severe_cold_rounded,
                            color: Colors.lightBlue,
                          )
                        ],
                      ),
                      
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Today 05:00",
                        maxLines: 1,
                       
                        style: TextStyle(
                          
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color:Color.fromARGB(255, 102, 102, 102)),
                      ),
                   
                      SizedBox(
                        height: 12,
                      ),

                      Text(
                        "10 minutes",
                  
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 102, 102, 102)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "-2 degrees",
           
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20,
                            
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 102, 102, 102)),
                      ),
                    ]),
                  // ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
