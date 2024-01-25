import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()

class Post {
  int id;
  String name;
  String description;

  Post(this.id, this.name, this.description);

  factory Post.fromJson(Map<String,dynamic> json) => _$PostFromJson(json);

  Map<String,dynamic> toJson()=> _$PostToJson(this);
}
