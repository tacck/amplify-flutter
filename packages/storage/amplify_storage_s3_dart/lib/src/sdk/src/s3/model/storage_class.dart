// Generated with smithy-dart 0.3.1. DO NOT MODIFY.
// ignore_for_file: avoid_unused_constructor_parameters,deprecated_member_use_from_same_package,non_constant_identifier_names,require_trailing_commas

library amplify_storage_s3_dart.s3.model.storage_class; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:smithy/smithy.dart' as _i1;

class StorageClass extends _i1.SmithyEnum<StorageClass> {
  const StorageClass._(super.index, super.name, super.value);

  const StorageClass._sdkUnknown(super.value) : super.sdkUnknown();

  static const deepArchive = StorageClass._(0, 'DEEP_ARCHIVE', 'DEEP_ARCHIVE');

  static const expressOnezone = StorageClass._(
    1,
    'EXPRESS_ONEZONE',
    'EXPRESS_ONEZONE',
  );

  static const glacier = StorageClass._(2, 'GLACIER', 'GLACIER');

  static const glacierIr = StorageClass._(3, 'GLACIER_IR', 'GLACIER_IR');

  static const intelligentTiering = StorageClass._(
    4,
    'INTELLIGENT_TIERING',
    'INTELLIGENT_TIERING',
  );

  static const onezoneIa = StorageClass._(5, 'ONEZONE_IA', 'ONEZONE_IA');

  static const outposts = StorageClass._(6, 'OUTPOSTS', 'OUTPOSTS');

  static const reducedRedundancy = StorageClass._(
    7,
    'REDUCED_REDUNDANCY',
    'REDUCED_REDUNDANCY',
  );

  static const snow = StorageClass._(8, 'SNOW', 'SNOW');

  static const standard = StorageClass._(9, 'STANDARD', 'STANDARD');

  static const standardIa = StorageClass._(10, 'STANDARD_IA', 'STANDARD_IA');

  /// All values of [StorageClass].
  static const values = <StorageClass>[
    StorageClass.deepArchive,
    StorageClass.expressOnezone,
    StorageClass.glacier,
    StorageClass.glacierIr,
    StorageClass.intelligentTiering,
    StorageClass.onezoneIa,
    StorageClass.outposts,
    StorageClass.reducedRedundancy,
    StorageClass.snow,
    StorageClass.standard,
    StorageClass.standardIa,
  ];

  static const List<_i1.SmithySerializer<StorageClass>> serializers = [
    _i1.SmithyEnumSerializer(
      'StorageClass',
      values: values,
      sdkUnknown: StorageClass._sdkUnknown,
      supportedProtocols: [
        _i1.ShapeId(namespace: 'aws.protocols', shape: 'restXml'),
      ],
    ),
  ];
}

extension StorageClassHelpers on List<StorageClass> {
  /// Returns the value of [StorageClass] whose name matches [name].
  ///
  /// Throws a `StateError` if no matching value is found.
  StorageClass byName(String name) =>
      firstWhere((el) => el.name.toLowerCase() == name.toLowerCase());

  /// Returns the value of [StorageClass] whose value matches [value].
  StorageClass byValue(String value) => firstWhere((el) => el.value == value);
}
