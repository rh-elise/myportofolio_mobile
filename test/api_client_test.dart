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
}
