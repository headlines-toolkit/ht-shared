import 'package:json_annotation/json_annotation.dart';

/// {@template content_type}
/// Defines the specific type of content being referred to or navigated to
/// within the application.
/// {@endtemplate}
@JsonEnum(fieldRename: FieldRename.snake)
enum ContentType {
  /// Refers to a news headline.
  headline,

  /// Refers to a news category.
  category,

  /// Refers to a news source.
  source,

  /// Refers to a country.
  country,

  // Add other content types as needed (e.g., author, topic)
}
