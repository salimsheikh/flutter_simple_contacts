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

  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var buttonSet1 = [
      ElevatedButton(
          onPressed: () {
            String contactNameText = contactNameCtrl.text.trim();
            String contactNumberText = contactNumberCtrl.text.trim();

            if (contactNameText.isNotEmpty && contactNumberText.isNotEmpty) {
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
          child: const Text("Add"))
    ];
    var buttonSet2 = [
      ElevatedButton(
          onPressed: () {
            String contactNameText = contactNameCtrl.text.trim();
            String contactNumberText = contactNumberCtrl.text.trim();

            if (contactNameText.isNotEmpty && contactNumberText.isNotEmpty) {
              setState(() {
                contactNameCtrl.text = "";
                contactNumberCtrl.text = "";
                contacts[selectedIndex].contactName = contactNameText;
                contacts[selectedIndex].contactNumber = contactNumberText;

                selectedIndex = -1;
              });
            }
          },
          child: const Text("Update")),
      ElevatedButton(
          onPressed: () {
            setState(() {
              contactNameCtrl.text = "";
              contactNumberCtrl.text = "";
              selectedIndex = -1;
            });
          },
          child: const Text("Close"))
    ];
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
            children: selectedIndex < 0 ? buttonSet1 : buttonSet2,
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
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              (index % 2 == 0) ? Colors.deepPurple : Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          child: Text(contacts[index].contactName[0].toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].contactName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].contactNumber),
          ],
        ),
        trailing: SizedBox(
          width: 50,
          child: Row(
            children: [
              InkWell(
                  onTap: (() {
                    setState(() {
                      contactNameCtrl.text = contacts[index].contactName;
                      contactNumberCtrl.text = contacts[index].contactNumber;
                      selectedIndex = index;
                    });
                  }),
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    setState(() {
                      contacts.removeAt(index);
                    });
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}
