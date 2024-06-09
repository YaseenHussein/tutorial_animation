class OnBoardingModel {
  final String imageUrl;
  final String label;
  final String description;

  OnBoardingModel(
      {required this.imageUrl, required this.label, required this.description});
}

List<OnBoardingModel> onBoardingModel = [
  OnBoardingModel(
      imageUrl:
          "https://lottie.host/f34f7ca4-01cf-4c6b-b8af-661eab1371b2/vOIXmKNa2D.json",
      label: "fast Delivery",
      description:
          "git fest delivery git fest delivery git fest delivery git fest delivery git fest delivery"),
  OnBoardingModel(
      imageUrl:
          "https://lottie.host/e059b553-d63a-4092-9f86-fde3f16716c0/lCrB09NsM8.json",
      label: "every day",
      description: "every day deliver"),
  OnBoardingModel(
      imageUrl:
          "https://lottie.host/e04fe181-7e17-4e62-bf58-d2e249eac7b9/e2HZYMDv00.json",
      label: "enjoy",
      description: "enjoy with your time")
];
