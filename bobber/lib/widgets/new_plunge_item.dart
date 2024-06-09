import 'package:bobber/controllers/savedata_controller.dart';
import 'package:bobber/models/plunge.dart';
import 'package:bobber/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPlunge extends StatefulWidget {
  const NewPlunge({super.key});

  @override
  State<NewPlunge> createState() {
    return _NewPlungeState();
  }
}

class _NewPlungeState extends State<NewPlunge> {
//always delete with dispose

  final _titleController = TextEditingController();

  final _durationController = TextEditingController();

  late var _plungeDate = DateTime.now();
  late FixedExtentScrollController _tempControler;

  //figure out what to do with the temp
  @override
  void initState() {
    super.initState();
    _tempControler = FixedExtentScrollController();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: now);

    if (pickedDate != null) {
      setState(() {
        _plungeDate = pickedDate;
      });
    }

    //this line executes after the async await has been executed
  }

  final _formKey = GlobalKey<FormState>();

  // void _saveItem() {

  //   _formKey.currentState!.save();
  // }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: LayoutBuilder(builder: (ctx, constraints) {
            return SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 48, 16, keyBoardSpace + 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('Plunge Title'),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length <= 1 ||
                              value.trim().length > 50) {
                            return "Error";
                          }
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      TextFormField(
                        controller: _durationController,
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        decoration: const InputDecoration(
                          suffixText: 'Minutes',
                          label: Text("Duration"),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Must be a valid temperature";
                          }
                        },
                      ),
                      const SizedBox(width: 24),
                      const Text(
                        "Set Temperature",
                        style: TextStyle(fontSize: 24),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 80,
                            child: ListWheelScrollView.useDelegate(
                              controller: _tempControler,
                              perspective: 0.005,
                              diameterRatio: 1.2,
                              physics: const FixedExtentScrollPhysics(),
                              itemExtent: 50,
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 10,
                                  builder: (context, index) {
                                    return BobberTileTemp(
                                      temps: -index,
                                    );
                                  }),
                            ),
                          ),
                          const SizedBox(width: 60),
                          SizedBox(
                            height: 160,
                            width: 150,
                            child: ListWheelScrollView.useDelegate(
                              perspective: 0.005,
                              diameterRatio: 1.2,
                              physics: const FixedExtentScrollPhysics(),
                              itemExtent: 50,
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 1,
                                  builder: (context, index) {
                                    return const BobberTileTempLabel(
                                      optionsTemp: 'Celcius',
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _plungeDate == null
                                  ? 'No Date Selected'
                                  : formatter.format(_plungeDate),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  _formKey.currentState!.reset();
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final plunge = Plunge(
                                      dateTimeStarted: _plungeDate,
                                      dateTimeCompleted: _plungeDate,
                                      duration: int.parse(
                                          _durationController.text.toString(),
                                          radix: 10),
                                      temperature: int.parse(
                                          _tempControler.selectedItem
                                              .toString(),
                                          radix: 10),
                                    );

                                    Get.lazyPut(() => SaveDataController
                                        .instance
                                        .createPlunge(plunge));
                                  }
                                  _formKey.currentState!.save();
                                },
                                child: const Text("Add Plunge"),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
