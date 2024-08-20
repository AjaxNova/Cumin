// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelForDbAdapter extends TypeAdapter<UserModelForDb> {
  @override
  final int typeId = 1;

  @override
  UserModelForDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModelForDb(
      id: fields[0] as String,
      name: fields[1] as String,
      password: fields[2] as String,
      email: fields[3] as String,
      likedpics: (fields[4] as List).cast<String>(),
      savedposts: (fields[5] as List).cast<String>(),
      isLoggedIn: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserModelForDb obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.likedpics)
      ..writeByte(5)
      ..write(obj.savedposts)
      ..writeByte(6)
      ..write(obj.isLoggedIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelForDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
