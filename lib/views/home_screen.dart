import 'package:flutter/material.dart';
import 'package:noteapp/dummy_db.dart';

import 'package:noteapp/views/widgets/List_Container/list_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextEditingController titlecon = TextEditingController();
TextEditingController descon = TextEditingController();
TextEditingController datecon = TextEditingController();
List<Map<String, String>> llsit = [];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.black,
            isScrollControlled: true,
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) => Padding(
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                                String title = titlecon.text;
                                String dec = descon.text;
                                String date = datecon.text;
                                Map note = {
                                  'titile': title,
                                  'desc': dec,
                                  'date': date,
                                };
                                DummyDb.notesList.add(note);
                                setState(() {});
                                Navigator.of(context).pop(context);
                                titlecon.clear();
                                descon.clear();
                                datecon.clear();
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    'Save',
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
            ),
          );
        },
      ),
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                  // ignore: unnecessary_null_comparison
                  itemBuilder: (context, index) => llsit != null
                      ? ListContainer(
                          desc: DummyDb.notesList[index]['desc'],
                          title: DummyDb.notesList[index]['titile'],
                          date: DummyDb.notesList[index]['date'],
                          onDelete: () {
                            setState(() {
                              DummyDb.notesList.removeAt(index);
                            });
                          },
                          onEdit: () {
                            AlertDialog(
                              content: Container(
                                height: 100,
                                width: 150,
                                child: TextFormField(),
                              ),
                              actions: [
                               
                              ],
                            );
                          },
                        )
                      : SizedBox(),
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
}
