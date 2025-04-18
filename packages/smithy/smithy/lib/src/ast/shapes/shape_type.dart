// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/ast.dart';
import 'package:smithy/src/ast/serializers.dart';

part 'shape_type.g.dart';

enum Category { simple, aggregate, service, apply }

class ShapeType extends EnumClass {
  const ShapeType._(super.name);
  static const ShapeType apply = _$apply;
  static const ShapeType blob = _$blob;
  static const ShapeType boolean = _$boolean;
  static const ShapeType string = _$string;
  @BuiltValueEnumConst(wireName: 'enum')
  static const ShapeType enum_ = _$enum;
  static const ShapeType timestamp = _$timestamp;
  static const ShapeType byte = _$byte;
  static const ShapeType short = _$short;
  static const ShapeType integer = _$integer;
  static const ShapeType intEnum = _$intEnum;
  static const ShapeType long = _$long;
  static const ShapeType float = _$float;
  static const ShapeType document = _$document;
  static const ShapeType double = _$double;
  static const ShapeType bigDecimal = _$bigDecimal;
  static const ShapeType bigInteger = _$bigInteger;
  static const ShapeType list = _$list;
  static const ShapeType set = _$set;
  static const ShapeType map = _$map;
  static const ShapeType structure = _$structure;
  static const ShapeType union = _$union;
  static const ShapeType member = _$member;
  static const ShapeType service = _$service;
  static const ShapeType resource = _$resource;
  static const ShapeType operation = _$operation;

  static BuiltSet<ShapeType> get values => _$shapeTypeValues;
  static ShapeType valueOf(String name) => _$shapeTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(ShapeType.serializer, this) as String;
  }

  static ShapeType deserialize(String string) {
    return serializers.deserializeWith(ShapeType.serializer, string)
        as ShapeType;
  }

  static Serializer<ShapeType> get serializer => _$shapeTypeSerializer;
}

extension ShapeTypeX on ShapeType {
  Category get category {
    switch (this) {
      case ShapeType.apply:
        return Category.apply;
      case ShapeType.blob:
      case ShapeType.boolean:
      case ShapeType.string:
      case ShapeType.timestamp:
      case ShapeType.byte:
      case ShapeType.short:
      case ShapeType.integer:
      case ShapeType.long:
      case ShapeType.float:
      case ShapeType.document:
      case ShapeType.double:
      case ShapeType.bigDecimal:
      case ShapeType.bigInteger:
      case ShapeType.enum_:
      case ShapeType.intEnum:
        return Category.simple;
      case ShapeType.list:
      case ShapeType.set:
      case ShapeType.map:
      case ShapeType.structure:
      case ShapeType.union:
      case ShapeType.member:
        return Category.aggregate;
      case ShapeType.service:
      case ShapeType.resource:
      case ShapeType.operation:
        return Category.service;
    }
    throw ArgumentError();
  }

  Type get type {
    switch (this) {
      case ShapeType.apply:
        return ApplyShape;
      case ShapeType.bigDecimal:
        return BigDecimalShape;
      case ShapeType.bigInteger:
        return BigIntegerShape;
      case ShapeType.blob:
        return BlobShape;
      case ShapeType.boolean:
        return BooleanShape;
      case ShapeType.byte:
        return ByteShape;
      case ShapeType.document:
        return DocumentShape;
      case ShapeType.double:
        return DoubleShape;
      case ShapeType.enum_:
        return StringEnumShape;
      case ShapeType.intEnum:
        return IntEnumShape;
      case ShapeType.float:
        return FloatShape;
      case ShapeType.integer:
        return IntegerShape;
      case ShapeType.list:
        return ListShape;
      case ShapeType.long:
        return LongShape;
      case ShapeType.map:
        return MapShape;
      case ShapeType.member:
        return MemberShape;
      case ShapeType.operation:
        return OperationShape;
      case ShapeType.resource:
        return ResourceShape;
      case ShapeType.service:
        return ServiceShape;
      case ShapeType.set:
        return SetShape;
      case ShapeType.short:
        return ShortShape;
      case ShapeType.string:
        return StringShape;
      case ShapeType.structure:
        return StructureShape;
      case ShapeType.timestamp:
        return TimestampShape;
      case ShapeType.union:
        return UnionShape;
    }
    throw ArgumentError.value(this);
  }
}
