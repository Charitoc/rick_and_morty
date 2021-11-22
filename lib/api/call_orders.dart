import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/api/api_urls.dart';
import 'package:rick_morty/api/call_responses.dart';
import 'package:rick_morty/helpers/Failure.dart';
import 'package:rick_morty/helpers/Success.dart';
import 'package:rick_morty/utils/global_settings.dart';

class CallOrders {
  //
  // If there is an api key, it should be in a secret folder that would be ignored in .gitignore
  //

  //BUILD DIO OPTIONS AND CALL API TO GET INFORMATION
  static Future<Either<Failure, Success>> getAllCharacters(
      BuildContext context, int page) async {
    var options = BaseOptions(
      baseUrl: ApiUrls.ALL_CHARS_URL + "/?page=$page",
      headers: {
        "Content-Type": "application/json",
      },
      method: "GET",
      responseType: ResponseType.plain,
      connectTimeout: GlobalSettings.callTimeout,
      receiveTimeout: GlobalSettings.callTimeout,
      sendTimeout: GlobalSettings.callTimeout,
    );

    Dio dio = Dio(options);

    return await CallResponses.callAPI(dio, context, ApiUrls.ALL_CHARS_URL,
        page: page);
  }

  //BUILD DIO OPTIONS AND CALL API TO GET INFORMATION
  static Future<Either<Failure, Success>> getLocations(
      String locationUrl, BuildContext context) async {
    var options = BaseOptions(
      baseUrl: locationUrl,
      headers: {
        "Content-Type": "application/json",
      },
      method: "GET",
      responseType: ResponseType.plain,
      connectTimeout: GlobalSettings.callTimeout,
      receiveTimeout: GlobalSettings.callTimeout,
      sendTimeout: GlobalSettings.callTimeout,
    );

    Dio dio = Dio(options);

    return await CallResponses.callAPI(dio, context, ApiUrls.LOCATION);
  }

  //BUILD DIO OPTIONS AND CALL API TO GET INFORMATION
  static Future<Either<Failure, Success>> getEpisodes(
      String episodeUrl, BuildContext context) async {
    var options = BaseOptions(
      baseUrl: episodeUrl,
      headers: {
        "Content-Type": "application/json",
      },
      method: "GET",
      responseType: ResponseType.plain,
      connectTimeout: GlobalSettings.callTimeout,
      receiveTimeout: GlobalSettings.callTimeout,
      sendTimeout: GlobalSettings.callTimeout,
    );

    Dio dio = Dio(options);

    return await CallResponses.callAPI(dio, context, ApiUrls.EPISODE);
  }
}
