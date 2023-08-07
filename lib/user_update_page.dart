import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class UserUpdatePage extends StatefulWidget {
  const UserUpdatePage({
    Key? key,
    required this.name,
    required this.age,
    required this.email,
    required this.id,
  }) : super(key: key);

  final String name;
  final String age;
  final String email;
  final String id;

  @override
  State<UserUpdatePage> createState() => _UserUpdatePageState();
}

class _UserUpdatePageState extends State<UserUpdatePage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerName.text = widget.name;
    controllerAge.text = widget.age;
    controllerEmail.text = widget.email;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextFormField(
            controller: controllerName,
            decoration: decoration('Name'),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: controllerAge,
            decoration: decoration('Age'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: controllerEmail,
            decoration: decoration('E-mail'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () async {
              final user = User(
                name: controllerName.text,
                age: int.parse(controllerAge.text),
                email: controllerEmail.text,
                id: widget.id,
              );

              await UpdateUser(user);

              Navigator.pop(context);
            },
            child: const Text('Update User'),
          )
        ],
      ),
    );
  }

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      );

  Future<void> UpdateUser(User user) async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(widget.id);

    final json = user.toJson();

    await docUser.set(json);
  }
}
