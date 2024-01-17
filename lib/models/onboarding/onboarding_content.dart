class OnboardingContent {
  final String title;
  final String description;
  final String image;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnboardingContent> onboardingContentList = [
  OnboardingContent(
    title: 'Welcome to Octo!',
    description:
        'Dive into a world of underwater discovery and conservation. Join us in exploring and protecting marine life.',
    image: 'assets/images/onboarding/onboarding_1.png',
  ),
  OnboardingContent(
    title: 'Explore, Identify, Contribute',
    description:
        'Discover underwater species, identify them with AI, and contribute to marine research. Let\'s make a splash for a sustainable ocean.',
    image: 'assets/images/onboarding/onboarding_2.png',
  ),
  OnboardingContent(
      title: "Get Started",
      description:
          "Ready to Dive In? Let's embark on this underwater adventure together!",
      image: 'assets/images/onboarding/onboarding_3.png')
];
