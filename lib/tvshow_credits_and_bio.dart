import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/actor_profile_page.dart';
import 'package:screenseeker/pages/tvshow_description_page.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TvShowCreditsAndBioWidget extends StatefulWidget {
  const TvShowCreditsAndBioWidget({
    super.key,
    required this.seriesId,
  });
  final int seriesId;

  @override
  State<TvShowCreditsAndBioWidget> createState() =>
      _TvShowCreditsAndBioWidgetState();
}

class _TvShowCreditsAndBioWidgetState extends State<TvShowCreditsAndBioWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List cast = [];
  List crew = [];
  List reviews = [];
  List images = [];
  List similar = [];

  @override
  void initState() {
    loadCast();
    loadCrew();
    loadReviews();
    loadImages();
    loadSimilar();
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

    Map castResults =
        await tmdbWithCustomLogs.v3.tv.getCredits(widget.seriesId);
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

    Map crewResults =
        await tmdbWithCustomLogs.v3.tv.getCredits(widget.seriesId);
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

    Map reviewsResults =
        await tmdbWithCustomLogs.v3.tv.getReviews(widget.seriesId);
    setState(() {
      reviews = reviewsResults['results'];
    });
  }

  //Images
  loadImages() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map imagesResults =
        await tmdbWithCustomLogs.v3.tv.getImages(widget.seriesId);
    setState(() {
      images = imagesResults['backdrops'];
    });
  }

  //Similar
  loadSimilar() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map similarResults =
        await tmdbWithCustomLogs.v3.tv.getSimilar(widget.seriesId);
    setState(() {
      similar = similarResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CreditsAndInfoInterface(
      cst: cast,
      crw: crew,
      revws: reviews,
      imgs: images,
      simlr: similar,
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
    required this.imgs,
    required this.simlr,
  });
  final List cst;
  final List crw;
  final List revws;
  final List imgs;
  final List simlr;

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
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ActorProfilePage(
                          name: cst[index]['name'],
                          // ignore: prefer_interpolation_to_compose_strings
                          profilePath: 'https://image.tmdb.org/t/p/w500' +
                              cst[index]['profile_path'],
                          popularity: cst[index]['popularity'].toString(),
                          knownFor: cst[index]['known_for_department'],
                          personId: cst[index]['id'],
                        ),
                      ),
                    );
                  },
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
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.5),
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
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.5),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ActorProfilePage(
                          name: crw[index]['name'],
                          // ignore: prefer_interpolation_to_compose_strings
                          profilePath: 'https://image.tmdb.org/t/p/w500' +
                              crw[index]['profile_path'],
                          popularity: crw[index]['popularity'].toString(),
                          knownFor: crw[index]['known_for_department'],
                          personId: crw[index]['id'],
                        ),
                      ),
                    );
                  },
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
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.5),
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
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.5),
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
          const SizedBox(height: 25.0),

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
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: SizedBox(
                      width: 340.0,
                      child: Container(
                        width: 340,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color.fromARGB(255, 221, 213, 213),
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
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Rating
                            Positioned(
                              right: 22.0,
                              top: 8.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '⭐ ${revws[index]['author_details']['rating']}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Review content
                            Positioned(
                              bottom: 8.0,
                              child: Container(
                                width: 340,
                                height: 195,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7.5,
                                      vertical: 6.0,
                                    ),
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
                  ),
                );
              },
            ),
          ),

          //
          // const SizedBox(height: 25.0),

          //Images
          // const Text(
          //   'Images',
          //   style: TextStyle(
          //     fontSize: 23.0,
          //     color: Colors.white,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),

          // //vertical space
          // const SizedBox(height: 10.0),

          // //Image List
          // SizedBox(
          //   height: 250,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: imgs.length,
          //     itemBuilder: (context, index) {
          //       return InkWell(
          //         onTap: () {},
          //         child: Padding(
          //           padding: const EdgeInsets.only(right: 6.0),
          //           child: SizedBox(
          //             width: 200,
          //             child: Container(
          //               width: 250,
          //               height: 200,
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   fit: BoxFit.cover,
          //                   image: NetworkImage(
          //                     // ignore: prefer_interpolation_to_compose_strings
          //                     'https://image.tmdb.org/t/p/w500' +
          //                         imgs[index]['file_path'].toString(),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),

          //
          const SizedBox(height: 25.0),

          //Similar Recommendations
          const Text(
            'Similar',
            style: TextStyle(
              fontSize: 23.0,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),

          //vertical space
          const SizedBox(height: 10.0),

          //Similar List
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: simlr.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // ignore: prefer_interpolation_to_compose_strings
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => TvShowDescriptionPage(
                                originalName: simlr[index]['original_name'],
                                description: simlr[index]['overview'],
                                // ignore: prefer_interpolation_to_compose_strings
                                bannerURL: 'https://image.tmdb.org/t/p/w500' +
                                    simlr[index]['backdrop_path'],
                                // ignore: prefer_interpolation_to_compose_strings
                                posterURL: 'https://image.tmdb.org/t/p/w500' +
                                    simlr[index]['poster_path'],
                                vote: simlr[index]['vote_average'].toString(),
                                firstAirDate: simlr[index]['first_air_date'],
                                seriesId: simlr[index]['id'],
                              ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 140.0,
                    child: Column(
                      children: [
                        Container(
                          height: 190.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  'https://image.tmdb.org/t/p/w500' +
                                      simlr[index]['poster_path'].toString()),
                            ),
                          ),
                        ),

                        //vertical space
                        const SizedBox(height: 8.0),

                        //Title
                        SizedBox(
                          child: Text(
                            simlr[index]['original_name'].toString(),
                          ),
                        ),
                      ],
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
