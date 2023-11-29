import 'dart:math';

import '../db/database.dart';

class QuoteModel {
  QuoteModel({
    required this.content,
    required this.author,
    required this.authorSlug,
    required this.length,
    this.dateAdded,
    this.dateModified,
  });

  final String content;
  final String author;
  final String authorSlug;
  final int length;
  final String? dateAdded;
  final String? dateModified;

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "author": author,
      "authorSlug": authorSlug,
      "length": length,
      "dateAdded": dateAdded,
      "dateModified": dateModified,
    };
  }

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      content: json["content"],
      author: json["author"],
      authorSlug: json["authorSlug"],
      length: json["length"],
      dateAdded: json["dateAdded"],
      dateModified: json["dateModified"],
    );
  }

  Quote toDataClass() {
    return Quote(
      id: Random().nextInt(1000000),
      content: content,
      author: author,
      authorSlug: authorSlug,
      length: length,
    );
  }

  factory QuoteModel.fromDataClass(Quote data) {
    return QuoteModel(
      content: data.content,
      author: data.author,
      authorSlug: data.authorSlug,
      length: data.length,
    );
  }
}
