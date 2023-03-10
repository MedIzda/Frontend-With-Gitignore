class DetailedPatient {
  String name;
  String surname;
  String pesel;

  DetailedPatient({
    required this.name,
    required this.surname,
    required this.pesel,
  });

  factory DetailedPatient.fromJson(dynamic json) {
    return DetailedPatient(
        name: json['name'], surname: json['surname'], pesel: json['pesel']);
  }
}
