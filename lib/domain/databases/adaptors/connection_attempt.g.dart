// GENERATED CODE - DO NOT MODIFY BY HAND
part of '../context_models/connection_attempt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConnectionAttemptAdapter extends TypeAdapter<ConnectionAttempt> {
  @override
  final int typeId = 2;

  @override
  ConnectionAttempt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConnectionAttempt(
      fields[1] as int,
      fields[4] as DateTime,
      fields[0] as int,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ConnectionAttempt obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.authConnectionId)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.signature)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectionAttemptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
