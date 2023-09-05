import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class SearchConfig extends StatefulWidget {
  const SearchConfig({
    super.key,
    required this.querry,
  });
  final String querry;
  @override
  State<SearchConfig> createState() => _SearchConfigState();
}

class _SearchConfigState extends State<SearchConfig> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List search = [];

  @override
  void initState() {
    loadSearch();
    super.initState();
  }

  //Querry API
  loadSearch() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map searchResults =
        await tmdbWithCustomLogs.v3.search.queryMulti(widget.querry);
    setState(() {
      search = searchResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
