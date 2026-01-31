import 'dart:math';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:gtb_teatro/design_system/gtb_teatro.dart';
import 'package:intersperse/intersperse.dart';
import 'package:intl/intl.dart';

const _curve1 = Cubic(0.0, 0.0, 0.25, 1.0);
const _curve2 = Cubic(0.25, 0.0, 0.25, 1.0);
const _titleAnimationDuration = Duration(milliseconds: 250);
const _contentAnimationDuration = Duration(milliseconds: 300);
const _daySelectionAnimationDuration = Duration(milliseconds: 150);
const _switchCalendarModeAnimationDuration = Duration(milliseconds: 200);

final class GtbCalendarPeriod {
  GtbCalendarPeriod({
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;
}

typedef GtbSelectDateCallback = void Function(DateTime dateTime);

typedef GtbDatePickerActionSettingsBuilder<T> = GtbActionSettings<VoidCallback> Function(BuildContext context, T? data);

enum _CalendarVisualization {
  day,
  month,
  year,
}

enum _Day {
  sunday(1, 'Dom'),
  monday(2, 'Seg'),
  tuesday(3, 'Ter'),
  wednesday(4, 'Qua'),
  thursday(5, 'Qui'),
  friday(6, 'Sex'),
  saturday(7, 'Sab')
  ;

  const _Day(
    this.weekday,
    this.shortName,
  );

  final int weekday;
  final String shortName;
}

enum _Month {
  january(1, 'Janeiro'),
  february(2, 'Fevereiro'),
  march(3, 'Março'),
  april(4, 'Abril'),
  may(5, 'Maio'),
  june(6, 'Junho'),
  july(7, 'Julho'),
  august(8, 'Agosto'),
  september(9, 'Setembro'),
  october(10, 'Outubro'),
  november(11, 'Novembro'),
  december(12, 'Dezembro')
  ;

  const _Month(
    this.value,
    this.name,
  );

  final int value;
  final String name;
}

/// Abstract base class for calendar selection modes.
///
/// Use one of the provided factories to create a specific selection mode:
/// - [GtbCalendarSelectionMode.none] for no selection.
/// - [GtbCalendarSelectionMode.year] for year selection.
/// - [GtbCalendarSelectionMode.month] for month selection.
/// - [GtbCalendarSelectionMode.date] for date selection.
/// - [GtbCalendarSelectionMode.period] for period selection.
sealed class GtbCalendarSelectionMode {
  const GtbCalendarSelectionMode();

  const factory GtbCalendarSelectionMode.none() = GtbCalendarSelectionModeNone;

  const factory GtbCalendarSelectionMode.year({
    required ValueChanged<DateTime> onSelectYear,
    GtbYearEnabledPredicate yearEnabledPredicate,
  }) = GtbCalendarSelectionModeYear;

  const factory GtbCalendarSelectionMode.month({
    required ValueChanged<DateTime> onSelectMonth,
    GtbMonthEnabledPredicate monthEnabledPredicate,
  }) = GtbCalendarSelectionModeMonth;

  const factory GtbCalendarSelectionMode.date({
    required ValueChanged<DateTime?> onSelectDate,
    DateTime? initialSelectedDate,
    GtbDateEnabledPredicate dateEnabledPredicate,
  }) = GtbCalendarSelectionModeDate;

  const factory GtbCalendarSelectionMode.period({
    required ValueChanged<GtbCalendarPeriod?> onSelectPeriod,
    GtbCalendarPeriod? initialSelectedPeriod,
    GtbPeriodEnabledPredicate periodEnabledPredicate,
  }) = GtbCalendarSelectionModePeriod;
}

final class GtbCalendarSelectionModeNone extends GtbCalendarSelectionMode {
  const GtbCalendarSelectionModeNone();
}

final class GtbCalendarSelectionModeYear extends GtbCalendarSelectionMode {
  const GtbCalendarSelectionModeYear({
    required this.onSelectYear,
    this.yearEnabledPredicate = const GtbYearEnabledPredicate.value(true),
  });

  final ValueChanged<DateTime> onSelectYear;
  final GtbYearEnabledPredicate yearEnabledPredicate;
}

final class GtbCalendarSelectionModeMonth extends GtbCalendarSelectionMode {
  const GtbCalendarSelectionModeMonth({
    required this.onSelectMonth,
    this.monthEnabledPredicate = const GtbMonthEnabledPredicate.value(true),
  });

  final ValueChanged<DateTime> onSelectMonth;
  final GtbMonthEnabledPredicate monthEnabledPredicate;
}

final class GtbCalendarSelectionModeDate extends GtbCalendarSelectionMode {
  const GtbCalendarSelectionModeDate({
    required this.onSelectDate,
    this.initialSelectedDate,
    this.dateEnabledPredicate = const GtbDateEnabledPredicate.value(true),
  });

  final ValueChanged<DateTime?> onSelectDate;
  final DateTime? initialSelectedDate;
  final GtbDateEnabledPredicate dateEnabledPredicate;
}

final class GtbCalendarSelectionModePeriod extends GtbCalendarSelectionMode {
  const GtbCalendarSelectionModePeriod({
    required this.onSelectPeriod,
    this.initialSelectedPeriod,
    this.periodEnabledPredicate = const GtbPeriodEnabledPredicate.value(true),
  });

  final ValueChanged<GtbCalendarPeriod?> onSelectPeriod;
  final GtbCalendarPeriod? initialSelectedPeriod;
  final GtbPeriodEnabledPredicate periodEnabledPredicate;
}

final class GtbCalendar extends StatefulWidget {
  const GtbCalendar({
    super.key,
    this.selectionMode = const GtbCalendarSelectionMode.none(),
    this.initialDate,
    this.dayEvents = const {},
    this.monthEvents = const {},
    this.yearEvents = const {},
  });

  final GtbCalendarSelectionMode selectionMode;
  final DateTime? initialDate;
  final Map<DateTime, List<GtbSubCalendarEventIndicator>> dayEvents;
  final Map<DateTime, List<GtbSubCalendarEventIndicator>> monthEvents;
  final Map<DateTime, List<GtbSubCalendarEventIndicator>> yearEvents;

  @override
  State<GtbCalendar> createState() => _GtbCalendarState();
}

final class _GtbCalendarState extends State<GtbCalendar> {
  late _CalendarVisualization _calendarVisualization;
  late DateTime _focusedDate;
  late DateTime _lastFocusedDate;
  DateTime? _startSelectedDate;
  DateTime? _endSelectedDate;

  @override
  void initState() {
    super.initState();

    final initialDate = widget.initialDate ?? clock.now();
    _focusedDate = DateTime(initialDate.year, initialDate.month);
    _lastFocusedDate = _focusedDate;

    _initSelection();
    _loadInitialCalendarMode();
  }

  @override
  void didUpdateWidget(covariant GtbCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialDate != widget.initialDate) {
      final initialDate = widget.initialDate ?? clock.now();
      _focusedDate = DateTime(initialDate.year, initialDate.month);
      _lastFocusedDate = _focusedDate;
    }

    if (oldWidget.selectionMode.runtimeType != widget.selectionMode.runtimeType) {
      _initSelection();
      _loadInitialCalendarMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _switchCalendarModeAnimationDuration,
      transitionBuilder: (child, animation) {
        final isChildEntering = child.key == ValueKey(_calendarVisualization);

        final scaleAnimation = CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 1.0, curve: _curve2),
        );

        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: isChildEntering
              ? const Interval(0.0, 0.75, curve: _curve2) //
              : const Interval(0.25, 1.0, curve: _curve2),
        );

        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
      child: switch (_calendarVisualization) {
        _CalendarVisualization.day => _CalendarDayMode(
          key: ValueKey(_calendarVisualization),
          events: widget.dayEvents,
          focusedDate: _focusedDate,
          lastFocusedDate: _lastFocusedDate,
          startSelectedDate: _startSelectedDate,
          endSelectedDate: _endSelectedDate,
          onCheckIsDayEnabled: _checkIsDayEnabled,
          onPressMonthAndYear: _openYearMode,
          onChangeFocusedDate: _configureFocusedDate,
          onSelectDate: widget.selectionMode == const GtbCalendarSelectionMode.none()
              ? null //
              : _handleSelectedDate,
        ),
        _CalendarVisualization.month => _CalendarMonthMode(
          key: ValueKey(_calendarVisualization),
          events: widget.monthEvents,
          focusedDate: _focusedDate,
          lastFocusedDate: _lastFocusedDate,
          onCheckIsMonthEnabled: _checkIsMonthEnabled,
          onChangeYear: _configureFocusedDate,
          onSelectMonth: _handleSelectedMonth,
        ),
        _CalendarVisualization.year => _CalendarYearMode(
          key: ValueKey(_calendarVisualization),
          events: widget.yearEvents,
          focusedDate: _focusedDate,
          lastFocusedDate: _lastFocusedDate,
          onCheckIsYearEnabled: _checkIsYearEnabled,
          onChangeYearRange: _configureFocusedDate,
          onSelectYear: _handleSelectedYear,
        ),
      },
    );
  }

  void _initSelection() {
    _startSelectedDate = switch (widget.selectionMode) {
      final GtbCalendarSelectionModeDate selectionMode => selectionMode.initialSelectedDate,
      final GtbCalendarSelectionModePeriod selectionMode => selectionMode.initialSelectedPeriod?.startDate,
      GtbCalendarSelectionModeNone() || //
      GtbCalendarSelectionModeMonth() ||
      GtbCalendarSelectionModeYear() => null,
    };

    _endSelectedDate = switch (widget.selectionMode) {
      final GtbCalendarSelectionModePeriod selectionMode => selectionMode.initialSelectedPeriod?.endDate,
      GtbCalendarSelectionModeNone() || //
      GtbCalendarSelectionModeDate() ||
      GtbCalendarSelectionModeMonth() ||
      GtbCalendarSelectionModeYear() => null,
    };
  }

  void _loadInitialCalendarMode() {
    _calendarVisualization = switch (widget.selectionMode) {
      GtbCalendarSelectionModeNone() => _CalendarVisualization.day,
      GtbCalendarSelectionModeDate() => _CalendarVisualization.day,
      GtbCalendarSelectionModePeriod() => _CalendarVisualization.day,
      GtbCalendarSelectionModeMonth() => _CalendarVisualization.month,
      GtbCalendarSelectionModeYear() => _CalendarVisualization.year,
    };
  }

  void _openYearMode() {
    setState(() {
      _calendarVisualization = _CalendarVisualization.year;
    });
  }

  void _handleSelectedMonth(DateTime date) {
    switch (widget.selectionMode) {
      case GtbCalendarSelectionModeMonth(:final onSelectMonth):
        onSelectMonth(date);
      case GtbCalendarSelectionModeYear():
        throw StateError("The month can't be selected when in GtbCalendarSelectionModeYear mode.");
      case GtbCalendarSelectionModeNone():
      case GtbCalendarSelectionModeDate():
      case GtbCalendarSelectionModePeriod():
        setState(() {
          _configureFocusedDate(date);
          _calendarVisualization = _CalendarVisualization.day;
        });
    }
  }

  void _handleSelectedYear(DateTime date) {
    switch (widget.selectionMode) {
      case GtbCalendarSelectionModeMonth():
        throw StateError("The year can't be selected when in GtbCalendarSelectionModeMonth mode.");
      case GtbCalendarSelectionModeYear(:final onSelectYear):
        onSelectYear(date);
      case GtbCalendarSelectionModeNone():
      case GtbCalendarSelectionModeDate():
      case GtbCalendarSelectionModePeriod():
        setState(() {
          _configureFocusedDate(date);
          _calendarVisualization = _CalendarVisualization.month;
        });
    }
  }

  void _handleSelectedDate(DateTime dateTime) {
    switch (widget.selectionMode) {
      case GtbCalendarSelectionModeNone():
      case GtbCalendarSelectionModeMonth():
      case GtbCalendarSelectionModeYear():
        throw StateError(
          "A date can't be selected when in the following modes: "
          '[GtbCalendarSelectionModeNone, GtbCalendarSelectionModeMonth, GtbCalendarSelectionModeYear].',
        );
      case GtbCalendarSelectionModeDate(:final onSelectDate):
        setState(() {
          _startSelectedDate = dateTime;
          _endSelectedDate = null;
        });

        if (_startSelectedDate case final startSelectedDate?) {
          onSelectDate(startSelectedDate);
        } else {
          onSelectDate(null);
        }
      case GtbCalendarSelectionModePeriod(:final onSelectPeriod):
        setState(() {
          if (_startSelectedDate != null && _endSelectedDate != null) {
            _startSelectedDate = dateTime;
            _endSelectedDate = null;
          } else if (_startSelectedDate case final startSelectedDate?) {
            if (startSelectedDate.millisecondsSinceEpoch > dateTime.millisecondsSinceEpoch) {
              _endSelectedDate = _startSelectedDate;
              _startSelectedDate = dateTime;
            } else if (startSelectedDate.millisecondsSinceEpoch < dateTime.millisecondsSinceEpoch) {
              _endSelectedDate = dateTime;
            }
          } else {
            _startSelectedDate = dateTime;
          }
        });

        if ((_startSelectedDate, _endSelectedDate) case (final startSelectedDate?, final endSelectedDate?)) {
          onSelectPeriod(
            GtbCalendarPeriod(
              startDate: startSelectedDate,
              endDate: endSelectedDate,
            ),
          );
        } else {
          onSelectPeriod(null);
        }
    }
  }

  void _configureFocusedDate(DateTime dateTime) {
    setState(() {
      _lastFocusedDate = _focusedDate;
      _focusedDate = dateTime;
    });
  }

  bool _checkIsDayEnabled(int year, int month, int day) {
    final selectionMode = widget.selectionMode;

    switch (selectionMode) {
      case GtbCalendarSelectionModeNone():
      case GtbCalendarSelectionModeYear():
      case GtbCalendarSelectionModeMonth():
        return true;
      case GtbCalendarSelectionModeDate():
        return selectionMode.dateEnabledPredicate.isDayValid(year, month, day);
      case GtbCalendarSelectionModePeriod():
        if (_startSelectedDate case final startSelectedDate?) {
          return selectionMode.periodEnabledPredicate.isEndDayValid(
            startSelectedDate.year,
            startSelectedDate.month,
            startSelectedDate.day,
            year,
            month,
            day,
          );
        } else {
          return selectionMode.periodEnabledPredicate.isStartDayValid(year, month, day);
        }
    }
  }

  bool _checkIsMonthEnabled(int year, int month) {
    final selectionMode = widget.selectionMode;

    switch (selectionMode) {
      case GtbCalendarSelectionModeNone():
      case GtbCalendarSelectionModeYear():
        return true;
      case GtbCalendarSelectionModeMonth():
        return selectionMode.monthEnabledPredicate.isMonthValid(year, month);
      case GtbCalendarSelectionModeDate():
        return selectionMode.dateEnabledPredicate.isMonthValid(year, month);
      case GtbCalendarSelectionModePeriod():
        if (_startSelectedDate case final startSelectedDate?) {
          return selectionMode.periodEnabledPredicate.isEndMonthValid(
            startSelectedDate.year,
            startSelectedDate.month,
            startSelectedDate.day,
            year,
            month,
          );
        } else {
          return selectionMode.periodEnabledPredicate.isStartMonthValid(year, month);
        }
    }
  }

  bool _checkIsYearEnabled(int year) {
    final selectionMode = widget.selectionMode;

    switch (selectionMode) {
      case GtbCalendarSelectionModeNone():
        return true;
      case GtbCalendarSelectionModeYear():
        return selectionMode.yearEnabledPredicate.isYearValid(year);
      case GtbCalendarSelectionModeMonth():
        return selectionMode.monthEnabledPredicate.isYearValid(year);
      case GtbCalendarSelectionModeDate():
        return selectionMode.dateEnabledPredicate.isYearValid(year);
      case GtbCalendarSelectionModePeriod():
        if (_startSelectedDate case final startSelectedDate?) {
          return selectionMode.periodEnabledPredicate.isEndYearValid(
            startSelectedDate.year,
            startSelectedDate.month,
            startSelectedDate.day,
            year,
          );
        } else {
          return selectionMode.periodEnabledPredicate.isStartYearValid(year);
        }
    }
  }
}

