import 'package:flutter/material.dart';
import 'package:open_weight_tracker/user_profile_form.dart';
import 'models.dart';
import 'user_repository.dart';
import 'main.dart';

class UserMainMenu extends StatefulWidget {
  late User currentUser = userRepository.getCurrentUser();
  UserMainMenu({
    super.key,
  });

  @override
  State<UserMainMenu> createState() => _UserMainMenuState(currentUser);
}

class _UserMainMenuState extends State<UserMainMenu> {
  User currentUser;
  _UserMainMenuState(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(2, 5, 2, 20),
      alignment: Alignment.topCenter,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: UserSmallCard(currentUser),
              ),
            ],
          ),
          const Text('All users: '),
          UserList(users: userRepository.getAllUsers())
        ],
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final List<User> users;
  const UserList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return UserSmallCard(users[index]);
          }),
    );
  }
}

class UserBigCard extends StatefulWidget {
  final User user;
  const UserBigCard(this.user, {super.key});

  @override
  State<UserBigCard> createState() => _UserBigCardState();
}

class _UserBigCardState extends State<UserBigCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(6));
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
      shadowColor: Theme.of(context).colorScheme.onSecondaryContainer,
      child: ListTile(
        leading: Icon(
          getSexIcon(widget.user),
          size: 50,
        ),
        title: Text(widget.user.name),
        subtitle: Text('Height: ${widget.user.height} Weight: TBI BMI: TBI '),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}
