import 'package:education_app/core/utils/typedefs.dart';

abstract class OnBoardingRepo {
  // saving whether to show onboarding or not
  // how do we know if we are going to show
  // the on boarding screen to the user.
  // And if it's not the first time we will
  // push the user to the login screen.
  // And the to the home screen

  // Detect if it's the first time in the app.

  const OnBoardingRepo();

  ResultFuture<void> cacheFirstTime();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
