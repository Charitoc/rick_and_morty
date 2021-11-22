// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:rick_morty/models/all_characters.dart';
import 'package:rick_morty/models/character.dart';
import 'package:rick_morty/models/episodes.dart';
import 'package:rick_morty/models/locations.dart';

class CharacterProvider with ChangeNotifier {
  AllCharacters? characterInfo;
  List<Character> charactersList = [];
  List<SingleLocation> locationList = [];
  List<Episode> episodeList = [];
  int selectedCharacter = -1;

  //CHOOSE CHARACTER
  void updateSelectedCharacter(int index) {
    selectedCharacter = index;
    notifyListeners();
  }

  //APPEND CHARACTERS TO LOCAL LIST IN ORDER TO NOT MAKE REDUNDANT API CALLS
  void addCharactersToList(AllCharacters value) {
    charactersList.addAll(value.characters);
    notifyListeners();
  }

  //APPEND LOCATIONS TO LOCAL LIST
  void addLocations(List<SingleLocation> locations) {
    for (SingleLocation loc in locations) {
      if (!locationList.contains(loc)) {
        locationList.add(loc);
      }
    }
    notifyListeners();
  }

  //APPEND EPISODES TO LOCAL LIST
  void addEpisodes(List<Episode> episodes) {
    for (Episode episode in episodes) {
      if (!episodeList.contains(episode)) {
        episodeList.add(episode);
      }
    }
    notifyListeners();
  }

  //GET LOCATION BY URL
  SingleLocation? getLocationByURL(String locationUrl) {
    final index = getLocationIndexByURL(locationUrl);
    return index == -1 ? null : locationList[index];
  }

  //GET LOCATION'S INDEX BY URL
  int getLocationIndexByURL(String locationUrl) {
    return locationList.indexWhere((element) {
      return element.url == locationUrl;
    });
  }

  //GET EPISODE BY URL
  Episode? getEpisodeByURL(String episodeUrl) {
    final index = getEpisodeIndexByURL(episodeUrl);
    return index == -1 ? null : episodeList[index];
  }

  //GET EPISODE INDEX BY URL
  int getEpisodeIndexByURL(String episodeUrl) {
    return episodeList.indexWhere((element) {
      return element.url == episodeUrl;
    });
  }
}
