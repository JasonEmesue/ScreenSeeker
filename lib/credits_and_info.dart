import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class CreditsAndInfoWidget extends StatefulWidget {
  const CreditsAndInfoWidget({super.key});

  @override
  State<CreditsAndInfoWidget> createState() => _CreditsAndInfoWidgetState();
}

class _CreditsAndInfoWidgetState extends State<CreditsAndInfoWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List cast = [];
  List crew = [];
  List reviews = [];

  @override
  void initState() {
    loadCast();
    loadCrew();
    loadReviews();
    super.initState();
  }

  //Cast
  loadCast() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map castResults = await tmdbWithCustomLogs.v3.movies.getCredits(872585);
    setState(() {
      cast = castResults['cast'];
    });
  }

  //Crew
  loadCrew() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map crewResults = await tmdbWithCustomLogs.v3.movies.getCredits(872585);
    setState(() {
      crew = crewResults['crew'];
    });
  }

  //Reviews
  loadReviews() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map reviewsResults = await tmdbWithCustomLogs.v3.movies.getReviews(872585);
    setState(() {
      reviews = reviewsResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CreditsAndInfoInterface(
      cst: cast,
      crw: crew,
      revws: reviews,
    );
  }
}

//Cast And Reviews Interface
class CreditsAndInfoInterface extends StatelessWidget {
  const CreditsAndInfoInterface({
    super.key,
    required this.cst,
    required this.crw,
    required this.revws,
  });
  final List cst;
  final List crw;
  final List revws;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Cast Header and List
          const Text(
            'Top Billed Cast',
            style: TextStyle(
              fontSize: 23.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),

          //vertical space
          const SizedBox(height: 10.0),

          //List Of Actor Profiles
          SizedBox(
            height: 266,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cst.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 190.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                // ignore: prefer_interpolation_to_compose_strings
                                'https://image.tmdb.org/t/p/w500' +
                                    cst[index]['profile_path'].toString(),
                              ),
                            ),
                          ),
                        ),

                        //Name And Character
                        Container(
                          height: 76.0,
                          width: 128,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Name
                              Padding(
                                padding: const EdgeInsets.all(2.5),
                                child: Flexible(
                                  child: Text(
                                    cst[index]['name'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),

                              //Character
                              Padding(
                                padding: const EdgeInsets.all(2.5),
                                child: Flexible(
                                  child: Text(
                                    cst[index]['character'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          //vertical space
          const SizedBox(height: 25.0),

          //Crew Header and List
          const Text(
            'Crew',
            style: TextStyle(
              fontSize: 23.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),

          //vertical space
          const SizedBox(height: 10.0),

          //List Of Crew Profiles
          SizedBox(
            height: 266,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: crw.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 190.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                // ignore: prefer_interpolation_to_compose_strings
                                'https://image.tmdb.org/t/p/w500' +
                                    crw[index]['profile_path'].toString(),
                              ),
                            ),
                          ),
                        ),

                        //Name And Jobs
                        Container(
                          height: 76.0,
                          width: 128,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Name
                              Padding(
                                padding: const EdgeInsets.all(2.5),
                                child: Flexible(
                                  child: Text(
                                    crw[index]['name'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),

                              //Jobs
                              Padding(
                                padding: const EdgeInsets.all(2.5),
                                child: Flexible(
                                  child: Text(
                                    crw[index]['job'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          //
          const SizedBox(width: 25.0),

          //List Of Reviews
          const Text(
            'Reviews',
            style: TextStyle(
              fontSize: 23.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),

          //vertical space
          const SizedBox(height: 10.0),

          //Reviews
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: revws.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 340.0,
                    child: Container(
                      width: 340,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromARGB(255, 226, 226, 226),
                      ),
                      child: Stack(
                        children: [
                          //Reviewer name
                          Positioned(
                            left: 8.0,
                            top: 7.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'written by',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  revws[index]['author'].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Rating
                          Positioned(
                            right: 40.0,
                            top: 10.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '⭐ Rating',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  revws[index]['author_details']['rating']
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Review content
                          Positioned(
                            bottom: 15.0,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                width: 340,
                                height: 185,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 3.5),
                                  child: Text(
                                    revws[index]['content'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
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
