import 'package:booksearch/providers/books.dart';
import 'package:booksearch/services/bloc/homepage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool byTitle = true;
  String searchString = '';
  bool free = false;

  void search() async {
    Provider.of<Books>(context, listen: false).setStartIndex();

    Provider.of<Books>(context, listen: false)
        .toggleTotalItemsCalculation(true);
    await Provider.of<Books>(context, listen: false)
        .getSearchedBookData(searchString, byTitle, free);
    Provider.of<Books>(context, listen: false)
        .toggleTotalItemsCalculation(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Container(
        height: 56,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    autofocus: true,
                    cursorColor: Colors.black38,
                    decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 4.0),
                            hintText: 'Search book',
                            hintStyle: TextStyle(
                                // color: kSearchBarHintColor,
                                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none)
                        .copyWith(
                            hintText: byTitle
                                ? 'Search by title'
                                : 'Search by author'),
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      searchString = value;
                      homePageBloc.buildUrl('', value, 2);
                    },
                    onSubmitted: (value) async {
                      if (value == '') return;
                      homePageBloc.buildUrl('', value, 2);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (searchString == null) return;
                      if (searchString != null &&
                          searchString.trim().length == 0) return;
                      homePageBloc.buildUrl('', searchString.trim(), 2);
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.black38,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
