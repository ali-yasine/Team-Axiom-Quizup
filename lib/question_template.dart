class question_template {
  final String prompt;
  final List<String> wrongAnswersTxt;
  final String correctAnswerTxt;
  final String subject;
  question_template(
      {required this.prompt,
      required this.wrongAnswersTxt,
      required this.correctAnswerTxt,
      required this.subject})
      : super();
  static question_template fromJson(Map<String, dynamic> json) =>
      question_template(
        subject: json['category'],
        prompt: json['prompt'],
        correctAnswerTxt: json['correctanswer'],
        wrongAnswersTxt: json['wronganswers'].cast<String>(),
      );
}
