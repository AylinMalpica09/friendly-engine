import 'package:flutter/material.dart';

import 'package:Kiboowi/models/profile_model.dart';
import 'package:Kiboowi/services/profile_service.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late Future<ProfileModel> futureProfile;

  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Color miColor = Color(0xFF4D5840);
  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    ProfileService ps = ProfileService();
    futureProfile = ps.fetchprofile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),

      body: Center(
        child: FutureBuilder<ProfileModel>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildProfile(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
  Widget buildProfile(ProfileModel profile) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: ${profile.name}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Username: ${profile.username}'),
          Text('Email: ${profile.email}'),
          Text('Birthday: ${profile.birthday}'),
          Text('Create Date: ${profile.createDate}'),
        ],
      ),
    );
  }
}

class EditableTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool enabled;
  final bool obscureText;
  final Color? labelTextColor;

  const EditableTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.enabled = false,
    this.labelTextColor,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: 1,
      enabled: widget.enabled,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        labelStyle: TextStyle(color: widget.labelTextColor ),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black, fontSize: 15),
    );
  }
}
