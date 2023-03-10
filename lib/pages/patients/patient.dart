class Patient {
  String name;
  String surname;
  String pesel;

  Patient({
    required this.name,
    required this.surname,
    required this.pesel,
  });

  factory Patient.fromJson(dynamic json) {
    return Patient(
        name: json['name'], surname: json['surname'], pesel: json['pesel']);
  }
}
