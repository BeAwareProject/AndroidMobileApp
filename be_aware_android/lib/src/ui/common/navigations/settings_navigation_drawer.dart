// ignore_for_file: use_build_context_synchronously

import 'package:be_aware_android/generated_code/dependency_injection/injectable.dart';
import 'package:be_aware_android/src/repos/auth_repo.dart';
import 'package:be_aware_android/src/ui/common/dividers/details_divider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsNavigationDrawer extends StatefulWidget {
  const SettingsNavigationDrawer({super.key});

  @override
  State<SettingsNavigationDrawer> createState() =>
      _SettingsNavigationDrawerState();
}

class _SettingsNavigationDrawerState extends State<SettingsNavigationDrawer> {
  final AuthRepo authRepo = getIt();

  Future<void> _logout() async {
    await authRepo.deleteTokensFromStorage();
    context.go("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "BeAware",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 10),
          const DetailsDivider(),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: [
                const Icon(Icons.person_outlined),
                const SizedBox(width: 3),
                Text(
                  "Konto",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*const Icon(Icons.person_outline),
                const SizedBox(width: 5),*/
                Text(
                  authRepo.loggedInUser!.username,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15),
                ),
                TextButton(
                  onPressed: _logout,
                  child: const Text("WYLOGUJ"),
                ),
              ],
            ),
          ),
          const DetailsDivider(),
        ],
      ),
    );
  }
}
