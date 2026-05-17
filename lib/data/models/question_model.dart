import 'package:hive/hive.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModel extends HiveObject {
  @HiveField(0)
  late int leetcodeId;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String difficulty; // Easy, Medium, Hard

  @HiveField(3)
  late String pattern;

  @HiveField(4)
  late String topic; // Enforces roadmap order

  @HiveField(5)
  late String url;

  @HiveField(6)
  late List<String> companies;

  @HiveField(7)
  late List<String> hints;

  @HiveField(8)
  late String timeComplexity;

  @HiveField(9)
  late String spaceComplexity;

  @HiveField(10)
  late List<String> tags;

  @HiveField(11)
  late int striverStep;
}
