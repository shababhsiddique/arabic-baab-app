// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArabicVerb.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArabicVerbAdapter extends TypeAdapter<ArabicVerb> {
  @override
  final int typeId = 0;

  @override
  ArabicVerb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArabicVerb(
      maadi: fields[0] as String,
      mudari: fields[1] as String,
      masdar: fields[2] as String,
      baab: fields[3] as String,
      bengaliMeaning: fields[4] as String,
      exampleSentence: fields[5] as String,
      isFavorite: fields[7] as bool,
      failCounter: fields[6] as int,
      failHistory: fields[8] as int?,
      amr: fields[9] as String?,
      nahi: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ArabicVerb obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.maadi)
      ..writeByte(1)
      ..write(obj.mudari)
      ..writeByte(2)
      ..write(obj.masdar)
      ..writeByte(3)
      ..write(obj.baab)
      ..writeByte(4)
      ..write(obj.bengaliMeaning)
      ..writeByte(5)
      ..write(obj.exampleSentence)
      ..writeByte(6)
      ..write(obj.failCounter)
      ..writeByte(7)
      ..write(obj.isFavorite)
      ..writeByte(8)
      ..write(obj.failHistory)
      ..writeByte(9)
      ..write(obj.amr)
      ..writeByte(10)
      ..write(obj.nahi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArabicVerbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
