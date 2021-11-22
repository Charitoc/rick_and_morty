// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/models/character.dart';
import 'package:rick_morty/providers/character_provider.dart';

class CharacterDetailsScreen extends StatefulWidget {
  const CharacterDetailsScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/character_details';

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //DATA FROM PROVIDER
    final provider = Provider.of<CharacterProvider>(context);
    final Character character =
        provider.charactersList[provider.selectedCharacter];
    final episode = provider.getEpisodeByURL(character.episode[0]);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Hero(
                    tag: character.id,
                    child: Image.network(
                      character.image,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    height: 80,
                    color: Colors.transparent,
                  )
                ],
              ),
              Container(
                height: 160,
                width: 240,
                alignment: FractionalOffset.bottomCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).primaryColor.withOpacity(0.9)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 53,
                        ),
                        FittedBox(
                          child: Text(
                            character.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            character.location.name,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    character.episode.length.toString(),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    "Episodes",
                                    style: TextStyle(
                                        fontSize: 9, color: Colors.white),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    episode!.episode.toString(),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  Text(
                                    "First Seen On",
                                    style: TextStyle(
                                        fontSize: 9, color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
            alignment: AlignmentDirectional.bottomCenter,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        title: Text(
                          character.species,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "Species",
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        title: Text(
                          character.type != '' ? character.type : '-',
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "Type",
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        title: Text(
                          character.gender,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "Gender",
                          style: TextStyle(color: Colors.white60),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
