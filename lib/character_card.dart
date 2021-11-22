// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/models/character.dart';
import 'package:rick_morty/providers/character_provider.dart';
import 'package:rick_morty/screens/character_details_screen.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard(this.index);

  final int index;
  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //GET DATA FROM PROVIDER
    final provider = Provider.of<CharacterProvider>(context);
    final Character character = provider.charactersList[widget.index];
    final location = provider.getLocationByURL(character.location.url);
    final episode = provider.getEpisodeByURL(character.episode[0]);

    return GestureDetector(
      //CHOOSE CHARACTER AND OPEN THE DETAILS SCREEN
      onTap: () {
        Provider.of<CharacterProvider>(context, listen: false)
            .updateSelectedCharacter(widget.index);
        Navigator.of(context).pushNamed(CharacterDetailsScreen.routeName);
      },
      child: Container(
        height: 300,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).backgroundColor),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Hero(
                  tag: character.id,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/placeholder.png'),
                    image: NetworkImage(character.image),
                    fit: BoxFit.fitHeight,
                    height: 200,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(character.name,
                            maxLines: 2,
                            softWrap: true,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: character.status == "Alive"
                                    ? Colors.lightGreenAccent
                                    : character.status == "Dead"
                                        ? Colors.red
                                        : Colors.grey[350],
                                borderRadius: BorderRadius.circular(90)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                              "${character.status ?? "-"} - ${character.species ?? "-"} ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Last known location:",
                          style: TextStyle(
                            color: Color.fromRGBO(158, 158, 158, 1),
                          )),
                      location == null
                          ? Container()
                          : Text(
                              character.location.name,
                              style: TextStyle(color: Colors.white),
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text("First seen in:",
                          style: TextStyle(
                            color: Color.fromRGBO(158, 158, 158, 1),
                          )),
                      episode == null
                          ? Container()
                          : Text(
                              episode.name,
                              style: TextStyle(color: Colors.white),
                            )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
