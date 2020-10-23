import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Donationform extends StatefulWidget {
  @override
  _DonationformState createState() => _DonationformState();
}

class _DonationformState extends State<Donationform> {
  String Taskname, Taskquantity, Taskunit, Taskloc, TaskContact;
  TextEditingController _tasknamecont,
      _taskquantity,
      _taskunit,
      _taskloc,
      _taskcontact;
  @override
  void initState() {
    super.initState();
    _tasknamecont = new TextEditingController();
    _taskquantity = new TextEditingController();
    _taskunit = new TextEditingController();
    _taskloc = new TextEditingController();
    _taskcontact = new TextEditingController();
  }

  int _mytasktype = 0;
  String taskval;
  void _handleTaskType(int value) {
    setState(() {
      _mytasktype = value;
      switch (value) {
        case 1:
          taskval = "Food";
          break;
        case 2:
          taskval = "Clothes";
          break;
        case 3:
          taskval = "Education";
          break;
        case 4:
          taskval = "Medicine";
          break;
        case 5:
          taskval = "others";
          break;
      }
    });
  }

  createData() {
    CollectionReference ds = FirebaseFirestore.instance.collection('Donation');
    Map<String, dynamic> tasks = {
      'Itemname': _tasknamecont.text,
      'Itemquantity': _taskquantity.text,
      'Itemunit': _taskunit.text,
      'Itemloc': _taskloc.text,
      'Itemcontact': _taskcontact.text,
      'Itemtype': taskval
    };
    print(tasks);
    ds.add(tasks).whenComplete(() => print('Task Created'));
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Giveaway',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.person),
              title: TextFormField(
                controller: _tasknamecont,
                decoration: InputDecoration(
                    labelText: "Item name: ", hintText: "eg: T-shirts"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            new ListTile(
              leading: const Icon(FontAwesomeIcons.tags),
              title: TextFormField(
                controller: _taskquantity,
                decoration: InputDecoration(
                    labelText: "Quantity: ", hintText: "eg: T-shirts"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            new ListTile(
              leading: const Icon(FontAwesomeIcons.list),
              title: TextFormField(
                controller: _taskunit,
                decoration: InputDecoration(
                    labelText: "Unit: ", hintText: "eg: T-shirts"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            new ListTile(
              leading: const Icon(Icons.location_on),
              title: TextFormField(
                controller: _taskloc,
                decoration: InputDecoration(
                    labelText: "Location: ", hintText: "eg: T-shirts"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.phone),
              title: TextFormField(
                controller: _taskcontact,
                decoration: InputDecoration(
                    labelText: "Contact: ", hintText: "eg: T-shirts"),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            new ListTile(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: _mytasktype,
                  onChanged: _handleTaskType,
                  activeColor: Colors.blue,
                ),
                Text('Food', style: TextStyle(fontSize: 10.0)),
                Radio(
                  value: 2,
                  groupValue: _mytasktype,
                  onChanged: _handleTaskType,
                  activeColor: Colors.blue,
                ),
                Text('Clothes', style: TextStyle(fontSize: 10.0)),
                Radio(
                  value: 3,
                  groupValue: _mytasktype,
                  onChanged: _handleTaskType,
                  activeColor: Colors.blue,
                ),
                Text('Education', style: TextStyle(fontSize: 10.0)),
                Radio(
                  value: 4,
                  groupValue: _mytasktype,
                  onChanged: _handleTaskType,
                  activeColor: Colors.blue,
                ),
                Text('Medicine', style: TextStyle(fontSize: 10.0))
              ],
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createData();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Donation added'),
          ));
        },
      ),
    );
  }
}
