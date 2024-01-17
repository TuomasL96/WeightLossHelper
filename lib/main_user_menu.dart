import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:open_weight_tracker/user_creation_menu.dart';
import 'models.dart';
import 'main.dart';
import 'widgets/shared_widgets.dart';

class UserMainMenu extends StatefulWidget {
  const UserMainMenu({
    super.key,
  });

  @override
  State<UserMainMenu> createState() => _UserMainMenuState();
}

class _UserMainMenuState extends State<UserMainMenu> {
  late User currentUser = userRepository.getCurrentUser();
  bool dbHasUser = (userRepository.dbHasCurrentUser() ? true : false);

  @override
  Widget build(BuildContext context) {
    Widget userPage;
    switch (dbHasUser) {
      case true:
        userPage = UserList(
            currentUser: currentUser, users: userRepository.getAllUsers());
      case false:
        userPage = UserProfileCreatorMenu();
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 20),
      alignment: Alignment.topCenter,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      child: userPage,
    );
  }
}

class UserList extends StatelessWidget {
  List<User> users;
  User currentUser;
  UserList({super.key, required this.currentUser, required this.users});

  late List<User> otherUsers = getAllButCurrentUser(users);

  List<User> getAllButCurrentUser(users) {
    List<User> otherUsers = [];
    for (User user in users) {
      if (user.isCurrentUser == false) {
        otherUsers.add(user);
      } //else {
      //throw ErrorDescription('Only current user found!');
      //}
    }
    return otherUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('Current user'),
      UserSmallCard(currentUser),
      const Text('Other Users'),
      Expanded(
        flex: 1,
        child: ListView.builder(
            itemCount: otherUsers.length,
            itemBuilder: (context, index) {
              return UserSmallCard(otherUsers[index]);
            }),
      ),
    ]);
  }
}

class UserSmallCard extends StatefulWidget {
  final User user;
  const UserSmallCard(this.user, {super.key});

  @override
  State<UserSmallCard> createState() => _UserSmallCardState();
}

class _UserSmallCardState extends State<UserSmallCard> {
  IconData getSexIcon(User user) {
    if (user.isMale == true) {
      return Icons.male;
    } else {
      return Icons.female;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      shadowColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 2.0,
      child: ListTile(
        leading: const Icon(
          Icons.account_circle,
          size: 50,
        ),
        title: Row(children: [
          Text('${widget.user.name}'),
          Icon(
            getSexIcon(widget.user),
            size: 20,
          )
        ]),
        subtitle: Text('Height: ${widget.user.height} Weight: TBI BMI: TBI '),
        trailing: const UserCardPopup(),
      ),
    );
  }
}

class UserCardPopup extends StatelessWidget {
  const UserCardPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0)),
        ),
        itemBuilder: (ctx) => [
              buildPopupMenuItem(
                  'Switch to',
                  Icons.edit, // TODO edit code
                  () => {
                        //todo,
                      }),
              buildPopupMenuItem(
                  'Delete',
                  Icons.delete,
                  () => {
                        //todo,
                      }),
            ]);
  }
}
