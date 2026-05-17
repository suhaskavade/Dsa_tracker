import 'package:hive/hive.dart';

part 'user_profile_model.g.dart';

@HiveType(typeId: 1)
class UserProfileModel extends HiveObject {
  @HiveField(0)
  int xp = 0;

  @HiveField(1)
  int currentLevel = 1;

  @HiveField(2)
  int currentStreak = 0;

  @HiveField(3)
  int longestStreak = 0;

  @HiveField(4)
  List<String> badges = [];

  @HiveField(5)
  List<String> unlockedTopics = ['Arrays + Strings']; // Starting point
}
