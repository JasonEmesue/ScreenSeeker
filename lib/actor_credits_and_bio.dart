import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/movie_description_page.dart';
import 'package:screenseeker/pages/tvshow_description_page.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ActorCreditsAndBio extends StatefulWidget {
  const ActorCreditsAndBio({
    super.key,
    required this.personId,
  });
  final int personId;

  @override
  State<ActorCreditsAndBio> createState() => _ActorCreditsAndBioState();
}

class _ActorCreditsAndBioState extends State<ActorCreditsAndBio> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  Map birthday = {};
  Map placeOfBirth = {};
  Map biography = {};
  List movieCredits = [];
  List tvCredits = [];

  @override
  void initState() {
    loadBirthday();
    loadPlaceOfBirth();
    loadBiography();
    loadMovieCredits();
    loadTVCredits();
    super.initState();
  }

  //Birthday
  loadBirthday() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map birthdayResults =
        await tmdbWithCustomLogs.v3.people.getDetails(widget.personId);
    setState(
      () {
        birthday = birthdayResults;
      },
    );
  }

  //Place Of Birth
  loadPlaceOfBirth() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map placeOfBirthResults =
        await tmdbWithCustomLogs.v3.people.getDetails(widget.personId);
    setState(
      () {
        placeOfBirth = placeOfBirthResults;
      },
    );
  }

  //Biography
  loadBiography() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map biographyResults =
        await tmdbWithCustomLogs.v3.people.getDetails(widget.personId);
    setState(
      () {
        biography = biographyResults;
      },
    );
  }

  //Movie Credits
  loadMovieCredits() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map movieCreditsResults =
        await tmdbWithCustomLogs.v3.people.getMovieCredits(widget.personId);
    setState(() {
      movieCredits = movieCreditsResults['cast'];
    });
  }

  //TV Credits
  loadTVCredits() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map tvCreditsResults =
        await tmdbWithCustomLogs.v3.people.getTvCredits(widget.personId);
    setState(() {
      tvCredits = tvCreditsResults['cast'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ActorCreditsAndBioInterface(
      bthday: birthday,
      plceOfBrth: placeOfBirth,
      biogrphy: biography,
      movCrdts: movieCredits,
      tvCrdts: tvCredits,
    );
  }
}

//Actor Credits Info
class ActorCreditsAndBioInterface extends StatelessWidget {
  const ActorCreditsAndBioInterface({
    super.key,
    required this.bthday,
    required this.plceOfBrth,
    required this.biogrphy,
    required this.movCrdts,
    required this.tvCrdts,
  });
  final Map bthday;
  final Map plceOfBrth;
  final Map biogrphy;
  final List movCrdts;
  final List tvCrdts;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Date Of Birth List
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: 55,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Date Of Birth',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            bthday['birthday'].toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            //Place Of Birth List
            SizedBox(
              height: 58,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Place Of Birth',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 19.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          plceOfBrth['place_of_birth'].toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),

            //Biography
            const Text(
              'Biography',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 19.0,
              ),
            ),

            //vertical space
            const SizedBox(
              height: 7.0,
            ),

            //Biography List
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 300,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            biogrphy['biography'].toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            //vertical space
            const SizedBox(
              height: 10.0,
            ),

            //Credits Text
            const Text(
              'Credits',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 19.0,
              ),
            ),

            //Credits Tab (Movie, TV)
            const TabBar(
              isScrollable: true,
              indicatorColor: Colors.purpleAccent,
              tabs: [
                Tab(
                  child: Text('MOVIE'),
                ),
                Tab(
                  child: Text('TV'),
                ),
              ],
            ),
            SizedBox(
              height: 720,
              child: TabBarView(
                children: [
                  //Movie Credits
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: movCrdts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => MovieDescriptionPage(
                                name: movCrdts[index]['title'].toString(),
                                description:
                                    movCrdts[index]['overview'].toString(),
                                // ignore: prefer_interpolation_to_compose_strings
                                bannerURL:
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'https://image.tmdb.org/t/p/w500' +
                                        movCrdts[index]['backdrop_path']
                                            .toString(),
                                // ignore: prefer_interpolation_to_compose_strings
                                posterURL:
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'https://image.tmdb.org/t/p/w500' +
                                        movCrdts[index]['poster_path']
                                            .toString(),
                                vote:
                                    movCrdts[index]['vote_average'].toString(),
                                releaseDate:
                                    movCrdts[index]['release_date'].toString(),
                                movieId: movCrdts[index]['id'].toString(),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 11.0,
                            left: 5.0,
                            top: 5.0,
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
                                            movCrdts[index]['poster_path']
                                                .toString(),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 20.0),

                                //Profile Name
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movCrdts[index]['title'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'as ${movCrdts[index]['character']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  //TV Credits
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: tvCrdts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => TvShowDescriptionPage(
                                originalName:
                                    tvCrdts[index]['original_name'].toString(),
                                description:
                                    tvCrdts[index]['overview'].toString(),
                                // ignore: prefer_interpolation_to_compose_strings
                                bannerURL: 'https://image.tmdb.org/t/p/w500' +
                                    tvCrdts[index]['backdrop_path'].toString(),
                                // ignore: prefer_interpolation_to_compose_strings
                                posterURL: 'https://image.tmdb.org/t/p/w500' +
                                    tvCrdts[index]['poster_path'].toString(),
                                vote: tvCrdts[index]['vote_average'].toString(),
                                firstAirDate:
                                    tvCrdts[index]['first_air_date'].toString(),
                                seriesId: tvCrdts[index]['id'],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 11.0,
                            left: 5.0,
                            top: 5.0,
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
                                            tvCrdts[index]['poster_path']
                                                .toString(),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 20.0),

                                //Profile Name
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tvCrdts[index]['original_name'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'as ${tvCrdts[index]['character']}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
