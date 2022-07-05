import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:livetrack_indra/utils/enums.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class User extends HiveObject {
  User(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.token,
  );

  /// Converter from response map data to model
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converter from model to map data for request
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @HiveField(0)
  @JsonKey(name: 'id')
  final String id;

  @HiveField(2)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @HiveField(3)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @HiveField(4)
  final String? name;

  @HiveField(5)
  final String token;
}
