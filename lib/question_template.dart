class question_template {
  final String prompt;
  final List<String> wrongAnswersTxt;
  final String correctAnswerTxt;
  question_template({
    required this.prompt,
    required this.wrongAnswersTxt,
    required this.correctAnswerTxt,
  }) : super();
}
