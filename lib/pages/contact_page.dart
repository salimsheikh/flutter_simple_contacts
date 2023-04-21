import 'package:flutter/material.dart';
import 'package:simple_contact_list/data/contact_list.dart';
import 'package:simple_contact_list/models/contact_model.dart';
import 'package:simple_contact_list/widget/scrollable_widget.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  //List<ContactModel> contacts = List.empty(growable: true);

  late List<ContactModel> contacts;

  TextEditingController contactNameCtrl = TextEditingController();
  TextEditingController contactNumberCtrl = TextEditingController();

  var selectedIndex = -1;
  bool isHeader = false;

  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    contacts = List.of(allContacts);
  }

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
              : ScrollableWidget(
                  child: buildDataTable(),
                )
        ]),
      ),
    );
  }

  Widget buildDataTable() {
    final columns = ['Name', 'Number', 'Edit', 'Delete'];
    return DataTable(
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        columns: getColumns(columns),
        rows: getCustomRows(contacts));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: column == 'Edit'
                ? const Icon(Icons.edit)
                : (column == 'Delete'
                    ? const Icon(Icons.delete)
                    : Text(column)),
            onSort: (column == 'Edit' || column == 'Delete') ? null : onSort,
          ))
      .toList();

  List<DataRow> getRows(List<ContactModel> contact) =>
      contact.map((ContactModel contact) {
        final cells = [contact.contactName, contact.contactNumber, '25'];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataRow> getCustomRows(List<ContactModel> contact) =>
      contact.map((ContactModel contact) {
        //final cells = [contact.contactName, contact.contactNumber, contact.age];

        return DataRow(cells: [
          DataCell(Text(contact.contactName)),
          DataCell(Text(contact.contactNumber)),
          DataCell(
            InkWell(
                onTap: (() {
                  var index = contacts.indexOf(contact);
                  setState(() {
                    contactNameCtrl.text = contact.contactName;
                    contactNumberCtrl.text = contact.contactNumber;
                    selectedIndex = index;
                  });
                }),
                child: const Icon(Icons.edit, color: Colors.blue)),
          ),
          DataCell(
            InkWell(
                onTap: (() {
                  var index = contacts.indexOf(contact);
                  setState(() {
                    contacts.removeAt(index);
                  });
                }),
                child: const Icon(Icons.delete, color: Colors.red)),
          ),
        ]);
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      contacts.sort((user1, user2) =>
          compareString(ascending, user1.contactName, user2.contactName));
    } else if (columnIndex == 1) {
      contacts.sort((user1, user2) =>
          compareString(ascending, user1.contactNumber, user2.contactNumber));
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
