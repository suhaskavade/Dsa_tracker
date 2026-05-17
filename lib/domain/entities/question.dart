class Question {
  final int leetcodeId;
  final String title;
  final String difficulty;
  final String pattern;
  final String topic;
  final String url;
  final List<String> companies;
  final List<String> hints;
  final String timeComplexity;
  final String spaceComplexity;
  final List<String> tags;
  final int striverStep;

  Question({
    required this.leetcodeId,
    required this.title,
    required this.difficulty,
    required this.pattern,
    required this.topic,
    required this.url,
    required this.companies,
    required this.hints,
    required this.timeComplexity,
    required this.spaceComplexity,
    required this.tags,
    required this.striverStep,
  });
}
