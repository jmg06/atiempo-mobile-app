import 'package:atiempo_mobile_app/config/theme/app_colors.dart';
import 'package:atiempo_mobile_app/shared/domain/enums/dose_block_status.dart';
import 'package:flutter/material.dart';

class AppDayStripBlock {
  const AppDayStripBlock({required this.hour, required this.status, required this.label});

  /// Hours from midnight: 3:15 p. m. is 15.25.
  final double hour;
  final DoseBlockStatus status;
  final String label;
}

class AppDayStrip extends StatelessWidget {
  const AppDayStrip({
    required this.blocks,
    required this.focusedIndex,
    this.startLabel = '6 a. m.',
    this.endLabel = '12 p. m.',
    super.key,
  });

  final List<AppDayStripBlock> blocks;
  final int focusedIndex;
  final String startLabel;
  final String endLabel;

  static const double _height = 58;
  static const double _axisY = 21;
  static const double _axisThickness = 2;
  static const double _inset = 10;
  static const double _dotSize = 12;
  static const double _focusOuter = 30;
  static const double _focusInner = 22;
  static const double _focusDot = 14;
  static const double _startHour = 6;
  static const double _endHour = 24;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle? micro = theme.textTheme.labelMedium;
    final Color mutedMicro = theme.colorScheme.onSurfaceVariant;

    return SizedBox(
      height: _height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double axisWidth = constraints.maxWidth - _inset * 2;

          double centreOf(AppDayStripBlock block) {
            final double fraction = ((block.hour - _startHour) / (_endHour - _startHour)).clamp(0, 1);
            return _inset + fraction * axisWidth;
          }

          return Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                left: _inset,
                top: _axisY,
                width: axisWidth,
                height: _axisThickness,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(_axisThickness / 2),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Text(startLabel, style: micro?.copyWith(color: mutedMicro)),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Text(endLabel, style: micro?.copyWith(color: mutedMicro)),
              ),
              for (int i = 0; i < blocks.length; i++)
                if (i != focusedIndex)
                  Positioned(
                    left: centreOf(blocks[i]) - _dotSize / 2,
                    top: _axisY + _axisThickness / 2 - _dotSize / 2,
                    child: _Dot(size: _dotSize, color: _colorOf(context, blocks[i].status)),
                  ),
              if (focusedIndex >= 0 && focusedIndex < blocks.length) ...<Widget>[
                Positioned(
                  left: centreOf(blocks[focusedIndex]) - _focusOuter / 2,
                  top: _axisY + _axisThickness / 2 - _focusOuter / 2,
                  child: _FocusMark(
                    color: _colorOf(context, blocks[focusedIndex].status),
                    surface: theme.colorScheme.surface,
                  ),
                ),
                Positioned(
                  left: centreOf(blocks[focusedIndex]) - 48,
                  top: 40,
                  width: 96,
                  child: Text(
                    blocks[focusedIndex].label,
                    textAlign: TextAlign.center,
                    style: micro?.copyWith(color: theme.colorScheme.onSurface),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Color _colorOf(BuildContext context, DoseBlockStatus status) {
    final AppColors colors = context.appColors;
    return switch (status) {
      DoseBlockStatus.scheduled => colors.stateScheduled,
      DoseBlockStatus.pending => colors.statePending,
      DoseBlockStatus.ringing => colors.stateRinging,
      DoseBlockStatus.done => colors.stateDone,
      DoseBlockStatus.delegated => colors.stateDelegated,
    };
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _FocusMark extends StatelessWidget {
  const _FocusMark({required this.color, required this.surface});

  final Color color;
  final Color surface;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppDayStrip._focusOuter,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _Dot(size: AppDayStrip._focusOuter, color: color),
          _Dot(size: AppDayStrip._focusInner, color: surface),
          _Dot(size: AppDayStrip._focusDot, color: color),
        ],
      ),
    );
  }
}
