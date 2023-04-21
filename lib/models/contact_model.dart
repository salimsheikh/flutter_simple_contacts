// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactModel {
  String contactName = '';
  String lastName = '';
  int age = 0;
  String contactNumber = '';
  ContactModel({
    required this.contactName,
    this.contactNumber = '',
    this.lastName = '',
    this.age = 0,
  });

  ContactModel copy({
    String? contactName,
    String? lastName,
    int? age,
  }) =>
      ContactModel(
        contactName: contactName ?? this.contactName,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactModel &&
          runtimeType == other.runtimeType &&
          contactName == other.contactName &&
          lastName == other.lastName &&
          age == other.age;

  @override
  int get hashCode => contactName.hashCode ^ lastName.hashCode ^ age.hashCode;
}
