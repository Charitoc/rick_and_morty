// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/api/api_urls.dart';
import 'package:rick_morty/helpers/Failure.dart';
import 'package:rick_morty/helpers/Success.dart';
import 'package:rick_morty/models/all_characters.dart';
import 'package:rick_morty/models/episodes.dart';
import 'package:rick_morty/models/locations.dart';
import 'package:rick_morty/providers/character_provider.dart';

class CallResponses {
  static Future<Either<Failure, Success>> callAPI(
      Dio dio, BuildContext context, String baseUrl,
      {int page = 1}) async {
    final response = await dio.request("");

    switch (baseUrl) {
      case ApiUrls.ALL_CHARS_URL:
        Provider.of<CharacterProvider>(context, listen: false)
            .addCharactersToList(allCharactersFromJson(response.data));
        return Right(Success());
      case ApiUrls.LOCATION:
        Provider.of<CharacterProvider>(context, listen: false)
            .addLocations(locationsFromJson(response.data));
        return Right(Success());
      case ApiUrls.EPISODE:
        Provider.of<CharacterProvider>(context, listen: false)
            .addEpisodes(episodesFromJson(response.data));
        return Right(Success());
      default:
        return Left(Failure("Something went wrong!"));
    }
  }
}
