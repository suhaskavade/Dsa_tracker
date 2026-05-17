// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProgressModelAdapter extends TypeAdapter<UserProgressModel> {
  @override
  final int typeId = 2;

  @override
  UserProgressModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProgressModel()
      ..questionId = fields[0] as int
      ..isSolved = fields[1] as bool
      ..solveCount = fields[2] as int
      ..isRevised = fields[3] as bool
      ..needsRevision = fields[4] as bool
      ..isFavorite = fields[5] as bool
      ..difficultyRating = fields[6] as String
      ..lastSolvedDate = fields[7] as DateTime?
      ..timeSpentSeconds = fields[8] as int
      ..personalNotes = fields[9] as String;
  }

  @override
  void write(BinaryWriter writer, UserProgressModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.questionId)
      ..writeByte(1)
      ..write(obj.isSolved)
      ..writeByte(2)
      ..write(obj.solveCount)
      ..writeByte(3)
      ..write(obj.isRevised)
      ..writeByte(4)
      ..write(obj.needsRevision)
      ..writeByte(5)
      ..write(obj.isFavorite)
      ..writeByte(6)
      ..write(obj.difficultyRating)
      ..writeByte(7)
      ..write(obj.lastSolvedDate)
      ..writeByte(8)
      ..write(obj.timeSpentSeconds)
      ..writeByte(9)
      ..write(obj.personalNotes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProgressModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
