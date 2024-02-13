import 'dart:io';

import 'package:agenda_flutter/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;

  ContactPage(
      {this.contact}); // quando o paramaetro de um construtor for opcional adicionamos ele dentro de chaves

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _userEdited = false;
  late Contact _editedContact;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //para acessar os parametros por estar em classes diferentes, basta chamar o widget, o widget é a classe e a page é o atributo.
    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      //caso ainda nao tenha um contato, aqui vai estar criando e adicionando dentro do map
      _editedContact = Contact.fromMap(widget.contact!.toMap());

      _nameController.text = _editedContact.name!;
      _emailController.text = _editedContact.email!;
      _phoneController.text = _editedContact.phone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          _editedContact.name ?? 'Novo contato',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Icon(Icons.save, color: Colors.white),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: _editedContact.img != null
                          ? DecorationImage(
                              image: FileImage(File(_editedContact.img!)))
                          : DecorationImage(
                              image: AssetImage("images/person.png"),
                              fit: BoxFit.cover)),
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editedContact.name = text;
                  });
                },
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                onChanged: (text) {
                  _userEdited = true;
                  _editedContact.phone = text;
                },
                keyboardType: TextInputType.phone,
              )
            ],
          )),
    );
  }
}
