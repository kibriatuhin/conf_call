import 'package:conf_call/resources/auth_method.dart';
import 'package:conf_call/resources/firestore_method.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class JitsiMeetMethod {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethod _firestoreMethod = FirestoreMethod();
  void createNewMeeting(
      {required String roomName,
      required bool isAudioMuted,
      required isVideoMuted,
      String username = ''}) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p

      String name ;
      if(username.isEmpty){
        name = _authMethods.user.displayName!;
      }else{
        name = username;
      }

      var options = JitsiMeetingOptions(
        room: roomName,
      )
        /* ..room = "myroom" // Required, spaces will be trimmed
        ..serverURL = "https://someHost.com"
        ..subject = "Meeting with Gunschu"*/
        ..userDisplayName = _authMethods.user.displayName
        ..userEmail = _authMethods.user.email
        ..userAvatarURL = _authMethods.user.photoURL // or .png
        /* ..audioOnly = true*/
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;
      // ..featureFlag = featureFlag;

      _firestoreMethod.addToMeetingHistory(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
