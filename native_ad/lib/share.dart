import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  bool loading = false;

  Future<bool> saveFile(String uri, String fileName) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          print("====================${directory!.path}============");
          String newPath = "";
          // /storage/emulated/0/Android/data/com.example.native_ad/files
          List<String> folders = directory.path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/RPSApp";
          directory = Directory(newPath);
          print(directory.path);
        } else {
          return false;
        }
      } else {
        // if(_requestPermission(permission.photos)){}else{}
      }
    } catch (e) {}
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isDenied) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  downloadFile() async {
    setState(() {
      loading = true;
    });
    bool download = await saveFile(
        "https://www.youtube.com/watch?v=6ZcQmdoz9N8", "video.mp4");
    if (download) {
      print("File Download");
    } else {
      print("problem Downloading File");
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Share"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: IconButton(
                  onPressed: () {
                    Share.share(
                        'check out my website https://flutter.dev/multi-platform/desktop?gclid=CjwKCAjw4c-ZBhAEEiwAZ105RRPf_mhiDStNJbOA6ZDCpznIWwzng0lJIYrwJNLrCxRl699vz47zZBoC9M4QAvD_BwE&gclsrc=aw.ds');
                  },
                  icon: const Icon(Icons.share),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  downloadFile();
                },
                child: Row(
                  children: const [
                    Icon(Icons.download),
                    Text("Download image"),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Share.shareFiles(['android/assets/image/1.jpg'],
                      text: 'Great picture');
                  Share.shareFiles([
                    '${'android/assets/image/1.jpg'}/image1.jpg',
                    '${'android/assets/image/1.jpg'}/image2.jpg'
                  ]);
                },
                icon: const Icon(Icons.share),
              )
            ],
          ),
        ),
      ),
    );
  }
}
