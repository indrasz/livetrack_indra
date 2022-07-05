// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:livetrack_indra/helpers/flash_message_helper.dart';
import 'package:livetrack_indra/helpers/user_helper.dart';
import 'package:livetrack_indra/services/hive_service.dart';
import 'package:livetrack_indra/utils/constants.dart';
import 'package:livetrack_indra/utils/get_it.dart';

/// Used to initialize the application in splashscreen
class MainRepository {
  /// The method is used to initialize the Application
  /// Setup the DI container, Dio, Hive and etc.
  Future<void> init(String lang) async {
    try {
      final dio = _setupDio(lang);

      GetItContainer.initializeConfig(dio);

      await GetIt.I<HiveService>().init();
    } catch (e) {
      GetIt.I<FlashMessageHelper>()
          .showError(e.toString(), duration: const Duration(seconds: 15));
    }
  }

  Dio _setupDio(String lang, {bool isUseLogger = true}) {
    final options = BaseOptions(
      baseUrl: kBaseUrl,
      connectTimeout: 16000,
      receiveTimeout: 16000,
      sendTimeout: 16000,
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-localization': lang,
        'Access-Control-Allow-Origin': '*',
      },
    );

    final dio = Dio(options);

    if (isUseLogger) {
      dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          if (e.response != null && e.response!.statusCode == 401) {
            GetIt.I<UserHelper>().logout();
          }
          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}
