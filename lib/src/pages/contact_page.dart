
import 'package:contact/src/helpers/common_actions.dart';
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
  void initState() {
    getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          Contact contactItem = contacts[index];
          String mobNos = (contactItem.phones ?? [])
              .map((e) => e.value ?? "")
              .toList()
              .join(" ");
          return ListTile(
            title: Text("${contactItem.displayName}"),
            subtitle: Text(mobNos),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      String mobNo = contactItem.phones?.first.value ?? "";
                      CommonAction.sendSms(mobNo, "HappyBirthday");
                    },
                    icon: Icon(Icons.sms_outlined)),
                IconButton(
                    onPressed: () {
                      // If user have multiple numbers
                      if(contactItem.phones == null){
                        return;
                      }
                      if(contactItem.phones!.length>1){
                        // Showing a dialog to opt the number
                        showContactNumberDialog(context,contactItem.phones!);
                      }else{
                        String mobNo = contactItem.phones!.first.value ?? "";
                        CommonAction.makeCall(mobNo);
                      }
                    },
                    icon: Icon(Icons.call)),
              ],
            ),
          );
        },
      ),
    );
  }

  void getContacts() async {
    PermissionStatus status =
        await Permission.contacts.request(); // Asynchronous -- User interaction
    if (status == PermissionStatus.granted) {
      List<Contact> contactsTemp =
          await ContactsService.getContacts(); // Asynchronous - Memory
      setState(() {
        contacts = contactsTemp;
      });
      // Read the contacts
    }
  }

  void showContactNumberDialog(BuildContext context, List<Item> phone) {
   showDialog(context: context,
       builder: (context){
          return AlertDialog(
            title: Text("Choose the number"),
            content: ListView.builder(
              itemCount: phone.length,
              itemBuilder: (context,index){
                Item item = phone[index];
                return ListTile(
                  title: Text(item.value ?? ""),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){
                        String mobNo = item.value ?? "";
                        CommonAction.sendSms(mobNo,"");
                      }, icon: Icon(Icons.sms)),
                      IconButton(onPressed: (){
                        String mobNo = item.value ?? "";
                        CommonAction.makeCall(mobNo);
                      }, icon: Icon(Icons.call)),
                    ],
                  ),
                );
              },
            ),
          );
       }
   );
  }
}
