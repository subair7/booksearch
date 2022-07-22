import 'package:booksearch/providers/books.dart';
import 'package:booksearch/screens/dashboard.dart';
import 'package:booksearch/screens/search_screen.dart';
import 'package:booksearch/services/connectivity_status.dart';
import 'package:booksearch/widgets/books_grid.dart';
import 'package:booksearch/widgets/global_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecificSearchScreen extends StatefulWidget {
  static const routeName = '/specific-search-screen';

  @override
  _SpecificSearchScreenState createState() => _SpecificSearchScreenState();
}

class _SpecificSearchScreenState extends State<SpecificSearchScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var connectivity = Provider.of<ConnectivityStatus>(context);
    if (connectivity != ConnectivityStatus.Offline) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> searchArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    Provider.of<Books>(context, listen: false).setStartIndex();
    Provider.of<Books>(context, listen: false)
        .toggleTotalItemsCalculation(true);
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
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: GlobalSearchWidget(
              onChanged: (s) {},
              hintText: 'Search books by author , category',
              onPressed: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              }),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              future: Provider.of<Books>(context, listen: false)
                  .getSearchedBookByArgs(searchArgs),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  Provider.of<Books>(context, listen: false)
                      .toggleTotalItemsCalculation(false);

                  return BooksGrid(routeName: SpecificSearchScreen.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
