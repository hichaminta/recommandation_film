class MovieModel {
  String? id;
  String? title;
  List<String>? genres;
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
    genres: ["Adventure", "Drama", "Sci-Fi"],
    overview:
        "A noble family becomes embroiled in a war for control of the galaxy's most valuable resource.",
    releaseDate: "2021-10-22",
    voteAverage: "8.3",
    popularity: "400.0",
    posterPath: "assets/images/popular_image_1.jpeg",
    image: "assets/images/popular_image_1.jpeg",
  ),
  MovieModel(
    id: "6",
    title: "Shang-Chi",
    genres: ["Action", "Adventure", "Fantasy"],
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
    genres: ["Crime", "Drama"],
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
    genres: ["Action", "Adventure", "Comedy"],
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
    genres: ["Drama", "Fantasy", "Horror"],
    overview: "The kids face supernatural forces that threaten their town.",
    releaseDate: "2016-07-15",
    voteAverage: "9.2",
    popularity: "320.0",
    posterPath: "assets/images/for_your_image_3.jpeg",
    image: "assets/images/for_your_image_3.jpeg",
  ),
];

final listPopulaireMovie = [
  MovieModel(
    id: "10",
    title: "Alien",
    genres: ["Horror", "Sci-Fi"],
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
    genres: ["Action", "Drama", "War"],
    overview:
        "A small group of Spartan warriors fight against the Persian empire.",
    releaseDate: "2006-03-09",
    voteAverage: "7.6",
    popularity: "450.0",
    posterPath: "assets/images/legendary_movie_2.jpeg",
    image: "assets/images/legendary_movie_2.jpeg",
  ),
  MovieModel(
    id: "12",
    title: "Narcos",
    genres: ["Crime", "Drama"],
    overview: "The rise and fall of the Colombian drug lord, Pablo Escobar.",
    releaseDate: "2015-08-28",
    voteAverage: "9.0",
    popularity: "500.0",
    posterPath: "assets/images/popular_image_3.jpeg",
    image: "assets/images/popular_image_3.jpeg",
  ),
  MovieModel(
    id: "13",
    title: "Shazam!",
    genres: ["Action", "Adventure", "Comedy"],
    overview: "A boy receives the power to transform into an adult superhero.",
    releaseDate: "2019-04-05",
    voteAverage: "7.5",
    popularity: "210.0",
    posterPath: "assets/images/for_your_image_2.jpeg",
    image: "assets/images/for_your_image_2.jpeg",
  ),
  MovieModel(
    id: "14",
    title: "Cruella",
    genres: ["Crime", "Drama", "Comedy"],
    overview:
        "The origin story of the infamous Disney villain, Cruella de Vil.",
    releaseDate: "2021-05-28",
    voteAverage: "8.5",
    popularity: "123.0",
    posterPath: "assets/images/for_your_image_1.jpeg",
    image: "assets/images/for_your_image_1.jpeg",
  ),
];

final genresList = [
  MovieModel(
    id: "15",
    title: "Horror",
    genres: ["Horror"],
    overview: "Scary movies that will keep you on the edge of your seat.",
    releaseDate: "Genre",
    voteAverage: "N/A",
    popularity: "N/A",
    posterPath: "assets/images/genres_1.png",
    image: "assets/images/genres_1.png",
  ),
  MovieModel(
    id: "16",
    title: "Fantasy",
    genres: ["Fantasy"],
    overview: "Movies filled with magical and mythical creatures.",
    releaseDate: "Genre",
    voteAverage: "N/A",
    popularity: "N/A",
    posterPath: "assets/images/genres_2.jpeg",
    image: "assets/images/genres_2.jpeg",
  ),
  MovieModel(
    id: "17",
    title: "History",
    genres: ["History"],
    overview: "Movies that portray important historical events.",
    releaseDate: "Genre",
    voteAverage: "N/A",
    popularity: "N/A",
    posterPath: "assets/images/genres_3.jpeg",
    image: "assets/images/genres_3.jpeg",
  ),
  MovieModel(
    id: "18",
    title: "Detective",
    genres: ["Detective"],
    overview: "Movies focused on solving mysteries and crimes.",
    releaseDate: "Genre",
    voteAverage: "N/A",
    popularity: "N/A",
    posterPath: "assets/images/genres_4.jpeg",
    image: "assets/images/genres_4.jpeg",
  ),
  MovieModel(
    id: "19",
    title: "Action",
    genres: ["Action"],
    overview: "Movies filled with intense action sequences.",
    releaseDate: "Genre",
    voteAverage: "N/A",
    popularity: "N/A",
    posterPath: "assets/images/genres_5.jpeg",
    image: "assets/images/genres_5.jpeg",
  ),
];
