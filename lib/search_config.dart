import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/actor_profile_page.dart';
import 'package:screenseeker/pages/movie_description_page.dart';
import 'package:screenseeker/pages/tvshow_description_page.dart';
import 'package:tmdb_api/tmdb_api.dart';

//Movie Search
class MovieSearchConfig extends StatefulWidget {
  const MovieSearchConfig({
    super.key,
    required this.querry,
  });
  final String querry;

  @override
  State<MovieSearchConfig> createState() => _MovieSearchConfigState();
}

class _MovieSearchConfigState extends State<MovieSearchConfig> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List movieSearch = [];

  @override
  void initState() {
    loadMovieSearch();
    super.initState();
  }

  //Querry API
  loadMovieSearch() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map movieSearchResults =
        await tmdbWithCustomLogs.v3.search.queryMovies(widget.querry);
    setState(() {
      movieSearch = movieSearchResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MovieSearchConfigInterface(
      qry: movieSearch,
    );
  }
}

//Movie Search Interface
class MovieSearchConfigInterface extends StatelessWidget {
  const MovieSearchConfigInterface({
    super.key,
    required this.qry,
  });
  final List qry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Results',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          right: 10.0,
          bottom: 10.0,
          left: 5.0,
          top: 13.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //List Results
            Expanded(
              child: SizedBox(
                height: 710,
                width: 500,
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
                              name: qry[index]['title'].toString(),
                              description: qry[index]['overview'].toString(),
                              // ignore: prefer_interpolation_to_compose_strings
                              bannerURL: 'https://image.tmdb.org/t/p/w500' +
                                  qry[index]['backdrop_path'].toString(),
                              // ignore: prefer_interpolation_to_compose_strings
                              posterURL: 'https://image.tmdb.org/t/p/w500' +
                                  qry[index]['poster_path'].toString(),
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
                              //Movie Poster
                              Container(
                                height: 140,
                                width: 110,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'https://image.tmdb.org/t/p/w500' +
                                          qry[index]['poster_path'].toString(),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10.0),

                              //Movie Title
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
            ),
          ],
        ),
      ),
    );
  }
}

//TV Show Search
class TVShowSearchConfig extends StatefulWidget {
  const TVShowSearchConfig({
    super.key,
    required this.querry,
  });
  final String querry;

  @override
  State<TVShowSearchConfig> createState() => _TVShowSearchConfigState();
}

class _TVShowSearchConfigState extends State<TVShowSearchConfig> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List tvShowSearch = [];

  @override
  void initState() {
    loadTVShowSearch();
    super.initState();
  }

  loadTVShowSearch() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map tvShowSearchResults =
        await tmdbWithCustomLogs.v3.search.queryTvShows(widget.querry);
    setState(() {
      tvShowSearch = tvShowSearchResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return TVShowSearchInterface(
      tvQry: tvShowSearch,
    );
  }
}

//Tv Show Search Interface
class TVShowSearchInterface extends StatelessWidget {
  const TVShowSearchInterface({
    super.key,
    required this.tvQry,
  });
  final List tvQry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:  const Text(
          'Results',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          right: 10.0,
          bottom: 10.0,
          left: 5.0,
          top: 13.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //List Results
            Expanded(
              child: SizedBox(
                height: 710,
                width: 500,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: tvQry.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => TvShowDescriptionPage(
                              originalName:
                                  tvQry[index]['original_name'].toString(),
                              description: tvQry[index]['overview'].toString(),
                              // ignore: prefer_interpolation_to_compose_strings
                              bannerURL: 'https://image.tmdb.org/t/p/w500' +
                                  tvQry[index]['backdrop_path'].toString(),
                              // ignore: prefer_interpolation_to_compose_strings
                              posterURL: 'https://image.tmdb.org/t/p/w500' +
                                  tvQry[index]['poster_path'].toString(),
                              vote: tvQry[index]['vote_average'].toString(),
                              firstAirDate:
                                  tvQry[index]['first_air_date'].toString(),
                              seriesId: tvQry[index]['id'],
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
                              //TV Show Poster
                              Container(
                                height: 140,
                                width: 110,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'https://image.tmdb.org/t/p/w500' +
                                          tvQry[index]['poster_path']
                                              .toString(),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10.0),

                              //Tv Show Title
                              Flexible(
                                child: Text(
                                  tvQry[index]['original_name'].toString(),
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
            ),
          ],
        ),
      ),
    );
  }
}

//People Search
class PeopleSearchConfig extends StatefulWidget {
  const PeopleSearchConfig({
    super.key,
    required this.peopleQuerry,
  });
  final String peopleQuerry;

  @override
  State<PeopleSearchConfig> createState() => _PeopleSearchConfigState();
}

class _PeopleSearchConfigState extends State<PeopleSearchConfig> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List peopleSearch = [];

  @override
  void initState() {
    loadPeopleSearch();
    super.initState();
  }

  //Querry API
  loadPeopleSearch() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map peopleSearchResults =
        await tmdbWithCustomLogs.v3.search.queryPeople(widget.peopleQuerry);
    setState(() {
      peopleSearch = peopleSearchResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return PeopleSearchInterface(
      pplQry: peopleSearch,
    );
  }
}

//People Search Interface
class PeopleSearchInterface extends StatelessWidget {
  const PeopleSearchInterface({super.key, required this.pplQry,});
  final List pplQry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title:  const Text(
          'Results',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.only(
          right: 10.0,
          bottom: 10.0,
          left: 5.0,
          top: 13.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //List Results
            Expanded(
              child: SizedBox(
                height: 710,
                width: 500,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: pplQry.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ActorProfilePage(
                          name: pplQry[index]['name'],
                          // ignore: prefer_interpolation_to_compose_strings
                          profilePath: 'https://image.tmdb.org/t/p/w500' +
                              pplQry[index]['profile_path'],
                          popularity: pplQry[index]['popularity'].toString(),
                          knownFor: pplQry[index]['known_for_department'],
                          personId: pplQry[index]['id'],
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
                              //Person Poster
                              Container(
                                height: 140,
                                width: 110,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'https://image.tmdb.org/t/p/w500' +
                                          pplQry[index]['profile_path'].toString(),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10.0),

                              //Person Name
                              Flexible(
                                child: Text(
                                  pplQry[index]['name'].toString(),
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
            ),
          ],
        ),
      ),
    );
  }
}
