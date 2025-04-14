import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recommandation_film/data/movie.dart';
import 'package:recommandation_film/widget_utilise/bottombar.dart';
import 'package:recommandation_film/widget_utilise/cardfilm.dart';
import 'package:recommandation_film/widget_utilise/cardrecommend.dart';
import 'package:recommandation_film/widget_utilise/genrewifget.dart';
import 'package:recommandation_film/utile/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // list de recommande  en l prener de fichier dart
  List<MovieModel> recmovielist = List.of(recommandtemovie);
  List<MovieModel> popmovie = List.of(listPopulaireMovie);
  List<GenreModel> listgenres = List.of(genresList);
  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  int currentPage = 0;
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
                      // space enntre les element
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hicham",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),

                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://media.licdn.com/dms/image/v2/D5603AQH8g9PHFejnlw/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1701385862141?e=1750291200&v=beta&t=d5SE_qVo1SGwjWqwpg5wqcjgZqz6kKN2xP1y-d-0N0w",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // *** fin de  nav ***
                  SizedBox(height: 20),
                  // *** serach bar ***
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: appSearchbarColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Recherche ...',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[600],
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //  ******affichage des  film*********
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      "Pour Vous",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  foryoucarsLayout(recmovielist),
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
                  //  ******affichage  populaire film*********
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
    Navigator.pushNamed(context, '/populaire_films');
  },
  child: Text(
    "Voir plus",
    style: TextStyle(
      color: appButtonColor,
      fontSize: 17,
      fontWeight: FontWeight.w300,
    ),
  ),
)

                          ],
                        ),
                      ],
                    ),
                  ),
                  movielistbulder(popmovie),
                  //****************genre****************
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
                            Text(
                              "Voir plus",
                              style: TextStyle(
                                color: appButtonColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
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
          // bottom bar
          bottombar(selectedIndex: 0),
        ],
      ),
    );
  }

  List<Widget> buildPageIndicatorWidget() {
    List<Widget> list = [];
    for (int i = 0; i < recmovielist.length; i++) {
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
        color:
            isActive
                ? Colors.blue
                : Colors.grey, // Changer la couleur selon l'état
        borderRadius: BorderRadius.circular(20), // Pour faire un cercle
      ),
    );
  }

  // for  you cards layout widget
  Widget foryoucarsLayout(List<MovieModel> movieListrec) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.47,
      child: PageView.builder(
        physics: ClampingScrollPhysics(),
        controller: pageController,

        itemCount: movieListrec.length,
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

  // for  you cards populairelayout widget
  Widget movielistbulder(List<MovieModel> movieListpop) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 29, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.27,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: movieListpop.length,
        itemBuilder: (context, index) {
          return Cardfilm(movie: movieListpop[index]);
        },
      ),
    );
  }

  // bulder for genre
  Widget genreBbulider(List<GenreModel> listgenres) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listgenres.length,
        itemBuilder: (context, index) {
          return genrewidget(genre: listgenres[index]);
        },
      ),
    );
  }
}
