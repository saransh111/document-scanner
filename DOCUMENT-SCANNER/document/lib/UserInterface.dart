import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:share/share.dart';

class myUI extends StatefulWidget {
  @override
  _myUIState createState() => _myUIState();
}

class _myUIState extends State<myUI> {
  var files;
  void getFiles() async {
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir;
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: ["pdf"] //optional, to filter files, list only pdf files
        );
    setState(() {}); //update the UI
  }

  @override
  void initState() {
    getFiles(); //call getFiles() function on initial state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var i;
    int a = 0;
    var toRemove = [];
    for (i in files) {
      String str = i.path.split('/').last;
      if (str.compareTo("111me175") > 0) {
        toRemove.add(i);
      }
      a++;
    }
    files.removeWhere((e) => toRemove.contains(e));
    int count = files?.length ?? 0;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: Image.asset(
                "assets/R8b0cf36b4cb903a1e92735501fc38464.png",
              ),
              title: Text(files[position].path.split('/').last),
              subtitle: Text('PDF Document'),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.open_in_new_sharp),
                    onPressed: () {
                      debugPrint("ListTile Tapped");
                      String path = files[position].path.toString();
                      OpenFile.open(path);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      debugPrint("ListTile Tapped");
                      String path = files[position].path.toString();
                      Share.shareFiles([path], text: '111ME175_ASSIGNMENT');
                    },
                  ) // icon-2
                ],
              ),

            ));
      },
    );
  }
}
