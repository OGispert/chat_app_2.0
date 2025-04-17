import 'package:chat_app_2/models/user.dart';
import 'package:flutter/material.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  final bool isConnected = false;

  final List<User> users = [
    User(isOnline: true, email: 'email@email.com', name: 'name 1'),
    User(isOnline: false, email: 'email2@email.com', name: 'name 2'),
    User(isOnline: true, email: 'email3@email.com', name: 'name 3'),
  ];

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
      body: ListView.separated(
        itemBuilder:
            (context, index) => ListTile(
              leading: CircleAvatar(
                child: Text(users[index].name.substring(0, 2)),
              ),
              title: Text(users[index].name),
              subtitle: Text(users[index].email),
              trailing: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: users[index].isOnline ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: users.length,
      ),
    );
  }
}
