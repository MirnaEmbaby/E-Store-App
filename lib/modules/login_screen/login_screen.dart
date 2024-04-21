import 'package:e_store/modules/shop_register_screen/shop_register_screen.dart';
import 'package:e_store/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LOGIN',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                Text(
                  'login now to browse our hot offers',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Please, enter your email address';
                    }
                  },
                  label: 'Email address',
                  prefix: Icons.email_outlined,
                  hasSuffix: false,
                )!,
                const SizedBox(
                  height: 15.0,
                ),
                defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Password is too short';
                      }
                    },
                    label: 'Password',
                    prefix: Icons.lock_outline,
                    hasSuffix: true,
                    suffix: Icons.visibility_outlined,
                    suffixPressed: () {})!,
                const SizedBox(
                  height: 30.0,
                ),
                defaultButton(
                  function: () {},
                  text: 'Login',
                  isUpperCase: true,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Dont\'t have an account?'),
                    defaultTextButton(
                      function: () {
                        navigateTo(
                          context,
                          const ShopRegisterScreen(),
                        );
                      },
                      text: 'Register now',
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
