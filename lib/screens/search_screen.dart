import 'package:booksearch/models/search_list.dart';
import 'package:booksearch/providers/books.dart';
import 'package:booksearch/screens/dashboard.dart';
import 'package:booksearch/services/bloc/homepage_bloc.dart';
import 'package:booksearch/services/utils.dart';
import 'package:booksearch/widgets/network_sensititve.dart';
import 'package:booksearch/widgets/search_bar.dart';
import 'package:booksearch/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool loadGrid = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Books>(context, listen: false).clearList();
      setState(() {
        loadGrid = true;
      });
    });
  }

  List filters = ['partial', 'full', 'free-ebooks', 'paid-ebooks'];
  int index1 = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                // Navigator.pushNamed(context, BookListScreen.routeName);
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        Set<String> result = {};
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.48,
                            child: Scaffold(
                              bottomNavigationBar: BottomAppBar(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Material(
                                        shadowColor: Colors.black,
                                        // elevation: 20,
                                        child: Container(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 10,
                                              left: 20,
                                              right: 20,
                                            ),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.teal,),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  4.0),
                                                          side: const BorderSide(color: CommonColor.DIVIDER_COLOR)))),
                                              onPressed: () {},
                                              child:
                                                  Text('Cancel'.toUpperCase()),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Material(
                                        shadowColor: Colors.black,
                                        // elevation: 20,
                                        child: Container(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 10,
                                              left: 20,
                                              right: 20,
                                            ),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          side: const BorderSide(
                                                              color: Colors.teal,)))),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                homePageBloc.buildUrl1(
                                                    '', '', index1);
                                              },
                                              child:
                                                  Text('Apply'.toUpperCase()),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              backgroundColor: CommonColor
                                  .VENUE_SEARCH_SCREE_BACKGROUND_COLOR,
                              appBar: AppBar(
                                backgroundColor: Colors.white,
                                elevation: 0.5,
                                automaticallyImplyLeading: false,
                                centerTitle: true,
                                title: Text(
                                  'Filters',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              body: ListView(
                                children: <Widget>[
                                  Column(
                                      children: List.generate(
                                          filters.length,
                                          (index) => ListTile(
                                              onTap: () {},
                                              title: Text(
                                                filters![index],
                                              ),
                                              trailing: Radio<int>(
                                                activeColor:
                                                    Colors.teal,
                                                value: index,
                                                groupValue: index1,
                                                onChanged: (value) {
                                                  setState(
                                                    () {
                                                      index1 = value ?? -1;
                                                    },
                                                  );
                                                },
                                              )))),
                                ],
                              ),
                            ));
                      });
                    });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.sort_outlined),
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
      body: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NetworkSensitive(offlineChild: Container(), child: SearchBar()),
            ],
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
                            width: MediaQuery.of(context).size.width - 16,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShimmerWidget.rectangular(
                            height: 80,
                            width: MediaQuery.of(context).size.width - 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Expanded(
                  child: Container(
                    // color:
                    //     CommonColor.VENUE_SEARCH_SCREE_BACKGROUND_COLOR,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return Card(
                            borderOnForeground: false,
                            color:
                                CommonColor.VENUE_SEARCH_SCREE_BACKGROUND_COLOR,
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
                                          image: snapshot.data![i].volumeInfo!
                                                  .imageLinks!.thumbnail ??
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
                                if (snapshot.data![i].volumeInfo!.title != null)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          Utils.trimString(
                                              snapshot.data![i].volumeInfo!
                                                      .title ??
                                                  'Book',
                                              60),
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        if (snapshot.data![i].volumeInfo !=
                                            null)
                                          Text(
                                            Utils.trimString(
                                                snapshot.data![i].volumeInfo!
                                                        .authors
                                                        ?.join(',') ??
                                                    'Author',
                                                60),
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ),
                                        if (snapshot.data![i].volumeInfo !=
                                            null)
                                          Text(
                                            Utils.trimString(
                                                snapshot.data![i].volumeInfo!
                                                        .categories
                                                        ?.join(',') ??
                                                    'Author',
                                                60),
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    fontSize: 10.0,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ),
                                        Text(
                                          'Pages ' +
                                              Utils.trimString(
                                                  snapshot.data![i].volumeInfo!
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
                  ),
                );

                //  Text(snapshot!.data!.items!.first.volumeInfo!
                //         .categories!.first ??
                //     '');
              }),
          // if (loadGrid)
          //   BooksGrid(
          //     routeName: SearchScreen.routeName,
          //   ),
        ],
      ),
    );
  }
}