sealed class GtbDatePickerSelectionMode {
  const GtbDatePickerSelectionMode();

  const factory GtbDatePickerSelectionMode.date(
    DateTime? initialSelectedDate,
    GtbDateEnabledPredicate dateEnabledPredicate,
    GtbDatePickerActionSettingsBuilder<DateTime?>? primaryActionSettingsBuilder,
    GtbDatePickerActionSettingsBuilder<DateTime?>? secondaryActionSettingsBuilder,
  ) = GtbDatePickerSelectionModeDate;

  const factory GtbDatePickerSelectionMode.period(
    GtbCalendarPeriod? initialSelectedPeriod,
    GtbPeriodEnabledPredicate periodEnabledPredicate,
    GtbDatePickerActionSettingsBuilder<GtbCalendarPeriod?>? primaryActionSettingsBuilder,
    GtbDatePickerActionSettingsBuilder<GtbCalendarPeriod?>? secondaryActionSettingsBuilder,
  ) = GtbDatePickerSelectionModePeriod;
}

final class GtbDatePickerSelectionModeDate extends GtbDatePickerSelectionMode {
  const GtbDatePickerSelectionModeDate(
    this.initialSelectedDate,
    this.dateEnabledPredicate,
    this.primaryActionSettingsBuilder,
    this.secondaryActionSettingsBuilder,
  );

  final DateTime? initialSelectedDate;
  final GtbDateEnabledPredicate dateEnabledPredicate;
  final GtbDatePickerActionSettingsBuilder<DateTime?>? primaryActionSettingsBuilder;
  final GtbDatePickerActionSettingsBuilder<DateTime?>? secondaryActionSettingsBuilder;
}

