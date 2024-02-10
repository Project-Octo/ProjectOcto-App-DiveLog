import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Models
import 'package:octo_app/models/onboarding/onboarding_content.dart';

//screens
import '../login_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController _pageController = PageController();
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
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(onboardingContentList[index].image,
                              height: 250),
                          Text(onboardingContentList[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              )),
                          const SizedBox(height: 20),
                          Text(
                            onboardingContentList[index].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    )),
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
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.all(40),
              child: TextButton(
                onPressed: () {
                  if (currentIndex == onboardingContentList.length - 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  } else {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutQuint);
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                ),
                child: Text(
                    currentIndex == onboardingContentList.length - 1
                        ? "Get Started"
                        : "Next",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                // border radius
              ))
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: currentIndex == index ? 20 : 10,
      decoration: BoxDecoration(
        color: index == onboardingContentList.length - 1
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
