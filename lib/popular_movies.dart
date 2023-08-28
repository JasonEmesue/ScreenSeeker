import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/movie_description_page.dart';
import 'package:tmdb_api/tmdb_api.dart';

class PopularMoviesWidget extends StatefulWidget {
  const PopularMoviesWidget({super.key});

  @override
  State<PopularMoviesWidget> createState() => _PopularMoviesWidgetState();
}

class _PopularMoviesWidgetState extends State<PopularMoviesWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List popularMovies = [];

  @override
  void initState() {
    loadPopularMovies();
    super.initState();
  }

  loadPopularMovies() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map popularMoviesResults = await tmdbWithCustomLogs.v3.movies.getPopular();
    setState(() {
      popularMovies = popularMoviesResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopularMoviesInterface(
      popularMov: popularMovies,
    );
  }
}

class PopularMoviesInterface extends StatelessWidget {
  const PopularMoviesInterface({
    super.key,
    required this.popularMov,
  });
  final List popularMov;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 10.0,
        right: 10.0,
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
              itemCount: popularMov.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => MovieDescriptionPage(
                          name: popularMov[index]['title'],
                          description: popularMov[index]['overview'],
                          // ignore: prefer_interpolation_to_compose_strings
                          bannerURL: 'https://image.tmdb.org/t/p/w500' +
                              popularMov[index]['backdrop_path'],
                          // ignore: prefer_interpolation_to_compose_strings
                          posterURL: 'https://image.tmdb.org/t/p/w500' +
                              popularMov[index]['poster_path'],
                          vote: popularMov[index]['vote_average'].toString(),
                          releaseDate: popularMov[index]['release_date'],
                          movieId: popularMov[index]['id'].toString(),
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
                                      popularMov[index]['poster_path']
                                          .toString(),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10.0),

                          //Profile Name
                          Flexible(
                            child: Text(
                              popularMov[index]['title'],
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
