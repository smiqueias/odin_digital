import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

final class GtbColorScheme with Diagnosticable {
  const GtbColorScheme({
    required this.primaryBase,
    required this.primaryBaseInverse,
    required this.primaryExtended10,
    required this.primaryExtended20,
    required this.primaryExtended30,
    required this.primaryExtended40,
    required this.primaryExtended50,
    required this.primaryExtended60,
    required this.primaryExtended70,
    required this.primaryExtended80,
    required this.primaryExtended90,
    required this.primaryExtended100,
    required this.secondaryBase,
    required this.secondaryBaseInverse,
    required this.neutralBase,
    required this.neutralBaseInverse,
    required this.neutralExtended10,
    required this.neutralExtended20,
    required this.neutralExtended30,
    required this.neutralExtended40,
    required this.neutralExtended50,
    required this.neutralExtended60,
    required this.neutralExtended70,
    required this.neutralExtended80,
    required this.neutralExtended90,
    required this.neutralExtended100,
    required this.actionMainEnabled,
    required this.actionMainHover,
    required this.actionMainFocus,
    required this.actionMainPressed,
    required this.actionMainSelected,
    required this.actionMainEnabledInverse,
    required this.actionMainHoverInverse,
    required this.actionMainFocusInverse,
    required this.actionMainPressedInverse,
    required this.actionMainSelectedInverse,
    required this.actionMainEmphasisHigh,
    required this.actionMainEmphasisMedium,
    required this.actionMainEmphasisLow,
    required this.actionMainEmphasisHighInverse,
    required this.actionMainEmphasisMediumInverse,
    required this.actionMainEmphasisLowInverse,
    required this.actionSecondaryEnabled,
    required this.actionSecondaryHover,
    required this.actionSecondaryFocus,
    required this.actionSecondaryPressed,
    required this.actionSecondarySelected,
    required this.actionSecondaryEnabledInverse,
    required this.actionSecondaryHoverInverse,
    required this.actionSecondaryFocusInverse,
    required this.actionSecondaryPressedInverse,
    required this.actionSecondarySelectedInverse,
    required this.actionSecondaryEmphasisHigh,
    required this.actionSecondaryEmphasisMedium,
    required this.actionSecondaryEmphasisLow,
    required this.actionSecondaryEmphasisHighInverse,
    required this.actionSecondaryEmphasisMediumInverse,
    required this.actionSecondaryEmphasisLowInverse,
    required this.actionNeutralEnabled,
    required this.actionNeutralHover,
    required this.actionNeutralFocus,
    required this.actionNeutralPressed,
    required this.actionNeutralSelected,
    required this.actionNeutralEnabledInverse,
    required this.actionNeutralHoverInverse,
    required this.actionNeutralFocusInverse,
    required this.actionNeutralPressedInverse,
    required this.actionNeutralSelectedInverse,
    required this.actionNeutralEmphasisHigh,
    required this.actionNeutralEmphasisMedium,
    required this.actionNeutralEmphasisLow,
    required this.actionNeutralEmphasisHighInverse,
    required this.actionNeutralEmphasisMediumInverse,
    required this.actionNeutralEmphasisLowInverse,
    required this.actionDisabledBase,
    required this.actionDisabledBaseInverse,
    required this.onColorEmphasisHigh,
    required this.onColorEmphasisMedium,
    required this.onColorEmphasisLow,
    required this.onColorEmphasisDisabled,
    required this.onColorEmphasisHighInverse,
    required this.onColorEmphasisMediumInverse,
    required this.onColorEmphasisLowInverse,
    required this.onColorEmphasisDisabledInverse,
    required this.onColorIndicatorHighlightBase,
    required this.onColorIndicatorHighlightSurface,
    required this.onColorIndicatorHighlightBaseInverse,
    required this.onColorIndicatorHighlightSurfaceInverse,
    required this.onColorIndicatorPositiveBase,
    required this.onColorIndicatorPositiveSurface,
    required this.onColorIndicatorPositiveBaseInverse,
    required this.onColorIndicatorPositiveSurfaceInverse,
    required this.onColorIndicatorNegativeBase,
    required this.onColorIndicatorNegativeSurface,
    required this.onColorIndicatorNegativeBaseInverse,
    required this.onColorIndicatorNegativeSurfaceInverse,
    required this.statusSuccessBase,
    required this.statusSuccessBaseSurface,
    required this.statusSuccessBaseInverse,
    required this.statusSuccessBaseSurfaceInverse,
    required this.statusWarningBase,
    required this.statusWarningBaseSurface,
    required this.statusWarningBaseInverse,
    required this.statusWarningBaseSurfaceInverse,
    required this.statusErrorBase,
    required this.statusErrorBaseSurface,
    required this.statusErrorBaseInverse,
    required this.statusErrorBaseSurfaceInverse,
    required this.statusInformativeBase,
    required this.statusInformativeBaseSurface,
    required this.statusInformativeBaseInverse,
    required this.statusInformativeBaseSurfaceInverse,
    required this.outlineBase,
    required this.outlineBaseInverse,
    required this.outlineBaseFocus,
    required this.outlineBaseFocusInverse,
    required this.backgroundBase,
    required this.backgroundBaseInverse,
    required this.supportAqua10,
    required this.supportAqua20,
    required this.supportAqua30,
    required this.supportAqua40,
    required this.supportAqua50,
    required this.supportAqua60,
    required this.supportAqua70,
    required this.supportAqua80,
    required this.supportAqua90,
    required this.supportAqua100,
    required this.supportBlue10,
    required this.supportBlue20,
    required this.supportBlue30,
    required this.supportBlue40,
    required this.supportBlue50,
    required this.supportBlue60,
    required this.supportBlue70,
    required this.supportBlue80,
    required this.supportBlue90,
    required this.supportBlue100,
    required this.supportBrown10,
    required this.supportBrown20,
    required this.supportBrown30,
    required this.supportBrown40,
    required this.supportBrown50,
    required this.supportBrown60,
    required this.supportBrown70,
    required this.supportBrown80,
    required this.supportBrown90,
    required this.supportBrown100,
    required this.supportGreen10,
    required this.supportGreen20,
    required this.supportGreen30,
    required this.supportGreen40,
    required this.supportGreen50,
    required this.supportGreen60,
    required this.supportGreen70,
    required this.supportGreen80,
    required this.supportGreen90,
    required this.supportGreen100,
    required this.supportGrey10,
    required this.supportGrey20,
    required this.supportGrey30,
    required this.supportGrey40,
    required this.supportGrey50,
    required this.supportGrey60,
    required this.supportGrey70,
    required this.supportGrey80,
    required this.supportGrey90,
    required this.supportGrey100,
    required this.supportLime10,
    required this.supportLime20,
    required this.supportLime30,
    required this.supportLime40,
    required this.supportLime50,
    required this.supportLime60,
    required this.supportLime70,
    required this.supportLime80,
    required this.supportLime90,
    required this.supportLime100,
    required this.supportOrange10,
    required this.supportOrange20,
    required this.supportOrange30,
    required this.supportOrange40,
    required this.supportOrange50,
    required this.supportOrange60,
    required this.supportOrange70,
    required this.supportOrange80,
    required this.supportOrange90,
    required this.supportOrange100,
    required this.supportPink10,
    required this.supportPink20,
    required this.supportPink30,
    required this.supportPink40,
    required this.supportPink50,
    required this.supportPink60,
    required this.supportPink70,
    required this.supportPink80,
    required this.supportPink90,
    required this.supportPink100,
    required this.supportPurple10,
    required this.supportPurple20,
    required this.supportPurple30,
    required this.supportPurple40,
    required this.supportPurple50,
    required this.supportPurple60,
    required this.supportPurple70,
    required this.supportPurple80,
    required this.supportPurple90,
    required this.supportPurple100,
    required this.supportRed10,
    required this.supportRed20,
    required this.supportRed30,
    required this.supportRed40,
    required this.supportRed50,
    required this.supportRed60,
    required this.supportRed70,
    required this.supportRed80,
    required this.supportRed90,
    required this.supportRed100,
    required this.supportViolet10,
    required this.supportViolet20,
    required this.supportViolet30,
    required this.supportViolet40,
    required this.supportViolet50,
    required this.supportViolet60,
    required this.supportViolet70,
    required this.supportViolet80,
    required this.supportViolet90,
    required this.supportViolet100,
    required this.supportYellow10,
    required this.supportYellow20,
    required this.supportYellow30,
    required this.supportYellow40,
    required this.supportYellow50,
    required this.supportYellow60,
    required this.supportYellow70,
    required this.supportYellow80,
    required this.supportYellow90,
    required this.supportYellow100,
    required this.specialFixedWhite,
    required this.specialFixedBlack,
    required this.specialShimmerBaseStart,
    required this.specialShimmerBaseEnd,
    required this.specialShimmerBaseStartInverse,
    required this.specialShimmerBaseEndInverse,
    required this.surfaceBrand01,
    required this.surfaceBrand02,
    required this.surfaceBrand03,
    required this.surfaceBrand04,
    required this.surfaceBrand05,
    required this.surfaceBrandOnBrand01Disabled,
    required this.surfaceBrandOnBrand01Outline,
    required this.surfaceBrandOnBrand01ActionEnabled,
    required this.surfaceBrandOnBrand01ActionHover,
    required this.surfaceBrandOnBrand01ActionPressed,
    required this.surfaceBrandOnBrand01EmphasisHigh,
    required this.surfaceBrandOnBrand01EmphasisMedium,
    required this.surfaceBrandOnBrand01EmphasisLow,
    required this.surfaceBrandOnBrand02Disabled,
    required this.surfaceBrandOnBrand02Outline,
    required this.surfaceBrandOnBrand02ActionEnabled,
    required this.surfaceBrandOnBrand02ActionHover,
    required this.surfaceBrandOnBrand02ActionPressed,
    required this.surfaceBrandOnBrand02EmphasisHigh,
    required this.surfaceBrandOnBrand02EmphasisMedium,
    required this.surfaceBrandOnBrand02EmphasisLow,
    required this.surfaceBrandOnBrand03Disabled,
    required this.surfaceBrandOnBrand03Outline,
    required this.surfaceBrandOnBrand03ActionEnabled,
    required this.surfaceBrandOnBrand03ActionHover,
    required this.surfaceBrandOnBrand03ActionPressed,
    required this.surfaceBrandOnBrand03EmphasisHigh,
    required this.surfaceBrandOnBrand03EmphasisMedium,
    required this.surfaceBrandOnBrand03EmphasisLow,
    required this.surfaceBrandOnBrand04Disabled,
    required this.surfaceBrandOnBrand04Outline,
    required this.surfaceBrandOnBrand04ActionEnabled,
    required this.surfaceBrandOnBrand04ActionHover,
    required this.surfaceBrandOnBrand04ActionPressed,
    required this.surfaceBrandOnBrand04EmphasisHigh,
    required this.surfaceBrandOnBrand04EmphasisMedium,
    required this.surfaceBrandOnBrand04EmphasisLow,
    required this.surfaceBrandOnBrand05Disabled,
    required this.surfaceBrandOnBrand05Outline,
    required this.surfaceBrandOnBrand05ActionEnabled,
    required this.surfaceBrandOnBrand05ActionHover,
    required this.surfaceBrandOnBrand05ActionPressed,
    required this.surfaceBrandOnBrand05EmphasisHigh,
    required this.surfaceBrandOnBrand05EmphasisMedium,
    required this.surfaceBrandOnBrand05EmphasisLow,
    required this.elevationLow,
    required this.elevationMedium,
    required this.elevationHigh,
  });

  final Color primaryBase;
  final Color primaryBaseInverse;

  final Color primaryExtended10;
  final Color primaryExtended20;
  final Color primaryExtended30;
  final Color primaryExtended40;
  final Color primaryExtended50;
  final Color primaryExtended60;
  final Color primaryExtended70;
  final Color primaryExtended80;
  final Color primaryExtended90;
  final Color primaryExtended100;

  final Color secondaryBase;
  final Color secondaryBaseInverse;

  final Color neutralBase;
  final Color neutralBaseInverse;

  final Color neutralExtended10;
  final Color neutralExtended20;
  final Color neutralExtended30;
  final Color neutralExtended40;
  final Color neutralExtended50;
  final Color neutralExtended60;
  final Color neutralExtended70;
  final Color neutralExtended80;
  final Color neutralExtended90;
  final Color neutralExtended100;

  final Color actionMainEnabled;
  final Color actionMainHover;
  final Color actionMainFocus;
  final Color actionMainPressed;
  final Color actionMainSelected;

  final Color actionMainEnabledInverse;
  final Color actionMainHoverInverse;
  final Color actionMainFocusInverse;
  final Color actionMainPressedInverse;
  final Color actionMainSelectedInverse;

  final Color actionMainEmphasisHigh;
  final Color actionMainEmphasisMedium;
  final Color actionMainEmphasisLow;
  final Color actionMainEmphasisHighInverse;
  final Color actionMainEmphasisMediumInverse;
  final Color actionMainEmphasisLowInverse;

  final Color actionSecondaryEnabled;
  final Color actionSecondaryHover;
  final Color actionSecondaryFocus;
  final Color actionSecondaryPressed;
  final Color actionSecondarySelected;

  final Color actionSecondaryEnabledInverse;
  final Color actionSecondaryHoverInverse;
  final Color actionSecondaryFocusInverse;
  final Color actionSecondaryPressedInverse;
  final Color actionSecondarySelectedInverse;

  final Color actionSecondaryEmphasisHigh;
  final Color actionSecondaryEmphasisMedium;
  final Color actionSecondaryEmphasisLow;
  final Color actionSecondaryEmphasisHighInverse;
  final Color actionSecondaryEmphasisMediumInverse;
  final Color actionSecondaryEmphasisLowInverse;

  final Color actionNeutralEnabled;
  final Color actionNeutralHover;
  final Color actionNeutralFocus;
  final Color actionNeutralPressed;
  final Color actionNeutralSelected;

  final Color actionNeutralEnabledInverse;
  final Color actionNeutralHoverInverse;
  final Color actionNeutralFocusInverse;
  final Color actionNeutralPressedInverse;
  final Color actionNeutralSelectedInverse;

  final Color actionNeutralEmphasisHigh;
  final Color actionNeutralEmphasisMedium;
  final Color actionNeutralEmphasisLow;
  final Color actionNeutralEmphasisHighInverse;
  final Color actionNeutralEmphasisMediumInverse;
  final Color actionNeutralEmphasisLowInverse;

  final Color actionDisabledBase;
  final Color actionDisabledBaseInverse;

  final Color onColorEmphasisHigh;
  final Color onColorEmphasisMedium;
  final Color onColorEmphasisLow;
  final Color onColorEmphasisDisabled;
  final Color onColorEmphasisHighInverse;
  final Color onColorEmphasisMediumInverse;
  final Color onColorEmphasisLowInverse;
  final Color onColorEmphasisDisabledInverse;

  final Color onColorIndicatorHighlightBase;
  final Color onColorIndicatorHighlightSurface;
  final Color onColorIndicatorHighlightBaseInverse;
  final Color onColorIndicatorHighlightSurfaceInverse;
  final Color onColorIndicatorPositiveBase;
  final Color onColorIndicatorPositiveSurface;
  final Color onColorIndicatorPositiveBaseInverse;
  final Color onColorIndicatorPositiveSurfaceInverse;
  final Color onColorIndicatorNegativeBase;
  final Color onColorIndicatorNegativeSurface;
  final Color onColorIndicatorNegativeBaseInverse;
  final Color onColorIndicatorNegativeSurfaceInverse;

  final Color statusSuccessBase;
  final Color statusSuccessBaseSurface;
  final Color statusSuccessBaseInverse;
  final Color statusSuccessBaseSurfaceInverse;

  final Color statusWarningBase;
  final Color statusWarningBaseSurface;
  final Color statusWarningBaseInverse;
  final Color statusWarningBaseSurfaceInverse;

  final Color statusErrorBase;
  final Color statusErrorBaseSurface;
  final Color statusErrorBaseInverse;
  final Color statusErrorBaseSurfaceInverse;

  final Color statusInformativeBase;
  final Color statusInformativeBaseSurface;
  final Color statusInformativeBaseInverse;
  final Color statusInformativeBaseSurfaceInverse;

  final Color outlineBase;
  final Color outlineBaseInverse;
  final Color outlineBaseFocus;
  final Color outlineBaseFocusInverse;

  final Color backgroundBase;
  final Color backgroundBaseInverse;

  final Color supportAqua10;
  final Color supportAqua20;
  final Color supportAqua30;
  final Color supportAqua40;
  final Color supportAqua50;
  final Color supportAqua60;
  final Color supportAqua70;
  final Color supportAqua80;
  final Color supportAqua90;
  final Color supportAqua100;

  final Color supportBlue10;
  final Color supportBlue20;
  final Color supportBlue30;
  final Color supportBlue40;
  final Color supportBlue50;
  final Color supportBlue60;
  final Color supportBlue70;
  final Color supportBlue80;
  final Color supportBlue90;
  final Color supportBlue100;

  final Color supportBrown10;
  final Color supportBrown20;
  final Color supportBrown30;
  final Color supportBrown40;
  final Color supportBrown50;
  final Color supportBrown60;
  final Color supportBrown70;
  final Color supportBrown80;
  final Color supportBrown90;
  final Color supportBrown100;

  final Color supportGreen10;
  final Color supportGreen20;
  final Color supportGreen30;
  final Color supportGreen40;
  final Color supportGreen50;
  final Color supportGreen60;
  final Color supportGreen70;
  final Color supportGreen80;
  final Color supportGreen90;
  final Color supportGreen100;

  final Color supportGrey10;
  final Color supportGrey20;
  final Color supportGrey30;
  final Color supportGrey40;
  final Color supportGrey50;
  final Color supportGrey60;
  final Color supportGrey70;
  final Color supportGrey80;
  final Color supportGrey90;
  final Color supportGrey100;

  final Color supportLime10;
  final Color supportLime20;
  final Color supportLime30;
  final Color supportLime40;
  final Color supportLime50;
  final Color supportLime60;
  final Color supportLime70;
  final Color supportLime80;
  final Color supportLime90;
  final Color supportLime100;

  final Color supportOrange10;
  final Color supportOrange20;
  final Color supportOrange30;
  final Color supportOrange40;
  final Color supportOrange50;
  final Color supportOrange60;
  final Color supportOrange70;
  final Color supportOrange80;
  final Color supportOrange90;
  final Color supportOrange100;

