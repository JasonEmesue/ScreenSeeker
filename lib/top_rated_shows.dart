import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/description_page.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TopRatedShowsWidget extends StatefulWidget {
  const TopRatedShowsWidget({super.key});

  @override
  State<TopRatedShowsWidget> createState() => _TopRatedShowsWidgetState();
}

class _TopRatedShowsWidgetState extends State<TopRatedShowsWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List topRatedShows = [];

  @override
  void initState() {
    loadTopRatedShows();
    super.initState();
  }

  loadTopRatedShows() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map topRatedShowsResults = await tmdbWithCustomLogs.v3.tv.getTopRated();
    setState(() {
      topRatedShows = topRatedShowsResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopRatedShowsInterface(topRated: topRatedShows);
  }
}

//The Top Rated Shows User Interface
class TopRatedShowsInterface extends StatelessWidget {
  const TopRatedShowsInterface({
    super.key,
    required this.topRated,
  });
  final List topRated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Rated Shows',
            style: TextStyle(
              fontSize: 23.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),

          //vertical space
          const SizedBox(height: 10.0),

          //List Posters Container
          SizedBox(
            height: 210,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRated.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => DescriptionPage(
                            name: topRated[index]['original_name'] ??
                                'Not Loaded',
                            description: topRated[index]['overview'],
                            // ignore: prefer_interpolation_to_compose_strings
                            bannerURL: 'https://image.tmdb.org/t/p/w500' +
                                topRated[index]['backdrop_path'],
                            // ignore: prefer_interpolation_to_compose_strings
                            posterURL: 'https://image.tmdb.org/t/p/w500' +
                                topRated[index]['poster_path'],
                            vote: topRated[index]['vote_average'].toString(),
                            releaseDate:
                                topRated[index]['first_air_date'].toString(),
                            movieId: topRated[index]['id'].toString(),
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 140.0,
                      child: Column(
                        children: [
                          Container(
                            height: 200.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'https://image.tmdb.org/t/p/w500' +
                                        topRated[index]['poster_path']),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

//Tab Top Rated Shows
class TabTopRatedShowsWidget extends StatefulWidget {
  const TabTopRatedShowsWidget({super.key});

  @override
  State<TabTopRatedShowsWidget> createState() => _TabTopRatedShowsWidgetState();
}

class _TabTopRatedShowsWidgetState extends State<TabTopRatedShowsWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List tabTopRatedShows = [];

  @override
  void initState() {
    loadTabTopRatedShows();
    super.initState();
  }

  loadTabTopRatedShows() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map tabTopRatedShowsResults = await tmdbWithCustomLogs.v3.tv.getTopRated();
    setState(() {
      tabTopRatedShows = tabTopRatedShowsResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabTopRatedShowsInterface(
      tabTpRtdShws: tabTopRatedShows,
    );
  }
}

//Tab Top Rated Shows Interface
class TabTopRatedShowsInterface extends StatelessWidget {
  const TabTopRatedShowsInterface({
    super.key,
    required this.tabTpRtdShws,
  });
  final List tabTpRtdShws;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              itemCount: tabTpRtdShws.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => DescriptionPage(
                          name: tabTpRtdShws[index]['original_name'],
                          description: tabTpRtdShws[index]['overview'],
                          // ignore: prefer_interpolation_to_compose_strings
                          bannerURL: 'https://image.tmdb.org/t/p/w500' +
                              tabTpRtdShws[index]['backdrop_path'],
                          // ignore: prefer_interpolation_to_compose_strings
                          posterURL: 'https://image.tmdb.org/t/p/w500' +
                              tabTpRtdShws[index]['poster_path'],
                          vote: tabTpRtdShws[index]['vote_average'].toString(),
                          releaseDate: tabTpRtdShws[index]['first_air_date'],
                          movieId: tabTpRtdShws[index]['id'].toString(),
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
                                      tabTpRtdShws[index]['poster_path']
                                          .toString(),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10.0),

                          //Profile Name
                          Flexible(
                            child: Text(
                              tabTpRtdShws[index]['original_name'],
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
    );
  }
}
