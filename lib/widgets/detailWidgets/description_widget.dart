import 'package:booksearch/models/book.dart';
import 'package:booksearch/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';

class DescriptionWidget extends StatelessWidget {
  final Book book;

  DescriptionWidget(this.book);

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 200,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: CommonColor.VENUE_SEARCH_SCREE_BACKGROUND_COLOR,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'DESCRIPTION',
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 100,
              width: double.infinity,
              child: SingleChildScrollView(
                  child: Text(
                _parseHtmlString(book.description??''),maxLines: 10,
                style: GoogleFonts.notoSans(
                    textStyle: TextStyle(
                  fontSize: 14.0,
                  letterSpacing: 0.2,
                  
                )),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
