import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/movie_description_page.dart';
import 'package:tmdb_api/tmdb_api.dart';

class LatestReleasesWidget extends StatefulWidget {
  const LatestReleasesWidget({super.key});

  @override
  State<LatestReleasesWidget> createState() => _LatestReleasesWidgetState();
}

class _LatestReleasesWidgetState extends State<LatestReleasesWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List latestReleases = [];

  @override
  void initState() {
    loadLatestReleases();
    super.initState();
  }

  loadLatestReleases() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map latestReleasesResults =
        await tmdbWithCustomLogs.v3.movies.getNowPlaying();
    setState(() {
      latestReleases = latestReleasesResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return LatestReleasesInterface(lateRelease: latestReleases);
  }
}

//The Latest Releases Interface
class LatestReleasesInterface extends StatelessWidget {
  const LatestReleasesInterface({
    super.key,
    required this.lateRelease,
  });
  final List lateRelease;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Releases',
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
            height: 195,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: lateRelease.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // ignore: prefer_interpolation_to_compose_strings
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => MovieDescriptionPage(
                            name: lateRelease[index]['title'],
                            description: lateRelease[index]['overview'],
                            // ignore: prefer_interpolation_to_compose_strings
                            bannerURL: 'https://image.tmdb.org/t/p/w500' +
                                lateRelease[index]['backdrop_path'],
                            // ignore: prefer_interpolation_to_compose_strings
                            posterURL: 'https://image.tmdb.org/t/p/w500' +
                                lateRelease[index]['poster_path'],
                            vote: lateRelease[index]['vote_average'].toString(),
                            releaseDate: lateRelease[index]['release_date'],
                            movieId: lateRelease[index]['id'].toString(),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SizedBox(
                        width: 280.0,
                        child: Column(
                          children: [
                            Container(
                              height: 150.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      'https://image.tmdb.org/t/p/w500' +
                                          lateRelease[index]['backdrop_path']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            //vertical space
                            const SizedBox(height: 8.0),

                            //Title
                            SizedBox(
                              child: Text(
                                lateRelease[index]['title'] ?? 'Loading',
                              ),
                            ),
                          ],
                        ),
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

//Now Playing Widget
class NowPlayingWidget extends StatefulWidget {
  const NowPlayingWidget({super.key});

  @override
  State<NowPlayingWidget> createState() => _NowPlayingWidgetState();
}

class _NowPlayingWidgetState extends State<NowPlayingWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List nowPlaying = [];

  @override
  void initState() {
    loadNowPlaying();
    super.initState();
  }

  loadNowPlaying() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map nowPlayingResults = await tmdbWithCustomLogs.v3.movies.getNowPlaying();
    setState(() {
      nowPlaying = nowPlayingResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return NowPlayingInterface(
      nowPlyng: nowPlaying,
    );
  }
}

//The Now Playing Interface
class NowPlayingInterface extends StatelessWidget {
  const NowPlayingInterface({super.key, required this.nowPlyng});
  final List nowPlyng;

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
              itemCount: nowPlyng.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => MovieDescriptionPage(
                          name: nowPlyng[index]['title'],
                          description: nowPlyng[index]['overview'],
                          // ignore: prefer_interpolation_to_compose_strings
                          bannerURL: 'https://image.tmdb.org/t/p/w500' +
                              nowPlyng[index]['backdrop_path'],
                          // ignore: prefer_interpolation_to_compose_strings
                          posterURL: 'https://image.tmdb.org/t/p/w500' +
                              nowPlyng[index]['poster_path'],
                          vote: nowPlyng[index]['vote_average'].toString(),
                          releaseDate: nowPlyng[index]['release_date'],
                          movieId: nowPlyng[index]['id'].toString(),
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
                                      nowPlyng[index]['poster_path'].toString(),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10.0),

                          //Profile Name
                          Flexible(
                            child: Text(
                              nowPlyng[index]['title'],
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
