import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models.dart';
import 'user_repository.dart';

UserRepository userRepository = UserRepository();

class UserMainMenu extends StatelessWidget {
  const UserMainMenu({super.key});

  //final User currentUser = userRepository.getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(20),
      child: const Row(
        children: [UserCard()],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  //final User? user;
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('The Enchanted Nightingale'),
          subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: const Text('BUY TICKETS'),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
            TextButton(
              child: const Text('LISTEN'),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    )));
  }
}
