class SupportTicket {
  int id;
  String name;
  String email;
  String description;
  DateTime createdAt;

  SupportTicket({
    required this.id,
    required this.name,
    required this.email,
    required this.description,
    required this.createdAt,
  });

  factory SupportTicket.fromMap(Map<String, dynamic> map) {
    return SupportTicket(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']!),
    );
  }
}
