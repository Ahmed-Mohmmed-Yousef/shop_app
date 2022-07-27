import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();

  List<BoardingModel> boards = [
    BoardingModel(
        'assets/images/onboard_1.jpeg', 'ON BOARD Title 1', 'On board body 1'),
    BoardingModel(
        'assets/images/onboard_1.jpeg', 'ON BOARD Title 2', 'On board body 2'),
    BoardingModel(
        'assets/images/onboard_1.jpeg', 'ON BOARD Title 3', 'On board body 3'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => navigateAndFinish(context,  const LoginScreen()),
            child: const Text(
              'SKIP',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) =>
                    buildingOnboardItem(boards[index]),
                itemCount: boards.length,
                onPageChanged: (index) {
                  setState(() {
                    isLast = index == boards.length - 1;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boards.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                    dotColor: Colors.grey,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateAndFinish(context, const LoginScreen());
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(isLast
                      ? Icons.login_outlined
                      : Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildingOnboardItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(model.image))),
        // const SizedBox(height: 30),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

// /Users/Ahmed Yousef/Developer/Flutter projects/shop_app/assets/images/onboard_1.jpeg