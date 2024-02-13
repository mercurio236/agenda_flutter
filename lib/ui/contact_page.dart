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
    );
  }
}
