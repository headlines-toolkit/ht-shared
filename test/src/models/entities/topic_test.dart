import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart'; // Added for CheckedFromJsonException
import 'package:test/test.dart';

void main() {
  group('Topic', () {
    Topic createSubject({
      required String id,
      required String name,
      required String description,
      required String iconUrl,
      required DateTime createdAt,
      required DateTime updatedAt,
      required ContentStatus status,
    }) {
      return Topic(
        id: id,
        name: name,
        description: description,
        iconUrl: iconUrl,
        createdAt: createdAt,
        updatedAt: updatedAt,
        status: status,
      );
    }

    test('supports value equality', () {
      const fixedId = 'fixed-topic-id';
      final now = DateTime.now();
      expect(
        createSubject(
          id: fixedId,
          name: 'Technology',
          description: 'Description',
          iconUrl: 'http://example.com/icon.png',
          createdAt: now,
          updatedAt: now,
          status: ContentStatus.active,
        ),
        createSubject(
          id: fixedId,
          name: 'Technology',
          description: 'Description',
          iconUrl: 'http://example.com/icon.png',
          createdAt: now,
          updatedAt: now,
          status: ContentStatus.active,
        ),
      );
    });

    test('constructor sets type to "topic"', () {
      final now = DateTime.now();
      final topic = createSubject(
        id: 'some-id',
        name: 'Sports',
        description: 'Description',
        iconUrl: 'http://example.com/icon.png',
        createdAt: now,
        updatedAt: now,
        status: ContentStatus.active,
      );
      expect(topic.type, 'topic');
    });

    test('props list contains all relevant fields', () {
      final now = DateTime.now();
      final topic = createSubject(
        id: 'topic-123',
        name: 'Props Test',
        description: 'A test description',
        iconUrl: 'icon.png',
        createdAt: now,
        updatedAt: now,
        status: ContentStatus.active,
      );
      expect(topic.props, [
        'topic-123',
        'Props Test',
        'A test description',
        'icon.png',
        now, // createdAt
        now, // updatedAt
        ContentStatus.active, // status
        'topic', // type
      ]);
    });

    group('fromJson', () {
      test('creates correct Topic object from valid JSON', () {
        final json = <String, dynamic>{
          'id': '123',
          'name': 'Science',
          'description': 'Science news',
          'iconUrl': 'http://example.com/science.png',
          'type': 'topic',
          'status': 'active',
          'createdAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        };
        expect(
          Topic.fromJson(json),
          equals(
            Topic(
              id: '123',
              name: 'Science',
              description: 'Science news',
              iconUrl: 'http://example.com/science.png',
              createdAt: DateTime.parse(json['createdAt'] as String),
              updatedAt: DateTime.parse(json['updatedAt'] as String),
              status: ContentStatus.active,
            ),
          ),
        );
      });

      test(
        'throws CheckedFromJsonException when required fields are missing',
        () {
          final json = <String, dynamic>{'name': 'Art', 'type': 'topic'};
          expect(
            () => Topic.fromJson(json),
            throwsA(isA<CheckedFromJsonException>()),
          );
        },
      );

      test('deserializes with a non-default status', () {
        final now = DateTime.now();
        final json = <String, dynamic>{
          'id': 'some-id',
          'name': 'Archived',
          'description': 'Description',
          'iconUrl': 'icon.png',
          'createdAt': now.toIso8601String(),
          'updatedAt': now.toIso8601String(),
          'status': 'archived',
        };
        final topic = Topic.fromJson(json);
        expect(topic.status, ContentStatus.archived);
      });
    });

    group('toJson', () {
      test('produces correct JSON map', () {
        final now = DateTime.now();
        final topic = createSubject(
          id: '456',
          name: 'Business',
          description: 'Business news',
          iconUrl: 'http://example.com/business.png',
          createdAt: now,
          updatedAt: now,
          status: ContentStatus.active,
        );
        expect(topic.toJson(), <String, dynamic>{
          'id': '456',
          'name': 'Business',
          'description': 'Business news',
          'iconUrl': 'http://example.com/business.png',
          'status': 'active',
          'type': 'topic',
          'createdAt': now.toIso8601String(),
          'updatedAt': now.toIso8601String(),
        });
      });

      test('includes all fields in JSON (no null fields skipped)', () {
        final now = DateTime.now();
        final topic = createSubject(
          id: 'some-id',
          name: 'Health',
          description: 'Health news',
          iconUrl: 'http://example.com/health.png',
          createdAt: now,
          updatedAt: now,
          status: ContentStatus.active,
        );
        expect(topic.toJson(), <String, dynamic>{
          'id': topic.id,
          'name': 'Health',
          'description': 'Health news',
          'iconUrl': 'http://example.com/health.png',
          'status': 'active',
          'type': 'topic',
          'createdAt': now.toIso8601String(),
          'updatedAt': now.toIso8601String(),
        });
      });
    });

    group('copyWith', () {
      test('returns a new object with updated name', () {
        final now = DateTime.now();
        final original = createSubject(
          id: 'original-id',
          name: 'Old Name',
          description: 'Desc',
          iconUrl: 'icon.png',
          createdAt: now,
          updatedAt: now,
          status: ContentStatus.active,
        );
        final updated = original.copyWith(name: 'New Name');
        expect(updated.name, 'New Name');
        expect(updated.id, original.id);
        expect(updated.description, original.description);
        expect(updated.iconUrl, original.iconUrl);
        expect(updated.createdAt, original.createdAt);
        expect(updated.updatedAt, original.updatedAt);
        expect(updated.status, original.status);
      });

      test('returns a new object with updated description', () {
        final now = DateTime.now();
        final original = createSubject(
          id: 'original-id',
          name: 'Test',
          description: 'Old Description',
          iconUrl: 'icon.png',
          createdAt: now,
          updatedAt: now,
          status: ContentStatus.active,
        );
        final updated = original.copyWith(description: 'New Description');
        expect(updated.description, 'New Description');
        expect(updated.name, original.name);
        expect(updated.id, original.id);
        expect(updated.iconUrl, original.iconUrl);
        expect(updated.createdAt, original.createdAt);
        expect(updated.updatedAt, original.updatedAt);
        expect(updated.status, original.status);
      });

      test('returns a new object with updated iconUrl', () {
        final now = DateTime.now();
        final original = createSubject(
          id: 'original-id',
          name: 'Test',
          description: 'Desc',
          iconUrl: 'old_icon.png',
          createdAt: now,
          updatedAt: now,
          status: ContentStatus.active,
        );
        final updated = original.copyWith(iconUrl: 'new_icon.png');
        expect(updated.iconUrl, 'new_icon.png');
        expect(updated.name, original.name);
        expect(updated.id, original.id);
        expect(updated.description, original.description);
        expect(updated.createdAt, original.createdAt);
        expect(updated.updatedAt, original.updatedAt);
        expect(updated.status, original.status);
      });

      test('returns a new object with multiple updated properties', () {
        final now = DateTime.now();
        final original = createSubject(
          id: 'original-id',
          name: 'Original',
          description: 'Desc',
          iconUrl: 'icon.png',
          createdAt: now,
          updatedAt: now,
          status: ContentStatus.active,
        );
        final updated = original.copyWith(
          name: 'Updated',
          description: 'Updated Desc',
          status: ContentStatus.archived,
        );
        expect(updated.name, 'Updated');
        expect(updated.description, 'Updated Desc');
        expect(updated.status, ContentStatus.archived);
        expect(updated.id, original.id);
        expect(updated.iconUrl, original.iconUrl);
        expect(updated.createdAt, original.createdAt);
        expect(updated.updatedAt, original.updatedAt);
      });
    });
  });
}
