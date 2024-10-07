import '../enum/review_status.dart';

class Review {
  final int id;
  final String name;
  final String feedback;
  final DateTime createdAt;
  final ReviewStatus status;

  set status(value) => status = value;

  Review({
    required this.id,
    required this.name,
    required this.feedback,
    required this.createdAt,
    required this.status,
  });

  // Convert Review object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'feedback': feedback,
      'createdAt': createdAt.toIso8601String(),
      'status': status.toString().split('.').last,  // Assuming you want to store the enum as a string
    };
  }

  // Factory constructor to create Review object from a Map
  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'],
      name: map['name'],
      feedback: map['feedback'],
      createdAt: DateTime.parse(map['createdAt']),
      status: ReviewStatus.values.firstWhere((e) => e.toString().split('.').last == map['status']),
    );
  }

  Review copyWith({
    int? id,
    String? name,
    String? feedback,
    DateTime? createdAt,
    ReviewStatus? status,
  }) {
    return Review(
      id: id ?? this.id,
      name: name ?? this.name,
      feedback: feedback ?? this.feedback,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