final class GtbDatePickerSelectionModePeriod extends GtbDatePickerSelectionMode {
  const GtbDatePickerSelectionModePeriod(
    this.initialSelectedPeriod,
    this.periodEnabledPredicate,
    this.primaryActionSettingsBuilder,
    this.secondaryActionSettingsBuilder,
  );

  final GtbCalendarPeriod? initialSelectedPeriod;
  final GtbPeriodEnabledPredicate periodEnabledPredicate;
  final GtbDatePickerActionSettingsBuilder<GtbCalendarPeriod?>? primaryActionSettingsBuilder;
  final GtbDatePickerActionSettingsBuilder<GtbCalendarPeriod?>? secondaryActionSettingsBuilder;
}

final class GtbDatePicker extends StatefulWidget {
  GtbDatePicker.date({
    super.key,
    DateTime? initialDate,
    this.dayEvents = const {},
    this.monthEvents = const {},
    this.yearEvents = const {},
    DateTime? initialSelectedDate,
    GtbDateEnabledPredicate dateEnabledPredicate = const GtbDateEnabledPredicate.value(true),
    GtbDatePickerActionSettingsBuilder<DateTime?>? primaryActionSettingsBuilder,
    GtbDatePickerActionSettingsBuilder<DateTime?>? secondaryActionSettingsBuilder,
  }) : initialDate = initialDate ?? initialSelectedDate,
       selectionMode = GtbDatePickerSelectionModeDate(
         initialSelectedDate,
         dateEnabledPredicate,
         primaryActionSettingsBuilder,
         secondaryActionSettingsBuilder,
       );

  GtbDatePicker.period({
    super.key,
    DateTime? initialDate,
    this.dayEvents = const {},
    this.monthEvents = const {},
    this.yearEvents = const {},
    GtbCalendarPeriod? initialSelectedPeriod,
    GtbPeriodEnabledPredicate periodEnabledPredicate = const GtbPeriodEnabledPredicate.value(true),
    GtbDatePickerActionSettingsBuilder<GtbCalendarPeriod?>? primaryActionSettingsBuilder,
    GtbDatePickerActionSettingsBuilder<GtbCalendarPeriod?>? secondaryActionSettingsBuilder,
  }) : initialDate = initialDate ?? initialSelectedPeriod?.startDate,
       selectionMode = GtbDatePickerSelectionModePeriod(
         initialSelectedPeriod,
         periodEnabledPredicate,
         primaryActionSettingsBuilder,
         secondaryActionSettingsBuilder,
       );

  final GtbDatePickerSelectionMode selectionMode;
  final DateTime? initialDate;
  final Map<DateTime, List<GtbSubCalendarEventIndicator>> dayEvents;
  final Map<DateTime, List<GtbSubCalendarEventIndicator>> monthEvents;
  final Map<DateTime, List<GtbSubCalendarEventIndicator>> yearEvents;

  @override
  State<GtbDatePicker> createState() => _GtbDatePickerState();
}

final class _GtbDatePickerState extends State<GtbDatePicker> {
  DateTime? _initialSelectedDate;
  DateTime? _selectedDate;
  GtbCalendarPeriod? _initialSelectedPeriod;
  GtbCalendarPeriod? _selectedPeriod;

  @override
  void initState() {
    super.initState();
    _initSelection();
  }

  @override
  Widget build(BuildContext context) {
    return GtbModal(
      title: const Text(''),
      content: GtbCalendar(
        selectionMode: switch (widget.selectionMode) {
          GtbDatePickerSelectionModeDate(:final dateEnabledPredicate) => GtbCalendarSelectionMode.date(
            onSelectDate: _handleSelectedDate,
            initialSelectedDate: _initialSelectedDate,
            dateEnabledPredicate: dateEnabledPredicate,
          ),
          GtbDatePickerSelectionModePeriod(:final periodEnabledPredicate) => GtbCalendarSelectionMode.period(
            onSelectPeriod: _handleSelectedPeriod,
            initialSelectedPeriod: _initialSelectedPeriod,
            periodEnabledPredicate: periodEnabledPredicate,
          ),
        },
        initialDate: widget.initialDate,
        dayEvents: widget.dayEvents,
        monthEvents: widget.monthEvents,
        yearEvents: widget.yearEvents,
      ),
      primaryAction: switch (widget.selectionMode) {
        GtbDatePickerSelectionModeDate(:final primaryActionSettingsBuilder) => primaryActionSettingsBuilder?.call(
          context,
          _selectedDate,
        ),
        GtbDatePickerSelectionModePeriod(:final primaryActionSettingsBuilder) => primaryActionSettingsBuilder?.call(
          context,
          _selectedPeriod,
        ),
      },
      secondaryAction: switch (widget.selectionMode) {
        GtbDatePickerSelectionModeDate(:final secondaryActionSettingsBuilder) => secondaryActionSettingsBuilder?.call(
          context,
          _selectedDate,
        ),
        GtbDatePickerSelectionModePeriod(:final secondaryActionSettingsBuilder) => secondaryActionSettingsBuilder?.call(
          context,
          _selectedPeriod,
        ),
      },
    );
  }

  void _initSelection() {
    _initialSelectedDate = _selectedDate = switch (widget.selectionMode) {
      final GtbDatePickerSelectionModeDate selectionMode => selectionMode.initialSelectedDate,
      GtbDatePickerSelectionModePeriod() => null,
    };

    _initialSelectedPeriod = _selectedPeriod = switch (widget.selectionMode) {
      final GtbDatePickerSelectionModePeriod selectionMode => selectionMode.initialSelectedPeriod,
      GtbDatePickerSelectionModeDate() => null,
    };
  }

  void _handleSelectedDate(DateTime? date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _handleSelectedPeriod(GtbCalendarPeriod? period) {
    setState(() {
      _selectedPeriod = period;
    });
  }
}

enum GtbSubCalendarDayState {
  enabled,
  selected,
  disabled,
  empty,
}

enum GtbSubCalendarDayRangeInterval {
  none,
  left,
  right,
  middle,
}

final class GtbSubCalendarDay extends StatefulWidget {
  const GtbSubCalendarDay({
    required this.date,
    required this.state,
    required this.interval,
    super.key,
    this.events = const [],
    this.onSelectDate,
  });

  final DateTime date;
  final GtbSubCalendarDayState state;
  final GtbSubCalendarDayRangeInterval interval;
  final List<GtbSubCalendarEventIndicator> events;
  final GtbSelectDateCallback? onSelectDate;

  @override
  State<GtbSubCalendarDay> createState() => _GtbSubCalendarDayState();
}

final class _GtbSubCalendarDayState extends State<GtbSubCalendarDay> with TickerProviderStateMixin {
  late final AnimationController _leftRangeAnimation;
  late final AnimationController _rightRangeAnimation;
  late final AnimationController _middleRangeAnimation;
  late final AnimationController _selectionAnimationController;
  late final CurvedAnimation _selectionAnimation;
  late bool _hasLeftRange;
  late bool _hasRightRange;
  late bool _hasSelection;
  late bool _hasBorder;

  @override
  void initState() {
    super.initState();

    _loadProperties();

    _leftRangeAnimation = AnimationController(
      vsync: this,
      duration: _daySelectionAnimationDuration,
      value: _hasLeftRange ? 1.0 : 0.0,
    );

    _rightRangeAnimation = AnimationController(
      vsync: this,
      duration: _daySelectionAnimationDuration,
      value: _hasRightRange ? 1.0 : 0.0,
    );

    _middleRangeAnimation = AnimationController(
      vsync: this,
      duration: _daySelectionAnimationDuration,
      value: _hasLeftRange && _hasRightRange ? 1.0 : 0.0,
    );

    _selectionAnimationController = AnimationController(
      vsync: this,
      duration: _daySelectionAnimationDuration,
      value: _hasSelection ? 1.0 : 0.0,
    );

    _selectionAnimation = CurvedAnimation(
      parent: _selectionAnimationController,
      curve: _curve1,
    );
  }

  @override
  void didUpdateWidget(covariant GtbSubCalendarDay oldWidget) {
    super.didUpdateWidget(oldWidget);

    _loadProperties();

    if (_hasLeftRange) {
      _leftRangeAnimation.forward();
    } else {
      _leftRangeAnimation.reverse();
    }

    if (_hasRightRange) {
      _rightRangeAnimation.forward();
    } else {
      _rightRangeAnimation.reverse();
    }

    if (_hasLeftRange && _hasRightRange) {
      _middleRangeAnimation.forward();
    } else {
      _middleRangeAnimation.reverse();
    }

    if (_hasSelection) {
      _selectionAnimationController.forward();
    } else {
      _selectionAnimationController.reverse();
    }
  }

