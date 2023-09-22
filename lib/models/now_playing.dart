class NowPlaying {
  final String? poster;
  final String? title;

  NowPlaying({
    this.poster,
    this.title,
  });

  factory NowPlaying.fromJson(Map<String,dynamic> data) {
    return NowPlaying(
      poster: data['poster'],
      title: data['title']
    );
  }
}
