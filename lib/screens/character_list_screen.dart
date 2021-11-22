import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/api/api_urls.dart';
import 'package:rick_morty/api/call_orders.dart';
import 'package:rick_morty/character_card.dart';
import 'package:rick_morty/providers/character_provider.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final scrollcontroller = ScrollController();
  Future? getAllCharacters;
  int page = 1;

  //GET DATA FOR NEXT PAGE WHEN THE SCROLLED POSITION REACHES THE END OF SCREEN
  void pagination() {
    if ((scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent)) {
      page += 1;
      callAPI(page);
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollcontroller.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollcontroller.addListener(pagination);
    getAllCharacters = callAPI(page);
  }

  Future callAPI(int page) async {
    //GET LOCAL CHARACTER LIST AFTER THE CHARACTERS FROM API ARE ADDED TO THE LOCAL ONE
    CallOrders.getAllCharacters(context, page)
        .then((value) => value.fold((l) => null, (r) {
              final characters =
                  Provider.of<CharacterProvider>(context, listen: false)
                      .charactersList;

              /// GET LOCATION DETAILS
              List<String> locationsUrls =
                  characters.map((e) => e.location.url).toList();
              List<String> locationsIds = locationsUrls
                  .map((e) {
                    List<String> splits = e.split("/");
                    return splits[splits.length - 1];
                  })
                  // REMOVE DUPLICATES WITH TOSET()
                  .toSet()
                  .toList();

              CallOrders.getLocations(
                  "${ApiUrls.LOCATION}${locationsIds.join(',')}", context);

              /// GET EPISODE DETAILS
              List<String> episodesList = characters.map((e) {
                return e.episode.isNotEmpty ? e.episode[0] : "";
              }).toList();

              List<String> episodeIds = episodesList
                  .map((e) {
                    List<String> splits = e.split("/");
                    return splits[splits.length - 1];
                  })
                  // REMOVE DUPLICATES WITH TOSET()
                  .toSet()
                  .toList();

              CallOrders.getEpisodes(
                  "${ApiUrls.EPISODE}${episodeIds.join(',')}", context);
            }));
  }

  @override
  Widget build(BuildContext context) {
    final characters = Provider.of<CharacterProvider>(context).charactersList;
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          toolbarHeight: 100,
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Rick_and_Morty.svg/799px-Rick_and_Morty.svg.png"),
          ),
        ),
        body: FutureBuilder(
            future: getAllCharacters,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    controller: scrollcontroller,
                    itemExtent: 180,
                    itemCount: characters.length,
                    itemBuilder: (ctx, index) => CharacterCard(index));
              } else {
                return const Center(
                  child: Text("Something went wrong!"),
                );
              }
            }));
  }
}