  @override
  void dispose() {
    _leftRangeAnimation.dispose();
    _rightRangeAnimation.dispose();
    _middleRangeAnimation.dispose();
    _selectionAnimationController.dispose();
    _selectionAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;

    final label = AnimatedDefaultTextStyle(
      duration: _daySelectionAnimationDuration,
      style: typography.labelSmall.copyWith(
        color: switch (widget.state) {
          GtbSubCalendarDayState.enabled => colorScheme.onColorEmphasisMedium,
          GtbSubCalendarDayState.selected => colorScheme.onColorEmphasisHighInverse,
          GtbSubCalendarDayState.disabled => colorScheme.onColorEmphasisDisabled,
          GtbSubCalendarDayState.empty => kTransparentColor,
        },
      ),
      child: Text('${widget.date.day}'),
    );

    return GtbInkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1000.0),
      ),
      onTap: widget.onSelectDate == null
          ? null //
          : () => widget.onSelectDate?.call(widget.date),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _CalendarDayDecorationPainter(
              rangeColor: colorScheme.actionNeutralPressed,
              selectionColor: colorScheme.actionSecondarySelected,
              borderColor: colorScheme.secondaryBase,
              borderColorInverse: colorScheme.secondaryBaseInverse,
              hasBorder: _hasBorder,
              leftRangeAnimation: _leftRangeAnimation,
              rightRangeAnimation: _rightRangeAnimation,
              middleRangeAnimation: _middleRangeAnimation,
              selectionAnimation: _selectionAnimation,
            ),
          ),
          if (widget.events.isEmpty)
            label
          else
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GtbGap.xxs,
                label,
                Padding(
                  padding: const EdgeInsets.only(bottom: GtbPaddingValue.xxxs),
                  child: _EventsRow(events: widget.events),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _loadProperties() {
    final currentDate = clock.now();

    _hasLeftRange =
        [
          GtbSubCalendarDayState.enabled,
          GtbSubCalendarDayState.disabled,
          GtbSubCalendarDayState.selected,
        ].contains(widget.state) &&
        [
          GtbSubCalendarDayRangeInterval.left,
          GtbSubCalendarDayRangeInterval.middle,
        ].contains(widget.interval);

    _hasRightRange =
        [
          GtbSubCalendarDayState.enabled,
          GtbSubCalendarDayState.disabled,
          GtbSubCalendarDayState.selected,
        ].contains(widget.state) &&
        [
          GtbSubCalendarDayRangeInterval.right,
          GtbSubCalendarDayRangeInterval.middle,
        ].contains(widget.interval);

    _hasSelection = widget.state == GtbSubCalendarDayState.selected;

    _hasBorder =
        [
          GtbSubCalendarDayState.enabled,
          GtbSubCalendarDayState.disabled,
          GtbSubCalendarDayState.selected,
        ].contains(widget.state) &&
        currentDate.year == widget.date.year &&
        currentDate.month == widget.date.month &&
        currentDate.day == widget.date.day;
  }
}

final class GtbSubCalendarOptionYearMonth extends StatelessWidget {
  const GtbSubCalendarOptionYearMonth({
    required this.label,
    super.key,
    this.events = const [],
    this.onPress,
  });

  final Widget label;
  final List<GtbSubCalendarEventIndicator> events;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return ElevatedButton(
      onPressed: onPress,
      style:
          ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: GtbPaddingValue.xs),
            shadowColor: kTransparentColor,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textStyle: typography.bodyBase,
          ).copyWith(
            backgroundColor: generateState(
              kTransparentColor,
              pressed: colorScheme.actionNeutralPressed,
            ),
            foregroundColor: generateState(
              colorScheme.onColorEmphasisHigh,
              pressed: colorScheme.onColorEmphasisHigh,
              disabled: colorScheme.onColorEmphasisDisabled,
            ),
            overlayColor: generateState(Theme.of(context).splashColor),
            shape: generateState(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(theme.borderTheme.radiusSmall),
              ),
              pressed: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(theme.borderTheme.radiusSmall),
                side: BorderSide(
                  color: colorScheme.outlineBase,
                  width: theme.borderTheme.strokeThin,
                ),
              ),
              disabled: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(theme.borderTheme.radiusSmall),
              ),
            ),
          ),
      child: switch (events.isEmpty) {
        true => label,
        false => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GtbGap.xxs,
            label,
            Padding(
              padding: const EdgeInsets.only(top: GtbPaddingValue.xxxs),
              child: _EventsRow(events: events),
            ),
          ],
        ),
      },
    );
  }
}

enum GtbSubCalendarActionKind {
  previous,
  next,
}

final class GtbSubCalendarAction extends StatelessWidget {
  const GtbSubCalendarAction({
    required this.kind,
    super.key,
    this.onPress,
  });

  const GtbSubCalendarAction.previous({
    super.key,
    this.onPress,
  }) : kind = GtbSubCalendarActionKind.previous;

  const GtbSubCalendarAction.next({
    super.key,
    this.onPress,
  }) : kind = GtbSubCalendarActionKind.next;

  final GtbSubCalendarActionKind kind;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GtbIconContainer(
      icon: switch (kind) {
        GtbSubCalendarActionKind.previous => GtbIcons.chevronLeft,
        GtbSubCalendarActionKind.next => GtbIcons.chevronRight,
      },
      size: GtbIconContainerSize.size24,
      onPress: onPress,
    );
  }
}

enum GtbSubCalendarEventIndicatorKind {
  category1,
  category2,
  category3,
  category4,
  info,
}

enum GtbSubCalendarEventIndicatorSize {
  small,
  large,
}

final class GtbSubCalendarEventIndicator extends StatelessWidget {
  const GtbSubCalendarEventIndicator({
    required this.kind,
    required this.title,
    required this.description,
    super.key,
    this.size = GtbSubCalendarEventIndicatorSize.small,
  });

  const GtbSubCalendarEventIndicator.category1({
    required this.title,
    required this.description,
    super.key,
    this.size = GtbSubCalendarEventIndicatorSize.small,
  }) : kind = GtbSubCalendarEventIndicatorKind.category1;

  const GtbSubCalendarEventIndicator.category2({
    required this.title,
    required this.description,
    super.key,
    this.size = GtbSubCalendarEventIndicatorSize.small,
  }) : kind = GtbSubCalendarEventIndicatorKind.category2;

  const GtbSubCalendarEventIndicator.category3({
    required this.title,
    required this.description,
    super.key,
    this.size = GtbSubCalendarEventIndicatorSize.small,
  }) : kind = GtbSubCalendarEventIndicatorKind.category3;

  const GtbSubCalendarEventIndicator.category4({
    required this.title,
    required this.description,
    super.key,
    this.size = GtbSubCalendarEventIndicatorSize.small,
  }) : kind = GtbSubCalendarEventIndicatorKind.category4;

  const GtbSubCalendarEventIndicator.info({
    required this.title,
    required this.description,
    super.key,
    this.size = GtbSubCalendarEventIndicatorSize.small,
  }) : kind = GtbSubCalendarEventIndicatorKind.info;

  final GtbSubCalendarEventIndicatorKind kind;
  final GtbSubCalendarEventIndicatorSize size;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = GtbThemeProvider.of(context).appColorScheme;

    final color = switch (kind) {
      GtbSubCalendarEventIndicatorKind.category1 => colorScheme.supportYellow70,
      GtbSubCalendarEventIndicatorKind.category2 => colorScheme.supportRed70,
      GtbSubCalendarEventIndicatorKind.category3 => colorScheme.supportAqua70,
      GtbSubCalendarEventIndicatorKind.category4 => colorScheme.supportLime70,
      GtbSubCalendarEventIndicatorKind.info => colorScheme.statusInformativeBase,
    };

    final sizeValue = switch (size) {
      GtbSubCalendarEventIndicatorSize.small => 4.0,
      GtbSubCalendarEventIndicatorSize.large => 8.0,
    };

