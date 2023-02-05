import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../models/user.dart';

class DioClient {
  final String token = dotenv.env['MODE']! == "production"
      ? dotenv.env['PRODUCTION_TOKEN']!
      : dotenv.env['DEV_TOKEN']!;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['MODE']! == "production"
          ? "${dotenv.env['PRODUCTION_BASE_URL']!}/public/v2"
          : "${dotenv.env['DEV_BASE_URL']!}/public/v2",
      responseType: ResponseType.plain,
    ),
  )..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

  Future<List<User>?> getUsers({int? page = 1, int? perPage = 10}) async {
    List<User>? user;
    try {
      Response response = await _dio.get("/users",
          options: Options(
            headers: {
              "Accept": "application/json",
              "authorization": "Bearer $token",
            },
          ),
          queryParameters: {
            "page": page,
            "per_page": perPage,
          });
      user = userFromJson(response.data);
    } on DioError catch (e) {
      debugPrint(e.message);
    }
    return user;
  }

  Future<User?> createUser({required User data}) async {
    User? user;
    try {
      Response response = await _dio.post(
        "/users",
        options: Options(
          headers: {
            "Accept": "application/json",
            "authorization": "Bearer $token",
          },
        ),
        data: data,
      );
      user = User.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      debugPrint(e.response?.statusCode.toString());
    }
    return user;
  }

  Future<User?> updateUser({required User data}) async {
    User? user;
    try {
      int userId = data.id;
      Response response = await _dio.put(
        "/users/$userId",
        options: Options(
          headers: {
            "Accept": "application/json",
            "authorization": "Bearer $token",
          },
        ),
        data: data,
      );
      user = User.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      debugPrint(e.response?.statusCode.toString());
    }
    return user;
  }

  Future<bool> deleteUser({required int id}) async {
    try {
      Response response = await _dio.delete("/users/$id",
          options: Options(
            headers: {
              "Accept": "application/json",
              "authorization": "Bearer $token",
            },
          ));
      if (response.statusCode == 204) {
        return true;
      }
      return false;
    } on DioError catch (e) {
      debugPrint(e.message);
      return false;
    }
  }
}
