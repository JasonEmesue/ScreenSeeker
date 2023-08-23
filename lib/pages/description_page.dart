import 'package:flutter/material.dart';
import 'package:screenseeker/credits_and_info.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({
    super.key,
    required this.name,
    required this.description,
    required this.bannerURL,
    required this.posterURL,
    required this.vote,
    required this.releaseDate,
    required this.movieId,
  });
  final String name, description, bannerURL, posterURL, vote, releaseDate;
  final String movieId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 250.0,
            child: Stack(
              children: [
                Positioned(
                  child: SizedBox(
                    height: 250.0,
                    width: size.width,
                    child: Image.network(
                      bannerURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 7,
                  child: Text(
                    '⭐ Average Rating - $vote',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 150, 140, 56),
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 7.0),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 206, 188, 188),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Title
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 23.0,
              ),
            ),
          ),

          //Poster/Description
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Poster
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: SizedBox(
                  height: 200,
                  width: 120,
                  child: Image.network(posterURL),
                ),
              ),

              //Description
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),

          //Release Date
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text(
              'Release Date - $releaseDate',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          ),

          //Movie Id
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              'Movie Id',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          ),

          //
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              movieId,
            ),
          ),

          //Cast and Reviews
          CreditsAndInfoWidget(
            movieId: int.parse(movieId) ,
          ),
        ],
      ),
    );
  }
}
