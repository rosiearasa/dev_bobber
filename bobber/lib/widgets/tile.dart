import 'package:bobber/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class BobberTileTemp extends StatelessWidget {
  final int temps;

  const BobberTileTemp({required this.temps, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
          child: Center(
        child: Text(
          temps.toString(),
          style: const TextStyle(
                      backgroundColor: Color.fromARGB(255, 242, 239, 229),
              color: Colors.black54, fontSize: 34, fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}

class BobberTileTempLabel extends StatelessWidget {
  final  String  optionsTemp;
  const BobberTileTempLabel({required this.optionsTemp,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Center(
        
        child: Text(optionsTemp,  style: const TextStyle(

              color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
