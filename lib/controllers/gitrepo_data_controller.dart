import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thiran/models/Gitrepo_model.dart';

class Gitcontrolller extends ChangeNotifier {
  List<dynamic>? _repositories = [];
  int _currentPage = 1;
  bool _hasReachedEnd = false;

  List<dynamic>? get repositories => _repositories;
  bool get hasReachedEnd => _hasReachedEnd;

  Future<void> fetchRepositories() async {
    if (_hasReachedEnd) return;
    // String url =
    //     'https://api.github.com/search/repositories?q=created:%3E2022-04-29&sort=stars&order=desc&page=${_currentPage.toString()}&per_page=20';
    String url =
        'https://api.github.com/search/repositories?q=created:%3E2022-04-29&sort=stars&order=desc';
    Uri uri = Uri.parse(url);
    Future<List<Item>?> getRepositoris() async {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        print(response.statusCode);
        var jsonString = response.body;
        return gitrepoFromJson(jsonString).items;
      } else {
        return null;
      }
    }

    final data = await getRepositoris();

    if (data != null) {
      if (data.isNotEmpty) {
        print(data);
        _repositories?.addAll(data);
        _currentPage++;
        notifyListeners();
      } else {
        _hasReachedEnd = true;
      }
    }
  }
}
