import 'package:chat_app_2/models/user.dart';
import 'package:chat_app_2/views/chat_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final bool isConnected = false;

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  final List<User> users = [
    User(isOnline: true, email: 'email@email.com', name: 'name 1'),
    User(isOnline: false, email: 'email2@email.com', name: 'name 2'),
    User(isOnline: true, email: 'email3@email.com', name: 'name 3'),
  ];

  void _loadUsers() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Message App'),
        elevation: 1,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child:
                isConnected
                    ? Icon(Icons.cloud_done_outlined, color: Colors.blue)
                    : Icon(Icons.cloud_off, color: Colors.red),
          ),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.green),
          waterDropColor: ColorScheme.of(context).primary,
        ),
        controller: _refreshController,
        onRefresh: _loadUsers,
        child: ListView.builder(
          itemBuilder: (c, i) => _UserListTile(user: users[i]),
          itemExtent: 100.0,
          itemCount: users.length,
        ),
      ),
    );
  }
}

class _UserListTile extends StatelessWidget {
  const _UserListTile({required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(user.name.substring(0, 2))),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.isOnline ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatView(userName: user.name),
          ),
        );
      },
    );
  }
}
