import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'response_metadata.g.dart';

/// {@template response_metadata}
/// Represents metadata often included in API responses.
///
/// This class is designed to be extensible, allowing for the addition
/// of more metadata fields in the future without breaking changes to
/// the main response wrapper.
/// {@endtemplate}
@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: true, checked: true)
class ResponseMetadata extends Equatable {
  /// {@macro response_metadata}
  const ResponseMetadata({required this.requestId, required this.timestamp});

  /// Factory method to create a [ResponseMetadata] instance from a JSON map.
  factory ResponseMetadata.fromJson(Map<String, dynamic> json) =>
      _$ResponseMetadataFromJson(json);

  /// An optional unique identifier for the request, useful for tracing.
  final String requestId;

  /// An optional timestamp indicating when the response was generated.
  final DateTime timestamp;

  /// Converts this [ResponseMetadata] instance to a JSON map.
  Map<String, dynamic> toJson() => _$ResponseMetadataToJson(this);

  @override
  List<Object?> get props => [requestId, timestamp];

  /// Creates a copy of this [ResponseMetadata] but with the given fields
  /// replaced with the new values.
  ResponseMetadata copyWith({String? requestId, DateTime? timestamp}) {
    return ResponseMetadata(
      requestId: requestId ?? this.requestId,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
