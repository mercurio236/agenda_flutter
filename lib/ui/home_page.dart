import 'package:agenda_flutter/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  /*   Contact c = Contact();

    c.name = 'Arley';
    c.email = 'arley.souto@hotmail.com';
    c.phone = '61984495952';
    c.img = '';

    helper.saveContact(c); */

    helper.getAllContacts().then((list){
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Agenda',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
