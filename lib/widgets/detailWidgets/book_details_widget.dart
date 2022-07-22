import 'package:booksearch/models/book.dart';
import 'package:booksearch/widgets/detailWidgets/authors_widget.dart';
import 'package:booksearch/widgets/detailWidgets/categories_widget.dart';
import 'package:booksearch/widgets/detailWidgets/description_widget.dart';
import 'package:booksearch/widgets/detailWidgets/metadata_widget.dart';
import 'package:booksearch/widgets/detailWidgets/title_widget.dart';
import 'package:flutter/material.dart';

class BookDetailsWidget extends StatelessWidget {
  final Book book;

  BookDetailsWidget(this.book);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CategoriesWidget(book),
        SizedBox(height: 10.0),
        AuthorsWidget(book),
        SizedBox(height: 10.0),
        TitleWidget(book),
        Divider(),
        DescriptionWidget(book),
        Divider(),
        MetadataWidget(book),
        SizedBox(height: 10.0),
        Divider(),
      ],
    );
  }
}
