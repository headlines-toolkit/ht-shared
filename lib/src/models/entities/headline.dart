import 'package:ht_shared/src/models/core/feed_item.dart';
import 'package:ht_shared/src/models/core/feed_item_action.dart'
    show FeedItemAction, feedItemActionFromJson, feedItemActionToJson;
import 'package:ht_shared/src/models/entities/category.dart';
import 'package:ht_shared/src/models/entities/source.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'headline.g.dart';

// Helper function for parsing DateTime, returning null on error
DateTime? _dateTimeFromJson(String? dateString) {
  if (dateString == null) return null;
  return DateTime.tryParse(dateString);
}

/// {@template headline}
/// Headline model
///
/// Represents a news headline item.
/// {@endtemplate}
@immutable
@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  includeIfNull: false,
  checked: true,
)
class Headline extends FeedItem {
  /// {@macro headline}
  Headline({
    required this.title,
    required FeedItemAction action,
    this.description,
    this.url,
    this.imageUrl,
    this.publishedAt,
    this.source,
    this.category,
    String? id,
  })  : assert(
          id == null || id.isNotEmpty,
          'id cannot be an empty string', // Updated assertion message
        ),
        id = id ?? const Uuid().v4(),
        action = action,
        super(type: 'headline', action: action);

  /// Creates a [Headline] instance from a JSON map.
  factory Headline.fromJson(Map<String, dynamic> json) =>
      _$HeadlineFromJson(json);

  /// Unique identifier for the headline.
  final String id;

  /// Title of the headline.
  final String title;

  /// Description or snippet of the headline content.
  final String? description;

  /// URL to the full article or content.
  final String? url;

  /// URL to an image associated with the headline.
  final String? imageUrl;

  /// Date and time when the headline was published.
  @JsonKey(fromJson: _dateTimeFromJson)
  final DateTime? publishedAt;

  /// Source or origin of the headline.
  final Source? source;

  /// Category of the current headline.
  final Category? category;

  /// The action to be performed when this feed item is interacted with.
  @JsonKey(fromJson: feedItemActionFromJson, toJson: feedItemActionToJson)
  @override
  final FeedItemAction action;

  /// Converts this [Headline] instance to a JSON map.
  @override
  Map<String, dynamic> toJson() {
    final json = _$HeadlineToJson(this);
    json['type'] = type;
    return json;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        url,
        imageUrl,
        publishedAt,
        source,
        category,
        type,
        action,
      ];

  @override
  bool get stringify => true;

  /// Creates a new [Headline] with updated properties.
  /// Use this to modify a [Headline] without changing the original instance.
  Headline copyWith({
    String? id,
    String? title,
    String? description,
    String? url,
    String? imageUrl,
    DateTime? publishedAt,
    Source? source,
    Category? category,
    FeedItemAction? action,
  }) {
    return Headline(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      source: source ?? this.source,
      category: category ?? this.category,
      action: action ?? this.action,
    );
  }
}
