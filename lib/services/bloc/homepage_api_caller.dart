import 'dart:convert';

import 'package:booksearch/models/booklist.dart';
import 'package:booksearch/models/search_list.dart';
import 'package:booksearch/services/utils.dart';
import 'package:http/http.dart' as http;

class HomePageAPiCaller {
  /*-------- LIST OF BOOKS------*/
  Future<BookList> apiBooks(String q) async {
    var client = http.Client();

    try {
      final response = await client
          .get(Uri.parse('${AppConstant.BASE_URL}/books/v1/volumes?q=$q'));
      if (response.statusCode == 200) {
        return BookList.fromJson(jsonDecode(response.body));
      } else {
        if (response.statusCode == 500) {
          throw "Something went wrong";
        }
        throw "Something went wrong";
      }
    } catch (e) {
      print(e);
      throw "Something went wrong";
    } finally {
      client.close();
    }
  }

  /*-------- LIST OF BOOKS BY TITLE------*/

  Future<SearchList> apiSearchBooksByTitle(String url) async {
    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return SearchList.fromJson(jsonDecode(response.body));
      } else {
        if (response.statusCode == 500) {
          throw "Something went wrong";
        }
        throw "Something went wrong";
      }
    } catch (e) {
      print(e);
      throw "Something went wrong";
    } finally {
      client.close();
    }
  }
}
