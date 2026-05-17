// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileModelAdapter extends TypeAdapter<UserProfileModel> {
  @override
  final int typeId = 1;

  @override
  UserProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileModel()
      ..xp = fields[0] as int
      ..currentLevel = fields[1] as int
      ..currentStreak = fields[2] as int
      ..longestStreak = fields[3] as int
      ..badges = (fields[4] as List).cast<String>()
      ..unlockedTopics = (fields[5] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, UserProfileModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.xp)
      ..writeByte(1)
      ..write(obj.currentLevel)
      ..writeByte(2)
      ..write(obj.currentStreak)
      ..writeByte(3)
      ..write(obj.longestStreak)
      ..writeByte(4)
      ..write(obj.badges)
      ..writeByte(5)
      ..write(obj.unlockedTopics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
