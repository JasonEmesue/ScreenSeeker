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
  List birthday = [];

  @override
  void initState() {
    loadBirthday();
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
    setState(() {
      birthday = birthdayResults as List;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

//Actor Credits Info
class ActorCreditsAndInfoInterface extends StatelessWidget {
  const ActorCreditsAndInfoInterface({
    super.key,
    required this.bthday,
    required this.placeOfBirth,
  });
  final List bthday;
  final List placeOfBirth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Birthday
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Birthday',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  //
                  const SizedBox(height: 3.0),
                  //
                  Text(
                    bthday.toString(),
                  ),
                ],
              ),

              //
              const SizedBox(
                width: 50.0,
              ),

              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Place Of Birth',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //
                  const SizedBox(height: 3.0),

                  //
                  Text(
                    placeOfBirth.toString(),
                  ),
                  ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
