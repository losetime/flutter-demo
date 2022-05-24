import 'package:json_annotation/json_annotation.dart';
part 'saddleTypeModel.g.dart';

@JsonSerializable()
class SaddleTypeModel {
  final int id;
  final String typeLevel;
  final String diameter;
  final String allowableLoad;
  final String bearingHeight; // 允许载荷
  final String bottomPlate; // 底板
  final String webPlate; // 腹板
  final String ribPlate; // 筋板
  final String backPlate; // 垫板
  final String boltSpace; // 螺栓间距
  final String bearingQuality; // 鞍式支座质量
  final String addQuality; // 增加高度增加的质量
  final String picUrl; // 选择的图片

  SaddleTypeModel( 
      {this.id,
      this.typeLevel,
      this.diameter,
      this.allowableLoad,
      this.bearingHeight,
      this.bottomPlate,
      this.webPlate,
      this.ribPlate,
      this.backPlate,
      this.boltSpace,
      this.bearingQuality,
      this.addQuality,
      this.picUrl});

  factory SaddleTypeModel.fromJson(Map<String, dynamic> json) =>
      _$SaddleTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaddleTypeModelToJson(this);
}
