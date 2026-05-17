// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionModelAdapter extends TypeAdapter<QuestionModel> {
  @override
  final int typeId = 0;

  @override
  QuestionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionModel()
      ..leetcodeId = fields[0] as int
      ..title = fields[1] as String
      ..difficulty = fields[2] as String
      ..pattern = fields[3] as String
      ..topic = fields[4] as String
      ..url = fields[5] as String
      ..companies = (fields[6] as List).cast<String>()
      ..hints = (fields[7] as List).cast<String>()
      ..timeComplexity = fields[8] as String
      ..spaceComplexity = fields[9] as String
      ..tags = (fields[10] as List).cast<String>()
      ..striverStep = fields[11] as int;
  }

  @override
  void write(BinaryWriter writer, QuestionModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.leetcodeId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.difficulty)
      ..writeByte(3)
      ..write(obj.pattern)
      ..writeByte(4)
      ..write(obj.topic)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.companies)
      ..writeByte(7)
      ..write(obj.hints)
      ..writeByte(8)
      ..write(obj.timeComplexity)
      ..writeByte(9)
      ..write(obj.spaceComplexity)
      ..writeByte(10)
      ..write(obj.tags)
      ..writeByte(11)
      ..write(obj.striverStep);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
