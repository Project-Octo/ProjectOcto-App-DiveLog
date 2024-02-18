import 'package:flutter/material.dart';
import 'package:octo_app/screens/onboarding/auth.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Models
import 'package:octo_app/models/onboarding/onboarding_content.dart';

// Screens
import '../login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}



class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingContentList.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        onboardingContentList[index].image,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        onboardingContentList[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        onboardingContentList[index].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: onboardingContentList.length,
            effect: const ExpandingDotsEffect(
              dotHeight: 16,
              dotWidth: 16,
              dotColor: Color(0xFFC4C4C4),
              activeDotColor: Color(0xFF0077C8),
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
                horizontal: 60, vertical: 40), // margin 값을 수정하여 가로 길이를 줄임
            child: TextButton(
              onPressed: () {
                if (currentIndex == onboardingContentList.length - 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                  );
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutQuint,
                  );
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                )),
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                currentIndex == onboardingContentList.length - 1
                    ? "Get Started"
                    : "Next",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
