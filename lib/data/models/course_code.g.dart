// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_code.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseCodeAdapter extends TypeAdapter<CourseCode> {
  @override
  final int typeId = 2;

  @override
  CourseCode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseCode(
      id: fields[1] as String?,
      code: fields[2] as String?,
      uid: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CourseCode obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
