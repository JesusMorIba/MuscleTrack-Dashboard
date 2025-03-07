import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:muscletrack_admin_dashboard/services/environment_service.dart';
import 'package:muscletrack_admin_dashboard/services/local_storage.dart';

class MuscleTrackApi {
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = Environment.baseURL;

    _dio.options.headers = {
      'Authorization': 'Bearer ${LocalStorage.prefs?.getString('token') ?? ''}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Future<dynamic> httpGet(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } catch (e) {
      throw Exception('Error en el Get');
    }
  }

  static Future<dynamic> httpPost(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        path,
        data: jsonEncode(data),
      );

      return response.data;
    } catch (e) {
      throw Exception('Error en el Post');
    }
  }

  static Future<dynamic> httpPut(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        path,
        data: jsonEncode(data),
      );

      return response.data;
    } catch (e) {
      throw Exception('Error en el Put');
    }
  }

  static Future<dynamic> httpDelete(
      String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.delete(
        path,
        data: jsonEncode(data),
      );

      return response.data;
    } catch (e) {
      throw Exception('Error en el Delete');
    }
  }
}