    return Container(
      width: sizeValue,
      height: sizeValue,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

final class _CalendarDayMode extends StatelessWidget {
  const _CalendarDayMode({
    required this.events,
    required this.focusedDate,
    required this.lastFocusedDate,
    required this.startSelectedDate,
    required this.endSelectedDate,
    required this.onCheckIsDayEnabled,
    required this.onPressMonthAndYear,
    required this.onChangeFocusedDate,
    required this.onSelectDate,
    super.key,
  });

  static final _monthFormatter = DateFormat('MMMM y');
  static const _totalCalendarDays = 42;

  final Map<DateTime, List<GtbSubCalendarEventIndicator>> events;
  final DateTime focusedDate;
  final DateTime lastFocusedDate;
  final DateTime? startSelectedDate;
  final DateTime? endSelectedDate;
  final bool Function(int year, int month, int day) onCheckIsDayEnabled;
  final VoidCallback onPressMonthAndYear;
  final ValueChanged<DateTime> onChangeFocusedDate;
  final ValueChanged<DateTime>? onSelectDate;

  @override
  Widget build(BuildContext context) {
    final previousMonthDate = DateTime(focusedDate.year, focusedDate.month - 1);
    final daysInPreviousMonth = DateTime(previousMonthDate.year, previousMonthDate.month + 1, 0).day;
    final startWeekday = focusedDate.weekday % 7;
    final firstVisibleDay = daysInPreviousMonth - startWeekday;

    final datesToShow = [
      for (int i = 1; i <= _totalCalendarDays; i++) //
        DateTime(previousMonthDate.year, previousMonthDate.month, firstVisibleDay + i),
    ];

    return _CalendarFrame(
      header: ClipRect(
        child: GtbButtonInline(
          isSelected: false,
          label: AnimatedSwitcher(
            duration: _titleAnimationDuration,
            transitionBuilder: (child, animation) {
              final isChildEntering = child.key == ValueKey(focusedDate);
              final isMovingForward = lastFocusedDate.millisecondsSinceEpoch < focusedDate.millisecondsSinceEpoch;

              return _titleTransitionFrom(child, animation, isChildEntering, isMovingForward);
            },
            child: Text(
              key: ValueKey(focusedDate),
              _monthFormatter.format(focusedDate).capitalize(),
            ),
          ),
          onPress: onPressMonthAndYear,
        ),
      ),
      content: Column(
        children: [
          Row(
            children: [
              for (final dayName in _Day.values.map((day) => day.shortName))
                Expanded(
                  child: Center(
                    child: Text(dayName),
                  ),
                ),
            ],
          ),
          GtbGap.xs,
          AnimatedSwitcher(
            duration: _contentAnimationDuration,
            transitionBuilder: (child, animation) {
              final isChildEntering = child.key == ValueKey(focusedDate);
              final isMovingForward = lastFocusedDate.millisecondsSinceEpoch < focusedDate.millisecondsSinceEpoch;

              return _contentTransitionFrom(child, animation, isChildEntering, isMovingForward);
            },
            child: _CalendarDayTable(
              key: ValueKey(focusedDate),
              items: datesToShow,
              numberOfColumns: 7,
              builder: (date) {
                final isDateEnabled = onCheckIsDayEnabled(date.year, date.month, date.day);

                final GtbSubCalendarDayState state;
                if (_isSameDay(startSelectedDate, date) || _isSameDay(endSelectedDate, date)) {
                  state = GtbSubCalendarDayState.selected;
                } else if (_isSameMonthAndYear(focusedDate, date) && isDateEnabled) {
                  state = GtbSubCalendarDayState.enabled;
                } else {
                  state = GtbSubCalendarDayState.disabled;
                }

                final GtbSubCalendarDayRangeInterval interval;
                if (_isInsideInterval(date)) {
                  if (_isSameDay(date, startSelectedDate)) {
                    interval = switch (date.weekday) {
                      6 => GtbSubCalendarDayRangeInterval.none,
                      _ => GtbSubCalendarDayRangeInterval.right,
                    };
                  } else if (_isSameDay(date, endSelectedDate)) {
                    interval = switch (date.weekday) {
                      7 => GtbSubCalendarDayRangeInterval.none,
                      _ => GtbSubCalendarDayRangeInterval.left,
                    };
                  } else {
                    interval = switch (date.weekday) {
                      6 => GtbSubCalendarDayRangeInterval.left,
                      7 => GtbSubCalendarDayRangeInterval.right,
                      _ => GtbSubCalendarDayRangeInterval.middle,
                    };
                  }
                } else {
                  interval = GtbSubCalendarDayRangeInterval.none;
                }

                final events = this
                    .events
                    .entries //
                    .where((mapEntry) => _isSameDay(mapEntry.key, date))
                    .map((mapEntry) => mapEntry.value)
                    .expand((eventList) => eventList)
                    .toList(growable: false);

                return SizedBox(
                  height: MediaQuery.textScalerOf(context).scale(40.0),
                  child: GtbSubCalendarDay(
                    key: ValueKey(date),
                    date: date,
                    state: state,
                    interval: interval,
                    events: events,
                    onSelectDate: isDateEnabled
                        ? onSelectDate //
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      onOpenPrevious: _openPreviousMonth,
      onOpenCurrent: _openCurrentMonth,
      onOpenNext: _openNextMonth,
    );
  }

  void _openCurrentMonth() {
    final currentDate = clock.now();
    onChangeFocusedDate(DateTime(currentDate.year, currentDate.month));
  }

  void _openPreviousMonth() {
    onChangeFocusedDate(DateTime(focusedDate.year, focusedDate.month - 1));
  }

  void _openNextMonth() {
    onChangeFocusedDate(DateTime(focusedDate.year, focusedDate.month + 1));
  }

  bool _isInsideInterval(DateTime date) {
    final startSelectedDate = this.startSelectedDate;
    final endSelectedDate = this.endSelectedDate;

    return startSelectedDate != null && //
        endSelectedDate != null &&
        startSelectedDate.millisecondsSinceEpoch <= date.millisecondsSinceEpoch &&
        endSelectedDate.millisecondsSinceEpoch >= date.millisecondsSinceEpoch;
  }
}

final class _CalendarMonthMode extends StatelessWidget {
  const _CalendarMonthMode({
    required this.events,
    required this.focusedDate,
    required this.lastFocusedDate,
    required this.onCheckIsMonthEnabled,
    required this.onChangeYear,
    required this.onSelectMonth,
    super.key,
  });

  final Map<DateTime, List<GtbSubCalendarEventIndicator>> events;
  final DateTime focusedDate;
  final DateTime lastFocusedDate;
  final bool Function(int year, int month) onCheckIsMonthEnabled;
  final ValueChanged<DateTime> onChangeYear;
  final ValueChanged<DateTime> onSelectMonth;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;

    return _CalendarFrame(
      header: AnimatedSwitcher(
        duration: _titleAnimationDuration,
        transitionBuilder: (child, animation) {
          final isChildEntering = child.key == ValueKey(focusedDate);
          final isMovingForward = lastFocusedDate.millisecondsSinceEpoch < focusedDate.millisecondsSinceEpoch;

          return _titleTransitionFrom(child, animation, isChildEntering, isMovingForward);
        },
        child: Text(
          key: ValueKey(focusedDate),
          '${focusedDate.year}',
          style: typography.bodyBase.copyWith(color: colorScheme.onColorEmphasisHigh),
        ),
      ),
      content: _CalendarMonthAndYearTable(
        key: ValueKey(focusedDate),
        items: _Month.values,
        numberOfColumns: 3,
        builder: (month) {
          final date = DateTime(focusedDate.year, month.value);

          final events = this
              .events
              .entries //
              .where((mapEntry) => _isSameMonthAndYear(mapEntry.key, date))
              .map((mapEntry) => mapEntry.value)
              .expand((eventList) => eventList)
              .toList(growable: false);

          return SizedBox(
            height: MediaQuery.textScalerOf(context).scale(75.0),
            child: GtbSubCalendarOptionYearMonth(
              label: Text(month.name),
              events: events,
              onPress: onCheckIsMonthEnabled(date.year, month.value)
                  ? (() => onSelectMonth(date)) //
                  : null,
            ),
          );
        },
      ),
      onOpenPrevious: () {
        onChangeYear(focusedDate.copyWith(year: focusedDate.year - 1));
      },
      onOpenCurrent: () {
        onChangeYear(focusedDate.copyWith(year: clock.now().year));
      },
      onOpenNext: () {
        onChangeYear(focusedDate.copyWith(year: focusedDate.year + 1));
      },
    );
  }
}

final class _CalendarYearMode extends StatelessWidget {
  const _CalendarYearMode({
    required this.events,
    required this.focusedDate,
    required this.lastFocusedDate,
    required this.onCheckIsYearEnabled,
    required this.onSelectYear,
    required this.onChangeYearRange,
    super.key,
  });

  final Map<DateTime, List<GtbSubCalendarEventIndicator>> events;
  final DateTime focusedDate;
  final DateTime lastFocusedDate;
  final bool Function(int year) onCheckIsYearEnabled;
  final ValueChanged<DateTime> onSelectYear;
  final ValueChanged<DateTime> onChangeYearRange;

  @override
  Widget build(BuildContext context) {
    final theme = GtbThemeProvider.of(context);
    final colorScheme = theme.appColorScheme;
    final typography = theme.typography;
    const numberOfYears = 20;

    return _CalendarFrame(
      header: AnimatedSwitcher(
        duration: _titleAnimationDuration,
        transitionBuilder: (child, animation) {
          final isChildEntering = child.key == ValueKey(focusedDate);
          final isMovingForward = lastFocusedDate.millisecondsSinceEpoch < focusedDate.millisecondsSinceEpoch;

          return _titleTransitionFrom(child, animation, isChildEntering, isMovingForward);
        },
        child: Text(
          key: ValueKey(focusedDate),
          '${focusedDate.year - numberOfYears + 1} - ${focusedDate.year}',
          style: typography.bodyBase.copyWith(color: colorScheme.onColorEmphasisHigh),
        ),
      ),
      content: AnimatedSwitcher(
        duration: _contentAnimationDuration,
        transitionBuilder: (child, animation) {
          final isChildEntering = child.key == ValueKey(focusedDate);
          final isMovingForward = lastFocusedDate.millisecondsSinceEpoch < focusedDate.millisecondsSinceEpoch;

          return _contentTransitionFrom(child, animation, isChildEntering, isMovingForward);
        },
        child: _CalendarMonthAndYearTable(
          key: ValueKey(focusedDate),
          items: [
            for (int i = 0; i < numberOfYears; i++) //
              focusedDate.year - numberOfYears + i + 1,
          ],
          numberOfColumns: 4,
          builder: (year) {
            final date = DateTime(year);

            final events =
                this //
                    .events
                    .entries
                    .where((mapEntry) => mapEntry.key.year == date.year)
                    .map((mapEntry) => mapEntry.value)
                    .expand((eventList) => eventList)
                    .toList(growable: false);

            return SizedBox(
              height: MediaQuery.textScalerOf(context).scale(60.0),
              child: GtbSubCalendarOptionYearMonth(
                label: Text('${date.year}'),
                events: events,
                onPress: onCheckIsYearEnabled(date.year)
                    ? (() => onSelectYear(date)) //
                    : null,
              ),
            );
          },
        ),
      ),
      onOpenPrevious: () {
        onChangeYearRange(focusedDate.copyWith(year: focusedDate.year - numberOfYears));
      },
      onOpenCurrent: () {
        onChangeYearRange(focusedDate.copyWith(year: clock.now().year));
      },
      onOpenNext: () {
        onChangeYearRange(focusedDate.copyWith(year: focusedDate.year + numberOfYears));
      },
    );
  }
}

final class _CalendarFrame extends StatelessWidget {
  const _CalendarFrame({
    required this.header,
    required this.content,
    required this.onOpenPrevious,
    required this.onOpenCurrent,
    required this.onOpenNext,
  });

  final Widget header;
  final Widget content;
  final VoidCallback onOpenPrevious;
  final VoidCallback onOpenCurrent;
  final VoidCallback onOpenNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            GtbSubCalendarAction.previous(
              onPress: onOpenPrevious,
            ),
            GtbGap.xs,
            Expanded(
              child: Center(
                child: header,
              ),
            ),
            GtbGap.xs,
            GtbSubCalendarAction.next(
              onPress: onOpenNext,
            ),
          ],
        ),
        GtbGap.xs,
        GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx < 0) {
              onOpenNext();
            }
            if (details.velocity.pixelsPerSecond.dx > 0) {
              onOpenPrevious();
            }
          },
          child: content,
        ),
        GtbGap.xs,
        GtbLink(
          size: GtbLinkSize.large,
          label: const Text('Hoje'),
          isUnderline: true,
          onPress: onOpenCurrent,
        ),
      ],
    );
  }
}

