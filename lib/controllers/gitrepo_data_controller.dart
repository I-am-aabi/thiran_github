import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thiran/models/Gitrepo_model.dart';
import 'package:intl/intl.dart';

class Gitcontrolller extends ChangeNotifier {
  List<dynamic>? _repositories = [];
  int _currentPage = 1;
  bool _hasReachedEnd = false;
  bool _is30days = false;

  List<dynamic>? get repositories => _repositories;
  bool get hasReachedEnd => _hasReachedEnd;
  bool get is30days => _is30days;

  change30days() {
    _is30days = !_is30days;
    _repositories = [];
    _currentPage = 1;
    fetchRepositories();
  }

  String getDay() {
    DateTime now = DateTime.now();
    DateTime sixtyDaysAgo = _is30days
        ? now.subtract(const Duration(days: 30))
        : now.subtract(const Duration(days: 60));
    String dateFormat = 'yyyy-MM-dd';
    String formattedDate = DateFormat(dateFormat).format(sixtyDaysAgo);
    return formattedDate;
  }

  Future<void> fetchRepositories() async {
    String day = getDay();
    if (_hasReachedEnd) return;
    String url =
        'https://api.github.com/search/repositories?q=created:%3E$day&sort=stars&order=desc&page=${_currentPage.toString()}&per_page=20';
    Uri uri = Uri.parse(url);
    Future<List<Item>?> getRepositoris() async {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        return gitrepoFromJson(jsonString).items;
      } else {
        return null;
      }
    }

    final data = await getRepositoris();

    if (data != null) {
      if (data.isNotEmpty) {
        _repositories?.addAll(data);
        _currentPage++;
        notifyListeners();
      } else {
        _hasReachedEnd = true;
      }
    }
  }
}
