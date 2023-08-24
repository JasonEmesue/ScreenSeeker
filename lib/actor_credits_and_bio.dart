import 'package:flutter/material.dart';
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

  @override
  void initState() {
    loadBirthday();
    loadPlaceOfBirth();
    loadBiography();
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

  @override
  Widget build(BuildContext context) {
    return ActorCreditsAndBioInterface(
      bthday: birthday,
      plceOfBrth: placeOfBirth,
      biogrphy: biography,
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
  });
  final Map bthday;
  final Map plceOfBrth;
  final Map biogrphy;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        'Date Of Birth:',
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
                      'Place Of Birth:',
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
            'Biography:',
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
                }),
          ),
        ],
      ),
    );
  }
}
