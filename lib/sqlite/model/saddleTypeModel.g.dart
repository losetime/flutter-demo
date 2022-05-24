// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saddleTypeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaddleTypeModel _$SaddleTypeModelFromJson(Map<String, dynamic> json) {
  return SaddleTypeModel(
    id: json['id'] as int,
    typeLevel: json['typeLevel'] as String,
    diameter: json['diameter'] as String,
    allowableLoad: json['allowableLoad'] as String,
    bearingHeight: json['bearingHeight'] as String,
    bottomPlate: json['bottomPlate'] as String,
    webPlate: json['webPlate'] as String,
    ribPlate: json['ribPlate'] as String,
    backPlate: json['backPlate'] as String,
    boltSpace: json['boltSpace'] as String,
    bearingQuality: json['bearingQuality'] as String,
    addQuality: json['addQuality'] as String,
    picUrl: json['picUrl'] as String,
  );
}

Map<String, dynamic> _$SaddleTypeModelToJson(SaddleTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeLevel': instance.typeLevel,
      'diameter': instance.diameter,
      'allowableLoad': instance.allowableLoad,
      'bearingHeight': instance.bearingHeight,
      'bottomPlate': instance.bottomPlate,
      'webPlate': instance.webPlate,
      'ribPlate': instance.ribPlate,
      'backPlate': instance.backPlate,
      'boltSpace': instance.boltSpace,
      'bearingQuality': instance.bearingQuality,
      'addQuality': instance.addQuality,
      'picUrl': instance.picUrl,
    };
