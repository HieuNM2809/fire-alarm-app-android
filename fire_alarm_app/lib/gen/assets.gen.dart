/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/sound_alarm.mp3
  String get soundAlarm => 'assets/audio/sound_alarm.mp3';

  /// List of all assets
  List<String> get values => [soundAlarm];
}

class $AssetsColorGen {
  const $AssetsColorGen();

  /// File path: assets/color/colors.xml
  String get colors => 'assets/color/colors.xml';

  /// File path: assets/color/colors2.xml
  String get colors2 => 'assets/color/colors2.xml';

  /// List of all assets
  List<String> get values => [colors, colors2];
}

class $AssetsFontGen {
  const $AssetsFontGen();

  /// File path: assets/font/DMSans-Bold.ttf
  String get dMSansBold => 'assets/font/DMSans-Bold.ttf';

  /// File path: assets/font/DMSans-Regular.ttf
  String get dMSansRegular => 'assets/font/DMSans-Regular.ttf';

  /// List of all assets
  List<String> get values => [dMSansBold, dMSansRegular];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/detector.png
  AssetGenImage get detector =>
      const AssetGenImage('assets/images/detector.png');

  /// File path: assets/images/gas_station.png
  AssetGenImage get gasStation =>
      const AssetGenImage('assets/images/gas_station.png');

  /// File path: assets/images/loading.gif
  AssetGenImage get loading => const AssetGenImage('assets/images/loading.gif');

  /// File path: assets/images/notification.png
  AssetGenImage get notification =>
      const AssetGenImage('assets/images/notification.png');

  /// File path: assets/images/pump.png
  AssetGenImage get pump => const AssetGenImage('assets/images/pump.png');

  /// File path: assets/images/temperature.png
  AssetGenImage get temperature =>
      const AssetGenImage('assets/images/temperature.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [detector, gasStation, loading, notification, pump, temperature];
}

class Assets {
  Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsColorGen color = $AssetsColorGen();
  static const $AssetsFontGen font = $AssetsFontGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