  final Color supportPink10;
  final Color supportPink20;
  final Color supportPink30;
  final Color supportPink40;
  final Color supportPink50;
  final Color supportPink60;
  final Color supportPink70;
  final Color supportPink80;
  final Color supportPink90;
  final Color supportPink100;

  final Color supportPurple10;
  final Color supportPurple20;
  final Color supportPurple30;
  final Color supportPurple40;
  final Color supportPurple50;
  final Color supportPurple60;
  final Color supportPurple70;
  final Color supportPurple80;
  final Color supportPurple90;
  final Color supportPurple100;

  final Color supportRed10;
  final Color supportRed20;
  final Color supportRed30;
  final Color supportRed40;
  final Color supportRed50;
  final Color supportRed60;
  final Color supportRed70;
  final Color supportRed80;
  final Color supportRed90;
  final Color supportRed100;

  final Color supportViolet10;
  final Color supportViolet20;
  final Color supportViolet30;
  final Color supportViolet40;
  final Color supportViolet50;
  final Color supportViolet60;
  final Color supportViolet70;
  final Color supportViolet80;
  final Color supportViolet90;
  final Color supportViolet100;

  final Color supportYellow10;
  final Color supportYellow20;
  final Color supportYellow30;
  final Color supportYellow40;
  final Color supportYellow50;
  final Color supportYellow60;
  final Color supportYellow70;
  final Color supportYellow80;
  final Color supportYellow90;
  final Color supportYellow100;

  final Color specialFixedWhite;
  final Color specialFixedBlack;

  final Color specialShimmerBaseStart;
  final Color specialShimmerBaseEnd;
  final Color specialShimmerBaseStartInverse;
  final Color specialShimmerBaseEndInverse;

  final Color surfaceBrand01;
  final Color surfaceBrand02;
  final Color surfaceBrand03;
  final Color surfaceBrand04;
  final Color surfaceBrand05;

  final Color surfaceBrandOnBrand01Disabled;
  final Color surfaceBrandOnBrand01Outline;
  final Color surfaceBrandOnBrand01ActionEnabled;
  final Color surfaceBrandOnBrand01ActionHover;
  final Color surfaceBrandOnBrand01ActionPressed;
  final Color surfaceBrandOnBrand01EmphasisHigh;
  final Color surfaceBrandOnBrand01EmphasisMedium;
  final Color surfaceBrandOnBrand01EmphasisLow;

  final Color surfaceBrandOnBrand02Disabled;
  final Color surfaceBrandOnBrand02Outline;
  final Color surfaceBrandOnBrand02ActionEnabled;
  final Color surfaceBrandOnBrand02ActionHover;
  final Color surfaceBrandOnBrand02ActionPressed;
  final Color surfaceBrandOnBrand02EmphasisHigh;
  final Color surfaceBrandOnBrand02EmphasisMedium;
  final Color surfaceBrandOnBrand02EmphasisLow;

  final Color surfaceBrandOnBrand03Disabled;
  final Color surfaceBrandOnBrand03Outline;
  final Color surfaceBrandOnBrand03ActionEnabled;
  final Color surfaceBrandOnBrand03ActionHover;
  final Color surfaceBrandOnBrand03ActionPressed;
  final Color surfaceBrandOnBrand03EmphasisHigh;
  final Color surfaceBrandOnBrand03EmphasisMedium;
  final Color surfaceBrandOnBrand03EmphasisLow;

  final Color surfaceBrandOnBrand04Disabled;
  final Color surfaceBrandOnBrand04Outline;
  final Color surfaceBrandOnBrand04ActionEnabled;
  final Color surfaceBrandOnBrand04ActionHover;
  final Color surfaceBrandOnBrand04ActionPressed;
  final Color surfaceBrandOnBrand04EmphasisHigh;
  final Color surfaceBrandOnBrand04EmphasisMedium;
  final Color surfaceBrandOnBrand04EmphasisLow;

  final Color surfaceBrandOnBrand05Disabled;
  final Color surfaceBrandOnBrand05Outline;
  final Color surfaceBrandOnBrand05ActionEnabled;
  final Color surfaceBrandOnBrand05ActionHover;
  final Color surfaceBrandOnBrand05ActionPressed;
  final Color surfaceBrandOnBrand05EmphasisHigh;
  final Color surfaceBrandOnBrand05EmphasisMedium;
  final Color surfaceBrandOnBrand05EmphasisLow;

  final List<BoxShadow> elevationLow;
  final List<BoxShadow> elevationMedium;
  final List<BoxShadow> elevationHigh;

  LinearGradient get specialShimmerBase {
    return LinearGradient(
      colors: [
        specialShimmerBaseStart,
        specialShimmerBaseEnd,
      ],
    );
  }

  LinearGradient get specialShimmerBaseInverse {
    return LinearGradient(
      colors: [
        specialShimmerBaseStartInverse,
        specialShimmerBaseEndInverse,
      ],
    );
  }

