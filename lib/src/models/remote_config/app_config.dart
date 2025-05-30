import 'package:equatable/equatable.dart';
import 'package:ht_shared/src/models/remote_config/ad_config.dart';
import 'package:ht_shared/src/models/remote_config/user_preference_config.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'app_config.g.dart';

/// {@template app_config}
/// Represents the overall application configuration.
///
/// This model serves as a central container for various configuration
/// settings that can be fetched and managed via the 'HtDataClient'.
/// It includes settings like user preference limits and can be extended
/// in the future to include other application-wide configurations
/// (e.g., API endpoints, feature flags).
///
/// There should typically be only one instance of this configuration,
/// identified by a fixed ID (e.g., 'app_config').
/// {@endtemplate}
@immutable
@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  includeIfNull: false,
  checked: true,
)
class AppConfig extends Equatable {
  /// {@macro app_config}
  ///
  /// Creates a new instance of [AppConfig].
  ///
  /// An [id] is required, typically a fixed identifier like 'app_config'.
  /// Provides sensible defaults for nested configuration models if not specified.
  const AppConfig({
    required this.id,
    UserPreferenceConfig? userPreferenceLimits,
    AdConfig? adConfig,
  })  : userPreferenceLimits = userPreferenceLimits ??
            const UserPreferenceConfig(
              guestFollowedItemsLimit: 5,
              guestSavedHeadlinesLimit: 10,
              authenticatedFollowedItemsLimit: 15,
              authenticatedSavedHeadlinesLimit: 30,
              premiumFollowedItemsLimit: 30,
              premiumSavedHeadlinesLimit: 100,
            ), // Default limits
        adConfig = adConfig ??
            const AdConfig(
              guestAdFrequency: 5,
              guestAdPlacementInterval: 3,
              authenticatedAdFrequency: 10,
              authenticatedAdPlacementInterval: 5,
              premiumAdFrequency: 0, // No ads for premium users by default
              premiumAdPlacementInterval: 0,
            ); // Default ad config

  /// Factory method to create an [AppConfig] instance from a JSON map.
  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  /// The unique identifier for the application configuration.
  /// Should typically be a fixed value like 'app_config'.
  final String id;

  /// Defines the maximum number of items a user can follow or save,
  /// tiered by user role.
  final UserPreferenceConfig userPreferenceLimits;

  /// Defines configuration settings related to ad injection and display,
  /// tiered by user role.
  final AdConfig adConfig;

  /// Converts this [AppConfig] instance to a JSON map.
  Map<String, dynamic> toJson() => _$AppConfigToJson(this);

  @override
  List<Object> get props => [
        id,
        userPreferenceLimits,
        adConfig,
      ];

  @override
  bool get stringify => true;
}
