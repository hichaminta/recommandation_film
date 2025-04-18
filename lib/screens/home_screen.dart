import 'package:flutter/material.dart';
import 'package:recommandation_film/data/model.dart';
import 'package:recommandation_film/widget_utilise/bottombar.dart';
import 'package:recommandation_film/widget_utilise/cardfilm.dart';
import 'package:recommandation_film/widget_utilise/cardrecommend.dart';
import 'package:recommandation_film/utile/colors.dart';
import 'package:recommandation_film/widget_utilise/genrewifget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MovieModel> recmovielist = [];
  List<MovieModel> popmovie = [];
  List<GenreModel> listgenres = [];
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    fetchMovies();
    fetchGenresList();
    fetchRecommendedMovies(); // Récupérer les films recommandés ici
  }

  Future<void> fetchMovies() async {
    try {
      List<MovieModel> movies = await fetchPopularMovies();
      setState(() {
        popmovie = movies;
      });
    } catch (e) {
      print("Erreur lors de la récupération des films populaires : $e");
    }
  }

  Future<void> fetchGenresList() async {
    try {
      List<GenreModel> genres = await fetchGenres();
      setState(() {
        listgenres = genres;
      });
    } catch (e) {
      print("Erreur lors de la récupération des genres : $e");
    }
  }

  // Fonction pour récupérer les films recommandés
  Future<void> fetchRecommendedMovies() async {
    try {
      List<MovieModel> recommendedMovies =
          await fetchRecommendationsFromLikedMovies();
      print(
        "Films recommandés récupérés : ${recommendedMovies.length} films",
      ); // Vérification
      setState(() {
        recmovielist = recommendedMovies;
      });
    } catch (e) {
      print("Erreur lors de la récupération des films recommandés : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "User",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://img.freepik.com/psd-gratuit/illustration-icone-contact-isolee_23-2151903337.jpg?t=st=1745014883~exp=1745018483~hmac=f658f856001c4b6da26c67ceb37f4f11d71f98221bcdd56a9f98b067a96e3998&w=900",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pour Vous",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/filmsrecommandes',
                                );
                              },
                              child: Text(
                                "Voir plus",
                                style: TextStyle(
                                  color: appButtonColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  foryoucarsLayout(
                    recmovielist,
                  ), // Afficher les films recommandés ici
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: appSearchbarColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IntrinsicWidth(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: buildPageIndicatorWidget(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Populaire",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/populaire_films',
                                );
                              },
                              child: Text(
                                "Voir plus",
                                style: TextStyle(
                                  color: appButtonColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  movielistbulder(popmovie),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Genres",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/genres');
                              },
                              child: Text(
                                "Voir plus",
                                style: TextStyle(
                                  color: appButtonColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  genreBbulider(listgenres),
                ],
              ),
            ),
          ),
          bottombar(selectedIndex: 0),
        ],
      ),
    );
  }

  List<Widget> buildPageIndicatorWidget() {
    List<Widget> list = [];
    for (int i = 0; i < recmovielist.take(5).length; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget foryoucarsLayout(List<MovieModel> movieListrec) {
    if (movieListrec.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      ); // Affiche un indicateur de chargement si la liste est vide
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.47,
      child: PageView.builder(
        physics: ClampingScrollPhysics(),
        controller: pageController,
        itemCount: movieListrec.take(5).length,
        itemBuilder: (context, index) {
          return CardRecommend(mv: movieListrec[index]);
        },
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }

  Widget movielistbulder(List<MovieModel> movieListpop) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.27,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: movieListpop.take(5).length,
        itemBuilder: (context, index) {
          return Cardfilm(movie: movieListpop[index]);
        },
      ),
    );
  }

  Widget genreBbulider(List<GenreModel> genreList) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genreList.take(5).length,
        itemBuilder: (context, index) {
          return GenreWidget(genre: genreList[index]);
        },
      ),
    );
  }
}
