import 'dart:io';

import 'package:agenda_flutter/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker picker = ImagePicker();

  final _namefocus = FocusNode();

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
    return PopScope(
        canPop: !_userEdited,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          _requestPop();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(
              _editedContact.name ?? 'Novo contato',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_editedContact.name.isNotEmpty) {
                Navigator.pop(context, _editedContact);
              } else {
                FocusScope.of(context).requestFocus(_namefocus);
              }
            },
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
                          image: _editedContact.img != ''
                              ? DecorationImage(
                                  image: FileImage(File(_editedContact.img!)))
                              : DecorationImage(
                                  image: AssetImage("images/person.png"),
                                  fit: BoxFit.cover)),
                    ),
                    onTap: () {
                      picker
                          .pickImage(source: ImageSource.gallery)
                          .then((value) {
                        if (value == null) return;
                        setState(() {
                          _editedContact.img = value.path;
                        });
                      });
                    },
                  ),
                  TextField(
                    controller: _nameController,
                    focusNode: _namefocus,
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
        ));
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Descartar alterações?'),
              content: Text('Se sair as alterações serão perididas'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); //removendo o dialog da pilha
                  },
                  child: Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); //removendo as telas da pilha
                    Navigator.pop(context);
                  },
                  child: Text("Sim"),
                )
              ],
            );
          });
      return Future.value(false); //para não sair da tela
    } else {
      return Future.value(true); // para sair da tela sem salvar
    }
  }
}
