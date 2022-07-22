import 'package:booksearch/models/booklist.dart';
import 'package:booksearch/models/search_list.dart';
import 'package:booksearch/services/bloc/homepage_api_caller.dart';
import 'package:rxdart/subjects.dart';

class HomePageBloc {
  final HomePageAPiCaller _api = HomePageAPiCaller();

  final BehaviorSubject<BookList> _liveBooks = BehaviorSubject<BookList>();
  final BehaviorSubject<BookList> _liveHindiBooks = BehaviorSubject<BookList>();
  final BehaviorSubject<SearchList> _liveList = BehaviorSubject<SearchList>();
  final BehaviorSubject<bool> _liveLoadmoreButtonEnable =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _liveIsVisible =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _liveProgress =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<List<Item>> _liveList1 = BehaviorSubject<List<Item>>();

  List filters = ['partial', 'full', 'free-ebooks', 'paid-ebooks'];

  fetchHindiBooks() async {
    _liveHindiBooks.addError('Loading');
    BookList booklist = await _api.apiBooks('s');
    _liveHindiBooks.add(booklist);
  }

  fetchBooks(String q) async {
    _liveBooks.addError('Loading');
    BookList booklist = await _api.apiBooks(q);
    _liveBooks.add(booklist);
  }

  var url = '';
  var t = '';
  buildUrl(String q, String title, int i) {
    t = title;
    url =
        'https://www.googleapis.com/books/v1/volumes?q=intitle:${title}&filter=${filters[i]}&maxResults=18&startIndex=0';
    searchBooks(url);
  }

  buildUrl1(String q, String title, int i) {
    url =
        'https://www.googleapis.com/books/v1/volumes?q=intitle:${t}&filter=${filters[i]}&maxResults=18&startIndex=0';
    searchBooks(url);
  }

  searchBooks(String url) async {
    _liveList1.addError('Loading');
    SearchList booklist = await _api.apiSearchBooksByTitle(url);
    _liveList1.add(booklist.items ?? []);
  }

  List<Item> books = [];
  showVisibility(bool value) {
    _liveIsVisible.addError('Loading...');
    _liveIsVisible.add(value);
  }

  showProgress(bool value) {
    _liveProgress.addError('Loading...');
    _liveProgress.add(value);
  }

  setLoadmoreButtonStatus(bool value) {
    _liveLoadmoreButtonEnable.add(value);
  }

  doPagination(List<Item> list, bool isFirstLoad) async {
    // _liveList.addError('Error');
    if (isFirstLoad) {
      print('first');
      books =
          //  list;
          [...books, ...list];
      showVisibility(true);
      showProgress(false);
    } else {
      SearchList searchedData = await _api.apiSearchBooksByTitle(url);
      // if(searchedData.data.venues!.length==0)
      books = [...books, ...searchedData.items ?? []];
      if (searchedData.items!.isEmpty) {
        setLoadmoreButtonStatus(true);
      } else {
        setLoadmoreButtonStatus(false);
      }
      showVisibility(true);
      showProgress(false);
    }
    _liveList1.add(books);
  }

  dispose() {
    _liveBooks.close();

    _liveList.close();
    _liveIsVisible.close();
    _liveProgress.close();
    _liveLoadmoreButtonEnable.close();
    _liveList.close();
    _liveList.close();
    _liveHindiBooks.close();
  }

  BehaviorSubject<BookList> get getBooks => _liveBooks;
  BehaviorSubject<BookList> get getHindiBooks => _liveHindiBooks;
  BehaviorSubject<List<Item>> get getSearchList => _liveList1;
  BehaviorSubject<bool> get getVisibility => _liveIsVisible;
  BehaviorSubject<bool> get getProgress => _liveProgress;
  BehaviorSubject<bool> get getLoadMoreButtonStatus =>
      _liveLoadmoreButtonEnable;
}

HomePageBloc homePageBloc = HomePageBloc();
