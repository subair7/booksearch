import 'package:booksearch/models/book.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommonColor {
 

  static const DIVIDER_COLOR = Color(0xffD1D1D1);
  static const YELLOW_COLOR = Color(0xffFEBA00);
  static const VENUE_SEARCH_SCREE_BACKGROUND_COLOR = Color(0xffFAF4FD);

  
}

class AppConstant {
  static const BASE_URL = 'https://www.googleapis.com';

  static const APP_TITLE = 'BOOKS';
}

class AppIcons {}

class Utils {
  static String listToString(List<String> list, String seperator) {
    String generatedString = '';
    if (list == null) {
      return '---';
    } else {
      list.forEach((element) {
        generatedString += element + seperator;
      });
      return generatedString;
    }
  }

  static Future<void> launchURL(String url) async {
    await launch(url);
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launch(url);
    //   // launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  static String trimString(String strToTrim, [int trimLimit = 40]) {
    if (strToTrim.length > trimLimit) {
      return '${strToTrim.substring(0, trimLimit)}...';
    }
    return strToTrim;
  }

  static Book bookFromJson(Map book) {
    var volumeInfo = book['volumeInfo'];
    var saleInfo = book['saleInfo'];
    var accessInfo = book['accessInfo'];
    return Book(
      id: book['id'],
      title: volumeInfo['title'],
      subtitle: volumeInfo['subtitle'],
      publishedDate: volumeInfo['publishedDate'] == null
          ? '---'
          : volumeInfo['publishedDate'],
      authors: volumeInfo['authors'] != null
          ? (volumeInfo['authors'] as List<dynamic>)
              .map((author) => author.toString())
              .toList()
          : [''],
      publisher:
          volumeInfo['publisher'] == null ? '---' : volumeInfo['publisher'],
      description: volumeInfo['description'] ?? 'No description available.',
      pageCount: volumeInfo['pageCount'],
      categories: volumeInfo['categories'] == null
          ? []
          : (volumeInfo['categories'] as List<dynamic>)
              .map((category) => category.toString())
              .toList(),
      averageRating: volumeInfo['averageRating'] == null
          ? '---'
          : volumeInfo['averageRating'].toString(),
      thumbnailUrl: volumeInfo['imageLinks'] != null
          ? '${volumeInfo['imageLinks']['thumbnail']}'
          : 'https://www.wildhareboca.com/wp-content/uploads/sites/310/2018/03/image-not-available.jpg',
      previewLink: volumeInfo['previewLink'],
      infoLink: volumeInfo['infoLink'],
      buyLink: saleInfo['buyLink'],
      webReaderLink: accessInfo['webReaderLink'],
      isEbook: saleInfo['isEbook'],
      saleability: saleInfo['saleability'],
      amount: saleInfo['saleability'] != 'FOR_SALE'
          ? '---'
          : saleInfo['retailPrice']['amount'].toString(),
      currencyCode: saleInfo['saleability'] != 'FOR_SALE'
          ? '---'
          : saleInfo['retailPrice']['currencyCode'],
      accessViewStatus: accessInfo['accessViewStatus'],
    );
  }
}
