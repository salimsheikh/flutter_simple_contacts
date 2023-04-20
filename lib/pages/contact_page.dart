import 'package:flutter/material.dart';
import 'package:simple_contact_list/models/contact_model.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<ContactModel> contacts = List.empty(growable: true);

  TextEditingController contactNameCtrl = TextEditingController();
  TextEditingController contactNumberCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const SizedBox(height: 25),
          TextField(
            controller: contactNameCtrl,
            decoration: const InputDecoration(
              hintText: "Contact Name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            controller: contactNumberCtrl,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: const InputDecoration(
              hintText: "Contact Number",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    String contactNameText = contactNameCtrl.text.trim();
                    String contactNumberText = contactNumberCtrl.text.trim();

                    if (contactNameText.isNotEmpty &&
                        contactNumberText.isNotEmpty) {
                      setState(() {
                        contactNameCtrl.text = "";
                        contactNumberCtrl.text = "";
                        contacts.add(ContactModel(
                          contactName: contactNameText,
                          contactNumber: contactNumberText,
                        ));
                      });
                    }
                  },
                  child: const Text("Save")),
              ElevatedButton(onPressed: () {}, child: const Text("Update"))
            ],
          ),
          const SizedBox(height: 25),
          contacts.isEmpty
              ? const Text(
                  "No Contacts yet...",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) => getRow(index),
                  ),
                )
        ]),
      ),
    );
  }

  Widget getRow(int index) {
    return ListTile(
      title: Column(children: [
        Text(contacts[index].contactNumber),
        Text(contacts[index].contactNumber),
      ]),
    );
  }
}
