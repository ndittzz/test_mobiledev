import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/user_list.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<UserProvider>(context, listen: false);
      provider.fetchUsers(refresh: true);
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final provider = Provider.of<UserProvider>(context, listen: false);
      if (!provider.isLoading && provider.hasMore) {
        // Changed from _hasMore to hasMore
        provider.fetchUsers();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Third Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () => provider.fetchUsers(refresh: true),
        child: provider.users.isEmpty && !provider.isLoading
            ? const Center(child: Text('No users available'))
            : ListView.builder(
                controller: _scrollController,
                itemCount: provider.users.length + (provider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= provider.users.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final user = provider.users[index];
                  return UserListItem(
                    user: user,
                    onTap: () {
                      provider.selectUser(user.fullName);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
      ),
    );
  }
}
