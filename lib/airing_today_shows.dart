import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/movie_description_page.dart';
import 'package:tmdb_api/tmdb_api.dart';

class AiringTodayWidget extends StatefulWidget {
  const AiringTodayWidget({super.key});

  @override
  State<AiringTodayWidget> createState() => _AiringTodayWidgetState();
}

class _AiringTodayWidgetState extends State<AiringTodayWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List airingToday = [];

  @override
  void initState() {
    loadAiringToday();
    super.initState();
  }

  loadAiringToday() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map airingTodayResults = await tmdbWithCustomLogs.v3.tv.getAiringToday();
    setState(() {
      airingToday = airingTodayResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AiringTodayInterface(
      airngTday: airingToday,
    );
  }
}

//Airing Today Interface
class AiringTodayInterface extends StatelessWidget {
  const AiringTodayInterface({
    super.key,
    required this.airngTday,
  });
  final List airngTday;

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
              itemCount: airngTday.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => MovieDescriptionPage(
                          name: airngTday[index]['original_name'],
                          description: airngTday[index]['overview'],
                          // ignore: prefer_interpolation_to_compose_strings
                          bannerURL: 'https://image.tmdb.org/t/p/w500' +
                              airngTday[index]['backdrop_path'],
                          // ignore: prefer_interpolation_to_compose_strings
                          posterURL: 'https://image.tmdb.org/t/p/w500' +
                              airngTday[index]['poster_path'],
                          vote: airngTday[index]['vote_average'].toString(),
                          releaseDate: airngTday[index]['first_air_date'],
                          movieId: airngTday[index]['id'].toString(),
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
                                      airngTday[index]['poster_path']
                                          .toString(),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10.0),

                          //Profile Name
                          Flexible(
                            child: Text(
                              airngTday[index]['original_name'],
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
