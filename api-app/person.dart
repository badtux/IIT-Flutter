class Person {
  final String name;
  final String number;

  Person({required this.name, required this.number});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      number: json['number'],
    );
  }
}
