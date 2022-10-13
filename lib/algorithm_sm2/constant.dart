class LearningStep {
  static const double againStep = 100;
  static const double hardStep = 20;
  static const double goodStep = 25;
  static const double graduatingIvl = 30;
  static const double easyIvl = 35;

  // static const double againStep = 25;
  // static const double hardStep = 720;
  // static const double goodStep = 1440;
  // static const double graduatingIvl = 4320;
  // static const double easyIvl = 5760;
}
class GraduatingStep {
  static const double defaultEaseFactor = 2.5;
  static const double defaultHardInterval = 1.2;
  static const double defaultEaseBonus = 1.3;
}

class RelearningStep {
  static const double againRelearningStep = 5;
  static const double hardRelearningStep = 10;
  // static const double againRelearningStep = 10;
  // static const double hardRelearningStep = 15;
  static const double newGoodInterval = 0.2;
  static const double newEasyInterval = 0.25;
  static const double minusAgainEase = 15;
  static const double minusHardEase = 0.2;
  static const double addEasyEase = 0.25;
}

class CardState {
  static const int learningState = 0;
  static const int graduatedState = 1;
  static const int relearningState = 2;
}