final class _CalendarDayDecorationPainter extends CustomPainter {
  _CalendarDayDecorationPainter({
    required this.rangeColor,
    required this.selectionColor,
    required this.borderColor,
    required this.borderColorInverse,
    required this.hasBorder,
    required this.leftRangeAnimation,
    required this.rightRangeAnimation,
    required this.middleRangeAnimation,
    required this.selectionAnimation,
  }) : super(
         repaint: Listenable.merge(
           [
             leftRangeAnimation,
             rightRangeAnimation,
             middleRangeAnimation,
             selectionAnimation,
           ],
         ),
       );

  final Color rangeColor;
  final Color selectionColor;
  final Color borderColor;
  final Color borderColorInverse;
  final bool hasBorder;
  final Animation<double> leftRangeAnimation;
  final Animation<double> rightRangeAnimation;
  final Animation<double> middleRangeAnimation;
  final Animation<double> selectionAnimation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final diameter = min(size.width, size.height);
    final horizontalShift = (size.width - diameter) / 2.0;
    final verticalShift = (size.height - diameter) / 2.0;

    if (middleRangeAnimation.value > 0) {
      paint.color = rangeColor.withValues(alpha: middleRangeAnimation.value);
      final rect = Rect.fromLTWH(
        0,
        0,
        size.width.ceilToDouble(),
        size.height,
      );
      canvas.drawRect(rect, paint);
    } else {
      if (leftRangeAnimation.value > 0) {
        paint.color = rangeColor.withValues(alpha: leftRangeAnimation.value);
        final rect = Rect.fromLTWH(
          0,
          0,
          size.width - horizontalShift,
          size.height - verticalShift,
        );
        final rRect = RRect.fromRectAndCorners(
          rect,
          topRight: Radius.circular(diameter / 2),
          bottomRight: Radius.circular(diameter / 2),
        );
        canvas.drawRRect(rRect, paint);
      }

      if (rightRangeAnimation.value > 0) {
        paint.color = rangeColor.withValues(alpha: rightRangeAnimation.value);
        final rect = Rect.fromLTWH(
          horizontalShift,
          verticalShift,
          (size.width - horizontalShift).ceilToDouble(),
          size.height - verticalShift,
        );
        final rRect = RRect.fromRectAndCorners(
          rect,
          topLeft: Radius.circular(diameter / 2),
          bottomLeft: Radius.circular(diameter / 2),
        );
        canvas.drawRRect(rRect, paint);
      }
    }

    if (selectionAnimation.value > 0) {
      paint.color = selectionColor;
      final rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: diameter * selectionAnimation.value,
        height: diameter * selectionAnimation.value,
      );
      final rRect = RRect.fromRectAndRadius(rect, Radius.circular(diameter / 2));
      canvas.drawRRect(rRect, paint);
    }

    if (hasBorder) {
      final borderPaint = Paint()
        ..color = Color.lerp(borderColor, borderColorInverse, selectionAnimation.value)!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      final circleOffset = Offset(size.width / 2, size.height / 2);

      canvas.drawCircle(circleOffset, size.height / 2, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CalendarDayDecorationPainter oldDelegate) {
    return oldDelegate.rangeColor != rangeColor || //
        oldDelegate.selectionColor != selectionColor ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.hasBorder != hasBorder ||
        oldDelegate.leftRangeAnimation.value != leftRangeAnimation.value ||
        oldDelegate.rightRangeAnimation.value != rightRangeAnimation.value ||
        oldDelegate.middleRangeAnimation.value != middleRangeAnimation.value ||
        oldDelegate.selectionAnimation.value != selectionAnimation.value;
  }
}

final class _EventsRow extends StatelessWidget {
  const _EventsRow({
    required this.events,
  });

  final List<GtbSubCalendarEventIndicator> events;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: intersperse(
        const SizedBox(width: 2.0),
        events,
      ).toList(growable: false),
    );
  }
}

final class _CalendarDayTable<T> extends StatelessWidget {
  const _CalendarDayTable({
    required this.items,
    required this.numberOfColumns,
    required this.builder,
    super.key,
  });

  final List<T> items;
  final int numberOfColumns;
  final Widget Function(T data) builder;

  @override
  Widget build(BuildContext context) {
    final numberOfRows = items.length / numberOfColumns;

    return Table(
      children: [
        for (int i = 0; i < numberOfRows; i = i + 1) ...[
          TableRow(
            children: [
              for (int j = 0; j < numberOfColumns; j = j + 1)
                if ((i * numberOfColumns) + j case final itemIndex when itemIndex < items.length)
                  Center(
                    child: builder(items[itemIndex]),
                  )
                else //
                  const SizedBox.shrink(),
            ],
          ),
          if (i < numberOfRows - 1)
            TableRow(
              children: [
                for (int j = 0; j < numberOfColumns; j = j + 1) //
                  const SizedBox(height: GtbGapValue.xxxs),
              ],
            ),
        ],
      ],
    );
  }
}

final class _CalendarMonthAndYearTable<T> extends StatelessWidget {
  const _CalendarMonthAndYearTable({
    required this.items,
    required this.numberOfColumns,
    required this.builder,
    super.key,
  });

  final List<T> items;
  final int numberOfColumns;
  final Widget Function(T data) builder;

  @override
  Widget build(BuildContext context) {
    final numberOfColumnsWithSpaces = numberOfColumns * 2 - 1;

    return Table(
      columnWidths: {
        for (int i = 0; i < numberOfColumnsWithSpaces; i++)
          i: i.isEven
              ? const IntrinsicColumnWidth() //
              : const FlexColumnWidth(),
      },
      children: [
        for (int i = 0; i < items.length / numberOfColumns; i = i + 1)
          TableRow(
            children: [
              for (int j = 0; j < numberOfColumnsWithSpaces; j = j + 1)
                () {
                  final itemIndex = (i * numberOfColumns) + (j + 1) ~/ 2;
                  if (j.isEven && itemIndex < items.length) {
                    return builder(items[itemIndex]);
                  } else {
                    return const SizedBox.shrink();
                  }
                }(),
            ],
          ),
      ],
    );
  }
}

/// Predicate interface to determine if a calendar year is enabled for selection in the calendar.
///
/// See also.
/// [GtbYearEnabledPredicateValue]
/// [GtbYearEnabledPredicateCustom]
abstract interface class GtbYearEnabledPredicate {
  // ignore: avoid_positional_boolean_parameters
  const factory GtbYearEnabledPredicate.value(bool value) = GtbYearEnabledPredicateValue;

  const factory GtbYearEnabledPredicate.custom({
    required bool Function(int year) onCheckIsValidYear,
  }) = GtbYearEnabledPredicateCustom;

  bool isYearValid(int year);
}

/// A predicate that enables or disables a calendar year based on a fixed boolean value.
final class GtbYearEnabledPredicateValue implements GtbYearEnabledPredicate {
  // ignore: avoid_positional_boolean_parameters
  const GtbYearEnabledPredicateValue(this.value);

  final bool value;

