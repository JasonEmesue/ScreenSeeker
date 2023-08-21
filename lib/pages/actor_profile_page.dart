import 'package:flutter/material.dart';

class ActorProfilePage extends StatelessWidget {
  const ActorProfilePage({
    super.key,
    required this.name,
    required this.profilePath,
    required this.popularity,
    required this.knownFor,
  });
  final String name, profilePath, popularity, knownFor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 70.0, left: 5.0, right: 5.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
