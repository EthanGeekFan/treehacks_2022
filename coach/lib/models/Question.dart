class Question {
  String prompt;
  List<String> choices;
  String selectedChoice = "";
  bool isFreeResponse;
  bool isSlider;
  int min;
  int max;

  Question(this.prompt, this.choices,
      {this.isFreeResponse = false,
      this.isSlider = false,
      this.min = 0,
      this.max = 10});
}

List<Question> introQuestions = [
  Question(
    "What is your gender?",
    ["Male", "Female", "Non-binary", "Prefer not to say"],
  ),
  Question(
    "What gender do you want to date?",
    ["Male", "Female", "Non-binary", "Prefer not to say"],
  ),
  Question(
    "What is your age?",
    ["Age"],
    min: 18,
    max: 40,
    isSlider: true,
  ),
  Question(
    "Which age range do you want to date?",
    ["Mininum", "Maximum"],
    min: 18,
    max: 40,
    isSlider: true,
  ),
  Question(
    "How interested are you in the following activities, on a scale of 1-10?",
    [
      "Sports/athletics",
      "Watching sports",
      "Body building/exercising",
      "Dining out",
      "Museums/galleries",
      "Art",
      "Hiking/camping",
      "Gaming",
      "Dancing/clubbing",
      "Reading",
      "Watching TV",
      "Theater",
      "Movies",
      "Going to concerts",
      "Music",
      "Shopping",
      "Yoga/meditation"
    ],
    isSlider: true,
  ),
  Question(
    "We want to know what you look for in your partner",
    [
      "Attractive",
      "Sincere",
      "Intelligent",
      "Fun",
      "Ambitious",
      "Has shared interests/hobbies",
    ],
    isSlider: true,
  ),
  Question(
    "How do you think you measure up?",
    [
      "Attractive",
      "Sincere",
      "Intelligent",
      "Fun",
      "Ambitious",
    ],
    isSlider: true,
  ),
];
