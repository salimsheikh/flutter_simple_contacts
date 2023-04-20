import 'package:flutter/material.dart';
import 'package:simple_contact_list/models/contact_model.dart';
import 'package:simple_contact_list/widget/scrollable_widget.dart';

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
  bool isHeader = false;

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
              : ScrollableWidget(child: buildDataTatle())
        ]),
      ),
    );
  }

  Widget buildDataTatle() {
    final columns = ['Name', 'Number', 'age'];
    return DataTable(columns: getColumns(columns), rows: getRows(contacts));
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(List<ContactModel> contact) =>
      contact.map((ContactModel contact) {
        final cells = [contact.contactName, contact.contactNumber, '25'];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
