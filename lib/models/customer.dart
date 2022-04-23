class Customer {
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime dateBirth;
  final DateTime dateAdded;
  final String celNum;
  final String telNum;
  final String adrCity;
  final String adrBarangay;
  final String adrZipcode;
  final String note;
  final String tagName;
  final int tagIndex;
  final String tagColor;

  const Customer({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateBirth,
    required this.dateAdded,
    required this.celNum,
    required this.telNum,
    required this.adrCity,
    required this.adrBarangay,
    required this.adrZipcode,
    this.note = "",
    required this.tagName,
    required this.tagIndex,
    required this.tagColor,
  });
}
