import 'package:ht_shared/src/models/core/feed_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'country.g.dart';

/// {@template country}
/// Represents a country with its essential details.
///
/// Used typically in contexts like selecting a country for news headlines
/// or user profile settings.
/// {@endtemplate}
@immutable
@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  includeIfNull: false,
  checked: true,
)
class Country extends FeedItem {
  /// {@macro country}
  Country({
    required this.isoCode,
    required this.name,
    required this.flagUrl,
    String? id,
  }) : id = id ?? const Uuid().v4(),
       super(type: 'country');

  /// Creates a Country instance from a JSON map.
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  /// A unique identifier for the country instance, typically a UUID.
  final String id;

  /// The unique ISO 3166-1 alpha-2 code for the country (e.g., "US", "GB").
  @JsonKey(name: 'iso_code')
  final String isoCode;

  /// The common name of the country (e.g., "United States", "United Kingdom").
  final String name;

  /// The URL pointing to an image of the country's flag.
  @JsonKey(name: 'flag_url')
  final String flagUrl;

  /// Converts this Country instance into a JSON map.
  @override
  Map<String, dynamic> toJson() {
    final json = _$CountryToJson(this);
    json['type'] = type;
    return json;
  }

  @override
  List<Object?> get props => [id, isoCode, name, flagUrl, type];

  /// Creates a copy of this [Country] but with the given fields replaced with
  /// the new values.
  Country copyWith({
    String? id,
    String? isoCode,
    String? name,
    String? flagUrl,
  }) {
    return Country(
      id: id ?? this.id,
      isoCode: isoCode ?? this.isoCode,
      name: name ?? this.name,
      flagUrl: flagUrl ?? this.flagUrl,
    );
  }
}
