/// Remote config Demo Data
const Map<String, dynamic> appConfigFixtureData = {
  'id': 'app_config',
  'user_preference_limits': {
    'guest_followed_items_limit': 5,
    'guest_saved_headlines_limit': 10,
    'authenticated_followed_items_limit': 15,
    'authenticated_saved_headlines_limit': 30,
    'premium_followed_items_limit': 30,
    'premium_saved_headlines_limit': 100,
  },
  'ad_config': {
    'guest_ad_frequency': 5,
    'guest_ad_placement_interval': 3,
    'authenticated_ad_frequency': 10,
    'authenticated_ad_placement_interval': 5,
    'premium_ad_frequency': 0,
    'premium_ad_placement_interval': 0,
  },
  'account_action_config': {
    'guest_days_between_account_actions': 2,
    'standard_user_days_between_account_actions': 7,
  },
};
