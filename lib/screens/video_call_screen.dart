import 'package:conf_call/resources/auth_method.dart';
import 'package:conf_call/resources/jitsi_meet_method.dart';
import 'package:conf_call/utils/colors.dart';
import 'package:conf_call/widgets/meeting_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class VideoCallScreen extends StatefulWidget {
  static const routeName = "/videoCall";
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  final JitsiMeetMethod jitsiMeetMethod = JitsiMeetMethod();

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
    // TODO: implement initState
    super.initState();
  }

  _joinMeeting() {
    jitsiMeetMethod.createNewMeeting(
      roomName: meetingIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: nameController.text,
    );
  }

  _isAudioMuted(bool b) {
    setState(() {
      isAudioMuted = b;
    });
  }

  _isVideoMuted(bool b) {
    setState(() {
      isVideoMuted = b;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Join a meeting",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  hintText: "ROOM ID",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0)),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  hintText: "Name",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _joinMeeting,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: const Text(
                "Join",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MeetingOption(
            text: "Mute Audio",
            isMute: isAudioMuted,
            onChange: _isAudioMuted,
          ),
          MeetingOption(
            text: "Turn Off My Video",
            isMute: isVideoMuted,
            onChange: _isVideoMuted,
          )
        ],
      ),
    );
  }
}
