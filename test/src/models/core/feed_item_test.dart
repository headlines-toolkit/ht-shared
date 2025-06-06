import 'package:ht_shared/ht_shared.dart';
import 'package:test/test.dart';

void main() {
  group('FeedItem', () {
    final mockCountry = Country(
      id: 'country-1',
      isoCode: 'US',
      name: 'United States',
      flagUrl: 'http://example.com/us.png',
    );
    final mockSource = Source(
      id: 'source-1',
      name: 'Example News',
      url: 'http://example.com',
      sourceType: SourceType.newsAgency,
    );
    final mockCategory = Category(id: 'category-1', name: 'Technology');
    final mockHeadline = Headline(
      id: 'headline-1',
      title: 'Example Headline',
      url: 'http://example.com/headline',
      publishedAt: DateTime.utc(2023),
    );
    final mockAd = Ad(
      id: 'ad-1',
      imageUrl: 'http://example.com/ad.jpg',
      targetUrl: 'http://example.com/ad-target',
      adType: AdType.banner,
      placement: AdPlacement.feedInlineStandardBanner,
    );
    final mockAccountAction = AccountAction(
      id: 'engagement-1', // Keep id for consistency if tests rely on it
      title: 'Sign Up Now',
      accountActionType: AccountActionType.linkAccount,
    );

    group('fromJson', () {
      test('dispatches to Headline.fromJson', () {
        final json = mockHeadline.toJson();
        final feedItem = FeedItem.fromJson(json);
        expect(feedItem, isA<Headline>());
        expect(feedItem, equals(mockHeadline));
      });

      test('dispatches to Category.fromJson', () {
        final json = mockCategory.toJson();
        final feedItem = FeedItem.fromJson(json);
        expect(feedItem, isA<Category>());
        expect(feedItem, equals(mockCategory));
      });

      test('dispatches to Source.fromJson', () {
        final json = mockSource.toJson();
        final feedItem = FeedItem.fromJson(json);
        expect(feedItem, isA<Source>());
        expect(feedItem, equals(mockSource));
      });

      test('dispatches to Country.fromJson', () {
        final json = mockCountry.toJson();
        final feedItem = FeedItem.fromJson(json);
        expect(feedItem, isA<Country>());
        expect(feedItem, equals(mockCountry));
      });

      test('dispatches to Ad.fromJson', () {
        final json = mockAd.toJson();
        final feedItem = FeedItem.fromJson(json);
        expect(feedItem, isA<Ad>());
        expect(feedItem, equals(mockAd));
      });

      test('dispatches to AccountAction.fromJson', () {
        final json = mockAccountAction.toJson();
        final feedItem = FeedItem.fromJson(json);
        expect(feedItem, isA<AccountAction>());
        expect(feedItem, equals(mockAccountAction));
      });

      test('throws FormatException if type is missing', () {
        final json = <String, dynamic>{'id': 'some-id'};
        expect(
          () => FeedItem.fromJson(json),
          throwsA(
            isA<FormatException>().having(
              (e) => e.message,
              'message',
              'Missing "type" field in FeedItem JSON.',
            ),
          ),
        );
      });

      test('throws FormatException if type is unknown', () {
        final json = <String, dynamic>{'type': 'unknown_type'};
        expect(
          () => FeedItem.fromJson(json),
          throwsA(
            isA<FormatException>().having(
              (e) => e.message,
              'message',
              'Unknown FeedItem type: unknown_type',
            ),
          ),
        );
      });
    });

    group('toJson', () {
      test('serializes Headline correctly', () {
        final json = mockHeadline.toJson();
        final deserialized = FeedItem.fromJson(json);
        expect(deserialized.toJson(), equals(json));
      });

      test('serializes Category correctly', () {
        final json = mockCategory.toJson();
        final deserialized = FeedItem.fromJson(json);
        expect(deserialized.toJson(), equals(json));
      });

      test('serializes Source correctly', () {
        final json = mockSource.toJson();
        final deserialized = FeedItem.fromJson(json);
        expect(deserialized.toJson(), equals(json));
      });

      test('serializes Country correctly', () {
        final json = mockCountry.toJson();
        final deserialized = FeedItem.fromJson(json);
        expect(deserialized.toJson(), equals(json));
      });

      test('serializes Ad correctly', () {
        final json = mockAd.toJson();
        final deserialized = FeedItem.fromJson(json);
        expect(deserialized.toJson(), equals(json));
      });

      test('serializes AccountAction correctly', () {
        final json = mockAccountAction.toJson();
        final deserialized = FeedItem.fromJson(json);
        expect(deserialized.toJson(), equals(json));
      });
    });
  });
}
