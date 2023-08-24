import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/pages/actor_profile_page.dart';
import 'package:tmdb_api/tmdb_api.dart';

class PeopleWidget extends StatefulWidget {
  const PeopleWidget({super.key});

  @override
  State<PeopleWidget> createState() => _PeopleWidgetState();
}

class _PeopleWidgetState extends State<PeopleWidget> {
  final String apiKey = 'ad05813d395ceca68ddf2a4e553aca56';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDA1ODEzZDM5NWNlY2E2OGRkZjJhNGU1NTNhY2E1NiIsInN1YiI6IjY0YmZkM2YyNmQ0Yzk3MDExY2JhMmRkMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B8WF9lb4Zl733EQmgFM56SCI_qAD-2bhrIjfxBMZSj0';
  List popularPeople = [];

  @override
  void initState() {
    loadPopularPeople();
    super.initState();
  }

  loadPopularPeople() async {
    //TMDB Object
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKey, readAccessToken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map popularPeopleResults = await tmdbWithCustomLogs.v3.people.getPopular();
    setState(() {
      popularPeople = popularPeopleResults['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopularPeopleInterface(
      popuPeople: popularPeople,
    );
  }
}

class PopularPeopleInterface extends StatelessWidget {
  const PopularPeopleInterface({
    super.key,
    required this.popuPeople,
  });
  final List popuPeople;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Pictures
          SizedBox(
            height: 700,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: popuPeople.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ActorProfilePage(
                          name: popuPeople[index]['name'],
                          // ignore: prefer_interpolation_to_compose_strings
                          profilePath: 'https://image.tmdb.org/t/p/w500' +
                              popuPeople[index]['profile_path'],
                          popularity:
                              popuPeople[index]['popularity'].toString(),
                          knownFor: popuPeople[index]['known_for_department'],
                          personId: popuPeople[index]['id'],
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
                                      popuPeople[index]['profile_path']
                                          .toString(),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 20.0),

                          //Profile Name
                          Text(
                            popuPeople[index]['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
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