  GtbColorScheme copyWith({
    Color? primaryBase,
    Color? primaryBaseInverse,
    Color? primaryExtended10,
    Color? primaryExtended20,
    Color? primaryExtended30,
    Color? primaryExtended40,
    Color? primaryExtended50,
    Color? primaryExtended60,
    Color? primaryExtended70,
    Color? primaryExtended80,
    Color? primaryExtended90,
    Color? primaryExtended100,
    Color? secondaryBase,
    Color? secondaryBaseInverse,
    Color? neutralBase,
    Color? neutralBaseInverse,
    Color? neutralExtended10,
    Color? neutralExtended20,
    Color? neutralExtended30,
    Color? neutralExtended40,
    Color? neutralExtended50,
    Color? neutralExtended60,
    Color? neutralExtended70,
    Color? neutralExtended80,
    Color? neutralExtended90,
    Color? neutralExtended100,
    Color? actionMainEnabled,
    Color? actionMainHover,
    Color? actionMainFocus,
    Color? actionMainPressed,
    Color? actionMainSelected,
    Color? actionMainEnabledInverse,
    Color? actionMainHoverInverse,
    Color? actionMainFocusInverse,
    Color? actionMainPressedInverse,
    Color? actionMainSelectedInverse,
    Color? actionMainEmphasisHigh,
    Color? actionMainEmphasisMedium,
    Color? actionMainEmphasisLow,
    Color? actionMainEmphasisHighInverse,
    Color? actionMainEmphasisMediumInverse,
    Color? actionMainEmphasisLowInverse,
    Color? actionSecondaryEnabled,
    Color? actionSecondaryHover,
    Color? actionSecondaryFocus,
    Color? actionSecondaryPressed,
    Color? actionSecondarySelected,
    Color? actionSecondaryEnabledInverse,
    Color? actionSecondaryHoverInverse,
    Color? actionSecondaryFocusInverse,
    Color? actionSecondaryPressedInverse,
    Color? actionSecondarySelectedInverse,
    Color? actionSecondaryEmphasisHigh,
    Color? actionSecondaryEmphasisMedium,
    Color? actionSecondaryEmphasisLow,
    Color? actionSecondaryEmphasisHighInverse,
    Color? actionSecondaryEmphasisMediumInverse,
    Color? actionSecondaryEmphasisLowInverse,
    Color? actionNeutralEnabled,
    Color? actionNeutralHover,
    Color? actionNeutralFocus,
    Color? actionNeutralPressed,
    Color? actionNeutralSelected,
    Color? actionNeutralEnabledInverse,
    Color? actionNeutralHoverInverse,
    Color? actionNeutralFocusInverse,
    Color? actionNeutralPressedInverse,
    Color? actionNeutralSelectedInverse,
    Color? actionNeutralEmphasisHigh,
    Color? actionNeutralEmphasisMedium,
    Color? actionNeutralEmphasisLow,
    Color? actionNeutralEmphasisHighInverse,
    Color? actionNeutralEmphasisMediumInverse,
    Color? actionNeutralEmphasisLowInverse,
    Color? actionDisabledBase,
    Color? actionDisabledBaseInverse,
    Color? onColorEmphasisHigh,
    Color? onColorEmphasisMedium,
    Color? onColorEmphasisLow,
    Color? onColorEmphasisDisabled,
    Color? onColorEmphasisHighInverse,
    Color? onColorEmphasisMediumInverse,
    Color? onColorEmphasisLowInverse,
    Color? onColorEmphasisDisabledInverse,
    Color? onColorIndicatorHighlightBase,
    Color? onColorIndicatorHighlightSurface,
    Color? onColorIndicatorHighlightBaseInverse,
    Color? onColorIndicatorHighlightSurfaceInverse,
    Color? onColorIndicatorPositiveBase,
    Color? onColorIndicatorPositiveSurface,
    Color? onColorIndicatorPositiveBaseInverse,
    Color? onColorIndicatorPositiveSurfaceInverse,
    Color? onColorIndicatorNegativeBase,
    Color? onColorIndicatorNegativeSurface,
    Color? onColorIndicatorNegativeBaseInverse,
    Color? onColorIndicatorNegativeSurfaceInverse,
    Color? statusSuccessBase,
    Color? statusSuccessBaseSurface,
    Color? statusSuccessBaseInverse,
    Color? statusSuccessBaseSurfaceInverse,
    Color? statusWarningBase,
    Color? statusWarningBaseSurface,
    Color? statusWarningBaseInverse,
    Color? statusWarningBaseSurfaceInverse,
    Color? statusErrorBase,
    Color? statusErrorBaseSurface,
    Color? statusErrorBaseInverse,
    Color? statusErrorBaseSurfaceInverse,
    Color? statusInformativeBase,
    Color? statusInformativeBaseSurface,
    Color? statusInformativeBaseInverse,
    Color? statusInformativeBaseSurfaceInverse,
    Color? outlineBase,
    Color? outlineBaseInverse,
    Color? outlineBaseFocus,
    Color? outlineBaseFocusInverse,
    Color? backgroundBase,
    Color? backgroundBaseInverse,
    Color? supportAqua10,
    Color? supportAqua20,
    Color? supportAqua30,
    Color? supportAqua40,
    Color? supportAqua50,
    Color? supportAqua60,
    Color? supportAqua70,
    Color? supportAqua80,
    Color? supportAqua90,
    Color? supportAqua100,
    Color? supportBlue10,
    Color? supportBlue20,
    Color? supportBlue30,
    Color? supportBlue40,
    Color? supportBlue50,
    Color? supportBlue60,
    Color? supportBlue70,
    Color? supportBlue80,
    Color? supportBlue90,
    Color? supportBlue100,
    Color? supportBrown10,
    Color? supportBrown20,
    Color? supportBrown30,
    Color? supportBrown40,
    Color? supportBrown50,
    Color? supportBrown60,
    Color? supportBrown70,
    Color? supportBrown80,
    Color? supportBrown90,
    Color? supportBrown100,
    Color? supportGreen10,
    Color? supportGreen20,
    Color? supportGreen30,
    Color? supportGreen40,
    Color? supportGreen50,
    Color? supportGreen60,
    Color? supportGreen70,
    Color? supportGreen80,
    Color? supportGreen90,
    Color? supportGreen100,
    Color? supportGrey10,
    Color? supportGrey20,
    Color? supportGrey30,
    Color? supportGrey40,
    Color? supportGrey50,
    Color? supportGrey60,
    Color? supportGrey70,
    Color? supportGrey80,
    Color? supportGrey90,
    Color? supportGrey100,
    Color? supportLime10,
    Color? supportLime20,
    Color? supportLime30,
    Color? supportLime40,
    Color? supportLime50,
    Color? supportLime60,
    Color? supportLime70,
    Color? supportLime80,
    Color? supportLime90,
    Color? supportLime100,
    Color? supportOrange10,
    Color? supportOrange20,
    Color? supportOrange30,
    Color? supportOrange40,
    Color? supportOrange50,
    Color? supportOrange60,
    Color? supportOrange70,
    Color? supportOrange80,
    Color? supportOrange90,
    Color? supportOrange100,
    Color? supportPink10,
    Color? supportPink20,
    Color? supportPink30,
    Color? supportPink40,
    Color? supportPink50,
    Color? supportPink60,
    Color? supportPink70,
    Color? supportPink80,
    Color? supportPink90,
    Color? supportPink100,
    Color? supportPurple10,
    Color? supportPurple20,
    Color? supportPurple30,
    Color? supportPurple40,
    Color? supportPurple50,
    Color? supportPurple60,
    Color? supportPurple70,
    Color? supportPurple80,
    Color? supportPurple90,
    Color? supportPurple100,
    Color? supportRed10,
    Color? supportRed20,
    Color? supportRed30,
    Color? supportRed40,
    Color? supportRed50,
    Color? supportRed60,
    Color? supportRed70,
    Color? supportRed80,
    Color? supportRed90,
    Color? supportRed100,
    Color? supportViolet10,
    Color? supportViolet20,
    Color? supportViolet30,
    Color? supportViolet40,
    Color? supportViolet50,
    Color? supportViolet60,
    Color? supportViolet70,
    Color? supportViolet80,
    Color? supportViolet90,
    Color? supportViolet100,
    Color? supportYellow10,
    Color? supportYellow20,
    Color? supportYellow30,
    Color? supportYellow40,
    Color? supportYellow50,
    Color? supportYellow60,
    Color? supportYellow70,
    Color? supportYellow80,
    Color? supportYellow90,
    Color? supportYellow100,
    Color? specialFixedWhite,
    Color? specialFixedBlack,
    Color? specialShimmerBaseStart,
    Color? specialShimmerBaseEnd,
    Color? specialShimmerBaseStartInverse,
    Color? specialShimmerBaseEndInverse,
    Color? surfaceBrand01,
    Color? surfaceBrand02,
    Color? surfaceBrand03,
    Color? surfaceBrand04,
    Color? surfaceBrand05,
    Color? surfaceBrandOnBrand01Disabled,
    Color? surfaceBrandOnBrand01Outline,
    Color? surfaceBrandOnBrand01ActionEnabled,
    Color? surfaceBrandOnBrand01ActionHover,
    Color? surfaceBrandOnBrand01ActionPressed,
    Color? surfaceBrandOnBrand01EmphasisHigh,
    Color? surfaceBrandOnBrand01EmphasisMedium,
    Color? surfaceBrandOnBrand01EmphasisLow,
    Color? surfaceBrandOnBrand02Disabled,
    Color? surfaceBrandOnBrand02Outline,
    Color? surfaceBrandOnBrand02ActionEnabled,
    Color? surfaceBrandOnBrand02ActionHover,
    Color? surfaceBrandOnBrand02ActionPressed,
    Color? surfaceBrandOnBrand02EmphasisHigh,
    Color? surfaceBrandOnBrand02EmphasisMedium,
    Color? surfaceBrandOnBrand02EmphasisLow,
    Color? surfaceBrandOnBrand03Disabled,
    Color? surfaceBrandOnBrand03Outline,
    Color? surfaceBrandOnBrand03ActionEnabled,
    Color? surfaceBrandOnBrand03ActionHover,
    Color? surfaceBrandOnBrand03ActionPressed,
    Color? surfaceBrandOnBrand03EmphasisHigh,
    Color? surfaceBrandOnBrand03EmphasisMedium,
    Color? surfaceBrandOnBrand03EmphasisLow,
    Color? surfaceBrandOnBrand04Disabled,
    Color? surfaceBrandOnBrand04Outline,
    Color? surfaceBrandOnBrand04ActionEnabled,
    Color? surfaceBrandOnBrand04ActionHover,
    Color? surfaceBrandOnBrand04ActionPressed,
    Color? surfaceBrandOnBrand04EmphasisHigh,
    Color? surfaceBrandOnBrand04EmphasisMedium,
    Color? surfaceBrandOnBrand04EmphasisLow,
    Color? surfaceBrandOnBrand05Disabled,
    Color? surfaceBrandOnBrand05Outline,
    Color? surfaceBrandOnBrand05ActionEnabled,
    Color? surfaceBrandOnBrand05ActionHover,
    Color? surfaceBrandOnBrand05ActionPressed,
    Color? surfaceBrandOnBrand05EmphasisHigh,
    Color? surfaceBrandOnBrand05EmphasisMedium,
    Color? surfaceBrandOnBrand05EmphasisLow,
    List<BoxShadow>? elevationLow,
    List<BoxShadow>? elevationMedium,
    List<BoxShadow>? elevationHigh,
  }) {
    return GtbColorScheme(
      primaryBase: primaryBase ?? this.primaryBase,
      primaryBaseInverse: primaryBaseInverse ?? this.primaryBaseInverse,
      primaryExtended10: primaryExtended10 ?? this.primaryExtended10,
      primaryExtended20: primaryExtended20 ?? this.primaryExtended20,
      primaryExtended30: primaryExtended30 ?? this.primaryExtended30,
      primaryExtended40: primaryExtended40 ?? this.primaryExtended40,
      primaryExtended50: primaryExtended50 ?? this.primaryExtended50,
      primaryExtended60: primaryExtended60 ?? this.primaryExtended60,
      primaryExtended70: primaryExtended70 ?? this.primaryExtended70,
      primaryExtended80: primaryExtended80 ?? this.primaryExtended80,
      primaryExtended90: primaryExtended90 ?? this.primaryExtended90,
      primaryExtended100: primaryExtended100 ?? this.primaryExtended100,
      secondaryBase: secondaryBase ?? this.secondaryBase,
      secondaryBaseInverse: secondaryBaseInverse ?? this.secondaryBaseInverse,
      neutralBase: neutralBase ?? this.neutralBase,
      neutralBaseInverse: neutralBaseInverse ?? this.neutralBaseInverse,
      neutralExtended10: neutralExtended10 ?? this.neutralExtended10,
      neutralExtended20: neutralExtended20 ?? this.neutralExtended20,
      neutralExtended30: neutralExtended30 ?? this.neutralExtended30,
      neutralExtended40: neutralExtended40 ?? this.neutralExtended40,
      neutralExtended50: neutralExtended50 ?? this.neutralExtended50,
      neutralExtended60: neutralExtended60 ?? this.neutralExtended60,
      neutralExtended70: neutralExtended70 ?? this.neutralExtended70,
      neutralExtended80: neutralExtended80 ?? this.neutralExtended80,
      neutralExtended90: neutralExtended90 ?? this.neutralExtended90,
      neutralExtended100: neutralExtended100 ?? this.neutralExtended100,
      actionMainEnabled: actionMainEnabled ?? this.actionMainEnabled,
      actionMainHover: actionMainHover ?? this.actionMainHover,
      actionMainFocus: actionMainFocus ?? this.actionMainFocus,
      actionMainPressed: actionMainPressed ?? this.actionMainPressed,
      actionMainSelected: actionMainSelected ?? this.actionMainSelected,
      actionMainEnabledInverse: actionMainEnabledInverse ?? this.actionMainEnabledInverse,
      actionMainHoverInverse: actionMainHoverInverse ?? this.actionMainHoverInverse,
      actionMainFocusInverse: actionMainFocusInverse ?? this.actionMainFocusInverse,
      actionMainPressedInverse: actionMainPressedInverse ?? this.actionMainPressedInverse,
      actionMainSelectedInverse: actionMainSelectedInverse ?? this.actionMainSelectedInverse,
      actionMainEmphasisHigh: actionMainEmphasisHigh ?? this.actionMainEmphasisHigh,
      actionMainEmphasisMedium: actionMainEmphasisMedium ?? this.actionMainEmphasisMedium,
      actionMainEmphasisLow: actionMainEmphasisLow ?? this.actionMainEmphasisLow,
      actionMainEmphasisHighInverse:
          actionMainEmphasisHighInverse ?? this.actionMainEmphasisHighInverse,
      actionMainEmphasisMediumInverse:
          actionMainEmphasisMediumInverse ?? this.actionMainEmphasisMediumInverse,
      actionMainEmphasisLowInverse:
          actionMainEmphasisLowInverse ?? this.actionMainEmphasisLowInverse,
      actionSecondaryEnabled: actionSecondaryEnabled ?? this.actionSecondaryEnabled,
      actionSecondaryHover: actionSecondaryHover ?? this.actionSecondaryHover,
      actionSecondaryFocus: actionSecondaryFocus ?? this.actionSecondaryFocus,
      actionSecondaryPressed: actionSecondaryPressed ?? this.actionSecondaryPressed,
      actionSecondarySelected: actionSecondarySelected ?? this.actionSecondarySelected,
      actionSecondaryEnabledInverse:
          actionSecondaryEnabledInverse ?? this.actionSecondaryEnabledInverse,
      actionSecondaryHoverInverse: actionSecondaryHoverInverse ?? this.actionSecondaryHoverInverse,
      actionSecondaryFocusInverse: actionSecondaryFocusInverse ?? this.actionSecondaryFocusInverse,
      actionSecondaryPressedInverse:
          actionSecondaryPressedInverse ?? this.actionSecondaryPressedInverse,
      actionSecondarySelectedInverse:
          actionSecondarySelectedInverse ?? this.actionSecondarySelectedInverse,
      actionSecondaryEmphasisHigh: actionSecondaryEmphasisHigh ?? this.actionSecondaryEmphasisHigh,
      actionSecondaryEmphasisMedium:
          actionSecondaryEmphasisMedium ?? this.actionSecondaryEmphasisMedium,
      actionSecondaryEmphasisLow: actionSecondaryEmphasisLow ?? this.actionSecondaryEmphasisLow,
      actionSecondaryEmphasisHighInverse:
          actionSecondaryEmphasisHighInverse ?? this.actionSecondaryEmphasisHighInverse,
      actionSecondaryEmphasisMediumInverse:
          actionSecondaryEmphasisMediumInverse ?? this.actionSecondaryEmphasisMediumInverse,
      actionSecondaryEmphasisLowInverse:
          actionSecondaryEmphasisLowInverse ?? this.actionSecondaryEmphasisLowInverse,
      actionNeutralEnabled: actionNeutralEnabled ?? this.actionNeutralEnabled,
      actionNeutralHover: actionNeutralHover ?? this.actionNeutralHover,
      actionNeutralFocus: actionNeutralFocus ?? this.actionNeutralFocus,
      actionNeutralPressed: actionNeutralPressed ?? this.actionNeutralPressed,
      actionNeutralSelected: actionNeutralSelected ?? this.actionNeutralSelected,
      actionNeutralEnabledInverse: actionNeutralEnabledInverse ?? this.actionNeutralEnabledInverse,
      actionNeutralHoverInverse: actionNeutralHoverInverse ?? this.actionNeutralHoverInverse,
      actionNeutralFocusInverse: actionNeutralFocusInverse ?? this.actionNeutralFocusInverse,
      actionNeutralPressedInverse: actionNeutralPressedInverse ?? this.actionNeutralPressedInverse,
      actionNeutralSelectedInverse:
          actionNeutralSelectedInverse ?? this.actionNeutralSelectedInverse,
      actionNeutralEmphasisHigh: actionNeutralEmphasisHigh ?? this.actionNeutralEmphasisHigh,
      actionNeutralEmphasisMedium: actionNeutralEmphasisMedium ?? this.actionNeutralEmphasisMedium,
      actionNeutralEmphasisLow: actionNeutralEmphasisLow ?? this.actionNeutralEmphasisLow,
      actionNeutralEmphasisHighInverse:
          actionNeutralEmphasisHighInverse ?? this.actionNeutralEmphasisHighInverse,
      actionNeutralEmphasisMediumInverse:
          actionNeutralEmphasisMediumInverse ?? this.actionNeutralEmphasisMediumInverse,
      actionNeutralEmphasisLowInverse:
          actionNeutralEmphasisLowInverse ?? this.actionNeutralEmphasisLowInverse,
      actionDisabledBase: actionDisabledBase ?? this.actionDisabledBase,
      actionDisabledBaseInverse: actionDisabledBaseInverse ?? this.actionDisabledBaseInverse,
      onColorEmphasisHigh: onColorEmphasisHigh ?? this.onColorEmphasisHigh,
      onColorEmphasisMedium: onColorEmphasisMedium ?? this.onColorEmphasisMedium,
      onColorEmphasisLow: onColorEmphasisLow ?? this.onColorEmphasisLow,
      onColorEmphasisDisabled: onColorEmphasisDisabled ?? this.onColorEmphasisDisabled,
      onColorEmphasisHighInverse: onColorEmphasisHighInverse ?? this.onColorEmphasisHighInverse,
      onColorEmphasisMediumInverse:
          onColorEmphasisMediumInverse ?? this.onColorEmphasisMediumInverse,
      onColorEmphasisLowInverse: onColorEmphasisLowInverse ?? this.onColorEmphasisLowInverse,
      onColorEmphasisDisabledInverse:
          onColorEmphasisDisabledInverse ?? this.onColorEmphasisDisabledInverse,
      onColorIndicatorHighlightBase:
          onColorIndicatorHighlightBase ?? this.onColorIndicatorHighlightBase,
      onColorIndicatorHighlightSurface:
          onColorIndicatorHighlightSurface ?? this.onColorIndicatorHighlightSurface,
      onColorIndicatorHighlightBaseInverse:
          onColorIndicatorHighlightBaseInverse ?? this.onColorIndicatorHighlightBaseInverse,
      onColorIndicatorHighlightSurfaceInverse:
          onColorIndicatorHighlightSurfaceInverse ?? this.onColorIndicatorHighlightSurfaceInverse,
      onColorIndicatorPositiveBase:
          onColorIndicatorPositiveBase ?? this.onColorIndicatorPositiveBase,
      onColorIndicatorPositiveSurface:
          onColorIndicatorPositiveSurface ?? this.onColorIndicatorPositiveSurface,
      onColorIndicatorPositiveBaseInverse:
          onColorIndicatorPositiveBaseInverse ?? this.onColorIndicatorPositiveBaseInverse,
      onColorIndicatorPositiveSurfaceInverse:
          onColorIndicatorPositiveSurfaceInverse ?? this.onColorIndicatorPositiveSurfaceInverse,
      onColorIndicatorNegativeBase:
          onColorIndicatorNegativeBase ?? this.onColorIndicatorNegativeBase,
      onColorIndicatorNegativeSurface:
          onColorIndicatorNegativeSurface ?? this.onColorIndicatorNegativeSurface,
      onColorIndicatorNegativeBaseInverse:
          onColorIndicatorNegativeBaseInverse ?? this.onColorIndicatorNegativeBaseInverse,
      onColorIndicatorNegativeSurfaceInverse:
          onColorIndicatorNegativeSurfaceInverse ?? this.onColorIndicatorNegativeSurfaceInverse,
      statusSuccessBase: statusSuccessBase ?? this.statusSuccessBase,
      statusSuccessBaseSurface: statusSuccessBaseSurface ?? this.statusSuccessBaseSurface,
      statusSuccessBaseInverse: statusSuccessBaseInverse ?? this.statusSuccessBaseInverse,
      statusSuccessBaseSurfaceInverse:
          statusSuccessBaseSurfaceInverse ?? this.statusSuccessBaseSurfaceInverse,
      statusWarningBase: statusWarningBase ?? this.statusWarningBase,
      statusWarningBaseSurface: statusWarningBaseSurface ?? this.statusWarningBaseSurface,
      statusWarningBaseInverse: statusWarningBaseInverse ?? this.statusWarningBaseInverse,
      statusWarningBaseSurfaceInverse:
          statusWarningBaseSurfaceInverse ?? this.statusWarningBaseSurfaceInverse,
      statusErrorBase: statusErrorBase ?? this.statusErrorBase,
      statusErrorBaseSurface: statusErrorBaseSurface ?? this.statusErrorBaseSurface,
      statusErrorBaseInverse: statusErrorBaseInverse ?? this.statusErrorBaseInverse,
      statusErrorBaseSurfaceInverse:
          statusErrorBaseSurfaceInverse ?? this.statusErrorBaseSurfaceInverse,
      statusInformativeBase: statusInformativeBase ?? this.statusInformativeBase,
      statusInformativeBaseSurface:
          statusInformativeBaseSurface ?? this.statusInformativeBaseSurface,
      statusInformativeBaseInverse:
          statusInformativeBaseInverse ?? this.statusInformativeBaseInverse,
      statusInformativeBaseSurfaceInverse:
          statusInformativeBaseSurfaceInverse ?? this.statusInformativeBaseSurfaceInverse,
      outlineBase: outlineBase ?? this.outlineBase,
      outlineBaseInverse: outlineBaseInverse ?? this.outlineBaseInverse,
      outlineBaseFocus: outlineBaseFocus ?? this.outlineBaseFocus,
      outlineBaseFocusInverse: outlineBaseFocusInverse ?? this.outlineBaseFocusInverse,
      backgroundBase: backgroundBase ?? this.backgroundBase,
      backgroundBaseInverse: backgroundBaseInverse ?? this.backgroundBaseInverse,
      supportAqua10: supportAqua10 ?? this.supportAqua10,
      supportAqua20: supportAqua20 ?? this.supportAqua20,
      supportAqua30: supportAqua30 ?? this.supportAqua30,
      supportAqua40: supportAqua40 ?? this.supportAqua40,
      supportAqua50: supportAqua50 ?? this.supportAqua50,
      supportAqua60: supportAqua60 ?? this.supportAqua60,
      supportAqua70: supportAqua70 ?? this.supportAqua70,
      supportAqua80: supportAqua80 ?? this.supportAqua80,
      supportAqua90: supportAqua90 ?? this.supportAqua90,
      supportAqua100: supportAqua100 ?? this.supportAqua100,
      supportBlue10: supportBlue10 ?? this.supportBlue10,
      supportBlue20: supportBlue20 ?? this.supportBlue20,
      supportBlue30: supportBlue30 ?? this.supportBlue30,
      supportBlue40: supportBlue40 ?? this.supportBlue40,
      supportBlue50: supportBlue50 ?? this.supportBlue50,
      supportBlue60: supportBlue60 ?? this.supportBlue60,
      supportBlue70: supportBlue70 ?? this.supportBlue70,
      supportBlue80: supportBlue80 ?? this.supportBlue80,
      supportBlue90: supportBlue90 ?? this.supportBlue90,
      supportBlue100: supportBlue100 ?? this.supportBlue100,
      supportBrown10: supportBrown10 ?? this.supportBrown10,
      supportBrown20: supportBrown20 ?? this.supportBrown20,
      supportBrown30: supportBrown30 ?? this.supportBrown30,
      supportBrown40: supportBrown40 ?? this.supportBrown40,
      supportBrown50: supportBrown50 ?? this.supportBrown50,
      supportBrown60: supportBrown60 ?? this.supportBrown60,
      supportBrown70: supportBrown70 ?? this.supportBrown70,
      supportBrown80: supportBrown80 ?? this.supportBrown80,
      supportBrown90: supportBrown90 ?? this.supportBrown90,
      supportBrown100: supportBrown100 ?? this.supportBrown100,
      supportGreen10: supportGreen10 ?? this.supportGreen10,
      supportGreen20: supportGreen20 ?? this.supportGreen20,
      supportGreen30: supportGreen30 ?? this.supportGreen30,
      supportGreen40: supportGreen40 ?? this.supportGreen40,
      supportGreen50: supportGreen50 ?? this.supportGreen50,
      supportGreen60: supportGreen60 ?? this.supportGreen60,
      supportGreen70: supportGreen70 ?? this.supportGreen70,
      supportGreen80: supportGreen80 ?? this.supportGreen80,
      supportGreen90: supportGreen90 ?? this.supportGreen90,
      supportGreen100: supportGreen100 ?? this.supportGreen100,
      supportGrey10: supportGrey10 ?? this.supportGrey10,
      supportGrey20: supportGrey20 ?? this.supportGrey20,
      supportGrey30: supportGrey30 ?? this.supportGrey30,
      supportGrey40: supportGrey40 ?? this.supportGrey40,
      supportGrey50: supportGrey50 ?? this.supportGrey50,
      supportGrey60: supportGrey60 ?? this.supportGrey60,
      supportGrey70: supportGrey70 ?? this.supportGrey70,
      supportGrey80: supportGrey80 ?? this.supportGrey80,
      supportGrey90: supportGrey90 ?? this.supportGrey90,
      supportGrey100: supportGrey100 ?? this.supportGrey100,
      supportLime10: supportLime10 ?? this.supportLime10,
      supportLime20: supportLime20 ?? this.supportLime20,
      supportLime30: supportLime30 ?? this.supportLime30,
      supportLime40: supportLime40 ?? this.supportLime40,
      supportLime50: supportLime50 ?? this.supportLime50,
      supportLime60: supportLime60 ?? this.supportLime60,
      supportLime70: supportLime70 ?? this.supportLime70,
      supportLime80: supportLime80 ?? this.supportLime80,
      supportLime90: supportLime90 ?? this.supportLime90,
      supportLime100: supportLime100 ?? this.supportLime100,
      supportOrange10: supportOrange10 ?? this.supportOrange10,
      supportOrange20: supportOrange20 ?? this.supportOrange20,
      supportOrange30: supportOrange30 ?? this.supportOrange30,
      supportOrange40: supportOrange40 ?? this.supportOrange40,
      supportOrange50: supportOrange50 ?? this.supportOrange50,
      supportOrange60: supportOrange60 ?? this.supportOrange60,
      supportOrange70: supportOrange70 ?? this.supportOrange70,
      supportOrange80: supportOrange80 ?? this.supportOrange80,
      supportOrange90: supportOrange90 ?? this.supportOrange90,
      supportOrange100: supportOrange100 ?? this.supportOrange100,
      supportPink10: supportPink10 ?? this.supportPink10,
      supportPink20: supportPink20 ?? this.supportPink20,
      supportPink30: supportPink30 ?? this.supportPink30,
      supportPink40: supportPink40 ?? this.supportPink40,
      supportPink50: supportPink50 ?? this.supportPink50,
      supportPink60: supportPink60 ?? this.supportPink60,
      supportPink70: supportPink70 ?? this.supportPink70,
      supportPink80: supportPink80 ?? this.supportPink80,
      supportPink90: supportPink90 ?? this.supportPink90,
      supportPink100: supportPink100 ?? this.supportPink100,
      supportPurple10: supportPurple10 ?? this.supportPurple10,
      supportPurple20: supportPurple20 ?? this.supportPurple20,
      supportPurple30: supportPurple30 ?? this.supportPurple30,
      supportPurple40: supportPurple40 ?? this.supportPurple40,
      supportPurple50: supportPurple50 ?? this.supportPurple50,
      supportPurple60: supportPurple60 ?? this.supportPurple60,
      supportPurple70: supportPurple70 ?? this.supportPurple70,
      supportPurple80: supportPurple80 ?? this.supportPurple80,
      supportPurple90: supportPurple90 ?? this.supportPurple90,
      supportPurple100: supportPurple100 ?? this.supportPurple100,
      supportRed10: supportRed10 ?? this.supportRed10,
      supportRed20: supportRed20 ?? this.supportRed20,
      supportRed30: supportRed30 ?? this.supportRed30,
      supportRed40: supportRed40 ?? this.supportRed40,
      supportRed50: supportRed50 ?? this.supportRed50,
      supportRed60: supportRed60 ?? this.supportRed60,
      supportRed70: supportRed70 ?? this.supportRed70,
      supportRed80: supportRed80 ?? this.supportRed80,
      supportRed90: supportRed90 ?? this.supportRed90,
      supportRed100: supportRed100 ?? this.supportRed100,
      supportViolet10: supportViolet10 ?? this.supportViolet10,
      supportViolet20: supportViolet20 ?? this.supportViolet20,
      supportViolet30: supportViolet30 ?? this.supportViolet30,
      supportViolet40: supportViolet40 ?? this.supportViolet40,
      supportViolet50: supportViolet50 ?? this.supportViolet50,
      supportViolet60: supportViolet60 ?? this.supportViolet60,
      supportViolet70: supportViolet70 ?? this.supportViolet70,
      supportViolet80: supportViolet80 ?? this.supportViolet80,
      supportViolet90: supportViolet90 ?? this.supportViolet90,
      supportViolet100: supportViolet100 ?? this.supportViolet100,
      supportYellow10: supportYellow10 ?? this.supportYellow10,
      supportYellow20: supportYellow20 ?? this.supportYellow20,
      supportYellow30: supportYellow30 ?? this.supportYellow30,
      supportYellow40: supportYellow40 ?? this.supportYellow40,
      supportYellow50: supportYellow50 ?? this.supportYellow50,
      supportYellow60: supportYellow60 ?? this.supportYellow60,
      supportYellow70: supportYellow70 ?? this.supportYellow70,
      supportYellow80: supportYellow80 ?? this.supportYellow80,
      supportYellow90: supportYellow90 ?? this.supportYellow90,
      supportYellow100: supportYellow100 ?? this.supportYellow100,
      specialFixedWhite: specialFixedWhite ?? this.specialFixedWhite,
      specialFixedBlack: specialFixedBlack ?? this.specialFixedBlack,
      specialShimmerBaseStart: specialShimmerBaseStart ?? this.specialShimmerBaseStart,
      specialShimmerBaseEnd: specialShimmerBaseEnd ?? this.specialShimmerBaseEnd,
      specialShimmerBaseStartInverse:
          specialShimmerBaseStartInverse ?? this.specialShimmerBaseStartInverse,
      specialShimmerBaseEndInverse:
          specialShimmerBaseEndInverse ?? this.specialShimmerBaseEndInverse,
      surfaceBrand01: surfaceBrand01 ?? this.surfaceBrand01,
      surfaceBrand02: surfaceBrand02 ?? this.surfaceBrand02,
      surfaceBrand03: surfaceBrand03 ?? this.surfaceBrand03,
      surfaceBrand04: surfaceBrand04 ?? this.surfaceBrand04,
      surfaceBrand05: surfaceBrand05 ?? this.surfaceBrand05,
      surfaceBrandOnBrand01Disabled:
          surfaceBrandOnBrand01Disabled ?? this.surfaceBrandOnBrand01Disabled,
      surfaceBrandOnBrand01Outline:
          surfaceBrandOnBrand01Outline ?? this.surfaceBrandOnBrand01Outline,
      surfaceBrandOnBrand01ActionEnabled:
          surfaceBrandOnBrand01ActionEnabled ?? this.surfaceBrandOnBrand01ActionEnabled,
      surfaceBrandOnBrand01ActionHover:
          surfaceBrandOnBrand01ActionHover ?? this.surfaceBrandOnBrand01ActionHover,
      surfaceBrandOnBrand01ActionPressed:
          surfaceBrandOnBrand01ActionPressed ?? this.surfaceBrandOnBrand01ActionPressed,
      surfaceBrandOnBrand01EmphasisHigh:
          surfaceBrandOnBrand01EmphasisHigh ?? this.surfaceBrandOnBrand01EmphasisHigh,
      surfaceBrandOnBrand01EmphasisMedium:
          surfaceBrandOnBrand01EmphasisMedium ?? this.surfaceBrandOnBrand01EmphasisMedium,
      surfaceBrandOnBrand01EmphasisLow:
          surfaceBrandOnBrand01EmphasisLow ?? this.surfaceBrandOnBrand01EmphasisLow,
      surfaceBrandOnBrand02Disabled:
          surfaceBrandOnBrand02Disabled ?? this.surfaceBrandOnBrand02Disabled,
      surfaceBrandOnBrand02Outline:
          surfaceBrandOnBrand02Outline ?? this.surfaceBrandOnBrand02Outline,
      surfaceBrandOnBrand02ActionEnabled:
          surfaceBrandOnBrand02ActionEnabled ?? this.surfaceBrandOnBrand02ActionEnabled,
      surfaceBrandOnBrand02ActionHover:
          surfaceBrandOnBrand02ActionHover ?? this.surfaceBrandOnBrand02ActionHover,
      surfaceBrandOnBrand02ActionPressed:
          surfaceBrandOnBrand02ActionPressed ?? this.surfaceBrandOnBrand02ActionPressed,
      surfaceBrandOnBrand02EmphasisHigh:
          surfaceBrandOnBrand02EmphasisHigh ?? this.surfaceBrandOnBrand02EmphasisHigh,
      surfaceBrandOnBrand02EmphasisMedium:
          surfaceBrandOnBrand02EmphasisMedium ?? this.surfaceBrandOnBrand02EmphasisMedium,
      surfaceBrandOnBrand02EmphasisLow:
          surfaceBrandOnBrand02EmphasisLow ?? this.surfaceBrandOnBrand02EmphasisLow,
      surfaceBrandOnBrand03Disabled:
          surfaceBrandOnBrand03Disabled ?? this.surfaceBrandOnBrand03Disabled,
      surfaceBrandOnBrand03Outline:
          surfaceBrandOnBrand03Outline ?? this.surfaceBrandOnBrand03Outline,
      surfaceBrandOnBrand03ActionEnabled:
          surfaceBrandOnBrand03ActionEnabled ?? this.surfaceBrandOnBrand03ActionEnabled,
      surfaceBrandOnBrand03ActionHover:
          surfaceBrandOnBrand03ActionHover ?? this.surfaceBrandOnBrand03ActionHover,
      surfaceBrandOnBrand03ActionPressed:
          surfaceBrandOnBrand03ActionPressed ?? this.surfaceBrandOnBrand03ActionPressed,
      surfaceBrandOnBrand03EmphasisHigh:
          surfaceBrandOnBrand03EmphasisHigh ?? this.surfaceBrandOnBrand03EmphasisHigh,
      surfaceBrandOnBrand03EmphasisMedium:
          surfaceBrandOnBrand03EmphasisMedium ?? this.surfaceBrandOnBrand03EmphasisMedium,
      surfaceBrandOnBrand03EmphasisLow:
          surfaceBrandOnBrand03EmphasisLow ?? this.surfaceBrandOnBrand03EmphasisLow,
      surfaceBrandOnBrand04Disabled:
          surfaceBrandOnBrand04Disabled ?? this.surfaceBrandOnBrand04Disabled,
      surfaceBrandOnBrand04Outline:
          surfaceBrandOnBrand04Outline ?? this.surfaceBrandOnBrand04Outline,
      surfaceBrandOnBrand04ActionEnabled:
          surfaceBrandOnBrand04ActionEnabled ?? this.surfaceBrandOnBrand04ActionEnabled,
      surfaceBrandOnBrand04ActionHover:
          surfaceBrandOnBrand04ActionHover ?? this.surfaceBrandOnBrand04ActionHover,
      surfaceBrandOnBrand04ActionPressed:
          surfaceBrandOnBrand04ActionPressed ?? this.surfaceBrandOnBrand04ActionPressed,
      surfaceBrandOnBrand04EmphasisHigh:
          surfaceBrandOnBrand04EmphasisHigh ?? this.surfaceBrandOnBrand04EmphasisHigh,
      surfaceBrandOnBrand04EmphasisMedium:
          surfaceBrandOnBrand04EmphasisMedium ?? this.surfaceBrandOnBrand04EmphasisMedium,
      surfaceBrandOnBrand04EmphasisLow:
          surfaceBrandOnBrand04EmphasisLow ?? this.surfaceBrandOnBrand04EmphasisLow,
      surfaceBrandOnBrand05Disabled:
          surfaceBrandOnBrand05Disabled ?? this.surfaceBrandOnBrand05Disabled,
      surfaceBrandOnBrand05Outline:
          surfaceBrandOnBrand05Outline ?? this.surfaceBrandOnBrand05Outline,
      surfaceBrandOnBrand05ActionEnabled:
          surfaceBrandOnBrand05ActionEnabled ?? this.surfaceBrandOnBrand05ActionEnabled,
      surfaceBrandOnBrand05ActionHover:
          surfaceBrandOnBrand05ActionHover ?? this.surfaceBrandOnBrand05ActionHover,
      surfaceBrandOnBrand05ActionPressed:
          surfaceBrandOnBrand05ActionPressed ?? this.surfaceBrandOnBrand05ActionPressed,
      surfaceBrandOnBrand05EmphasisHigh:
          surfaceBrandOnBrand05EmphasisHigh ?? this.surfaceBrandOnBrand05EmphasisHigh,
      surfaceBrandOnBrand05EmphasisMedium:
          surfaceBrandOnBrand05EmphasisMedium ?? this.surfaceBrandOnBrand05EmphasisMedium,
      surfaceBrandOnBrand05EmphasisLow:
          surfaceBrandOnBrand05EmphasisLow ?? this.surfaceBrandOnBrand05EmphasisLow,
      elevationLow: elevationLow ?? this.elevationLow,
      elevationMedium: elevationMedium ?? this.elevationMedium,
      elevationHigh: elevationHigh ?? this.elevationHigh,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is GtbColorScheme &&
        other.primaryBase == primaryBase &&
        other.primaryBaseInverse == primaryBaseInverse &&
        other.primaryExtended10 == primaryExtended10 &&
        other.primaryExtended20 == primaryExtended20 &&
        other.primaryExtended30 == primaryExtended30 &&
        other.primaryExtended40 == primaryExtended40 &&
        other.primaryExtended50 == primaryExtended50 &&
        other.primaryExtended60 == primaryExtended60 &&
        other.primaryExtended70 == primaryExtended70 &&
        other.primaryExtended80 == primaryExtended80 &&
        other.primaryExtended90 == primaryExtended90 &&
        other.primaryExtended100 == primaryExtended100 &&
        other.secondaryBase == secondaryBase &&
        other.secondaryBaseInverse == secondaryBaseInverse &&
        other.neutralBase == neutralBase &&
        other.neutralBaseInverse == neutralBaseInverse &&
        other.neutralExtended10 == neutralExtended10 &&
        other.neutralExtended20 == neutralExtended20 &&
        other.neutralExtended30 == neutralExtended30 &&
        other.neutralExtended40 == neutralExtended40 &&
        other.neutralExtended50 == neutralExtended50 &&
        other.neutralExtended60 == neutralExtended60 &&
        other.neutralExtended70 == neutralExtended70 &&
        other.neutralExtended80 == neutralExtended80 &&
        other.neutralExtended90 == neutralExtended90 &&
        other.neutralExtended100 == neutralExtended100 &&
        other.actionMainEnabled == actionMainEnabled &&
        other.actionMainHover == actionMainHover &&
        other.actionMainFocus == actionMainFocus &&
        other.actionMainPressed == actionMainPressed &&
        other.actionMainSelected == actionMainSelected &&
        other.actionMainEnabledInverse == actionMainEnabledInverse &&
        other.actionMainHoverInverse == actionMainHoverInverse &&
        other.actionMainFocusInverse == actionMainFocusInverse &&
        other.actionMainPressedInverse == actionMainPressedInverse &&
        other.actionMainSelectedInverse == actionMainSelectedInverse &&
        other.actionMainEmphasisHigh == actionMainEmphasisHigh &&
        other.actionMainEmphasisMedium == actionMainEmphasisMedium &&
        other.actionMainEmphasisLow == actionMainEmphasisLow &&
        other.actionMainEmphasisHighInverse == actionMainEmphasisHighInverse &&
        other.actionMainEmphasisMediumInverse == actionMainEmphasisMediumInverse &&
        other.actionMainEmphasisLowInverse == actionMainEmphasisLowInverse &&
        other.actionSecondaryEnabled == actionSecondaryEnabled &&
        other.actionSecondaryHover == actionSecondaryHover &&
        other.actionSecondaryFocus == actionSecondaryFocus &&
        other.actionSecondaryPressed == actionSecondaryPressed &&
        other.actionSecondarySelected == actionSecondarySelected &&
        other.actionSecondaryEnabledInverse == actionSecondaryEnabledInverse &&
        other.actionSecondaryHoverInverse == actionSecondaryHoverInverse &&
        other.actionSecondaryFocusInverse == actionSecondaryFocusInverse &&
        other.actionSecondaryPressedInverse == actionSecondaryPressedInverse &&
        other.actionSecondarySelectedInverse == actionSecondarySelectedInverse &&
        other.actionSecondaryEmphasisHigh == actionSecondaryEmphasisHigh &&
        other.actionSecondaryEmphasisMedium == actionSecondaryEmphasisMedium &&
        other.actionSecondaryEmphasisLow == actionSecondaryEmphasisLow &&
        other.actionSecondaryEmphasisHighInverse == actionSecondaryEmphasisHighInverse &&
        other.actionSecondaryEmphasisMediumInverse == actionSecondaryEmphasisMediumInverse &&
        other.actionSecondaryEmphasisLowInverse == actionSecondaryEmphasisLowInverse &&
        other.actionNeutralEnabled == actionNeutralEnabled &&
        other.actionNeutralHover == actionNeutralHover &&
        other.actionNeutralFocus == actionNeutralFocus &&
        other.actionNeutralPressed == actionNeutralPressed &&
        other.actionNeutralSelected == actionNeutralSelected &&
        other.actionNeutralEnabledInverse == actionNeutralEnabledInverse &&
        other.actionNeutralHoverInverse == actionNeutralHoverInverse &&
        other.actionNeutralFocusInverse == actionNeutralFocusInverse &&
        other.actionNeutralPressedInverse == actionNeutralPressedInverse &&
        other.actionNeutralSelectedInverse == actionNeutralSelectedInverse &&
        other.actionNeutralEmphasisHigh == actionNeutralEmphasisHigh &&
        other.actionNeutralEmphasisMedium == actionNeutralEmphasisMedium &&
        other.actionNeutralEmphasisLow == actionNeutralEmphasisLow &&
        other.actionNeutralEmphasisHighInverse == actionNeutralEmphasisHighInverse &&
        other.actionNeutralEmphasisMediumInverse == actionNeutralEmphasisMediumInverse &&
        other.actionNeutralEmphasisLowInverse == actionNeutralEmphasisLowInverse &&
        other.actionDisabledBase == actionDisabledBase &&
        other.actionDisabledBaseInverse == actionDisabledBaseInverse &&
        other.onColorEmphasisHigh == onColorEmphasisHigh &&
        other.onColorEmphasisMedium == onColorEmphasisMedium &&
        other.onColorEmphasisLow == onColorEmphasisLow &&
        other.onColorEmphasisDisabled == onColorEmphasisDisabled &&
        other.onColorEmphasisHighInverse == onColorEmphasisHighInverse &&
        other.onColorEmphasisMediumInverse == onColorEmphasisMediumInverse &&
        other.onColorEmphasisLowInverse == onColorEmphasisLowInverse &&
        other.onColorEmphasisDisabledInverse == onColorEmphasisDisabledInverse &&
        other.onColorIndicatorHighlightBase == onColorIndicatorHighlightBase &&
        other.onColorIndicatorHighlightSurface == onColorIndicatorHighlightSurface &&
        other.onColorIndicatorHighlightBaseInverse == onColorIndicatorHighlightBaseInverse &&
        other.onColorIndicatorHighlightSurfaceInverse == onColorIndicatorHighlightSurfaceInverse &&
        other.onColorIndicatorPositiveBase == onColorIndicatorPositiveBase &&
        other.onColorIndicatorPositiveSurface == onColorIndicatorPositiveSurface &&
        other.onColorIndicatorPositiveBaseInverse == onColorIndicatorPositiveBaseInverse &&
        other.onColorIndicatorPositiveSurfaceInverse == onColorIndicatorPositiveSurfaceInverse &&
        other.onColorIndicatorNegativeBase == onColorIndicatorNegativeBase &&
        other.onColorIndicatorNegativeSurface == onColorIndicatorNegativeSurface &&
        other.onColorIndicatorNegativeBaseInverse == onColorIndicatorNegativeBaseInverse &&
        other.onColorIndicatorNegativeSurfaceInverse == onColorIndicatorNegativeSurfaceInverse &&
        other.statusSuccessBase == statusSuccessBase &&
        other.statusSuccessBaseSurface == statusSuccessBaseSurface &&
        other.statusSuccessBaseInverse == statusSuccessBaseInverse &&
        other.statusSuccessBaseSurfaceInverse == statusSuccessBaseSurfaceInverse &&
        other.statusWarningBase == statusWarningBase &&
        other.statusWarningBaseSurface == statusWarningBaseSurface &&
        other.statusWarningBaseInverse == statusWarningBaseInverse &&
        other.statusWarningBaseSurfaceInverse == statusWarningBaseSurfaceInverse &&
        other.statusErrorBase == statusErrorBase &&
        other.statusErrorBaseSurface == statusErrorBaseSurface &&
        other.statusErrorBaseInverse == statusErrorBaseInverse &&
        other.statusErrorBaseSurfaceInverse == statusErrorBaseSurfaceInverse &&
        other.statusInformativeBase == statusInformativeBase &&
        other.statusInformativeBaseSurface == statusInformativeBaseSurface &&
        other.statusInformativeBaseInverse == statusInformativeBaseInverse &&
        other.statusInformativeBaseSurfaceInverse == statusInformativeBaseSurfaceInverse &&
        other.outlineBase == outlineBase &&
        other.outlineBaseInverse == outlineBaseInverse &&
        other.outlineBaseFocus == outlineBaseFocus &&
        other.outlineBaseFocusInverse == outlineBaseFocusInverse &&
        other.backgroundBase == backgroundBase &&
        other.backgroundBaseInverse == backgroundBaseInverse &&
        other.supportAqua10 == supportAqua10 &&
        other.supportAqua20 == supportAqua20 &&
        other.supportAqua30 == supportAqua30 &&
        other.supportAqua40 == supportAqua40 &&
        other.supportAqua50 == supportAqua50 &&
        other.supportAqua60 == supportAqua60 &&
        other.supportAqua70 == supportAqua70 &&
        other.supportAqua80 == supportAqua80 &&
        other.supportAqua90 == supportAqua90 &&
        other.supportAqua100 == supportAqua100 &&
        other.supportBlue10 == supportBlue10 &&
        other.supportBlue20 == supportBlue20 &&
        other.supportBlue30 == supportBlue30 &&
        other.supportBlue40 == supportBlue40 &&
        other.supportBlue50 == supportBlue50 &&
        other.supportBlue60 == supportBlue60 &&
        other.supportBlue70 == supportBlue70 &&
        other.supportBlue80 == supportBlue80 &&
        other.supportBlue90 == supportBlue90 &&
        other.supportBlue100 == supportBlue100 &&
        other.supportBrown10 == supportBrown10 &&
        other.supportBrown20 == supportBrown20 &&
        other.supportBrown30 == supportBrown30 &&
        other.supportBrown40 == supportBrown40 &&
        other.supportBrown50 == supportBrown50 &&
        other.supportBrown60 == supportBrown60 &&
        other.supportBrown70 == supportBrown70 &&
        other.supportBrown80 == supportBrown80 &&
        other.supportBrown90 == supportBrown90 &&
        other.supportBrown100 == supportBrown100 &&
        other.supportGreen10 == supportGreen10 &&
        other.supportGreen20 == supportGreen20 &&
        other.supportGreen30 == supportGreen30 &&
        other.supportGreen40 == supportGreen40 &&
        other.supportGreen50 == supportGreen50 &&
        other.supportGreen60 == supportGreen60 &&
        other.supportGreen70 == supportGreen70 &&
        other.supportGreen80 == supportGreen80 &&
        other.supportGreen90 == supportGreen90 &&
        other.supportGreen100 == supportGreen100 &&
        other.supportGrey10 == supportGrey10 &&
        other.supportGrey20 == supportGrey20 &&
        other.supportGrey30 == supportGrey30 &&
        other.supportGrey40 == supportGrey40 &&
        other.supportGrey50 == supportGrey50 &&
        other.supportGrey60 == supportGrey60 &&
        other.supportGrey70 == supportGrey70 &&
        other.supportGrey80 == supportGrey80 &&
        other.supportGrey90 == supportGrey90 &&
        other.supportGrey100 == supportGrey100 &&
        other.supportLime10 == supportLime10 &&
        other.supportLime20 == supportLime20 &&
        other.supportLime30 == supportLime30 &&
        other.supportLime40 == supportLime40 &&
        other.supportLime50 == supportLime50 &&
        other.supportLime60 == supportLime60 &&
        other.supportLime70 == supportLime70 &&
        other.supportLime80 == supportLime80 &&
        other.supportLime90 == supportLime90 &&
        other.supportLime100 == supportLime100 &&
        other.supportOrange10 == supportOrange10 &&
        other.supportOrange20 == supportOrange20 &&
        other.supportOrange30 == supportOrange30 &&
        other.supportOrange40 == supportOrange40 &&
        other.supportOrange50 == supportOrange50 &&
        other.supportOrange60 == supportOrange60 &&
        other.supportOrange70 == supportOrange70 &&
        other.supportOrange80 == supportOrange80 &&
        other.supportOrange90 == supportOrange90 &&
        other.supportOrange100 == supportOrange100 &&
        other.supportPink10 == supportPink10 &&
        other.supportPink20 == supportPink20 &&
        other.supportPink30 == supportPink30 &&
        other.supportPink40 == supportPink40 &&
        other.supportPink50 == supportPink50 &&
        other.supportPink60 == supportPink60 &&
        other.supportPink70 == supportPink70 &&
        other.supportPink80 == supportPink80 &&
        other.supportPink90 == supportPink90 &&
        other.supportPink100 == supportPink100 &&
        other.supportPurple10 == supportPurple10 &&
        other.supportPurple20 == supportPurple20 &&
        other.supportPurple30 == supportPurple30 &&
        other.supportPurple40 == supportPurple40 &&
        other.supportPurple50 == supportPurple50 &&
        other.supportPurple60 == supportPurple60 &&
        other.supportPurple70 == supportPurple70 &&
        other.supportPurple80 == supportPurple80 &&
        other.supportPurple90 == supportPurple90 &&
        other.supportPurple100 == supportPurple100 &&
        other.supportRed10 == supportRed10 &&
        other.supportRed20 == supportRed20 &&
        other.supportRed30 == supportRed30 &&
        other.supportRed40 == supportRed40 &&
        other.supportRed50 == supportRed50 &&
        other.supportRed60 == supportRed60 &&
        other.supportRed70 == supportRed70 &&
        other.supportRed80 == supportRed80 &&
        other.supportRed90 == supportRed90 &&
        other.supportRed100 == supportRed100 &&
        other.supportViolet10 == supportViolet10 &&
        other.supportViolet20 == supportViolet20 &&
        other.supportViolet30 == supportViolet30 &&
        other.supportViolet40 == supportViolet40 &&
        other.supportViolet50 == supportViolet50 &&
        other.supportViolet60 == supportViolet60 &&
        other.supportViolet70 == supportViolet70 &&
        other.supportViolet80 == supportViolet80 &&
        other.supportViolet90 == supportViolet90 &&
        other.supportViolet100 == supportViolet100 &&
        other.supportYellow10 == supportYellow10 &&
        other.supportYellow20 == supportYellow20 &&
        other.supportYellow30 == supportYellow30 &&
        other.supportYellow40 == supportYellow40 &&
        other.supportYellow50 == supportYellow50 &&
        other.supportYellow60 == supportYellow60 &&
        other.supportYellow70 == supportYellow70 &&
        other.supportYellow80 == supportYellow80 &&
        other.supportYellow90 == supportYellow90 &&
        other.supportYellow100 == supportYellow100 &&
        other.specialFixedWhite == specialFixedWhite &&
        other.specialFixedBlack == specialFixedBlack &&
        other.specialShimmerBaseStart == specialShimmerBaseStart &&
        other.specialShimmerBaseEnd == specialShimmerBaseEnd &&
        other.specialShimmerBaseStartInverse == specialShimmerBaseStartInverse &&
        other.specialShimmerBaseEndInverse == specialShimmerBaseEndInverse &&
        other.surfaceBrand01 == surfaceBrand01 &&
        other.surfaceBrand02 == surfaceBrand02 &&
        other.surfaceBrand03 == surfaceBrand03 &&
        other.surfaceBrand04 == surfaceBrand04 &&
        other.surfaceBrand05 == surfaceBrand05 &&
        other.surfaceBrandOnBrand01Disabled == surfaceBrandOnBrand01Disabled &&
        other.surfaceBrandOnBrand01Outline == surfaceBrandOnBrand01Outline &&
        other.surfaceBrandOnBrand01ActionEnabled == surfaceBrandOnBrand01ActionEnabled &&
        other.surfaceBrandOnBrand01ActionHover == surfaceBrandOnBrand01ActionHover &&
        other.surfaceBrandOnBrand01ActionPressed == surfaceBrandOnBrand01ActionPressed &&
        other.surfaceBrandOnBrand01EmphasisHigh == surfaceBrandOnBrand01EmphasisHigh &&
        other.surfaceBrandOnBrand01EmphasisMedium == surfaceBrandOnBrand01EmphasisMedium &&
        other.surfaceBrandOnBrand01EmphasisLow == surfaceBrandOnBrand01EmphasisLow &&
        other.surfaceBrandOnBrand02Disabled == surfaceBrandOnBrand02Disabled &&
        other.surfaceBrandOnBrand02Outline == surfaceBrandOnBrand02Outline &&
        other.surfaceBrandOnBrand02ActionEnabled == surfaceBrandOnBrand02ActionEnabled &&
        other.surfaceBrandOnBrand02ActionHover == surfaceBrandOnBrand02ActionHover &&
        other.surfaceBrandOnBrand02ActionPressed == surfaceBrandOnBrand02ActionPressed &&
        other.surfaceBrandOnBrand02EmphasisHigh == surfaceBrandOnBrand02EmphasisHigh &&
        other.surfaceBrandOnBrand02EmphasisMedium == surfaceBrandOnBrand02EmphasisMedium &&
        other.surfaceBrandOnBrand02EmphasisLow == surfaceBrandOnBrand02EmphasisLow &&
        other.surfaceBrandOnBrand03Disabled == surfaceBrandOnBrand03Disabled &&
        other.surfaceBrandOnBrand03Outline == surfaceBrandOnBrand03Outline &&
        other.surfaceBrandOnBrand03ActionEnabled == surfaceBrandOnBrand03ActionEnabled &&
        other.surfaceBrandOnBrand03ActionHover == surfaceBrandOnBrand03ActionHover &&
        other.surfaceBrandOnBrand03ActionPressed == surfaceBrandOnBrand03ActionPressed &&
        other.surfaceBrandOnBrand03EmphasisHigh == surfaceBrandOnBrand03EmphasisHigh &&
        other.surfaceBrandOnBrand03EmphasisMedium == surfaceBrandOnBrand03EmphasisMedium &&
        other.surfaceBrandOnBrand03EmphasisLow == surfaceBrandOnBrand03EmphasisLow &&
        other.surfaceBrandOnBrand04Disabled == surfaceBrandOnBrand04Disabled &&
        other.surfaceBrandOnBrand04Outline == surfaceBrandOnBrand04Outline &&
        other.surfaceBrandOnBrand04ActionEnabled == surfaceBrandOnBrand04ActionEnabled &&
        other.surfaceBrandOnBrand04ActionHover == surfaceBrandOnBrand04ActionHover &&
        other.surfaceBrandOnBrand04ActionPressed == surfaceBrandOnBrand04ActionPressed &&
        other.surfaceBrandOnBrand04EmphasisHigh == surfaceBrandOnBrand04EmphasisHigh &&
        other.surfaceBrandOnBrand04EmphasisMedium == surfaceBrandOnBrand04EmphasisMedium &&
        other.surfaceBrandOnBrand04EmphasisLow == surfaceBrandOnBrand04EmphasisLow &&
        other.surfaceBrandOnBrand05Disabled == surfaceBrandOnBrand05Disabled &&
        other.surfaceBrandOnBrand05Outline == surfaceBrandOnBrand05Outline &&
        other.surfaceBrandOnBrand05ActionEnabled == surfaceBrandOnBrand05ActionEnabled &&
        other.surfaceBrandOnBrand05ActionHover == surfaceBrandOnBrand05ActionHover &&
        other.surfaceBrandOnBrand05ActionPressed == surfaceBrandOnBrand05ActionPressed &&
        other.surfaceBrandOnBrand05EmphasisHigh == surfaceBrandOnBrand05EmphasisHigh &&
        other.surfaceBrandOnBrand05EmphasisMedium == surfaceBrandOnBrand05EmphasisMedium &&
        other.surfaceBrandOnBrand05EmphasisLow == surfaceBrandOnBrand05EmphasisLow &&
        other.elevationLow == elevationLow &&
        other.elevationMedium == elevationMedium &&
        other.elevationHigh == elevationHigh;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      primaryBase,
      primaryBaseInverse,
      primaryExtended10,
      primaryExtended20,
      primaryExtended30,
      primaryExtended40,
      primaryExtended50,
      primaryExtended60,
      primaryExtended70,
      primaryExtended80,
      primaryExtended90,
      primaryExtended100,
      secondaryBase,
      secondaryBaseInverse,
      neutralBase,
      neutralBaseInverse,
      neutralExtended10,
      neutralExtended20,
      neutralExtended30,
      neutralExtended40,
      neutralExtended50,
      neutralExtended60,
      neutralExtended70,
      neutralExtended80,
      neutralExtended90,
      neutralExtended100,
      actionMainEnabled,
      actionMainHover,
      actionMainFocus,
      actionMainPressed,
      actionMainSelected,
      actionMainEnabledInverse,
      actionMainHoverInverse,
      actionMainFocusInverse,
      actionMainPressedInverse,
      actionMainSelectedInverse,
      actionMainEmphasisHigh,
      actionMainEmphasisMedium,
      actionMainEmphasisLow,
      actionMainEmphasisHighInverse,
      actionMainEmphasisMediumInverse,
      actionMainEmphasisLowInverse,
      actionSecondaryEnabled,
      actionSecondaryHover,
      actionSecondaryFocus,
      actionSecondaryPressed,
      actionSecondarySelected,
      actionSecondaryEnabledInverse,
      actionSecondaryHoverInverse,
      actionSecondaryFocusInverse,
      actionSecondaryPressedInverse,
      actionSecondarySelectedInverse,
      actionSecondaryEmphasisHigh,
      actionSecondaryEmphasisMedium,
      actionSecondaryEmphasisLow,
      actionSecondaryEmphasisHighInverse,
      actionSecondaryEmphasisMediumInverse,
      actionSecondaryEmphasisLowInverse,
      actionNeutralEnabled,
      actionNeutralHover,
      actionNeutralFocus,
      actionNeutralPressed,
      actionNeutralSelected,
      actionNeutralEnabledInverse,
      actionNeutralHoverInverse,
      actionNeutralFocusInverse,
      actionNeutralPressedInverse,
      actionNeutralSelectedInverse,
      actionNeutralEmphasisHigh,
      actionNeutralEmphasisMedium,
      actionNeutralEmphasisLow,
      actionNeutralEmphasisHighInverse,
      actionNeutralEmphasisMediumInverse,
      actionNeutralEmphasisLowInverse,
      actionDisabledBase,
      actionDisabledBaseInverse,
      onColorEmphasisHigh,
      onColorEmphasisMedium,
      onColorEmphasisLow,
      onColorEmphasisDisabled,
      onColorEmphasisHighInverse,
      onColorEmphasisMediumInverse,
      onColorEmphasisLowInverse,
      onColorEmphasisDisabledInverse,
      onColorIndicatorHighlightBase,
      onColorIndicatorHighlightSurface,
      onColorIndicatorHighlightBaseInverse,
      onColorIndicatorHighlightSurfaceInverse,
      onColorIndicatorPositiveBase,
      onColorIndicatorPositiveSurface,
      onColorIndicatorPositiveBaseInverse,
      onColorIndicatorPositiveSurfaceInverse,
      onColorIndicatorNegativeBase,
      onColorIndicatorNegativeSurface,
      onColorIndicatorNegativeBaseInverse,
      onColorIndicatorNegativeSurfaceInverse,
      statusSuccessBase,
      statusSuccessBaseSurface,
      statusSuccessBaseInverse,
      statusSuccessBaseSurfaceInverse,
      statusWarningBase,
      statusWarningBaseSurface,
      statusWarningBaseInverse,
      statusWarningBaseSurfaceInverse,
      statusErrorBase,
      statusErrorBaseSurface,
      statusErrorBaseInverse,
      statusErrorBaseSurfaceInverse,
      statusInformativeBase,
      statusInformativeBaseSurface,
      statusInformativeBaseInverse,
      statusInformativeBaseSurfaceInverse,
      outlineBase,
      outlineBaseInverse,
      outlineBaseFocus,
      outlineBaseFocusInverse,
      backgroundBase,
      backgroundBaseInverse,
      supportAqua10,
      supportAqua20,
      supportAqua30,
      supportAqua40,
      supportAqua50,
      supportAqua60,
      supportAqua70,
      supportAqua80,
      supportAqua90,
      supportAqua100,
      supportBlue10,
      supportBlue20,
      supportBlue30,
      supportBlue40,
      supportBlue50,
      supportBlue60,
      supportBlue70,
      supportBlue80,
      supportBlue90,
      supportBlue100,
      supportBrown10,
      supportBrown20,
      supportBrown30,
      supportBrown40,
      supportBrown50,
      supportBrown60,
      supportBrown70,
      supportBrown80,
      supportBrown90,
      supportBrown100,
      supportGreen10,
      supportGreen20,
      supportGreen30,
      supportGreen40,
      supportGreen50,
      supportGreen60,
      supportGreen70,
      supportGreen80,
      supportGreen90,
      supportGreen100,
      supportGrey10,
      supportGrey20,
      supportGrey30,
      supportGrey40,
      supportGrey50,
      supportGrey60,
      supportGrey70,
      supportGrey80,
      supportGrey90,
      supportGrey100,
      supportLime10,
      supportLime20,
      supportLime30,
      supportLime40,
      supportLime50,
      supportLime60,
      supportLime70,
      supportLime80,
      supportLime90,
      supportLime100,
      supportOrange10,
      supportOrange20,
      supportOrange30,
      supportOrange40,
      supportOrange50,
      supportOrange60,
      supportOrange70,
      supportOrange80,
      supportOrange90,
      supportOrange100,
      supportRed10,
      supportRed20,
      supportRed30,
      supportRed40,
      supportRed50,
      supportRed60,
      supportRed70,
      supportRed80,
      supportRed90,
      supportRed100,
      supportPink10,
      supportPink20,
      supportPink30,
      supportPink40,
      supportPink50,
      supportPink60,
      supportPink70,
      supportPink80,
      supportPink90,
      supportPink100,
      supportPurple10,
      supportPurple20,
      supportPurple30,
      supportPurple40,
      supportPurple50,
      supportPurple60,
      supportPurple70,
      supportPurple80,
      supportPurple90,
      supportPurple100,
      supportViolet10,
      supportViolet20,
      supportViolet30,
      supportViolet40,
      supportViolet50,
      supportViolet60,
      supportViolet70,
      supportViolet80,
      supportViolet90,
      supportViolet100,
      supportYellow10,
      supportYellow20,
      supportYellow30,
      supportYellow40,
      supportYellow50,
      supportYellow60,
      supportYellow70,
      supportYellow80,
      supportYellow90,
      supportYellow100,
      specialFixedWhite,
      specialFixedBlack,
      specialShimmerBaseStart,
      specialShimmerBaseEnd,
      specialShimmerBaseStartInverse,
      specialShimmerBaseEndInverse,
      surfaceBrand01,
      surfaceBrand02,
      surfaceBrand03,
      surfaceBrand04,
      surfaceBrand05,
      surfaceBrandOnBrand01Disabled,
      surfaceBrandOnBrand01Outline,
      surfaceBrandOnBrand01ActionEnabled,
      surfaceBrandOnBrand01ActionHover,
      surfaceBrandOnBrand01ActionPressed,
      surfaceBrandOnBrand01EmphasisHigh,
      surfaceBrandOnBrand01EmphasisMedium,
      surfaceBrandOnBrand01EmphasisLow,
      surfaceBrandOnBrand02Disabled,
      surfaceBrandOnBrand02Outline,
      surfaceBrandOnBrand02ActionEnabled,
      surfaceBrandOnBrand02ActionHover,
      surfaceBrandOnBrand02ActionPressed,
      surfaceBrandOnBrand02EmphasisHigh,
      surfaceBrandOnBrand02EmphasisMedium,
      surfaceBrandOnBrand02EmphasisLow,
      surfaceBrandOnBrand03Disabled,
      surfaceBrandOnBrand03Outline,
      surfaceBrandOnBrand03ActionEnabled,
      surfaceBrandOnBrand03ActionHover,
      surfaceBrandOnBrand03ActionPressed,
      surfaceBrandOnBrand03EmphasisHigh,
      surfaceBrandOnBrand03EmphasisMedium,
      surfaceBrandOnBrand03EmphasisLow,
      surfaceBrandOnBrand04Disabled,
      surfaceBrandOnBrand04Outline,
      surfaceBrandOnBrand04ActionEnabled,
      surfaceBrandOnBrand04ActionHover,
      surfaceBrandOnBrand04ActionPressed,
      surfaceBrandOnBrand04EmphasisHigh,
      surfaceBrandOnBrand04EmphasisMedium,
      surfaceBrandOnBrand04EmphasisLow,
      surfaceBrandOnBrand05Disabled,
      surfaceBrandOnBrand05Outline,
      surfaceBrandOnBrand05ActionEnabled,
      surfaceBrandOnBrand05ActionHover,
      surfaceBrandOnBrand05ActionPressed,
      surfaceBrandOnBrand05EmphasisHigh,
      surfaceBrandOnBrand05EmphasisMedium,
      surfaceBrandOnBrand05EmphasisLow,
      elevationLow,
      elevationMedium,
      elevationHigh,
    ]);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    final Map<String, Color> data = {
      'primaryBase': primaryBase,
      'primaryBaseInverse': primaryBaseInverse,
      'primaryExtended10': primaryExtended10,
      'primaryExtended20': primaryExtended20,
      'primaryExtended30': primaryExtended30,
      'primaryExtended40': primaryExtended40,
      'primaryExtended50': primaryExtended50,
      'primaryExtended60': primaryExtended60,
      'primaryExtended70': primaryExtended70,
      'primaryExtended80': primaryExtended80,
      'primaryExtended90': primaryExtended90,
      'primaryExtended100': primaryExtended100,
      'secondaryBase': secondaryBase,
      'secondaryBaseInverse': secondaryBaseInverse,
      'neutralBase': neutralBase,
      'neutralBaseInverse': neutralBaseInverse,
      'neutralExtended10': neutralExtended10,
      'neutralExtended20': neutralExtended20,
      'neutralExtended30': neutralExtended30,
      'neutralExtended40': neutralExtended40,
      'neutralExtended50': neutralExtended50,
      'neutralExtended60': neutralExtended60,
      'neutralExtended70': neutralExtended70,
      'neutralExtended80': neutralExtended80,
      'neutralExtended90': neutralExtended90,
      'neutralExtended100': neutralExtended100,
      'actionMainEnabled': actionMainEnabled,
      'actionMainHover': actionMainHover,
      'actionMainFocus': actionMainFocus,
      'actionMainPressed': actionMainPressed,
      'actionMainSelected': actionMainSelected,
      'actionMainEnabledInverse': actionMainEnabledInverse,
      'actionMainHoverInverse': actionMainHoverInverse,
      'actionMainFocusInverse': actionMainFocusInverse,
      'actionMainPressedInverse': actionMainPressedInverse,
      'actionMainSelectedInverse': actionMainSelectedInverse,
      'actionMainEmphasisHigh': actionMainEmphasisHigh,
      'actionMainEmphasisMedium': actionMainEmphasisMedium,
      'actionMainEmphasisLow': actionMainEmphasisLow,
      'actionMainEmphasisHighInverse': actionMainEmphasisHighInverse,
      'actionMainEmphasisMediumInverse': actionMainEmphasisMediumInverse,
      'actionMainEmphasisLowInverse': actionMainEmphasisLowInverse,
      'actionSecondaryEnabled': actionSecondaryEnabled,
      'actionSecondaryHover': actionSecondaryHover,
      'actionSecondaryFocus': actionSecondaryFocus,
      'actionSecondaryPressed': actionSecondaryPressed,
      'actionSecondarySelected': actionSecondarySelected,
      'actionSecondaryEnabledInverse': actionSecondaryEnabledInverse,
      'actionSecondaryHoverInverse': actionSecondaryHoverInverse,
      'actionSecondaryFocusInverse': actionSecondaryFocusInverse,
      'actionSecondaryPressedInverse': actionSecondaryPressedInverse,
      'actionSecondarySelectedInverse': actionSecondarySelectedInverse,
      'actionSecondaryEmphasisHigh': actionSecondaryEmphasisHigh,
      'actionSecondaryEmphasisMedium': actionSecondaryEmphasisMedium,
      'actionSecondaryEmphasisLow': actionSecondaryEmphasisLow,
      'actionSecondaryEmphasisHighInverse': actionSecondaryEmphasisHighInverse,
      'actionSecondaryEmphasisMediumInverse': actionSecondaryEmphasisMediumInverse,
      'actionSecondaryEmphasisLowInverse': actionSecondaryEmphasisLowInverse,
      'actionNeutralEnabled': actionNeutralEnabled,
      'actionNeutralHover': actionNeutralHover,
      'actionNeutralFocus': actionNeutralFocus,
      'actionNeutralPressed': actionNeutralPressed,
      'actionNeutralSelected': actionNeutralSelected,
      'actionNeutralEnabledInverse': actionNeutralEnabledInverse,
      'actionNeutralHoverInverse': actionNeutralHoverInverse,
      'actionNeutralFocusInverse': actionNeutralFocusInverse,
      'actionNeutralPressedInverse': actionNeutralPressedInverse,
      'actionNeutralSelectedInverse': actionNeutralSelectedInverse,
      'actionNeutralEmphasisHigh': actionNeutralEmphasisHigh,
      'actionNeutralEmphasisMedium': actionNeutralEmphasisMedium,
      'actionNeutralEmphasisLow': actionNeutralEmphasisLow,
      'actionNeutralEmphasisHighInverse': actionNeutralEmphasisHighInverse,
      'actionNeutralEmphasisMediumInverse': actionNeutralEmphasisMediumInverse,
      'actionNeutralEmphasisLowInverse': actionNeutralEmphasisLowInverse,
      'actionDisabledBase': actionDisabledBase,
      'actionDisabledBaseInverse': actionDisabledBaseInverse,
      'onColorEmphasisHigh': onColorEmphasisHigh,
      'onColorEmphasisMedium': onColorEmphasisMedium,
      'onColorEmphasisLow': onColorEmphasisLow,
      'onColorEmphasisDisabled': onColorEmphasisDisabled,
      'onColorEmphasisHighInverse': onColorEmphasisHighInverse,
      'onColorEmphasisMediumInverse': onColorEmphasisMediumInverse,
      'onColorEmphasisLowInverse': onColorEmphasisLowInverse,
      'onColorEmphasisDisabledInverse': onColorEmphasisDisabledInverse,
      'onColorIndicatorHighlightBase': onColorIndicatorHighlightBase,
      'onColorIndicatorHighlightSurface': onColorIndicatorHighlightSurface,
      'onColorIndicatorHighlightBaseInverse': onColorIndicatorHighlightBaseInverse,
      'onColorIndicatorHighlightSurfaceInverse': onColorIndicatorHighlightSurfaceInverse,
      'onColorIndicatorPositiveBase': onColorIndicatorPositiveBase,
      'onColorIndicatorPositiveSurface': onColorIndicatorPositiveSurface,
      'onColorIndicatorPositiveBaseInverse': onColorIndicatorPositiveBaseInverse,
      'onColorIndicatorPositiveSurfaceInverse': onColorIndicatorPositiveSurfaceInverse,
      'onColorIndicatorNegativeBase': onColorIndicatorNegativeBase,
      'onColorIndicatorNegativeSurface': onColorIndicatorNegativeSurface,
      'onColorIndicatorNegativeBaseInverse': onColorIndicatorNegativeBaseInverse,
      'onColorIndicatorNegativeSurfaceInverse': onColorIndicatorNegativeSurfaceInverse,
      'statusSuccessBase': statusSuccessBase,
      'statusSuccessBaseSurface': statusSuccessBaseSurface,
      'statusSuccessBaseInverse': statusSuccessBaseInverse,
      'statusSuccessBaseSurfaceInverse': statusSuccessBaseSurfaceInverse,
      'statusWarningBase': statusWarningBase,
      'statusWarningBaseSurface': statusWarningBaseSurface,
      'statusWarningBaseInverse': statusWarningBaseInverse,
      'statusWarningBaseSurfaceInverse': statusWarningBaseSurfaceInverse,
      'statusErrorBase': statusErrorBase,
      'statusErrorBaseSurface': statusErrorBaseSurface,
      'statusErrorBaseInverse': statusErrorBaseInverse,
      'statusErrorBaseSurfaceInverse': statusErrorBaseSurfaceInverse,
      'statusInformativeBase': statusInformativeBase,
      'statusInformativeBaseSurface': statusInformativeBaseSurface,
      'statusInformativeBaseInverse': statusInformativeBaseInverse,
      'statusInformativeBaseSurfaceInverse': statusInformativeBaseSurfaceInverse,
      'outlineBase': outlineBase,
      'outlineBaseInverse': outlineBaseInverse,
      'outlineBaseFocus': outlineBaseFocus,
      'outlineBaseFocusInverse': outlineBaseFocusInverse,
      'backgroundBase': backgroundBase,
      'backgroundBaseInverse': backgroundBaseInverse,
      'supportAqua10': supportAqua10,
      'supportAqua20': supportAqua20,
      'supportAqua30': supportAqua30,
      'supportAqua40': supportAqua40,
      'supportAqua50': supportAqua50,
      'supportAqua60': supportAqua60,
      'supportAqua70': supportAqua70,
      'supportAqua80': supportAqua80,
      'supportAqua90': supportAqua90,
      'supportAqua100': supportAqua100,
      'supportBlue10': supportBlue10,
      'supportBlue20': supportBlue20,
      'supportBlue30': supportBlue30,
      'supportBlue40': supportBlue40,
      'supportBlue50': supportBlue50,
      'supportBlue60': supportBlue60,
      'supportBlue70': supportBlue70,
      'supportBlue80': supportBlue80,
      'supportBlue90': supportBlue90,
      'supportBlue100': supportBlue100,
      'supportBrown10': supportBrown10,
      'supportBrown20': supportBrown20,
      'supportBrown30': supportBrown30,
      'supportBrown40': supportBrown40,
      'supportBrown50': supportBrown50,
      'supportBrown60': supportBrown60,
      'supportBrown70': supportBrown70,
      'supportBrown80': supportBrown80,
      'supportBrown90': supportBrown90,
      'supportBrown100': supportBrown100,
      'supportGreen10': supportGreen10,
      'supportGreen20': supportGreen20,
      'supportGreen30': supportGreen30,
      'supportGreen40': supportGreen40,
      'supportGreen50': supportGreen50,
      'supportGreen60': supportGreen60,
      'supportGreen70': supportGreen70,
      'supportGreen80': supportGreen80,
      'supportGreen90': supportGreen90,
      'supportGreen100': supportGreen100,
      'supportGrey10': supportGrey10,
      'supportGrey20': supportGrey20,
      'supportGrey30': supportGrey30,
      'supportGrey40': supportGrey40,
      'supportGrey50': supportGrey50,
      'supportGrey60': supportGrey60,
      'supportGrey70': supportGrey70,
      'supportGrey80': supportGrey80,
      'supportGrey90': supportGrey90,
      'supportGrey100': supportGrey100,
      'supportLime10': supportLime10,
      'supportLime20': supportLime20,
      'supportLime30': supportLime30,
      'supportLime40': supportLime40,
      'supportLime50': supportLime50,
      'supportLime60': supportLime60,
      'supportLime70': supportLime70,
      'supportLime80': supportLime80,
      'supportLime90': supportLime90,
      'supportLime100': supportLime100,
      'supportOrange10': supportOrange10,
      'supportOrange20': supportOrange20,
      'supportOrange30': supportOrange30,
      'supportOrange40': supportOrange40,
      'supportOrange50': supportOrange50,
      'supportOrange60': supportOrange60,
      'supportOrange70': supportOrange70,
      'supportOrange80': supportOrange80,
      'supportOrange90': supportOrange90,
      'supportOrange100': supportOrange100,
      'supportPink10': supportPink10,
      'supportPink20': supportPink20,
      'supportPink30': supportPink30,
      'supportPink40': supportPink40,
      'supportPink50': supportPink50,
      'supportPink60': supportPink60,
      'supportPink70': supportPink70,
      'supportPink80': supportPink80,
      'supportPink90': supportPink90,
      'supportPink100': supportPink100,
      'supportPurple10': supportPurple10,
      'supportPurple20': supportPurple20,
      'supportPurple30': supportPurple30,
      'supportPurple40': supportPurple40,
      'supportPurple50': supportPurple50,
      'supportPurple60': supportPurple60,
      'supportPurple70': supportPurple70,
      'supportPurple80': supportPurple80,
      'supportPurple90': supportPurple90,
      'supportPurple100': supportPurple100,
      'supportRed10': supportRed10,
      'supportRed20': supportRed20,
      'supportRed30': supportRed30,
      'supportRed40': supportRed40,
      'supportRed50': supportRed50,
      'supportRed60': supportRed60,
      'supportRed70': supportRed70,
      'supportRed80': supportRed80,
      'supportRed90': supportRed90,
      'supportRed100': supportRed100,
      'supportViolet10': supportViolet10,
      'supportViolet20': supportViolet20,
      'supportViolet30': supportViolet30,
      'supportViolet40': supportViolet40,
      'supportViolet50': supportViolet50,
      'supportViolet60': supportViolet60,
      'supportViolet70': supportViolet70,
      'supportViolet80': supportViolet80,
      'supportViolet90': supportViolet90,
      'supportViolet100': supportViolet100,
      'supportYellow10': supportYellow10,
      'supportYellow20': supportYellow20,
      'supportYellow30': supportYellow30,
      'supportYellow40': supportYellow40,
      'supportYellow50': supportYellow50,
      'supportYellow60': supportYellow60,
      'supportYellow70': supportYellow70,
      'supportYellow80': supportYellow80,
      'supportYellow90': supportYellow90,
      'supportYellow100': supportYellow100,
      'specialFixedWhite': specialFixedWhite,
      'specialFixedBlack': specialFixedBlack,
      'specialShimmerBaseStart': specialShimmerBaseStart,
      'specialShimmerBaseEnd': specialShimmerBaseEnd,
      'specialShimmerBaseStartInverse': specialShimmerBaseStartInverse,
      'specialShimmerBaseEndInverse': specialShimmerBaseEndInverse,
      'surfaceBrand01': surfaceBrand01,
      'surfaceBrand02': surfaceBrand02,
      'surfaceBrand03': surfaceBrand03,
      'surfaceBrand04': surfaceBrand04,
      'surfaceBrand05': surfaceBrand05,
      'surfaceBrandOnBrand01Disabled': surfaceBrandOnBrand01Disabled,
      'surfaceBrandOnBrand01Outline': surfaceBrandOnBrand01Outline,
      'surfaceBrandOnBrand01ActionEnabled': surfaceBrandOnBrand01ActionEnabled,
      'surfaceBrandOnBrand01ActionHover': surfaceBrandOnBrand01ActionHover,
      'surfaceBrandOnBrand01ActionPressed': surfaceBrandOnBrand01ActionPressed,
      'surfaceBrandOnBrand01EmphasisHigh': surfaceBrandOnBrand01EmphasisHigh,
      'surfaceBrandOnBrand01EmphasisMedium': surfaceBrandOnBrand01EmphasisMedium,
      'surfaceBrandOnBrand01EmphasisLow': surfaceBrandOnBrand01EmphasisLow,
      'surfaceBrandOnBrand02Disabled': surfaceBrandOnBrand02Disabled,
      'surfaceBrandOnBrand02Outline': surfaceBrandOnBrand02Outline,
      'surfaceBrandOnBrand02ActionEnabled': surfaceBrandOnBrand02ActionEnabled,
      'surfaceBrandOnBrand02ActionHover': surfaceBrandOnBrand02ActionHover,
      'surfaceBrandOnBrand02ActionPressed': surfaceBrandOnBrand02ActionPressed,
      'surfaceBrandOnBrand02EmphasisHigh': surfaceBrandOnBrand02EmphasisHigh,
      'surfaceBrandOnBrand02EmphasisMedium': surfaceBrandOnBrand02EmphasisMedium,
      'surfaceBrandOnBrand02EmphasisLow': surfaceBrandOnBrand02EmphasisLow,
      'surfaceBrandOnBrand03Disabled': surfaceBrandOnBrand03Disabled,
      'surfaceBrandOnBrand03Outline': surfaceBrandOnBrand03Outline,
      'surfaceBrandOnBrand03ActionEnabled': surfaceBrandOnBrand03ActionEnabled,
      'surfaceBrandOnBrand03ActionHover': surfaceBrandOnBrand03ActionHover,
      'surfaceBrandOnBrand03ActionPressed': surfaceBrandOnBrand03ActionPressed,
      'surfaceBrandOnBrand03EmphasisHigh': surfaceBrandOnBrand03EmphasisHigh,
      'surfaceBrandOnBrand03EmphasisMedium': surfaceBrandOnBrand03EmphasisMedium,
      'surfaceBrandOnBrand03EmphasisLow': surfaceBrandOnBrand03EmphasisLow,
      'surfaceBrandOnBrand04Disabled': surfaceBrandOnBrand04Disabled,
      'surfaceBrandOnBrand04Outline': surfaceBrandOnBrand04Outline,
      'surfaceBrandOnBrand04ActionEnabled': surfaceBrandOnBrand04ActionEnabled,
      'surfaceBrandOnBrand04ActionHover': surfaceBrandOnBrand04ActionHover,
      'surfaceBrandOnBrand04ActionPressed': surfaceBrandOnBrand04ActionPressed,
      'surfaceBrandOnBrand04EmphasisHigh': surfaceBrandOnBrand04EmphasisHigh,
      'surfaceBrandOnBrand04EmphasisMedium': surfaceBrandOnBrand04EmphasisMedium,
      'surfaceBrandOnBrand04EmphasisLow': surfaceBrandOnBrand04EmphasisLow,
      'surfaceBrandOnBrand05Disabled': surfaceBrandOnBrand05Disabled,
      'surfaceBrandOnBrand05Outline': surfaceBrandOnBrand05Outline,
      'surfaceBrandOnBrand05ActionEnabled': surfaceBrandOnBrand05ActionEnabled,
      'surfaceBrandOnBrand05ActionHover': surfaceBrandOnBrand05ActionHover,
      'surfaceBrandOnBrand05ActionPressed': surfaceBrandOnBrand05ActionPressed,
      'surfaceBrandOnBrand05EmphasisHigh': surfaceBrandOnBrand05EmphasisHigh,
      'surfaceBrandOnBrand05EmphasisMedium': surfaceBrandOnBrand05EmphasisMedium,
      'surfaceBrandOnBrand05EmphasisLow': surfaceBrandOnBrand05EmphasisLow,
    };

