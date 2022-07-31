import 'package:flutter/material.dart';
import 'package:new_flutter_shop_app/conestance/const.dart';
import 'package:new_flutter_shop_app/screens/login/shop_login_screen.dart';
import 'package:new_flutter_shop_app/shardPreferance/shard_preferance.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  late final String title;
  late final String image;
  late final String body;

  BoardingModel({required this.title, required this.image, required this.body});
}

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  var controller = PageController();

  List<BoardingModel> modle = [
    BoardingModel(
        title: 'boarding 1', image: 'assets/images/sl1.png', body: 'body 1'),
    BoardingModel(
        title: 'boarding 2', image: 'assets/images/sl1.png', body: 'body 2 '),
    BoardingModel(
        title: 'boarding 3',
        image: 'assets/images/onbordering1.png',
        body: 'body 3 '),
  ];

  bool isLast = false;

  void submit() {
    MyShardPreferance.saveData(key: onBoarding, value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginUserScreen(),
            ),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text("SKIP"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(modle[index]),
                itemCount: modle.length,
                onPageChanged: (int index) {
                  if (index == modle.length - 1) {
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
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: controller, // PageController
                    count: modle.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.deepOrange,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0), // your preferred effect
                    onDotClicked: (index) {}),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      controller.nextPage(
                          duration: Duration(milliseconds: 650),
                          curve: Curves.bounceInOut);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
