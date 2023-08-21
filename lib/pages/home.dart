import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/latest_releases_and_now_playing.dart';
import 'package:screenseeker/pages/movies_page.dart';
import 'package:screenseeker/pages/people_page.dart';
import 'package:screenseeker/pages/tv_shows_page.dart';
import 'package:screenseeker/top_rated_shows.dart';
import 'package:screenseeker/trending_movies.dart';
import 'package:screenseeker/top_rated_movies.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/images/SSlogo2.png',
          width: 200.0,
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 7.0, vertical: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 46, 58, 65)),
              onPressed: () {},
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width,
                height: 1170,
                child: Column(
                  children: [
                    //Search Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: SearchBar(
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                            side: MaterialStatePropertyAll(
                              BorderSide(
                                width: 9.0,
                              ),
                            ),
                            leading: Icon(
                              Icons.search,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: 312.0,
                            ),
                          ),
                        ),

                        //Search Button
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 50.0,
                            color: const Color.fromARGB(255, 107, 163, 109),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: const Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //Movies, TV, People
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 225.0,
                        top: 15.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Movies Button
                          CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 95, 94, 94),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(builder: (context) => const MoviesPage()),
                                );
                              },
                              color: Colors.purpleAccent,
                              icon: const Icon(
                                Icons.movie_creation_outlined,
                              ),
                            ),
                          ),

                          //TV Button
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 13.0),
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 95, 94, 94),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                  context,
                                  CupertinoPageRoute(builder: (context) => const TVShowsPage()),
                                );
                                },
                                color: Colors.purpleAccent,
                                icon: const Icon(
                                  Icons.tv,
                                ),
                              ),
                            ),
                          ),

                          //People Button
                          CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 95, 94, 94),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => const PeoplePage()),
                                );
                              },
                              color: Colors.purpleAccent,
                              icon: const Icon(
                                Icons.people_alt_outlined,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Tab
                    // const TabBarView(
                    //   viewportFraction: 600,
                    //   children: [
                    //     Icon(
                    //       Icons.insert_chart,
                    //       size: 200,
                    //     ),
                    //     Icon(
                    //       Icons.zoom_out_map_rounded,
                    //       size: 200,
                    //     ),
                    //     Icon(
                    //       Icons.hls,
                    //       size: 200,
                    //     ),
                    //   ],
                    // ),

                    //Latest Releases
                    const LatestReleasesWidget(),

                    //Trending Movies Widget
                    const TrendingMoviesWidget(),

                    //Top Rated Shows Widget
                    const TopRatedShowsWidget(),

                    //Upcoming Movies
                    const TopRatedMoviesWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
