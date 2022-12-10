// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../context_models/auth_connection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthConnectionAdapter extends TypeAdapter<AuthConnection> {
  @override
  final int typeId = 1;

  @override
  AuthConnection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthConnection(
      fields[0] as int,
      fields[5] as DateTime,
      fields[2] as String,
      fields[4] as bool,
      fields[3] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthConnection obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.registerHash)
      ..writeByte(4)
      ..write(obj.isEnabled)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthConnectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
