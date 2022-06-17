import 'dart:math';

import 'package:conf_call/resources/jitsi_meet_method.dart';
import 'package:conf_call/screens/video_call_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/home_meeting_button.dart';
class MeetingScreens extends StatelessWidget {
   MeetingScreens({Key? key}) : super(key: key);
   final JitsiMeetMethod _jitsiMeetMethod = JitsiMeetMethod();
  createMeeting  () async{
    var random = Random();
    String roomName = (random.nextInt(10000000)+10000000).toString();
   _jitsiMeetMethod.createNewMeeting(roomName: roomName, isAudioMuted: true, isVideoMuted: true);
    
  }
  joinMeeting(BuildContext context){
    Navigator.pushNamed(context, VideoCallScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: createMeeting,
              icon: Icons.videocam,
              text: "New Meeting",
            ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context),
              icon: Icons.add_box,
              text: "Join Meeting",
            ),
            HomeMeetingButton(
              onPressed: () {},
              icon: Icons.calendar_today,
              text: "Schedule",
            ),
            HomeMeetingButton(
              onPressed: () {},
              icon: Icons.arrow_upward,
              text: "Share Screen",
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              "Create/Join Meetings with just a click!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        )
      ],
    );
  }
}
