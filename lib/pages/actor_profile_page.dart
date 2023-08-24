import 'package:flutter/material.dart';
import 'package:screenseeker/actor_credits_and_bio.dart';

class ActorProfilePage extends StatelessWidget {
  const ActorProfilePage({
    super.key,
    required this.name,
    required this.profilePath,
    required this.popularity,
    required this.knownFor,
    required this.personId,
  });
  final String name, profilePath, popularity, knownFor;
  final int personId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 5.0, right: 5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 150,
                      child: Image.network(profilePath),
                    ),
                    const SizedBox(width: 30),

                    //Name and other Info
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child:
                                //Actor Name
                                Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          //vertical space
                          const SizedBox(height: 10),

                          //Popularity
                          Text(
                            'Popularity:  $popularity',
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),

                          //vertical space
                          const SizedBox(height: 10),

                          //Known For
                          Text(
                            'Known For:  $knownFor',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //Credits And Bio
                ActorCreditsAndBio(personId: personId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
