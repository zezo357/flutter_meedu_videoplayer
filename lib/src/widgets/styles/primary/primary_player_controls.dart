import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:flutter_meedu_videoplayer/src/helpers/responsive.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/play_pause_button.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/player_button.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/styles/controls_container.dart';
import 'package:flutter_meedu_videoplayer/src/widgets/styles/primary/bottom_controls.dart';

class PrimaryVideoPlayerControls extends StatelessWidget {
  final Responsive responsive;
  const PrimaryVideoPlayerControls({Key? key, required this.responsive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = MeeduPlayerController.of(context);

    return ControlsContainer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // RENDER A CUSTOM HEADER
          if (_.header != null)
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: _.header!,
              ),
            ),
          Container(
            height: context.mediaQuerySize.height,
            width: context.mediaQuerySize.width,
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_.enabledButtons.rewindAndfastForward) ...[
                PlayerButton(
                  onPressed: _.rewind,
                  size: responsive.ip(_.fullscreen.value ? 8 : 12),
                  iconColor: Colors.white,
                  backgrounColor: Colors.transparent,
                  iconPath: 'assets/icons/rewind.png',
                  customIcon: _.customIcons.rewind,
                ),
                SizedBox(width: 10),
              ],
              if (_.enabledButtons.playPauseAndRepeat)
                RxBuilder(
                    //observables: [_.showSwipeDuration],
                    //observables: [_.swipeDuration],
                    (__) {
                  _.dataStatus.status.value;
                  if (!_.showSwipeDuration.value &&
                      !_.dataStatus.error &&
                      !_.dataStatus.loading &&
                      !_.isBuffering.value) {
                    return PlayPauseButton(
                      size: responsive.ip(_.fullscreen.value ? 8 : 13),
                    );
                  } else {
                    return Container();
                  }
                }),
              if (_.enabledButtons.rewindAndfastForward) ...[
                SizedBox(width: 10),
                PlayerButton(
                  onPressed: _.fastForward,
                  iconColor: Colors.white,
                  backgrounColor: Colors.transparent,
                  size: responsive.ip(_.fullscreen.value ? 8 : 12),
                  iconPath: 'assets/icons/fast-forward.png',
                  customIcon: _.customIcons.fastForward,
                ),
              ]
            ],
          ),

          PrimaryBottomControls(
            responsive: responsive,
          ),
        ],
      ),
    );
  }
}
