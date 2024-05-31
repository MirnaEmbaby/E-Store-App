import 'package:e_store/modules/login_screen/login_screen.dart';
import 'package:e_store/modules/shop_layout/cubit/cubit.dart';
import 'package:e_store/shared/network/local/cache_helper.dart';
import 'package:e_store/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Widget? defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  required bool hasSuffix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit != null ? (s) => onSubmit(s) : null,
      onChanged: onChanged != null ? (s) => onChanged(s) : null,
      onTap: onTap != null ? () => onTap() : null,
      validator: (s) => validate(s),
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
            color: defaultTeal,
          ),
          suffixIcon: hasSuffix
              ? IconButton(
                  onPressed: () => suffixPressed!(),
                  icon: Icon(
                    suffix,
                    color: defaultTeal,
                  ),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: defaultTeal,
              width: 2.0,
            ),
          ),
          enabledBorder: const OutlineInputBorder()),
    );

Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function? function,
  required String? text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: defaultTeal,
      ),
      child: MaterialButton(
        onPressed: () {
          function!();
        },
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function function,
  required String? text,
  Color? color,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text!.toUpperCase(),
        style: TextStyle(color: color),
      ),
    );

enum ToastStates { success, error, warning }

void showToast(String? text, ToastStates state) => Fluttertoast.showToast(
    msg: text!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: toastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);

Color toastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

void signOut(context) {
  CacheHelper.removeData(key: 'token').then(
    (value) => navigateAndFinish(
      context,
      LoginScreen(),
    ),
  );
}

Widget buildListItem(model, context, {bool isOldPrice = true}) => Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          height: 130,
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image!),
                    width: 120,
                    height: 120,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(5.0),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        '${model.oldPrice} EGP',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          height: 0.1,
                        ),
                      ),
                    Row(
                      children: [
                        Text(
                          '${model.price} EGP',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: defaultTeal,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavs(model.id!);
                          },
                          icon: Icon(
                            ShopCubit.get(context).favourites[model.id]!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18.0,
                            color: defaultTeal,
                            shadows: const [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 10,
                                blurRadius: 10,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
