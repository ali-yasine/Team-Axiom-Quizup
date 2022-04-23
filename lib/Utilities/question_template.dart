class QuestionTemplate {
  final String prompt;
  final List<String> wrongAnswersTxt;
  final String correctAnswerTxt;
  final String subject;
  QuestionTemplate(
      {required this.prompt,
      required this.wrongAnswersTxt,
      required this.correctAnswerTxt,
      required this.subject})
      : super();
  static QuestionTemplate fromJson(Map<String, dynamic> json) {
    return QuestionTemplate(
      subject: json['subject'],
      prompt: json['prompt'],
      correctAnswerTxt: json['correctanswer'],
      wrongAnswersTxt: json['wronganswers'].cast<String>(),
    );
  }

  static Map<String, dynamic> toJson(QuestionTemplate template) => {
        'category': template.subject,
        'prompt': template.prompt,
        'correctanswer': template.correctAnswerTxt,
        'wronganswers': template.wrongAnswersTxt
      };
}
