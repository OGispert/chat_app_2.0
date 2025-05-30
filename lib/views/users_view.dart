import 'package:chat_app_2/models/user.dart';
import 'package:chat_app_2/services/auth_service.dart';
import 'package:chat_app_2/services/chat_service.dart';
import 'package:chat_app_2/services/socket_service.dart';
import 'package:chat_app_2/services/users_service.dart';
import 'package:chat_app_2/views/chat_view.dart';
import 'package:chat_app_2/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  final usersService = UsersService();
  List<User> users = [];

  void _loadUsers() async {
    users = await usersService.getUsers();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Message App'),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            authService.logout();
            socketService.disconnect();
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(pageBuilder: (_, __, ___) => LoginView()),
            );
          },
          icon: Icon(Icons.logout),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child:
                socketService.serverState == ServerState.online
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
      subtitle: Text(user.username),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.isOnline ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.receipient = user;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatView()),
        );
      },
    );
  }
}
