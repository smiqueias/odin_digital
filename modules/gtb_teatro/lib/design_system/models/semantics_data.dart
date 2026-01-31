import 'package:flutter/semantics.dart';

final class GtbSemanticsData {
  final bool exclude;
  final bool container;
  final SemanticsProperties properties;
  final bool blockUserActions;
  final bool explicitChildNodes;
  final Key? key;

  const GtbSemanticsData({
    this.exclude = false,
    this.container = false,
    this.properties = const SemanticsProperties(),
    this.blockUserActions = false,
    this.explicitChildNodes = false,
    this.key,
  });
}
