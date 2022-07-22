import 'package:booksearch/providers/books.dart';
import 'package:booksearch/providers/categories.dart';
import 'package:booksearch/screens/book_list.dart';
import 'package:booksearch/screens/dashboard.dart';
import 'package:booksearch/screens/search_screen.dart';
import 'package:booksearch/screens/specific_search_screen.dart';
import 'package:booksearch/services/connectivity_service.dart';
import 'package:booksearch/services/connectivity_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(BooksApp());
}

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Books(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Categories(),
        ),
        StreamProvider<ConnectivityStatus>(
          create: (BuildContext context) =>
              ConnectivityService().connectionStatusController.stream,
          initialData: ConnectivityStatus.Cellular,
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.teal,
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0))),
        debugShowCheckedModeBanner: false,
        title: 'Books App',
        initialRoute: DashBoardScreen.routeName,
        routes: {
          SearchScreen.routeName: (context) => SearchScreen(),
          SpecificSearchScreen.routeName: (context) => SpecificSearchScreen(),
          DashBoardScreen.routeName: (context) => DashBoardScreen(),
          BookListScreen.routeName: (context) => BookListScreen(),
        },
      ),
    );
  }
}
