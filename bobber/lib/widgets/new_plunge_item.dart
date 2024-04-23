import 'package:bobber/models/plunge.dart';
import 'package:flutter/material.dart';


class NewPlunge extends StatefulWidget {
  const NewPlunge({super.key, required this.onAddPlunge});

  final void Function(Plunge plunge) onAddPlunge;

  @override
  State<NewPlunge> createState() {
    return _NewPlungeState();
  }
}

class _NewPlungeState extends State<NewPlunge> {
//always delete with dispose

  final _titleController = TextEditingController();

  final _durationController = TextEditingController();

  DateTime? _plungeDate;
  final _temperatureController = TextEditingController();
  
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _plungeDate = pickedDate;
    });

    //this line executes after the async await has been executed
  }
  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {


      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyBoardSpace + 16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Plunge Title'),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
              TextField(
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    decoration: const InputDecoration(
                      suffixText: 'Minutes',
                      label: Text("Duration"),
                    ),
                  ),
            TextField(
                    controller: _temperatureController,
                    keyboardType: const TextInputType.numberWithOptions(signed: true,),
                    maxLength: 5,
                    decoration: const InputDecoration(
                      // TODO MAKE THIS ENUM FOR DROPDOWN TO SELECT
                      suffixText: 'C/F',
                      label: Text("Temperature"),
                    ),
                  ),
       
                const SizedBox(width: 24),
                const SizedBox(width: 24),
              Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _plungeDate == null
                                ? 'No Date Selected'
                                : formatter.format(_plungeDate!),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),

                       Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Save Plunge"),
                      ),
                    ],
                  )
             

              ],
            ),
          ),
        ),
      );
    });
  }
}
