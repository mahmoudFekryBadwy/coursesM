// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_video.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseVideoAdapter extends TypeAdapter<CourseVideo> {
  @override
  final int typeId = 1;

  @override
  CourseVideo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseVideo(
      id: fields[1] as String?,
      name: fields[2] as String?,
      number: fields[3] as String?,
      link: fields[4] as String?,
      filePath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CourseVideo obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.number)
      ..writeByte(4)
      ..write(obj.link)
      ..writeByte(5)
      ..write(obj.filePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseVideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
