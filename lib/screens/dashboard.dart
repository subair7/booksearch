import 'dart:collection';
import 'package:booksearch/models/booklist.dart';
import 'package:booksearch/models/search_list.dart';
import 'package:booksearch/providers/categories.dart';
import 'package:booksearch/screens/search_screen.dart';
import 'package:booksearch/screens/specific_search_screen.dart';
import 'package:booksearch/services/bloc/homepage_bloc.dart';
import 'package:booksearch/services/utils.dart';
import 'package:booksearch/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = '/dashboard-screen';

  const DashBoardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Future.delayed(Duration.zero).then((_) {
      homePageBloc.fetchBooks('a');
      homePageBloc.buildUrl('', 'sports', 2);
    });
  }

  LinkedHashMap<String, String> map1 = LinkedHashMap<String, String>();
  LinkedHashMap<String, String> map2 = LinkedHashMap<String, String>();
  ScrollController _controller = ScrollController();
  List<Color> colorList = [
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.cyan,
    Colors.amber
  ];
  Set<String> vm_chips = {};
  bool isNewList = false;

  int? group = -1;
  var val = '';

  bool pressed = false;
  int totalCount = 0;

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  // The key of the list
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context);
    int page = 1;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            // automaticallyImplyLeading: false,
            titleSpacing: 1,
            elevation: 0.0,
            leading: Icon(
              Icons.menu_book,
              color: Colors.white,
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              )
            ],
            title: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, DashBoardScreen.routeName);
              },
              child: Text(
                'BOOKS',
                style: TextStyle(fontSize: 18),
              ),
            )),
        ////////////*BODY////////////////////////////
        body: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Genres',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                      ],
                    ),
                  ),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: categories.categoriesList.length > 6
                          ? 6
                          : categories.categoriesList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 2.0,
                          childAspectRatio: 4 / 3),
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                SpecificSearchScreen.routeName,
                                arguments: {
                                  'category': categories
                                          .categoriesList[i].categoryLink ??
                                      'Other',
                                  'categoryTitle': categories
                                          .categoriesList[i].categoryTitle ??
                                      'Other',
                                });
                          },
                          child: Card(
                            child: Container(
                              height: 60,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: colorList[i],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              child: Center(
                                child: Text(
                                  categories.categoriesList[i].categoryTitle ??
                                      'Other',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('You May Like',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        Text('View All'),
                      ],
                    ),
                  ),
                  StreamBuilder<BookList>(
                      stream: homePageBloc.getBooks,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ShimmerWidget.rectangular(
                                      height: 24,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                    ),
                                    const Spacer(),
                                    ShimmerWidget.rectangular(
                                      height: 24,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                    ),
                                    const Spacer(),
                                    ShimmerWidget.rectangular(
                                      height: 24,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                    ),
                                    const Spacer(),
                                    ShimmerWidget.rectangular(
                                      height: 24,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ShimmerWidget.rectangular(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                Column(
                                    children: List.generate(
                                  4,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xffE5E5E5)),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ShimmerWidget.rectangular(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.20,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                ShimmerWidget.rectangular(
                                                  height: 16,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                ShimmerWidget.rectangular(
                                                  height: 16,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ShimmerWidget.rectangular(
                                                      height: 16,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.30,
                                                    ),
                                                    ShimmerWidget.rectangular(
                                                      height: 16,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.20,
                                                    ),
                                                    ShimmerWidget.rectangular(
                                                      height: 16,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.30,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                ShimmerWidget.rectangular(
                                                  height: 16,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.70,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                ShimmerWidget.rectangular(
                                                  height: 24,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          );
                        }

                        return Card(
                          child: Container(
                            color:
                                CommonColor.VENUE_SEARCH_SCREE_BACKGROUND_COLOR,
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.items!.length > 6
                                    ? 6
                                    : snapshot.data!.items!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 5.0,
                                        crossAxisSpacing: 2.0,
                                        childAspectRatio: 2 / 3),
                                itemBuilder: (context, i) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 7,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Card(
                                            color: Colors.grey[100],
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            elevation: 4.0,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              child: FadeInImage.memoryNetwork(
                                                image: snapshot
                                                        .data!
                                                        .items![i]
                                                        .volumeInfo!
                                                        .imageLinks!
                                                        .thumbnail ??
                                                    '',
                                                fit: BoxFit.cover,
                                                placeholder: kTransparentImage,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      if (snapshot.data!.items![i].volumeInfo!
                                              .title !=
                                          null)
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            Utils.trimString(
                                                snapshot.data!.items![i]
                                                        .volumeInfo!.title ??
                                                    'Book',
                                                22),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                    ],
                                  );
                                  // BookOverviewItem(
                                  //     snapshot.data!.items![i].id??'');
                                }),
                          ),
                        );

                        //  Text(snapshot!.data!.items!.first.volumeInfo!
                        //         .categories!.first ??
                        //     '');
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Trending',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)),
                        Text('View All'),
                      ],
                    ),
                  ),
                  StreamBuilder<List<Item>>(
                      stream: homePageBloc.getSearchList,
                      builder: (context, snapshot) {
                        // if (!snapshot.hasError) {
                        //   return Text('No Books Available');
                        // }
                        if (!snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ShimmerWidget.rectangular(
                                    height: 80,
                                    width:
                                        MediaQuery.of(context).size.width - 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ShimmerWidget.rectangular(
                                    height: 80,
                                    width:
                                        MediaQuery.of(context).size.width - 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return Container(
                          // color:
                          //     CommonColor.VENUE_SEARCH_SCREE_BACKGROUND_COLOR,
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length > 6
                                  ? 6
                                  : snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return Card(
                                  borderOnForeground: false,
                                  color: CommonColor
                                      .VENUE_SEARCH_SCREE_BACKGROUND_COLOR,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 80,
                                          width: 60,
                                          child: Card(
                                            color: Colors.grey[100],
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            elevation: 4.0,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              child: FadeInImage.memoryNetwork(
                                                image: snapshot
                                                        .data![i]
                                                        .volumeInfo!
                                                        .imageLinks!
                                                        .thumbnail ??
                                                    '',
                                                fit: BoxFit.cover,
                                                placeholder: kTransparentImage,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      if (snapshot.data![i].volumeInfo!.title !=
                                          null)
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                Utils.trimString(
                                                    snapshot
                                                            .data![i]
                                                            .volumeInfo!
                                                            .title ??
                                                        'Book',
                                                    60),
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              if (snapshot
                                                      .data![i].volumeInfo !=
                                                  null)
                                                Text(
                                                  Utils.trimString(
                                                      snapshot
                                                              .data![i]
                                                              .volumeInfo!
                                                              .authors
                                                              ?.join(',') ??
                                                          'Author',
                                                      60),
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  style: GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                ),
                                              if (snapshot
                                                      .data![i].volumeInfo !=
                                                  null)
                                                Text(
                                                  Utils.trimString(
                                                      snapshot
                                                              .data![i]
                                                              .volumeInfo!
                                                              .categories
                                                              ?.join(',') ??
                                                          'Author',
                                                      60),
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  style: GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          fontSize: 10.0,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                ),
                                              Text(
                                                'Pages ' +
                                                    Utils.trimString(
                                                        snapshot
                                                                .data![i]
                                                                .volumeInfo!
                                                                .pageCount
                                                                .toString() ??
                                                            '',
                                                        60),
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontSize: 8.0,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ); // BookOverviewItem(
                                //     snapshot.data!.items![i].id??'');
                              }),
                        );

                        //  Text(snapshot!.data!.items!.first.volumeInfo!
                        //         .categories!.first ??
                        //     '');
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
