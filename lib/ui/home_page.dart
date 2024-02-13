import 'dart:ffi';
import 'dart:io';

import 'package:agenda_flutter/helpers/contact_helper.dart';
import 'package:agenda_flutter/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Contatos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _contactsCards(context, index);
          },
        ),
      ),
    );
  }

  Widget _contactsCards(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: contacts[index].img != ''
                        ? DecorationImage(
                            image: FileImage(File(contacts[index].img!)))
                        : DecorationImage(
                            image: AssetImage("images/person.png"),
                            fit: BoxFit.cover)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contacts[index].name ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Text(
                        contacts[index].email ?? '',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        contacts[index].phone ?? '',
                        style: TextStyle(fontSize: 18),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Ligar",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showContactPage(contact: contacts[index]);
                          },
                          child: Text(
                            "Ediar",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                          onPressed: () {
                            helper.deleteContact(contacts[index].id!);

                            setState(() {
                              contacts.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          )),
                    )
                  ]),
                );
              });
        });
  }

  void _showContactPage({Contact? contact}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                )));

    if (recContact != null) {
      if (contact != null) {
        await helper.updateContact(recContact);
        getAllContacts();
      } else {
        await helper.saveContact(recContact);
      }
      getAllContacts();
    }
  }

  void getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }
}
