import 'package:hive/hive.dart';

part 'user_progress_model.g.dart';

@HiveType(typeId: 2)
class UserProgressModel extends HiveObject {
  @HiveField(0)
  late int questionId; // Matches leetcodeId

  @HiveField(1)
  bool isSolved = false;

  @HiveField(2)
  int solveCount = 0;

  @HiveField(3)
  bool isRevised = false;

  @HiveField(4)
  bool needsRevision = false;

  @HiveField(5)
  bool isFavorite = false;

  @HiveField(6)
  String difficultyRating = ''; // Beginner, Intermediate, Advanced

  @HiveField(7)
  DateTime? lastSolvedDate;

  @HiveField(8)
  int timeSpentSeconds = 0;

  @HiveField(9)
  String personalNotes = ''; // Markdown
}
