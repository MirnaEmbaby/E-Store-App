import 'package:e_store/models/boarding_model.dart';
import 'package:e_store/modules/login_screen/login_screen.dart';
import 'package:e_store/shared/components/components.dart';
import 'package:e_store/shared/network/local/cache_helper.dart';
import 'package:e_store/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/order.png',
      title: 'Order',
      body: 'Browse our wide selection of products and services.',
    ),
    BoardingModel(
      image: 'assets/images/pay.png',
      title: 'Pay',
      body:
          'Select a convenient payment method and securely complete your purchase.',
    ),
    BoardingModel(
      image: 'assets/images/delivery.png',
      title: 'Delivery',
      body: 'Choose a delivery time and location that works best for you.',
    ),
  ];

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true);
    navigateAndFinish(context, LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          defaultTextButton(
            function: () => submit(),
            text: 'skip',
            color: Colors.black,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
              controller: boardController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (int index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultTeal,
                    dotWidth: 10,
                    dotHeight: 10,
                    expansionFactor: 2,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () => isLast
                      ? submit()
                      : boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: const TextStyle(
                    fontSize: 36.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  model.body,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ],
      );
}
