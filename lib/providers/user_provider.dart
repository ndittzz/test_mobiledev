import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _selectedUserName;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get selectedUserName => _selectedUserName;
  bool get hasMore => _hasMore;

  Future<void> fetchUsers({bool refresh = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    if (refresh) {
      _page = 1;
      _hasMore = true;
      notifyListeners();
    }

    try {
      final response = await http.get(
        Uri.parse('https://reqres.in/api/users?page=$_page&per_page=10'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newUsers = (data['data'] as List)
            .map((user) => User.fromJson(user))
            .toList();

        if (refresh) {
          _users = newUsers;
        } else {
          _users.addAll(newUsers);
        }

        _hasMore = data['total_pages'] > _page;
        _page++;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching users: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectUser(String name) {
    _selectedUserName = name;
    notifyListeners();
  }

  void clearSelectedUser() {
    _selectedUserName = null;
    notifyListeners();
  }
}
