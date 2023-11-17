import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/search_config.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _movieSearchController = TextEditingController();
  final TextEditingController _tvShowSearchController = TextEditingController();
  final TextEditingController _peopleSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0),
          child: Image.asset(
            'assets/images/SSlogo3.png',
            width: 30.0,
            height: 20.0,
          ),
        ),
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Movie Search
              const Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 7.0),
                child: Text(
                  'Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              TextField(
                controller: _movieSearchController,
                onSubmitted: (value) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => MovieSearchConfig(querry: value),
                    ),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Search Movies...',
                  hintStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _movieSearchController.clear(),
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              //TV Show Search
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 30.0, bottom: 7.0),
                child: Text(
                  'TV Shows',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              TextField(
                controller: _tvShowSearchController,
                onSubmitted: (value) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => TVShowSearchConfig(querry: value),
                    ),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Search TV Shows...',
                  hintStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                  
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _tvShowSearchController.clear(),
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              //People Search
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 30.0, bottom: 7.0),
                child: Text(
                  'People',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              TextField(
                controller: _peopleSearchController,
                onSubmitted: (value) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          PeopleSearchConfig(peopleQuerry: value),
                    ),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Search People...',
                  hintStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => _peopleSearchController.clear(),
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