  @override
  bool isYearValid(int year) => value;
}

/// A predicate that enables or disables a calendar year based on a custom function.
final class GtbYearEnabledPredicateCustom implements GtbYearEnabledPredicate {
  const GtbYearEnabledPredicateCustom({
    required this.onCheckIsValidYear,
  });

  final bool Function(int year) onCheckIsValidYear;

  @override
  bool isYearValid(int year) => onCheckIsValidYear(year);
}

/// Predicate interface to determine if a calendar month is enabled for selection in the calendar.
///
/// See also.
/// [GtbMonthEnabledPredicateValue]
/// [GtbMonthEnabledPredicateCustom]
abstract interface class GtbMonthEnabledPredicate {
  // ignore: avoid_positional_boolean_parameters
  const factory GtbMonthEnabledPredicate.value(bool value) = GtbMonthEnabledPredicateValue;

  const factory GtbMonthEnabledPredicate.custom({
    required bool Function(int year) onCheckIsValidYear,
    required bool Function(int year, int month) onCheckIsValidMonth,
  }) = GtbMonthEnabledPredicateCustom;

  bool isYearValid(int year);

  bool isMonthValid(int year, int month);
}

/// A predicate that enables or disables a calendar month based on a fixed boolean value.
final class GtbMonthEnabledPredicateValue implements GtbMonthEnabledPredicate {
  // ignore: avoid_positional_boolean_parameters
  const GtbMonthEnabledPredicateValue(this.value);

  final bool value;

  @override
  bool isYearValid(int year) => value;

  @override
  bool isMonthValid(int year, int month) => value;
}

/// A predicate that enables or disables a calendar month based on custom functions.
final class GtbMonthEnabledPredicateCustom implements GtbMonthEnabledPredicate {
  const GtbMonthEnabledPredicateCustom({
    required this.onCheckIsValidYear,
    required this.onCheckIsValidMonth,
  });

  final bool Function(int year) onCheckIsValidYear;
  final bool Function(int year, int month) onCheckIsValidMonth;

  @override
  bool isYearValid(int year) => onCheckIsValidYear(year);

  @override
  bool isMonthValid(int year, int month) => onCheckIsValidMonth(year, month);
}

/// Predicate interface to determine if a calendar date is enabled for selection in the calendar.
/// See also.
/// [GtbDateEnabledPredicateValue]
/// [GtbDateEnabledPredicateMinDate]
/// [GtbDateEnabledPredicateMaxDate]
/// [GtbDateEnabledPredicatePeriod]
/// [GtbDateEnabledPredicateCustom]
abstract interface class GtbDateEnabledPredicate {
  // ignore: avoid_positional_boolean_parameters
  const factory GtbDateEnabledPredicate.value(bool value) = GtbDateEnabledPredicateValue;

  const factory GtbDateEnabledPredicate.minDate(DateTime minDate) = GtbDateEnabledPredicateMinDate;

  const factory GtbDateEnabledPredicate.maxDate(DateTime maxDate) = GtbDateEnabledPredicateMaxDate;

  const factory GtbDateEnabledPredicate.period({
    required DateTime startDate,
    required DateTime endDate,
  }) = GtbDateEnabledPredicatePeriod;

  const factory GtbDateEnabledPredicate.custom({
    required bool Function(int year) onCheckIsValidYear,
    required bool Function(int year, int month) onCheckIsValidMonth,
    required bool Function(int year, int month, int day) onCheckIsValidDay,
  }) = GtbDateEnabledPredicateCustom;

  bool isYearValid(int year);

  bool isMonthValid(int year, int month);

  bool isDayValid(int year, int month, int day);
}

/// A predicate that enables or disables a calendar date based on a fixed boolean value.
final class GtbDateEnabledPredicateValue implements GtbDateEnabledPredicate {
  // ignore: avoid_positional_boolean_parameters
  const GtbDateEnabledPredicateValue(this.value);

  final bool value;

  @override
  bool isYearValid(int year) => value;

  @override
  bool isMonthValid(int year, int month) => value;

  @override
  bool isDayValid(int year, int month, int day) => value;
}

/// A predicate that enables or disables a calendar date based on a minimum date.
///
/// Dates before the [minDate] are considered disabled.
/// Dates on or after the [minDate] are considered enabled.
final class GtbDateEnabledPredicateMinDate implements GtbDateEnabledPredicate {
  const GtbDateEnabledPredicateMinDate(this.minDate);

  final DateTime minDate;

  @override
  bool isYearValid(int year) {
    return year >= minDate.year;
  }

  @override
  bool isMonthValid(int year, int month) {
    final date = DateTime(year, month + 1, 0);
    return date.isDateAfterOrEquals(minDate);
  }

  @override
  bool isDayValid(int year, int month, int day) {
    final date = DateTime(year, month, day);
    return date.isDateAfterOrEquals(minDate);
  }
}

/// A predicate that enables or disables a calendar date based on a maximum date.
///
/// Dates after the [maxDate] are considered disabled.
/// Dates on or before the [maxDate] are considered enabled.
final class GtbDateEnabledPredicateMaxDate implements GtbDateEnabledPredicate {
  const GtbDateEnabledPredicateMaxDate(this.maxDate);

  final DateTime maxDate;

  @override
  bool isYearValid(int year) {
    return year <= maxDate.year;
  }

  @override
  bool isMonthValid(int year, int month) {
    final date = DateTime(year, month, 0);
    return date.isDateBeforeOrEquals(maxDate);
  }

  @override
  bool isDayValid(int year, int month, int day) {
    final date = DateTime(year, month, day);
    return date.isDateBeforeOrEquals(maxDate);
  }
}

