import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/home.dart';
import 'package:screenseeker/pages/movie_description_page.dart';
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
        await tmdbWithCustomLogs.v3.search.queryMovies(widget.querry);
    setState(() {
      search = searchResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchConfigInterface(
      qry: search,
    );
  }
}

class SearchConfigInterface extends StatelessWidget {
  const SearchConfigInterface({
    super.key,
    required this.qry,
  });
  final List qry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'RESULTS',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          //Results List
          Container(
            padding: const EdgeInsets.only(
              right: 10.0,
              bottom: 10.0,
              left: 5.0,
              top: 13.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Pictures
                SizedBox(
                  height: 664,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: qry.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => MovieDescriptionPage(
                                name: qry[index]['title'],
                                description: qry[index]['overview'],
                                // ignore: prefer_interpolation_to_compose_strings
                                bannerURL: 'https://image.tmdb.org/t/p/w500' +
                                    qry[index]['backdrop_path'],
                                // ignore: prefer_interpolation_to_compose_strings
                                posterURL: 'https://image.tmdb.org/t/p/w500' +
                                    qry[index]['poster_path'],
                                vote: qry[index]['vote_average'].toString(),
                                releaseDate: qry[index]['release_date'],
                                movieId: qry[index]['id'].toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 11.0,
                            left: 5.0,
                          ),
                          child: SizedBox(
                            width: 500,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //Profile Picture
                                Container(
                                  height: 140,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        'https://image.tmdb.org/t/p/w500' +
                                            qry[index]['poster_path']
                                                .toString(),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10.0),

                                //Profile Name
                                Flexible(
                                  child: Text(
                                    qry[index]['title'].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
