import 'package:flutter/material.dart';
import 'package:noteapp/dummy_db.dart';
import 'package:noteapp/utils/color_constant.dart/color_const.dart';

import 'package:noteapp/views/widgets/List_Container/list_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  TextEditingController titlecon = TextEditingController();
  TextEditingController descon = TextEditingController();
  TextEditingController datecon = TextEditingController();
  // List<Map<String, String>> llsit = [];
  List noteColor = [
    ColorConst.darkGreen,
    ColorConst.lighBrown,
    ColorConst.lighMaron,
    ColorConst.lightBlue
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          titlecon.clear();
          descon.clear();
          datecon.clear();
          showModelBottomSheet(context);
        },
      ),
      backgroundColor: Colors.grey,
      appBar: AppBar(
        // backgroundColor: noteColor[selectedIndex],
        title: Text('To-Do App'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => ListContainer(
                        col: noteColor[DummyDb.notesList[index]['color']],
                        desc: DummyDb.notesList[index]['desc'],
                        title: DummyDb.notesList[index]['titile'],
                        date: DummyDb.notesList[index]['date'],
                        onDelete: () {
                          setState(() {
                            DummyDb.notesList.removeAt(index);
                          });
                        },
                        onEdit: () {
                          setState(() {});
                          titlecon.text = DummyDb.notesList[index]['titile'];
                          descon.text = DummyDb.notesList[index]['desc'];
                          datecon.text = DummyDb.notesList[index]['date'];

                          showModelBottomSheet(context,
                              isedit: true, index: index);
                        },
                      ),
                  separatorBuilder: (context, index) => Divider(
                        endIndent: 40,
                        indent: 40,
                        color: Colors.black,
                        thickness: 1,
                      ),
                  itemCount: DummyDb.notesList.length),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> showModelBottomSheet(BuildContext context,
      {bool isedit = false, int? index}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, bottonsetState) {
          selectedIndex = selectedIndex ?? 0;
          return Container(
            color: noteColor[selectedIndex],
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isedit ? 'update note' : 'Add a note',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      TextFormField(
                        controller: titlecon,
                        decoration: InputDecoration(
                            fillColor: Colors.grey,
                            filled: true,
                            hintText: 'Title',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: descon,
                        maxLines: 3,
                        decoration: InputDecoration(
                            fillColor: Colors.grey,
                            filled: true,
                            hintText: 'Description',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: datecon,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            fillColor: Colors.grey,
                            filled: true,
                            hintText: 'date',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          noteColor.length,
                          (index) => GestureDetector(
                            onTap: () {
                              selectedIndex = index;
                              bottonsetState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: noteColor[index],
                                    border: Border.all(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        width: 2)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isedit) {
                                DummyDb.notesList[index!] = {
                                  'titile': titlecon.text,
                                  'desc': descon.text,
                                  'date': datecon.text,
                                  'color': selectedIndex,
                                };
                              } else {
                                DummyDb.notesList.add({
                                  'titile': titlecon.text,
                                  'desc': descon.text,
                                  'date': datecon.text,
                                  'color': selectedIndex,
                                });
                              }
                              setState(() {});
                              Navigator.of(context).pop(context);
                            },
                            child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  isedit ? 'Update' : 'Save',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
