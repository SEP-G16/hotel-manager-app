import '../enum/review_status.dart';

class Review {
  final int id;
  final String name;
  final String feedback;
  final DateTime createdAt;
  final ReviewStatus status;

  Review({
    required this.id,
    required this.name,
    required this.feedback,
    required this.createdAt,
    required this.status,
  });
}
