import '../db/database.dart';

class QuoteModel {
  QuoteModel({
    required this.id,
    required this.content,
    required this.author,
    required this.authorSlug,
    required this.length,
    this.dateAdded,
    this.dateModified,
  });


  final String id;
  final String content;
  final String author;
  final String authorSlug;
  final int length;
  final String? dateAdded;
  final String? dateModified;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
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
      id: json["_id"],
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
      id: id,
      content: content,
      author: author,
      authorSlug: authorSlug,
      length: length,
    );
  }

  factory QuoteModel.fromDataClass(Quote data) {
    return QuoteModel(
      id: data.id,
      content: data.content,
      author: data.author,
      authorSlug: data.authorSlug,
      length: data.length,
    );
  }
}
