class GenreModel {
  String? id;
  String? name;
  String? image;

  GenreModel({this.id, this.name, this.image});
}

class MovieModel {
  String? id;
  String? title;
  List<GenreModel>? genres; // Changer le type en une liste de GenreModel
  String? overview;
  String? releaseDate;
  String? voteAverage;
  String? popularity;
  String? posterPath;
  String? image;

  MovieModel({
    this.id,
    this.title,
    this.genres,
    this.overview,
    this.releaseDate,
    this.voteAverage,
    this.popularity,
    this.posterPath,
    this.image,
  });
}

final recommandtemovie = [
  MovieModel(
    id: "5",
    title: "Dune",
    genres: [
      GenreModel(
        id: "1",
        name: "Adventure",
        image: "assets/images/adventure.png",
      ),
      GenreModel(id: "2", name: "Drama", image: "assets/images/drama.png"),
      GenreModel(id: "3", name: "Sci-Fi", image: "assets/images/scifi.png"),
    ],
    overview:
        "A noble family becomes embroiled in a war for control of the galaxy's most valuable resourceA noble family becomes embroiled in a war for control of the galaxy's most valuable resourceA noble family becomes embroiled in a war for control of the galaxy's most valuable resourceA noble family becomes embroiled in a war for control of the galaxy's most valuable resourceA noble family becomes embroiled in a war for control of the galaxy's most valuable resourceA noble family becomes embroiled in a war for control of the galaxy's most valuable resourceA noble family becomes embroiled in a war for control of the galaxy's most valuable resourceA noble family becomes embroiled in a war for control of the galaxy's most valuable resourceA noble family becomes embroiled in a war for control of the galaxy's most valuable resource.",
    releaseDate: "2021-10-22",
    voteAverage: "8.3",
    popularity: "400.0",
    posterPath: "assets/images/popular_image_1.jpeg",
    image: "assets/images/popular_image_1.jpeg",
  ),
  
];

final listPopulaireMovie = [
  MovieModel(
    id: "10",
    title: "Alien",
    genres: [
      GenreModel(id: "15", name: "Horror", image: "assets/images/horror.png"),
      GenreModel(id: "3", name: "Sci-Fi", image: "assets/images/scifi.png"),
    ],
    overview:
        "The crew of a commercial spacecraft encounter a deadly alien species.",
    releaseDate: "1979-05-25",
    voteAverage: "8.4",
    popularity: "150.0",
    posterPath: "assets/images/legendary_movie_1.jpeg",
    image: "assets/images/legendary_movie_1.jpeg",
  ),
  MovieModel(
    id: "11",
    title: "300",
    genres: [
      GenreModel(id: "9", name: "Action", image: "assets/images/action.png"),
      GenreModel(id: "16", name: "Drama", image: "assets/images/drama.png"),
      GenreModel(id: "17", name: "War", image: "assets/images/war.png"),
    ],
    overview:
        "A small group of Spartan warriors fight against the Persian empire.",
    releaseDate: "2006-03-09",
    voteAverage: "7.6",
    popularity: "450.0",
    posterPath: "assets/images/legendary_movie_2.jpeg",
    image: "assets/images/legendary_movie_2.jpeg",
  ),
  // Ajoutez les autres films de la liste de manière similaire
];

final genresList = [
  GenreModel(id: "15", name: "Horror", image: "assets/images/genres_1.png"),
  GenreModel(id: "16", name: "Fantasy", image: "assets/images/genres_2.jpeg"),
  GenreModel(id: "17", name: "History", image: "assets/images/genres_3.jpeg"),
  GenreModel(id: "18", name: "Detective", image: "assets/images/genres_4.jpeg"),
  GenreModel(id: "19", name: "Action", image: "assets/images/genres_5.jpeg"),
];
final listoutfilms = [
  MovieModel(
    id: "10",
    title: "Alien",
    genres: [
      GenreModel(id: "15", name: "Horror", image: "assets/images/horror.png"),
      GenreModel(id: "3", name: "Sci-Fi", image: "assets/images/scifi.png"),
    ],
    overview:
        "The crew of a commercial spacecraft encounter a deadly alien species.",
    releaseDate: "1979-05-25",
    voteAverage: "8.4",
    popularity: "150.0",
    posterPath: "assets/images/legendary_movie_1.jpeg",
    image: "assets/images/legendary_movie_1.jpeg",
  ),
  MovieModel(
    id: "11",
    title: "300",
    genres: [
      GenreModel(id: "9", name: "Action", image: "assets/images/action.png"),
      GenreModel(id: "16", name: "Drama", image: "assets/images/drama.png"),
      GenreModel(id: "17", name: "War", image: "assets/images/war.png"),
    ],
    overview:
        "A small group of Spartan warriors fight against the Persian empire.",
    releaseDate: "2006-03-09",
    voteAverage: "7.6",
    popularity: "450.0",
    posterPath: "assets/images/legendary_movie_2.jpeg",
    image: "assets/images/legendary_movie_2.jpeg",
  ),
MovieModel(
    id: "6",
    title: "Shang-Chi",
    genres: [
      GenreModel(id: "4", name: "Action", image: "assets/images/action.png"),
      GenreModel(
        id: "5",
        name: "Adventure",
        image: "assets/images/adventure.png",
      ),
      GenreModel(id: "6", name: "Fantasy", image: "assets/images/fantasy.png"),
    ],
    overview: "Shang-Chi must confront the past he thought he left behind.",
    releaseDate: "2021-09-03",
    voteAverage: "6.9",
    popularity: "350.0",
    posterPath: "assets/images/popular_image_2.jpeg",
    image: "assets/images/popular_image_2.jpeg",
  ),
  MovieModel(
    id: "7",
    title: "Narcos",
    genres: [
      GenreModel(id: "7", name: "Crime", image: "assets/images/crime.png"),
      GenreModel(id: "8", name: "Drama", image: "assets/images/drama.png"),
    ],
    overview: "The true story of the rise of the drug trade in Colombia.",
    releaseDate: "2015-08-28",
    voteAverage: "9.0",
    popularity: "500.0",
    posterPath: "assets/images/popular_image_3.jpeg",
    image: "assets/images/popular_image_3.jpeg",
  ),
  MovieModel(
    id: "8",
    title: "Shazam!",
    genres: [
      GenreModel(id: "9", name: "Action", image: "assets/images/action.png"),
      GenreModel(
        id: "10",
        name: "Adventure",
        image: "assets/images/adventure.png",
      ),
      GenreModel(id: "11", name: "Comedy", image: "assets/images/comedy.png"),
    ],
    overview:
        "Billy Batson is a teenager who can transform into an adult superhero.",
    releaseDate: "2019-04-05",
    voteAverage: "7.5",
    popularity: "210.0",
    posterPath: "assets/images/for_your_image_2.jpeg",
    image: "assets/images/for_your_image_2.jpeg",
  ),
  MovieModel(
    id: "9",
    title: "Stranger Things",
    genres: [
      GenreModel(id: "12", name: "Drama", image: "assets/images/drama.png"),
      GenreModel(id: "13", name: "Fantasy", image: "assets/images/fantasy.png"),
      GenreModel(id: "14", name: "Horror", image: "assets/images/horror.png"),
    ],
    overview: "The kids face supernatural forces that threaten their town.",
    releaseDate: "2016-07-15",
    voteAverage: "9.2",
    popularity: "320.0",
    posterPath: "assets/images/for_your_image_3.jpeg",
    image: "assets/images/for_your_image_3.jpeg",
  ),
];