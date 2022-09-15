

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  List<Contact> contacts = [];

  @override
  void initState(){
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Container(),
    );
  }

  void getContacts() async{
    PermissionStatus status =  await Permission.contacts.request();  // Asynchronous -- User interaction
    if(status == PermissionStatus.granted){
      List<Contact> contactsTemp = await ContactsService.getContacts(); // Asynchronous - Memory
      setState(() {
        contacts = contactsTemp;
      });
      // Read the contacts
    }
  }

}
