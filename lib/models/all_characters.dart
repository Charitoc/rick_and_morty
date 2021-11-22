//@dart=2.9
import 'dart:convert';
import 'package:rick_morty/models/character.dart';

AllCharacters allCharactersFromJson(String str) =>
    AllCharacters.fromJson(json.decode(str));

String allCharactersToJson(AllCharacters data) => json.encode(data.toJson());

class AllCharacters {
  AllCharacters({
    this.info,
    this.characters,
  });

  Info info;
  List<Character> characters;

  factory AllCharacters.fromJson(Map<String, dynamic> json) => AllCharacters(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        characters: json["results"] == null
            ? null
            : List<Character>.from(
                json["results"].map((x) => Character.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info == null ? null : info.toJson(),
        "results": characters == null
            ? null
            : List<dynamic>.from(characters.map((x) => x.toJson())),
      };
}

class Info {
  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  int count;
  int pages;
  String next;
  dynamic prev;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"] == null ? null : json["count"],
        pages: json["pages"] == null ? null : json["pages"],
        next: json["next"] == null ? null : json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "pages": pages == null ? null : pages,
        "next": next == null ? null : next,
        "prev": prev,
      };
}
