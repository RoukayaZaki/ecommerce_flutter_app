// lib/src/models/feedback_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_by_contract/annotation.dart';

part 'feedback_model.g.dart';


@Contract()
class FeedbackModel {
  final String id;
  final String userId;
  final int rating;
  final String? comments;
  final DateTime date;

  @Precondition({
    'id != null': 'id must be provided',
    'userId != null': 'userId must be provided',
    'rating != null': 'rating must be provided',
    'rating >= 1 && rating <= 5': 'rating must be between 1 and 5',
    'date != null': 'date must be provided',
  })
  FeedbackModel({
    required this.id,
    required this.userId,
    required this.rating,
    this.comments,
    required this.date,
  });

  // Factory constructor to create FeedbackModel from Firestore document
  factory FeedbackModel.fromMap(Map<String, dynamic> map, String docId) {
    return FeedbackModel(
      id: docId,
      userId: map['userId'] ?? '',
      rating: (map['rating'] as num).toInt(),
      comments: map['comments'],
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  // Convert FeedbackModel to Map for Firestore
   @Postcondition({
    'result.containsKey("userId")': 'The map must contain a valid userId',
    'result["rating"] == rating': 'The map must contain the correct rating value',
    'result.containsKey("date")': 'The map must contain a valid date field',
  })
  Map<String, dynamic> _toMap() {
    return {
      'userId': userId,
      'rating': rating,
      'comments': comments,
      'date': Timestamp.fromDate(date),
    };
  }

  // CopyWith method for immutability
  // TODO: allow public methods that doesn't have DbC annotations
  // @Invariant()
  FeedbackModel _copyWith({
    String? id,
    String? userId,
    int? rating,
    String? comments,
    DateTime? date,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      rating: rating ?? this.rating,
      comments: comments ?? this.comments,
      date: date ?? this.date,
    );
  }
}
