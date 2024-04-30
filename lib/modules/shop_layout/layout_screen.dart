import 'package:e_store/modules/login_screen/login_screen.dart';
import 'package:e_store/shared/components/components.dart';
import 'package:e_store/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextButton(
        child: const Text('Sign out'),
        onPressed: () {
          CacheHelper.removeData(key: 'token')
              .then((value) => navigateAndFinish(
                    context,
                    LoginScreen(),
                  ));
        },
      ),
    );
  }
}