    data.forEach(
      (key, value) {
        properties.add(ColorProperty(key, value, level: DiagnosticLevel.debug));
      },
    );

    properties.add(
      DiagnosticsProperty<List<BoxShadow>>(
        'elevationLow',
        elevationLow,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<List<BoxShadow>>(
        'elevationMedium',
        elevationMedium,
        level: DiagnosticLevel.debug,
      ),
    );
    properties.add(
      DiagnosticsProperty<List<BoxShadow>>(
        'elevationHigh',
        elevationHigh,
        level: DiagnosticLevel.debug,
      ),
    );
  }

  static GtbColorScheme lerp(GtbColorScheme a, GtbColorScheme b, double t) {
    return GtbColorScheme(
      primaryBase: Color.lerp(a.primaryBase, b.primaryBase, t)!,
      primaryBaseInverse: Color.lerp(a.primaryBaseInverse, b.primaryBaseInverse, t)!,
      primaryExtended10: Color.lerp(a.primaryExtended10, b.primaryExtended10, t)!,
      primaryExtended20: Color.lerp(a.primaryExtended20, b.primaryExtended20, t)!,
      primaryExtended30: Color.lerp(a.primaryExtended30, b.primaryExtended30, t)!,
      primaryExtended40: Color.lerp(a.primaryExtended40, b.primaryExtended40, t)!,
      primaryExtended50: Color.lerp(a.primaryExtended50, b.primaryExtended50, t)!,
      primaryExtended60: Color.lerp(a.primaryExtended60, b.primaryExtended60, t)!,
      primaryExtended70: Color.lerp(a.primaryExtended70, b.primaryExtended70, t)!,
      primaryExtended80: Color.lerp(a.primaryExtended80, b.primaryExtended80, t)!,
      primaryExtended90: Color.lerp(a.primaryExtended90, b.primaryExtended90, t)!,
      primaryExtended100: Color.lerp(a.primaryExtended100, b.primaryExtended100, t)!,
      secondaryBase: Color.lerp(a.secondaryBase, b.secondaryBase, t)!,
      secondaryBaseInverse: Color.lerp(a.secondaryBaseInverse, b.secondaryBaseInverse, t)!,
      neutralBase: Color.lerp(a.neutralBase, b.neutralBase, t)!,
      neutralBaseInverse: Color.lerp(a.neutralBaseInverse, b.neutralBaseInverse, t)!,
      neutralExtended10: Color.lerp(a.neutralExtended10, b.neutralExtended10, t)!,
      neutralExtended20: Color.lerp(a.neutralExtended20, b.neutralExtended20, t)!,
      neutralExtended30: Color.lerp(a.neutralExtended30, b.neutralExtended30, t)!,
      neutralExtended40: Color.lerp(a.neutralExtended40, b.neutralExtended40, t)!,
      neutralExtended50: Color.lerp(a.neutralExtended50, b.neutralExtended50, t)!,
      neutralExtended60: Color.lerp(a.neutralExtended60, b.neutralExtended60, t)!,
      neutralExtended70: Color.lerp(a.neutralExtended70, b.neutralExtended70, t)!,
      neutralExtended80: Color.lerp(a.neutralExtended80, b.neutralExtended80, t)!,
      neutralExtended90: Color.lerp(a.neutralExtended90, b.neutralExtended90, t)!,
      neutralExtended100: Color.lerp(a.neutralExtended100, b.neutralExtended100, t)!,
      actionMainEnabled: Color.lerp(a.actionMainEnabled, b.actionMainEnabled, t)!,
      actionMainHover: Color.lerp(a.actionMainHover, b.actionMainHover, t)!,
      actionMainFocus: Color.lerp(a.actionMainFocus, b.actionMainFocus, t)!,
      actionMainPressed: Color.lerp(a.actionMainPressed, b.actionMainPressed, t)!,
      actionMainSelected: Color.lerp(a.actionMainSelected, b.actionMainSelected, t)!,
      actionMainEnabledInverse: Color.lerp(
        a.actionMainEnabledInverse,
        b.actionMainEnabledInverse,
        t,
      )!,
      actionMainHoverInverse: Color.lerp(a.actionMainHoverInverse, b.actionMainHoverInverse, t)!,
      actionMainFocusInverse: Color.lerp(a.actionMainFocusInverse, b.actionMainFocusInverse, t)!,
      actionMainPressedInverse: Color.lerp(
        a.actionMainPressedInverse,
        b.actionMainPressedInverse,
        t,
      )!,
      actionMainSelectedInverse: Color.lerp(
        a.actionMainSelectedInverse,
        b.actionMainSelectedInverse,
        t,
      )!,
      actionMainEmphasisHigh: Color.lerp(a.actionMainEmphasisHigh, b.actionMainEmphasisHigh, t)!,
      actionMainEmphasisMedium: Color.lerp(
        a.actionMainEmphasisMedium,
        b.actionMainEmphasisMedium,
        t,
      )!,
      actionMainEmphasisLow: Color.lerp(a.actionMainEmphasisLow, b.actionMainEmphasisLow, t)!,
      actionMainEmphasisHighInverse: Color.lerp(
        a.actionMainEmphasisHighInverse,
        b.actionMainEmphasisHighInverse,
        t,
      )!,
      actionMainEmphasisMediumInverse: Color.lerp(
        a.actionMainEmphasisMediumInverse,
        b.actionMainEmphasisMediumInverse,
        t,
      )!,
      actionMainEmphasisLowInverse: Color.lerp(
        a.actionMainEmphasisLowInverse,
        b.actionMainEmphasisLowInverse,
        t,
      )!,
      actionSecondaryEnabled: Color.lerp(a.actionSecondaryEnabled, b.actionSecondaryEnabled, t)!,
      actionSecondaryHover: Color.lerp(a.actionSecondaryHover, b.actionSecondaryHover, t)!,
      actionSecondaryFocus: Color.lerp(a.actionSecondaryFocus, b.actionSecondaryFocus, t)!,
      actionSecondaryPressed: Color.lerp(a.actionSecondaryPressed, b.actionSecondaryPressed, t)!,
      actionSecondarySelected: Color.lerp(a.actionSecondarySelected, b.actionSecondarySelected, t)!,
      actionSecondaryEnabledInverse: Color.lerp(
        a.actionSecondaryEnabledInverse,
        b.actionSecondaryEnabledInverse,
        t,
      )!,
      actionSecondaryHoverInverse: Color.lerp(
        a.actionSecondaryHoverInverse,
        b.actionSecondaryHoverInverse,
        t,
      )!,
      actionSecondaryFocusInverse: Color.lerp(
        a.actionSecondaryFocusInverse,
        b.actionSecondaryFocusInverse,
        t,
      )!,
      actionSecondaryPressedInverse: Color.lerp(
        a.actionSecondaryPressedInverse,
        b.actionSecondaryPressedInverse,
        t,
      )!,
      actionSecondarySelectedInverse: Color.lerp(
        a.actionSecondarySelectedInverse,
        b.actionSecondarySelectedInverse,
        t,
      )!,
      actionSecondaryEmphasisHigh: Color.lerp(
        a.actionSecondaryEmphasisHigh,
        b.actionSecondaryEmphasisHigh,
        t,
      )!,
      actionSecondaryEmphasisMedium: Color.lerp(
        a.actionSecondaryEmphasisMedium,
        b.actionSecondaryEmphasisMedium,
        t,
      )!,
      actionSecondaryEmphasisLow: Color.lerp(
        a.actionSecondaryEmphasisLow,
        b.actionSecondaryEmphasisLow,
        t,
      )!,
      actionSecondaryEmphasisHighInverse: Color.lerp(
        a.actionSecondaryEmphasisHighInverse,
        b.actionSecondaryEmphasisHighInverse,
        t,
      )!,
      actionSecondaryEmphasisMediumInverse: Color.lerp(
        a.actionSecondaryEmphasisMediumInverse,
        b.actionSecondaryEmphasisMediumInverse,
        t,
      )!,
      actionSecondaryEmphasisLowInverse: Color.lerp(
        a.actionSecondaryEmphasisLowInverse,
        b.actionSecondaryEmphasisLowInverse,
        t,
      )!,
      actionNeutralEnabled: Color.lerp(a.actionNeutralEnabled, b.actionNeutralEnabled, t)!,
      actionNeutralHover: Color.lerp(a.actionNeutralHover, b.actionNeutralHover, t)!,
      actionNeutralFocus: Color.lerp(a.actionNeutralFocus, b.actionNeutralFocus, t)!,
      actionNeutralPressed: Color.lerp(a.actionNeutralPressed, b.actionNeutralPressed, t)!,
      actionNeutralSelected: Color.lerp(a.actionNeutralSelected, b.actionNeutralSelected, t)!,
      actionNeutralEnabledInverse: Color.lerp(
        a.actionNeutralEnabledInverse,
        b.actionNeutralEnabledInverse,
        t,
      )!,
      actionNeutralHoverInverse: Color.lerp(
        a.actionNeutralHoverInverse,
        b.actionNeutralHoverInverse,
        t,
      )!,
      actionNeutralFocusInverse: Color.lerp(
        a.actionNeutralFocusInverse,
        b.actionNeutralFocusInverse,
        t,
      )!,
      actionNeutralPressedInverse: Color.lerp(
        a.actionNeutralPressedInverse,
        b.actionNeutralPressedInverse,
        t,
      )!,
      actionNeutralSelectedInverse: Color.lerp(
        a.actionNeutralSelectedInverse,
        b.actionNeutralSelectedInverse,
        t,
      )!,
      actionNeutralEmphasisHigh: Color.lerp(
        a.actionNeutralEmphasisHigh,
        b.actionNeutralEmphasisHigh,
        t,
      )!,
      actionNeutralEmphasisMedium: Color.lerp(
        a.actionNeutralEmphasisMedium,
        b.actionNeutralEmphasisMedium,
        t,
      )!,
      actionNeutralEmphasisLow: Color.lerp(
        a.actionNeutralEmphasisLow,
        b.actionNeutralEmphasisLow,
        t,
      )!,
      actionNeutralEmphasisHighInverse: Color.lerp(
        a.actionNeutralEmphasisHighInverse,
        b.actionNeutralEmphasisHighInverse,
        t,
      )!,
      actionNeutralEmphasisMediumInverse: Color.lerp(
        a.actionNeutralEmphasisMediumInverse,
        b.actionNeutralEmphasisMediumInverse,
        t,
      )!,
      actionNeutralEmphasisLowInverse: Color.lerp(
        a.actionNeutralEmphasisLowInverse,
        b.actionNeutralEmphasisLowInverse,
        t,
      )!,
      actionDisabledBase: Color.lerp(a.actionDisabledBase, b.actionDisabledBase, t)!,
      actionDisabledBaseInverse: Color.lerp(
        a.actionDisabledBaseInverse,
        b.actionDisabledBaseInverse,
        t,
      )!,
      onColorEmphasisHigh: Color.lerp(a.onColorEmphasisHigh, b.onColorEmphasisHigh, t)!,
      onColorEmphasisMedium: Color.lerp(a.onColorEmphasisMedium, b.onColorEmphasisMedium, t)!,
      onColorEmphasisLow: Color.lerp(a.onColorEmphasisLow, b.onColorEmphasisLow, t)!,
      onColorEmphasisDisabled: Color.lerp(a.onColorEmphasisDisabled, b.onColorEmphasisDisabled, t)!,
      onColorEmphasisHighInverse: Color.lerp(
        a.onColorEmphasisHighInverse,
        b.onColorEmphasisHighInverse,
        t,
      )!,
      onColorEmphasisMediumInverse: Color.lerp(
        a.onColorEmphasisMediumInverse,
        b.onColorEmphasisMediumInverse,
        t,
      )!,
      onColorEmphasisLowInverse: Color.lerp(
        a.onColorEmphasisLowInverse,
        b.onColorEmphasisLowInverse,
        t,
      )!,
      onColorEmphasisDisabledInverse: Color.lerp(
        a.onColorEmphasisDisabledInverse,
        b.onColorEmphasisDisabledInverse,
        t,
      )!,
      onColorIndicatorHighlightBase: Color.lerp(
        a.onColorIndicatorHighlightBase,
        b.onColorIndicatorHighlightBase,
        t,
      )!,
      onColorIndicatorHighlightSurface: Color.lerp(
        a.onColorIndicatorHighlightSurface,
        b.onColorIndicatorHighlightSurface,
        t,
      )!,
      onColorIndicatorHighlightBaseInverse: Color.lerp(
        a.onColorIndicatorHighlightBaseInverse,
        b.onColorIndicatorHighlightBaseInverse,
        t,
      )!,
      onColorIndicatorHighlightSurfaceInverse: Color.lerp(
        a.onColorIndicatorHighlightSurfaceInverse,
        b.onColorIndicatorHighlightSurfaceInverse,
        t,
      )!,
      onColorIndicatorPositiveBase: Color.lerp(
        a.onColorIndicatorPositiveBase,
        b.onColorIndicatorPositiveBase,
        t,
      )!,
      onColorIndicatorPositiveSurface: Color.lerp(
        a.onColorIndicatorPositiveSurface,
        b.onColorIndicatorPositiveSurface,
        t,
      )!,
      onColorIndicatorPositiveBaseInverse: Color.lerp(
        a.onColorIndicatorPositiveBaseInverse,
        b.onColorIndicatorPositiveBaseInverse,
        t,
      )!,
      onColorIndicatorPositiveSurfaceInverse: Color.lerp(
        a.onColorIndicatorPositiveSurfaceInverse,
        b.onColorIndicatorPositiveSurfaceInverse,
        t,
      )!,
      onColorIndicatorNegativeBase: Color.lerp(
        a.onColorIndicatorNegativeBase,
        b.onColorIndicatorNegativeBase,
        t,
      )!,
      onColorIndicatorNegativeSurface: Color.lerp(
        a.onColorIndicatorNegativeSurface,
        b.onColorIndicatorNegativeSurface,
        t,
      )!,
      onColorIndicatorNegativeBaseInverse: Color.lerp(
        a.onColorIndicatorNegativeBaseInverse,
        b.onColorIndicatorNegativeBaseInverse,
        t,
      )!,
      onColorIndicatorNegativeSurfaceInverse: Color.lerp(
        a.onColorIndicatorNegativeSurfaceInverse,
        b.onColorIndicatorNegativeSurfaceInverse,
        t,
      )!,
      statusSuccessBase: Color.lerp(a.statusSuccessBase, b.statusSuccessBase, t)!,
      statusSuccessBaseSurface: Color.lerp(
        a.statusSuccessBaseSurface,
        b.statusSuccessBaseSurface,
        t,
      )!,
      statusSuccessBaseInverse: Color.lerp(
        a.statusSuccessBaseInverse,
        b.statusSuccessBaseInverse,
        t,
      )!,
      statusSuccessBaseSurfaceInverse: Color.lerp(
        a.statusSuccessBaseSurfaceInverse,
        b.statusSuccessBaseSurfaceInverse,
        t,
      )!,
      statusWarningBase: Color.lerp(a.statusWarningBase, b.statusWarningBase, t)!,
      statusWarningBaseSurface: Color.lerp(
        a.statusWarningBaseSurface,
        b.statusWarningBaseSurface,
        t,
      )!,
      statusWarningBaseInverse: Color.lerp(
        a.statusWarningBaseInverse,
        b.statusWarningBaseInverse,
        t,
      )!,
      statusWarningBaseSurfaceInverse: Color.lerp(
        a.statusWarningBaseSurfaceInverse,
        b.statusWarningBaseSurfaceInverse,
        t,
      )!,
      statusErrorBase: Color.lerp(a.statusErrorBase, b.statusErrorBase, t)!,
      statusErrorBaseSurface: Color.lerp(a.statusErrorBaseSurface, b.statusErrorBaseSurface, t)!,
      statusErrorBaseInverse: Color.lerp(a.statusErrorBaseInverse, b.statusErrorBaseInverse, t)!,
      statusErrorBaseSurfaceInverse: Color.lerp(
        a.statusErrorBaseSurfaceInverse,
        b.statusErrorBaseSurfaceInverse,
        t,
      )!,
      statusInformativeBase: Color.lerp(a.statusInformativeBase, b.statusInformativeBase, t)!,
      statusInformativeBaseSurface: Color.lerp(
        a.statusInformativeBaseSurface,
        b.statusInformativeBaseSurface,
        t,
      )!,
      statusInformativeBaseInverse: Color.lerp(
        a.statusInformativeBaseInverse,
        b.statusInformativeBaseInverse,
        t,
      )!,
      statusInformativeBaseSurfaceInverse: Color.lerp(
        a.statusInformativeBaseSurfaceInverse,
        b.statusInformativeBaseSurfaceInverse,
        t,
      )!,
      outlineBase: Color.lerp(a.outlineBase, b.outlineBase, t)!,
      outlineBaseInverse: Color.lerp(a.outlineBaseInverse, b.outlineBaseInverse, t)!,
      outlineBaseFocus: Color.lerp(a.outlineBaseFocus, b.outlineBaseFocus, t)!,
      outlineBaseFocusInverse: Color.lerp(a.outlineBaseFocusInverse, b.outlineBaseFocusInverse, t)!,
      backgroundBase: Color.lerp(a.backgroundBase, b.backgroundBase, t)!,
      backgroundBaseInverse: Color.lerp(a.backgroundBaseInverse, b.backgroundBaseInverse, t)!,
      supportAqua10: Color.lerp(a.supportAqua10, b.supportAqua10, t)!,
      supportAqua20: Color.lerp(a.supportAqua20, b.supportAqua20, t)!,
      supportAqua30: Color.lerp(a.supportAqua30, b.supportAqua30, t)!,
      supportAqua40: Color.lerp(a.supportAqua40, b.supportAqua40, t)!,
      supportAqua50: Color.lerp(a.supportAqua50, b.supportAqua50, t)!,
      supportAqua60: Color.lerp(a.supportAqua60, b.supportAqua60, t)!,
      supportAqua70: Color.lerp(a.supportAqua70, b.supportAqua70, t)!,
      supportAqua80: Color.lerp(a.supportAqua80, b.supportAqua80, t)!,
      supportAqua90: Color.lerp(a.supportAqua90, b.supportAqua90, t)!,
      supportAqua100: Color.lerp(a.supportAqua100, b.supportAqua100, t)!,
      supportBlue10: Color.lerp(a.supportBlue10, b.supportBlue10, t)!,
      supportBlue20: Color.lerp(a.supportBlue20, b.supportBlue20, t)!,
      supportBlue30: Color.lerp(a.supportBlue30, b.supportBlue30, t)!,
      supportBlue40: Color.lerp(a.supportBlue40, b.supportBlue40, t)!,
      supportBlue50: Color.lerp(a.supportBlue50, b.supportBlue50, t)!,
      supportBlue60: Color.lerp(a.supportBlue60, b.supportBlue60, t)!,
      supportBlue70: Color.lerp(a.supportBlue70, b.supportBlue70, t)!,
      supportBlue80: Color.lerp(a.supportBlue80, b.supportBlue80, t)!,
      supportBlue90: Color.lerp(a.supportBlue90, b.supportBlue90, t)!,
      supportBlue100: Color.lerp(a.supportBlue100, b.supportBlue100, t)!,
      supportBrown10: Color.lerp(a.supportBrown10, b.supportBrown10, t)!,
      supportBrown20: Color.lerp(a.supportBrown20, b.supportBrown20, t)!,
      supportBrown30: Color.lerp(a.supportBrown30, b.supportBrown30, t)!,
      supportBrown40: Color.lerp(a.supportBrown40, b.supportBrown40, t)!,
      supportBrown50: Color.lerp(a.supportBrown50, b.supportBrown50, t)!,
      supportBrown60: Color.lerp(a.supportBrown60, b.supportBrown60, t)!,
      supportBrown70: Color.lerp(a.supportBrown70, b.supportBrown70, t)!,
      supportBrown80: Color.lerp(a.supportBrown80, b.supportBrown80, t)!,
      supportBrown90: Color.lerp(a.supportBrown90, b.supportBrown90, t)!,
      supportBrown100: Color.lerp(a.supportBrown100, b.supportBrown100, t)!,
      supportGreen10: Color.lerp(a.supportGreen10, b.supportGreen10, t)!,
      supportGreen20: Color.lerp(a.supportGreen20, b.supportGreen20, t)!,
      supportGreen30: Color.lerp(a.supportGreen30, b.supportGreen30, t)!,
      supportGreen40: Color.lerp(a.supportGreen40, b.supportGreen40, t)!,
      supportGreen50: Color.lerp(a.supportGreen50, b.supportGreen50, t)!,
      supportGreen60: Color.lerp(a.supportGreen60, b.supportGreen60, t)!,
      supportGreen70: Color.lerp(a.supportGreen70, b.supportGreen70, t)!,
      supportGreen80: Color.lerp(a.supportGreen80, b.supportGreen80, t)!,
      supportGreen90: Color.lerp(a.supportGreen90, b.supportGreen90, t)!,
      supportGreen100: Color.lerp(a.supportGreen100, b.supportGreen100, t)!,
      supportGrey10: Color.lerp(a.supportGrey10, b.supportGrey10, t)!,
      supportGrey20: Color.lerp(a.supportGrey20, b.supportGrey20, t)!,
      supportGrey30: Color.lerp(a.supportGrey30, b.supportGrey30, t)!,
      supportGrey40: Color.lerp(a.supportGrey40, b.supportGrey40, t)!,
      supportGrey50: Color.lerp(a.supportGrey50, b.supportGrey50, t)!,
      supportGrey60: Color.lerp(a.supportGrey60, b.supportGrey60, t)!,
      supportGrey70: Color.lerp(a.supportGrey70, b.supportGrey70, t)!,
      supportGrey80: Color.lerp(a.supportGrey80, b.supportGrey80, t)!,
      supportGrey90: Color.lerp(a.supportGrey90, b.supportGrey90, t)!,
      supportGrey100: Color.lerp(a.supportGrey100, b.supportGrey100, t)!,
      supportLime10: Color.lerp(a.supportLime10, b.supportLime10, t)!,
      supportLime20: Color.lerp(a.supportLime20, b.supportLime20, t)!,
      supportLime30: Color.lerp(a.supportLime30, b.supportLime30, t)!,
      supportLime40: Color.lerp(a.supportLime40, b.supportLime40, t)!,
      supportLime50: Color.lerp(a.supportLime50, b.supportLime50, t)!,
      supportLime60: Color.lerp(a.supportLime60, b.supportLime60, t)!,
      supportLime70: Color.lerp(a.supportLime70, b.supportLime70, t)!,
      supportLime80: Color.lerp(a.supportLime80, b.supportLime80, t)!,
      supportLime90: Color.lerp(a.supportLime90, b.supportLime90, t)!,
      supportLime100: Color.lerp(a.supportLime100, b.supportLime100, t)!,
      supportOrange10: Color.lerp(a.supportOrange10, b.supportOrange10, t)!,
      supportOrange20: Color.lerp(a.supportOrange20, b.supportOrange20, t)!,
      supportOrange30: Color.lerp(a.supportOrange30, b.supportOrange30, t)!,
      supportOrange40: Color.lerp(a.supportOrange40, b.supportOrange40, t)!,
      supportOrange50: Color.lerp(a.supportOrange50, b.supportOrange50, t)!,
      supportOrange60: Color.lerp(a.supportOrange60, b.supportOrange60, t)!,
      supportOrange70: Color.lerp(a.supportOrange70, b.supportOrange70, t)!,
      supportOrange80: Color.lerp(a.supportOrange80, b.supportOrange80, t)!,
      supportOrange90: Color.lerp(a.supportOrange90, b.supportOrange90, t)!,
      supportOrange100: Color.lerp(a.supportOrange100, b.supportOrange100, t)!,
      supportPink10: Color.lerp(a.supportPink10, b.supportPink10, t)!,
      supportPink20: Color.lerp(a.supportPink20, b.supportPink20, t)!,
      supportPink30: Color.lerp(a.supportPink30, b.supportPink30, t)!,
      supportPink40: Color.lerp(a.supportPink40, b.supportPink40, t)!,
      supportPink50: Color.lerp(a.supportPink50, b.supportPink50, t)!,
      supportPink60: Color.lerp(a.supportPink60, b.supportPink60, t)!,
      supportPink70: Color.lerp(a.supportPink70, b.supportPink70, t)!,
      supportPink80: Color.lerp(a.supportPink80, b.supportPink80, t)!,
      supportPink90: Color.lerp(a.supportPink90, b.supportPink90, t)!,
      supportPink100: Color.lerp(a.supportPink100, b.supportPink100, t)!,
      supportPurple10: Color.lerp(a.supportPurple10, b.supportPurple10, t)!,
      supportPurple20: Color.lerp(a.supportPurple20, b.supportPurple20, t)!,
      supportPurple30: Color.lerp(a.supportPurple30, b.supportPurple30, t)!,
      supportPurple40: Color.lerp(a.supportPurple40, b.supportPurple40, t)!,
      supportPurple50: Color.lerp(a.supportPurple50, b.supportPurple50, t)!,
      supportPurple60: Color.lerp(a.supportPurple60, b.supportPurple60, t)!,
      supportPurple70: Color.lerp(a.supportPurple70, b.supportPurple70, t)!,
      supportPurple80: Color.lerp(a.supportPurple80, b.supportPurple80, t)!,
      supportPurple90: Color.lerp(a.supportPurple90, b.supportPurple90, t)!,
      supportPurple100: Color.lerp(a.supportPurple100, b.supportPurple100, t)!,
      supportRed10: Color.lerp(a.supportRed10, b.supportRed10, t)!,
      supportRed20: Color.lerp(a.supportRed20, b.supportRed20, t)!,
      supportRed30: Color.lerp(a.supportRed30, b.supportRed30, t)!,
      supportRed40: Color.lerp(a.supportRed40, b.supportRed40, t)!,
      supportRed50: Color.lerp(a.supportRed50, b.supportRed50, t)!,
      supportRed60: Color.lerp(a.supportRed60, b.supportRed60, t)!,
      supportRed70: Color.lerp(a.supportRed70, b.supportRed70, t)!,
      supportRed80: Color.lerp(a.supportRed80, b.supportRed80, t)!,
      supportRed90: Color.lerp(a.supportRed90, b.supportRed90, t)!,
      supportRed100: Color.lerp(a.supportRed100, b.supportRed100, t)!,
      supportViolet10: Color.lerp(a.supportViolet10, b.supportViolet10, t)!,
      supportViolet20: Color.lerp(a.supportViolet20, b.supportViolet20, t)!,
      supportViolet30: Color.lerp(a.supportViolet30, b.supportViolet30, t)!,
      supportViolet40: Color.lerp(a.supportViolet40, b.supportViolet40, t)!,
      supportViolet50: Color.lerp(a.supportViolet50, b.supportViolet50, t)!,
      supportViolet60: Color.lerp(a.supportViolet60, b.supportViolet60, t)!,
      supportViolet70: Color.lerp(a.supportViolet70, b.supportViolet70, t)!,
      supportViolet80: Color.lerp(a.supportViolet80, b.supportViolet80, t)!,
      supportViolet90: Color.lerp(a.supportViolet90, b.supportViolet90, t)!,
      supportViolet100: Color.lerp(a.supportViolet100, b.supportViolet100, t)!,
      supportYellow10: Color.lerp(a.supportYellow10, b.supportYellow10, t)!,
      supportYellow20: Color.lerp(a.supportYellow20, b.supportYellow20, t)!,
      supportYellow30: Color.lerp(a.supportYellow30, b.supportYellow30, t)!,
      supportYellow40: Color.lerp(a.supportYellow40, b.supportYellow40, t)!,
      supportYellow50: Color.lerp(a.supportYellow50, b.supportYellow50, t)!,
      supportYellow60: Color.lerp(a.supportYellow60, b.supportYellow60, t)!,
      supportYellow70: Color.lerp(a.supportYellow70, b.supportYellow70, t)!,
      supportYellow80: Color.lerp(a.supportYellow80, b.supportYellow80, t)!,
      supportYellow90: Color.lerp(a.supportYellow90, b.supportYellow90, t)!,
      supportYellow100: Color.lerp(a.supportYellow100, b.supportYellow100, t)!,
      specialFixedWhite: Color.lerp(a.specialFixedWhite, b.specialFixedWhite, t)!,
      specialFixedBlack: Color.lerp(a.specialFixedBlack, b.specialFixedBlack, t)!,
      specialShimmerBaseStart: Color.lerp(a.specialShimmerBaseStart, b.specialShimmerBaseStart, t)!,
      specialShimmerBaseEnd: Color.lerp(a.specialShimmerBaseEnd, b.specialShimmerBaseEnd, t)!,
      specialShimmerBaseStartInverse: Color.lerp(
        a.specialShimmerBaseStartInverse,
        b.specialShimmerBaseStartInverse,
        t,
      )!,
      specialShimmerBaseEndInverse: Color.lerp(
        a.specialShimmerBaseEndInverse,
        b.specialShimmerBaseEndInverse,
        t,
      )!,
      surfaceBrand01: Color.lerp(a.surfaceBrand01, b.surfaceBrand01, t)!,
      surfaceBrand02: Color.lerp(a.surfaceBrand02, b.surfaceBrand02, t)!,
      surfaceBrand03: Color.lerp(a.surfaceBrand03, b.surfaceBrand03, t)!,
      surfaceBrand04: Color.lerp(a.surfaceBrand04, b.surfaceBrand04, t)!,
      surfaceBrand05: Color.lerp(a.surfaceBrand05, b.surfaceBrand05, t)!,
      surfaceBrandOnBrand01Disabled: Color.lerp(
        a.surfaceBrandOnBrand01Disabled,
        b.surfaceBrandOnBrand01Disabled,
        t,
      )!,
      surfaceBrandOnBrand01Outline: Color.lerp(
        a.surfaceBrandOnBrand01Outline,
        b.surfaceBrandOnBrand01Outline,
        t,
      )!,
      surfaceBrandOnBrand01ActionEnabled: Color.lerp(
        a.surfaceBrandOnBrand01ActionEnabled,
        b.surfaceBrandOnBrand01ActionEnabled,
        t,
      )!,
      surfaceBrandOnBrand01ActionHover: Color.lerp(
        a.surfaceBrandOnBrand01ActionHover,
        b.surfaceBrandOnBrand01ActionHover,
        t,
      )!,
      surfaceBrandOnBrand01ActionPressed: Color.lerp(
        a.surfaceBrandOnBrand01ActionPressed,
        b.surfaceBrandOnBrand01ActionPressed,
        t,
      )!,
      surfaceBrandOnBrand01EmphasisHigh: Color.lerp(
        a.surfaceBrandOnBrand01EmphasisHigh,
        b.surfaceBrandOnBrand01EmphasisHigh,
        t,
      )!,
      surfaceBrandOnBrand01EmphasisMedium: Color.lerp(
        a.surfaceBrandOnBrand01EmphasisMedium,
        b.surfaceBrandOnBrand01EmphasisMedium,
        t,
      )!,
      surfaceBrandOnBrand01EmphasisLow: Color.lerp(
        a.surfaceBrandOnBrand01EmphasisLow,
        b.surfaceBrandOnBrand01EmphasisLow,
        t,
      )!,
      surfaceBrandOnBrand02Disabled: Color.lerp(
        a.surfaceBrandOnBrand02Disabled,
        b.surfaceBrandOnBrand02Disabled,
        t,
      )!,
      surfaceBrandOnBrand02Outline: Color.lerp(
        a.surfaceBrandOnBrand02Outline,
        b.surfaceBrandOnBrand02Outline,
        t,
      )!,
      surfaceBrandOnBrand02ActionEnabled: Color.lerp(
        a.surfaceBrandOnBrand02ActionEnabled,
        b.surfaceBrandOnBrand02ActionEnabled,
        t,
      )!,
      surfaceBrandOnBrand02ActionHover: Color.lerp(
        a.surfaceBrandOnBrand02ActionHover,
        b.surfaceBrandOnBrand02ActionHover,
        t,
      )!,
      surfaceBrandOnBrand02ActionPressed: Color.lerp(
        a.surfaceBrandOnBrand02ActionPressed,
        b.surfaceBrandOnBrand02ActionPressed,
        t,
      )!,
      surfaceBrandOnBrand02EmphasisHigh: Color.lerp(
        a.surfaceBrandOnBrand02EmphasisHigh,
        b.surfaceBrandOnBrand02EmphasisHigh,
        t,
      )!,
      surfaceBrandOnBrand02EmphasisMedium: Color.lerp(
        a.surfaceBrandOnBrand02EmphasisMedium,
        b.surfaceBrandOnBrand02EmphasisMedium,
        t,
      )!,
      surfaceBrandOnBrand02EmphasisLow: Color.lerp(
        a.surfaceBrandOnBrand02EmphasisLow,
        b.surfaceBrandOnBrand02EmphasisLow,
        t,
      )!,
      surfaceBrandOnBrand03Disabled: Color.lerp(
        a.surfaceBrandOnBrand03Disabled,
        b.surfaceBrandOnBrand03Disabled,
        t,
      )!,
      surfaceBrandOnBrand03Outline: Color.lerp(
        a.surfaceBrandOnBrand03Outline,
        b.surfaceBrandOnBrand03Outline,
        t,
      )!,
      surfaceBrandOnBrand03ActionEnabled: Color.lerp(
        a.surfaceBrandOnBrand03ActionEnabled,
        b.surfaceBrandOnBrand03ActionEnabled,
        t,
      )!,
      surfaceBrandOnBrand03ActionHover: Color.lerp(
        a.surfaceBrandOnBrand03ActionHover,
        b.surfaceBrandOnBrand03ActionHover,
        t,
      )!,
      surfaceBrandOnBrand03ActionPressed: Color.lerp(
        a.surfaceBrandOnBrand03ActionPressed,
        b.surfaceBrandOnBrand03ActionPressed,
        t,
      )!,
      surfaceBrandOnBrand03EmphasisHigh: Color.lerp(
        a.surfaceBrandOnBrand03EmphasisHigh,
        b.surfaceBrandOnBrand03EmphasisHigh,
        t,
      )!,
      surfaceBrandOnBrand03EmphasisMedium: Color.lerp(
        a.surfaceBrandOnBrand03EmphasisMedium,
        b.surfaceBrandOnBrand03EmphasisMedium,
        t,
      )!,
      surfaceBrandOnBrand03EmphasisLow: Color.lerp(
        a.surfaceBrandOnBrand03EmphasisLow,
        b.surfaceBrandOnBrand03EmphasisLow,
        t,
      )!,
      surfaceBrandOnBrand04Disabled: Color.lerp(
        a.surfaceBrandOnBrand04Disabled,
        b.surfaceBrandOnBrand04Disabled,
        t,
      )!,
      surfaceBrandOnBrand04Outline: Color.lerp(
        a.surfaceBrandOnBrand04Outline,
        b.surfaceBrandOnBrand04Outline,
        t,
      )!,
      surfaceBrandOnBrand04ActionEnabled: Color.lerp(
        a.surfaceBrandOnBrand04ActionEnabled,
        b.surfaceBrandOnBrand04ActionEnabled,
        t,
      )!,
      surfaceBrandOnBrand04ActionHover: Color.lerp(
        a.surfaceBrandOnBrand04ActionHover,
        b.surfaceBrandOnBrand04ActionHover,
        t,
      )!,
      surfaceBrandOnBrand04ActionPressed: Color.lerp(
        a.surfaceBrandOnBrand04ActionPressed,
        b.surfaceBrandOnBrand04ActionPressed,
        t,
      )!,
      surfaceBrandOnBrand04EmphasisHigh: Color.lerp(
        a.surfaceBrandOnBrand04EmphasisHigh,
        b.surfaceBrandOnBrand04EmphasisHigh,
        t,
      )!,
      surfaceBrandOnBrand04EmphasisMedium: Color.lerp(
        a.surfaceBrandOnBrand04EmphasisMedium,
        b.surfaceBrandOnBrand04EmphasisMedium,
        t,
      )!,
      surfaceBrandOnBrand04EmphasisLow: Color.lerp(
        a.surfaceBrandOnBrand04EmphasisLow,
        b.surfaceBrandOnBrand04EmphasisLow,
        t,
      )!,
      surfaceBrandOnBrand05Disabled: Color.lerp(
        a.surfaceBrandOnBrand05Disabled,
        b.surfaceBrandOnBrand05Disabled,
        t,
      )!,
      surfaceBrandOnBrand05Outline: Color.lerp(
        a.surfaceBrandOnBrand05Outline,
        b.surfaceBrandOnBrand05Outline,
        t,
      )!,
      surfaceBrandOnBrand05ActionEnabled: Color.lerp(
        a.surfaceBrandOnBrand05ActionEnabled,
        b.surfaceBrandOnBrand05ActionEnabled,
        t,
      )!,
      surfaceBrandOnBrand05ActionHover: Color.lerp(
        a.surfaceBrandOnBrand05ActionHover,
        b.surfaceBrandOnBrand05ActionHover,
        t,
      )!,
      surfaceBrandOnBrand05ActionPressed: Color.lerp(
        a.surfaceBrandOnBrand05ActionPressed,
        b.surfaceBrandOnBrand05ActionPressed,
        t,
      )!,
      surfaceBrandOnBrand05EmphasisHigh: Color.lerp(
        a.surfaceBrandOnBrand05EmphasisHigh,
        b.surfaceBrandOnBrand05EmphasisHigh,
        t,
      )!,
      surfaceBrandOnBrand05EmphasisMedium: Color.lerp(
        a.surfaceBrandOnBrand05EmphasisMedium,
        b.surfaceBrandOnBrand05EmphasisMedium,
        t,
      )!,
      surfaceBrandOnBrand05EmphasisLow: Color.lerp(
        a.surfaceBrandOnBrand05EmphasisLow,
        b.surfaceBrandOnBrand05EmphasisLow,
        t,
      )!,
      elevationLow: BoxShadow.lerpList(a.elevationLow, b.elevationLow, t)!,
      elevationMedium: BoxShadow.lerpList(a.elevationMedium, b.elevationMedium, t)!,
      elevationHigh: BoxShadow.lerpList(a.elevationHigh, b.elevationHigh, t)!,
    );
  }
}
