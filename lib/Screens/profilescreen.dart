// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/user.dart';
import 'package:projectf/Screens/loginscreen.dart';
import 'package:projectf/Widgets/CustomsForAuth/button.dart';
import 'package:projectf/Widgets/CustomsForAuth/edit.dart';
import 'package:projectf/constant.dart';
import 'package:projectf/changetheme.dart';

class ProfileScreen extends StatefulWidget {
  final Users? user;

  const ProfileScreen({Key? key, this.user}) : super(key: key);
  static const String id = 'profilescreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DataBaseHandler dataBaseHandler = DataBaseHandler();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color color =
        theme.brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  radius: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.user?.fName}',
                          style: Styles.headlineStyle2.copyWith(color: color),
                        ),
                        Text(
                          '${widget.user?.lName}',
                          style: Styles.headlineStyle2.copyWith(color: color),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          _EditProfileScreen(context, widget.user!);
                        },
                        child: Text(
                          'Edit Profile',
                          style: Styles.headlineStyle3.copyWith(color: color),
                        )),
                  ],
                ),
              ],
            ),
          ),
          const Gap(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChangeTheme.of(context)!.data?.isDark == true
                    ? Text(
                        'Light Mode',
                        style: Styles.headlineStyle3.copyWith(color: color),
                      )
                    : Text(
                        'Dark Mode',
                        style: Styles.headlineStyle3.copyWith(color: color),
                      ),
                InkWell(
                  onTap: () {
                    ChangeTheme.of(context)?.data?.toggleTheme();
                    setState(() {});
                  },
                  child: ChangeTheme.of(context)!.data?.isDark == true
                      ? const Icon(Icons.dark_mode_outlined)
                      : const Icon(Icons.light_mode_outlined),
                ),
              ],
            ),
          ),
          const Gap(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: Button(
                onTap: () async {
                  await dataBaseHandler.deleteUser('${widget.user?.name}');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                text: 'Delete Account',
                color: Colors.red),
          ),
          const Gap(25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0),
            child: Button(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                text: 'Logout',
                color: Colors.red),
          ),
          const Gap(25),
        ],
      ),
    );
  }

  void _EditProfileScreen(BuildContext context, Users users) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.42,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(5),
                  EditInfo(
                    enabled: true,
                    isobscureText: false,
                    controller: TextEditingController(text: users.fName),
                    text: 'First Name',
                    onChanged: (value) {
                      users.fName = value;
                    },
                  ),
                  const Gap(15),
                  EditInfo(
                    enabled: true,
                    isobscureText: false,
                    controller: TextEditingController(text: users.lName),
                    text: 'Last Name',
                    onChanged: (value) {
                      users.lName = value;
                    },
                  ),
                  const Gap(15),
                  EditInfo(
                    enabled: false,
                    isobscureText: false,
                    controller: TextEditingController(text: users.name),
                    text: 'User Name',
                    onChanged: (value) {
                      users.name = value;
                    },
                  ),
                  const Gap(15),
                  EditInfo(
                    enabled: true,
                    isobscureText: false,
                    controller: TextEditingController(text: users.password),
                    text: 'Password',
                    onChanged: (value) {
                      setState(() {
                        value;
                        users.password = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await dataBaseHandler.updateUser(users);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
