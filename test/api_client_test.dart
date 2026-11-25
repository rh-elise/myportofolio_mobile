import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  test('getExperiences mem-parsing daftar dari endpoint publik', () async {
    late http.Request captured;
    final client = MockClient((request) async {
      captured = request;
      return http.Response(
        '[{"id": 3, "title": "Magang", "description": "Deskripsi", '
        '"category": "internship", "thumbnail": null, "year": 2025, '
        '"status": "completed", "star_count": 2, "is_starred": false, '
        '"starred_by_names": "owner"}]',
        200,
        headers: {'content-type': 'application/json'},
      );
    });

    final api = ApiClient(client: client, baseUrl: 'http://localhost:8000');
    final experiences = await api.getExperiences();

    expect(captured.method, 'GET');
    expect(captured.url.path, '/api/v1/experience/');
    expect(captured.headers.containsKey('Authorization'), isFalse);
    expect(experiences, hasLength(1));
    expect(experiences.first.title, 'Magang');
    expect(experiences.first.category, 'internship');
    expect(experiences.first.starCount, 2);
  });

  test('createExperience mengirim header token dan body JSON', () async {
    late http.Request captured;
    final client = MockClient((request) async {
      captured = request;
      return http.Response(
        '{"id": 7, "title": "Relawan", "description": "Mengajar", '
        '"category": "volunteer", "thumbnail": "", "year": 2024, '
        '"status": "completed", "star_count": 0, "is_starred": false, '
        '"starred_by_names": ""}',
        201,
        headers: {'content-type': 'application/json'},
      );
    });

    final api = ApiClient(client: client, baseUrl: 'http://localhost:8000');
    final created = await api.createExperience(
      const Experience(
        title: 'Relawan',
        description: 'Mengajar',
        category: 'volunteer',
        year: 2024,
        status: 'completed',
      ),
      token: 'abc123',
    );

    expect(captured.method, 'POST');
    expect(captured.url.path, '/api/v1/experience/');
    expect(captured.headers['Authorization'], 'Token abc123');
    expect(captured.headers['Content-Type'], contains('application/json'));

    final body = jsonDecode(captured.body) as Map<String, dynamic>;
    expect(body['title'], 'Relawan');
    expect(body['category'], 'volunteer');
    expect(body['year'], 2024);
    // Field yang ditandai includeToJson: false tidak boleh ikut terkirim.
    expect(body.containsKey('id'), isFalse);
    expect(body.containsKey('star_count'), isFalse);
    expect(body.containsKey('starred_by_names'), isFalse);

    expect(created.id, 7);
  });

  test('createExperience melempar ApiException saat token ditolak', () async {
    final client = MockClient((request) async {
      return http.Response('{"detail": "Invalid token."}', 403);
    });

    final api = ApiClient(client: client, baseUrl: 'http://localhost:8000');

    expect(
      () => api.createExperience(
        const Experience(
          title: 'Relawan',
          description: 'Mengajar',
          category: 'volunteer',
          year: 2024,
          status: 'completed',
        ),
        token: 'revoked',
      ),
      throwsA(
        isA<ApiException>().having((error) => error.statusCode, 'status', 403),
      ),
    );
  });

  test(
    'updateExperience mengirim PATCH ke detail dan mem-parsing hasil',
    () async {
      late http.Request captured;
      final client = MockClient((request) async {
        captured = request;
        return http.Response(
          '{"id": 3, "title": "Magang Baru", "description": "Deskripsi baru", '
          '"category": "internship", "thumbnail": "", "year": 2026, '
          '"status": "ongoing", "star_count": 0, "is_starred": false, '
          '"starred_by_names": ""}',
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final api = ApiClient(client: client, baseUrl: 'http://localhost:8000');
      final updated = await api.updateExperience(
        const Experience(
          id: 3,
          title: 'Magang Baru',
          description: 'Deskripsi baru',
          category: 'internship',
          year: 2026,
          status: 'ongoing',
        ),
        token: 'abc123',
      );

      expect(captured.method, 'PATCH');
      expect(captured.url.path, '/api/v1/experience/3/');
      expect(captured.headers['Authorization'], 'Token abc123');
      expect(captured.headers['Content-Type'], contains('application/json'));

      final body = jsonDecode(captured.body) as Map<String, dynamic>;
      expect(body['title'], 'Magang Baru');
      expect(body['status'], 'ongoing');
      expect(body.containsKey('id'), isFalse);
      expect(body.containsKey('star_count'), isFalse);

      expect(updated.id, 3);
      expect(updated.title, 'Magang Baru');
    },
  );

  test('updateExperience menolak Experience tanpa id', () async {
    final client = MockClient((request) async {
      return http.Response('{}', 200);
    });

    final api = ApiClient(client: client, baseUrl: 'http://localhost:8000');

    await expectLater(
      api.updateExperience(
        const Experience(
          title: 'Tanpa ID',
          description: 'Belum tersimpan',
          category: 'research',
          year: 2026,
          status: 'ongoing',
        ),
        token: 'abc123',
      ),
      throwsArgumentError,
    );
  });

  test('deleteExperience mengirim DELETE ke detail', () async {
    late http.Request captured;
    final client = MockClient((request) async {
      captured = request;
      return http.Response('', 204);
    });

    final api = ApiClient(client: client, baseUrl: 'http://localhost:8000');
    await api.deleteExperience(3, token: 'abc123');

    expect(captured.method, 'DELETE');
    expect(captured.url.path, '/api/v1/experience/3/');
    expect(captured.headers['Authorization'], 'Token abc123');
    expect(captured.body, isEmpty);
  });

  test('deleteExperience melempar ApiException saat token ditolak', () async {
    final client = MockClient((request) async {
      return http.Response('{"detail": "Invalid token."}', 403);
    });

    final api = ApiClient(client: client, baseUrl: 'http://localhost:8000');

    await expectLater(
      api.deleteExperience(3, token: 'revoked'),
      throwsA(
        isA<ApiException>().having((error) => error.statusCode, 'status', 403),
      ),
    );
  });
}
