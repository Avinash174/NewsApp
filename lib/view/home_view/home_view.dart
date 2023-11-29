import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/actegories_news_model.dart';
import 'package:news_app/view/categories.dart';
import 'package:news_app/view/news_details_screen.dart';
import 'package:news_app/view_model/new_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum filterItems { aftenposte, ansa }

class _HomeScreenState extends State<HomeScreen> {
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'ansa';
  NewsViewModel newsViewModel = NewsViewModel();
  filterItems? selectedMenu;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CategoryScreen(),
              ),
            );
          },
          icon: Image.asset(
            'assets/icons/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        actions: [
          PopupMenuButton<filterItems>(
            onSelected: (filterItems items) {
              if (filterItems.aftenposte.name == items.name) {
                name = 'aftenposten';
              }
              if (filterItems.ansa.name == items.name) {
                name = 'ansa';
              }
              setState(() {
                selectedMenu = items;
              });
            },
            initialValue: selectedMenu,
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
            itemBuilder: (context) => <PopupMenuEntry<filterItems>>[
              const PopupMenuItem<filterItems>(
                value: filterItems.aftenposte,
                child: Text('Aftenposten'),
              ),
              const PopupMenuItem<filterItems>(
                value: filterItems.ansa,
                child: Text('ANSA.it'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder(
              future: newsViewModel.fetchNewsChannelHeadlineApi('aftenposten'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => NewsDetailScreen(
                                        newsTitle: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        author: snapshot
                                            .data!.articles![index].author
                                            .toString(),
                                        content: snapshot
                                            .data!.articles![index].content
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString(),
                                        newsImg: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        source: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        newDate: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                      )));
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * .6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: height * .02,
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(
                                    15.0,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container(child: spinKit2),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error_outline_outlined,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                  child: Container(
                                    height: height * .22,
                                    padding: const EdgeInsets.all(20),
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: width * .7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.justify,
                                            style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          child: SizedBox(
                                            width: width * .7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          FutureBuilder<CategoriesNewsModel>(
            future: newsViewModel.fetchCategoriesNewsChannel('General'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (BuildContext context, int index) {
                    DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString());
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusDirectional.circular(
                            15.0,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data!.articles![index].urlToImage
                                .toString(),
                            fit: BoxFit.cover,
                            height: height * .18,
                            width: .3,
                            placeholder: (context, url) =>
                                Container(child: spinKit2),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error_outline_outlined,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: height * .18,
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data!.articles![index].title
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        format.format(dateTime),
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 40,
);