/// A predicate that enables or disables a calendar date based on a period.
///
/// Dates within the period defined by [startDate] and [endDate] are considered enabled.
/// Dates outside this period are considered disabled.
final class GtbDateEnabledPredicatePeriod implements GtbDateEnabledPredicate {
  const GtbDateEnabledPredicatePeriod({
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;

  @override
  bool isYearValid(int year) {
    return startDate.year <= year && endDate.year >= year;
  }

  @override
  bool isMonthValid(int year, int month) {
    final firstMonthDay = DateTime(year, month);
    final lastMonthDay = DateTime(year, month + 1, 0);
    return firstMonthDay.isDateInPeriod(startDate, endDate) || //
        lastMonthDay.isDateInPeriod(startDate, endDate) ||
        startDate.isDateInPeriod(firstMonthDay, lastMonthDay) ||
        endDate.isDateInPeriod(firstMonthDay, lastMonthDay);
  }

  @override
  bool isDayValid(int year, int month, int day) {
    final selectedDate = DateTime(year, month, day);
    return selectedDate.isDateInPeriod(startDate, endDate);
  }
}

/// A predicate that enables or disables a calendar date based on custom functions.
final class GtbDateEnabledPredicateCustom implements GtbDateEnabledPredicate {
  const GtbDateEnabledPredicateCustom({
    required this.onCheckIsValidYear,
    required this.onCheckIsValidMonth,
    required this.onCheckIsValidDay,
  });

  final bool Function(int year) onCheckIsValidYear;
  final bool Function(int year, int month) onCheckIsValidMonth;
  final bool Function(int year, int month, int day) onCheckIsValidDay;

  @override
  bool isYearValid(int year) => onCheckIsValidYear(year);
  @override
  bool isMonthValid(int year, int month) => onCheckIsValidMonth(year, month);

  @override
  bool isDayValid(int year, int month, int day) => onCheckIsValidDay(year, month, day);
}

/// Predicate interface to determine if a calendar period (start and end date) is enabled for selection in the calendar.
///
/// See also.
/// [GtbPeriodEnabledPredicateValue]
/// [GtbPeriodEnabledPredicateCustom]
/// [GtbPeriodEnabledPredicatePeriod]
abstract interface class GtbPeriodEnabledPredicate {
  // ignore: avoid_positional_boolean_parameters
  const factory GtbPeriodEnabledPredicate.value(bool value) = GtbPeriodEnabledPredicateValue;

  const factory GtbPeriodEnabledPredicate.custom({
    required bool Function(int year) onCheckIsValidStartYear,
    required bool Function(int year, int month) onCheckIsValidStartMonth,
    required bool Function(int year, int month, int day) onCheckIsValidStartDay,
    required bool Function(int startYear, int startMonth, int startDay, int year) onCheckIsValidEndYear,
    required bool Function(int startYear, int startMonth, int startDay, int year, int month) onCheckIsValidEndMonth,
    required bool Function(int startYear, int startMonth, int startDay, int year, int month, int day) onCheckIsValidEndDay,
  }) = GtbPeriodEnabledPredicateCustom;

  factory GtbPeriodEnabledPredicate.period({
    required DateTime startDate,
    required DateTime endDate,
  }) = GtbPeriodEnabledPredicatePeriod;

  bool isStartYearValid(int year);

  bool isStartMonthValid(int year, int month);

  bool isStartDayValid(int year, int month, int day);

  bool isEndYearValid(int startYear, int startMonth, int startDay, int year);

  bool isEndMonthValid(int startYear, int startMonth, int startDay, int year, int month);

  bool isEndDayValid(int startYear, int startMonth, int startDay, int year, int month, int day);
}

/// A predicate that enables or disables a calendar period based on a fixed boolean value.
final class GtbPeriodEnabledPredicateValue implements GtbPeriodEnabledPredicate {
  // ignore: avoid_positional_boolean_parameters
  const GtbPeriodEnabledPredicateValue(this.value);

  final bool value;

  @override
  bool isStartYearValid(int year) => value;

  @override
  bool isStartMonthValid(int year, int month) => value;

  @override
  bool isStartDayValid(int year, int month, int day) => value;

  @override
  bool isEndYearValid(int startYear, int startMonth, int startDay, int year) => value;

  @override
  bool isEndMonthValid(int startYear, int startMonth, int startDay, int year, int month) => value;

  @override
  bool isEndDayValid(int startYear, int startMonth, int startDay, int year, int month, int day) => value;
}

/// A predicate that enables or disables a calendar period based on custom functions.
final class GtbPeriodEnabledPredicateCustom implements GtbPeriodEnabledPredicate {
  const GtbPeriodEnabledPredicateCustom({
    required this.onCheckIsValidStartYear,
    required this.onCheckIsValidStartMonth,
    required this.onCheckIsValidStartDay,
    required this.onCheckIsValidEndYear,
    required this.onCheckIsValidEndMonth,
    required this.onCheckIsValidEndDay,
  });

  final bool Function(int year) onCheckIsValidStartYear;
  final bool Function(int year, int month) onCheckIsValidStartMonth;
  final bool Function(int year, int month, int day) onCheckIsValidStartDay;
  final bool Function(int startYear, int startMonth, int startDay, int year) onCheckIsValidEndYear;
  final bool Function(int startYear, int startMonth, int startDay, int year, int month) onCheckIsValidEndMonth;
  final bool Function(int startYear, int startMonth, int startDay, int year, int month, int day) onCheckIsValidEndDay;

  @override
  bool isStartYearValid(int year) => onCheckIsValidStartYear(year);

  @override
  bool isStartMonthValid(int year, int month) => onCheckIsValidStartMonth(year, month);

  @override
  bool isStartDayValid(int year, int month, int day) => onCheckIsValidStartDay(year, month, day);

  @override
  bool isEndYearValid(int startYear, int startMonth, int startDay, int year) {
    return onCheckIsValidEndYear(startYear, startMonth, startDay, year);
  }

  @override
  bool isEndMonthValid(int startYear, int startMonth, int startDay, int year, int month) {
    return onCheckIsValidEndMonth(startYear, startMonth, startDay, year, month);
  }

  @override
  bool isEndDayValid(int startYear, int startMonth, int startDay, int year, int month, int day) {
    return onCheckIsValidEndDay(startYear, startMonth, startDay, year, month, day);
  }
}

/// A predicate that enables or disables a calendar period based on a fixed date range.
///
/// Dates within the period defined by [startDate] and [endDate] are considered enabled.
/// Dates outside this period are considered disabled.
final class GtbPeriodEnabledPredicatePeriod implements GtbPeriodEnabledPredicate {
  GtbPeriodEnabledPredicatePeriod({
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;
  late final _datePredicate = GtbDateEnabledPredicate.period(
    startDate: startDate,
    endDate: endDate,
  );

  @override
  bool isStartYearValid(int year) => _datePredicate.isYearValid(year);

  @override
  bool isStartMonthValid(int year, int month) => _datePredicate.isMonthValid(year, month);

  @override
  bool isStartDayValid(int year, int month, int day) => _datePredicate.isDayValid(year, month, day);

  @override
  bool isEndYearValid(int startYear, int startMonth, int startDay, int year) {
    return _datePredicate.isYearValid(year);
  }

  @override
  bool isEndMonthValid(int startYear, int startMonth, int startDay, int year, int month) {
    return _datePredicate.isMonthValid(year, month);
  }

  @override
  bool isEndDayValid(int startYear, int startMonth, int startDay, int year, int month, int day) {
    return _datePredicate.isDayValid(year, month, day);
  }
}

bool _isSameDay(DateTime? date1, DateTime? date2) {
  return switch ((date1, date2)) {
    (null, null) => true,
    (null, _?) => false,
    (_?, null) => false,
    (final date1?, final date2?) => date1.year == date2.year && date1.month == date2.month && date1.day == date2.day,
  };
}

bool _isSameMonthAndYear(DateTime? date1, DateTime? date2) {
  return switch ((date1, date2)) {
    (null, null) => true,
    (null, _?) => false,
    (_?, null) => false,
    (final date1?, final date2?) => date1.year == date2.year && date1.month == date2.month,
  };
}

Widget _titleTransitionFrom(Widget child, Animation<double> animation, bool isChildEntering, bool isMovingForward) {
  final fadeAnimation = CurvedAnimation(
    parent: animation,
    curve: isChildEntering
        ? const Interval(0.33, 1.0, curve: _curve2) //
        : const Interval(0.66, 1.0, curve: _curve2),
  );

  return FadeTransition(
    opacity: fadeAnimation,
    child: _contentTransitionFrom(child, animation, isChildEntering, isMovingForward),
  );
}

Widget _contentTransitionFrom(Widget child, Animation<double> animation, bool isChildEntering, bool isMovingForward) {
  final slideAnimation =
      CurvedAnimation(
        parent: animation,
        curve: isChildEntering
            ? const Interval(0.33, 1.0, curve: _curve2) //
            : const Interval(0.66, 1.0, curve: _curve2),
      ).drive(
        Tween<Offset>(
          begin: switch ((isChildEntering, isMovingForward)) {
            (true, true) => const Offset(1.1, 0.0),
            (true, false) => const Offset(-1.1, 0.0),
            (false, false) => const Offset(1.1, 0.0),
            (false, true) => const Offset(-1.1, 0.0),
          },
          end: Offset.zero,
        ),
      );

  return SlideTransition(
    position: slideAnimation,
    child: child,
  );
}

Future<DateTime?> showGtbDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? initialSelectedDate,
  Map<DateTime, List<GtbSubCalendarEventIndicator>>? dayEvents,
  Map<DateTime, List<GtbSubCalendarEventIndicator>>? monthEvents,
  Map<DateTime, List<GtbSubCalendarEventIndicator>>? yearEvents,
  GtbDateEnabledPredicate dateEnabledPredicate = const GtbDateEnabledPredicate.value(true),
  GtbDatePickerActionSettingsBuilder<DateTime>? primaryActionSettingsBuilder = _defaultActionSettingsBuilder,
  GtbDatePickerActionSettingsBuilder<DateTime>? secondaryActionSettingsBuilder,
  RouteSettings? routeSettings,
}) async {
  return showGtbModal<DateTime>(
    context: context,
    routeSettings: routeSettings,
    builder: (modalContext) {
      return GtbDatePicker.date(
        initialDate: initialDate,
        dayEvents: dayEvents ?? {},
        monthEvents: monthEvents ?? {},
        yearEvents: yearEvents ?? {},
        dateEnabledPredicate: dateEnabledPredicate,
        initialSelectedDate: initialSelectedDate,
        primaryActionSettingsBuilder: primaryActionSettingsBuilder,
        secondaryActionSettingsBuilder: secondaryActionSettingsBuilder,
      );
    },
  );
}

Future<GtbCalendarPeriod?> showGtbPeriodPicker({
  required BuildContext context,
  DateTime? initialDate,
  GtbCalendarPeriod? initialSelectedPeriod,
  Map<DateTime, List<GtbSubCalendarEventIndicator>>? dayEvents,
  Map<DateTime, List<GtbSubCalendarEventIndicator>>? monthEvents,
  Map<DateTime, List<GtbSubCalendarEventIndicator>>? yearEvents,
  GtbPeriodEnabledPredicate periodEnabledPredicate = const GtbPeriodEnabledPredicate.value(true),
  GtbDatePickerActionSettingsBuilder<GtbCalendarPeriod>? primaryActionSettingsBuilder = _defaultActionSettingsBuilder,
  GtbDatePickerActionSettingsBuilder<GtbCalendarPeriod>? secondaryActionSettingsBuilder,
  RouteSettings? routeSettings,
}) async {
  return showGtbModal<GtbCalendarPeriod>(
    context: context,
    routeSettings: routeSettings,
    builder: (modalContext) {
      return GtbDatePicker.period(
        initialDate: initialDate,
        dayEvents: dayEvents ?? {},
        monthEvents: monthEvents ?? {},
        yearEvents: yearEvents ?? {},
        periodEnabledPredicate: periodEnabledPredicate,
        initialSelectedPeriod: initialSelectedPeriod,
        primaryActionSettingsBuilder: primaryActionSettingsBuilder,
        secondaryActionSettingsBuilder: secondaryActionSettingsBuilder,
      );
    },
  );
}

GtbActionSettings<VoidCallback> _defaultActionSettingsBuilder<T>(BuildContext context, T? data) {
  return GtbActionSettings(
    text: 'OK',
    onPress: data == null
        ? null //
        : () => Navigator.of(context).pop(data),
  );
}
